From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and related stuff
Date: Tue, 15 Mar 2016 08:56:05 -0700
Message-ID: <xmqqk2l391m2.fsf@gitster.mtv.corp.google.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	<1457548582-28302-5-git-send-email-dturner@twopensource.com>
	<xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Cgz0zTryCCXoPMh40Rq4yOCy1L8Nih-YbKaZLyV=Gi-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 16:56:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afrKR-0005kG-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 16:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbcCOP4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 11:56:10 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756288AbcCOP4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 11:56:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0410F4B5FB;
	Tue, 15 Mar 2016 11:56:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JfIoMatFA37UESoT9Fi8co7HqlA=; b=NWTgp5
	5+jZKzrp318jGG1Qg58wMdZ/KFQLi7MgHtsrDpGcKVhbolFKSInevkVKVCVotzZ9
	hNtLUHG7TVc0JaslWDuzSXrSA5wC6wZN7LhsT1VeHQaYbSIy1ocxyjT0XTphaL91
	kTTPQbsuEkgqCXOt0qRbWy6xoA6zoOiWeWOu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xsiyzpMyaCiFO+2YLe4T71RQfb4PvmI6
	icZ1roOlBQWHj1IsJuTkWja85Txe9mzk4zgtZtN0MhGGLySHsany3P4pdbjgLZ8T
	zPZ40iDsivurS1qXIcWUPJdi3XEhrEeO8WlJNNmywrzapSRXPu4L0fzDb3Yw7kwQ
	73Yiy6bL75M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFC254B5F8;
	Tue, 15 Mar 2016 11:56:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67BA04B5F7;
	Tue, 15 Mar 2016 11:56:06 -0400 (EDT)
In-Reply-To: <CACsJy8Cgz0zTryCCXoPMh40Rq4yOCy1L8Nih-YbKaZLyV=Gi-w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 15 Mar 2016 18:56:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D6421CE-EAC6-11E5-AD1B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288857>

Duy Nguyen <pclouds@gmail.com> writes:

> Another aspect that's not mentioned is, we keep this daemon's logic as
> thin as possible. The "brain" stays in git. So the daemon can read and
> validate stuff, but that's about all it's allowed to do. It's not
> supposed to add/create new contents. It's not even allowed to accept
> direct updates from git.

That explanation does make the intent clear. It is a kind of design
decision that needs to be made early and that is hard to change
later (I am not saying I see the need of changing, though), so it is
worth stating explicitly to guide future readers and updaters of the
code.

Thanks.
