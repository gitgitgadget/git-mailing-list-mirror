From: Junio C Hamano <gitster@pobox.com>
Subject: Re: move detection doesnt take filename into account
Date: Tue, 01 Jul 2014 07:57:36 -0700
Message-ID: <xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
References: <53B105DA.30004@gmail.com>
	<287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliot Wolk <elliot.wolk@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 16:57:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1zVE-0003Of-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 16:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811AbaGAO5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 10:57:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61552 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbaGAO5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 10:57:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B42C24C94;
	Tue,  1 Jul 2014 10:57:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PIubpyjLsCSb3nGZmQPdYigVcF4=; b=jC5qgA
	4abZSAUo9omP3hSmws0gqY1SWmd3BfCRyd9DH5YhtmkZ5SE+/4jf7p4mWKraIaHV
	+a5DrqNyMw0Q5jtvQD91zlYfcWByiYWlufr0CnEoU8MYwK9ga6c/S3/yBhg1LBQy
	TeOVauowE/4qPHuGnpGTQ5nQaagYA4X8Vcym0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VUuCjpr4aFJd6udl+gcfPT+vteJgyUm7
	i8EG2AEfpKM9V/zEpQH0c0SqNkynS0kO8aOSe6aPsoucWExf6/mdf4RJrrpeJ8Ob
	jM0oxEaIXiwJ5hjHI2l+e7HHa4VXhXBTcKcfam5DjISiEro5XJfZGh8QUrPA8bXG
	4E7dC+E5qUU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4149024C93;
	Tue,  1 Jul 2014 10:57:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69D6224C91;
	Tue,  1 Jul 2014 10:57:27 -0400 (EDT)
In-Reply-To: <287177519.16421.1404206204124.JavaMail.zimbra@dewire.com> (Robin
	Rosenberg's message of "Tue, 1 Jul 2014 11:16:44 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 048FB554-0130-11E4-8696-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252719>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> I think it does, but based on filename suffix. E.g. here is a rename of
> three empty files with a suffix.
>
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  rename 1.a => 2.a (100%)
>  rename 1.b => 2.b (100%)
>  rename 1.c => 2.c (100%)

This is not more than a chance.

We tie-break rename source candidates that have the same content
similarity score to a rename destination using "name similarity",
whose implementation has been diffcore-rename.c::basename_same(),
which scores 1 if `basename $src` and `basename $dst` are the same
and 0 otherwise, i.e. from 1.a to a/1.a is judged to be a better
rename than from 1.a to a/2.a but otherwise there is nothing that
favors rename from 1.a to 2.a over 1.a to 2.b.
