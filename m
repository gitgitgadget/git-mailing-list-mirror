From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 12:20:54 -0700
Message-ID: <7vhbgiyoo9.fsf@alter.siamese.dyndns.org>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes> <20101019182845.GE25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8HkR-0007Z3-5W
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab0JSTVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 15:21:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0JSTVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:21:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DED2E0B8C;
	Tue, 19 Oct 2010 15:21:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QRjnwH08CSx0NiIGVhbUWP6QywA=; b=kyBB5q
	CX0zrv+lyySMXZ8CJUyuW36/3IGqJXsVDGsXzbmePm1MqCtHJVQCBbSqqe2QGInl
	88MLegUquvS5Vc9g0Z+/7bltxMAng5l54QpuGrL3RA+lepHt5FP7jylSXpp+fqiG
	Y0XpB4zjg77/ummrdNQPFVpB/p0s/dsinmjDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xqrrVPnCtBLgSiL+xtzMcOM6BQ/Zvtwa
	SU+L9aPjKYscawtrvQl3JpHB9Q6HR6XTfinzFIRYpJ/3ZzUwy5WDOT3KGnJzSItz
	reg+RoGKAQ2OXYbjx5CGsRiAkdua2NAGRrZg1MHPYta4KpBwuLp73JeCHAc2EnTj
	Ow7B7Y9NS2g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B364E0B78;
	Tue, 19 Oct 2010 15:21:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 364ABE0B65; Tue, 19 Oct
 2010 15:20:56 -0400 (EDT)
In-Reply-To: <20101019182845.GE25139@burratino> (Jonathan Nieder's message of
 "Tue\, 19 Oct 2010 13\:28\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 043D224C-DBB6-11DF-946D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159358>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Wouldn't it make sense to make "git reset" basically a synonym for
> "git rm --cached" when in the 'branch yet to be born' case?

Hmm,...

While you are on 'master', shouldn't these behave identically?

    $ git reset master -- frotz.c
    $ git reset HEAD -- frotz.c
    $ git reset -- frotz.c

while shouldn't this fail if there is no 'naster' branch?

    $ git reset naster -- frotz.c

It is probably Ok to limit the scope of this change to the case without
any explicit rev, e.g. "git reset -- frotz.c", but at that point I somehow
don't think it will reduce confusion but rather will make things worse.

> +	if (!strcmp(rev, "HEAD")) {

Comparing the address of the "HEAD" used for initialization with rev may
make sure that the code will catch only "no explicit rev" case here, but
that is not what is happening here, which is even less consistent.
