From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Instruct git-completion.bash that we are in test mode
Date: Mon, 21 Jan 2013 15:32:29 -0800
Message-ID: <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:32:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQrG-0002k7-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab3AUXcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 18:32:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab3AUXcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 18:32:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D9CBACD;
	Mon, 21 Jan 2013 18:32:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3xvDLPGvY7Xy
	ymNx3Q8H+0467p4=; b=e8TuR6SoEVx630HLVVPcG+H8ugeNSWbUyDPo1soAIWzM
	e6eIcXJDtcVzwYxhO3pgGt5/iab1bnIEmxTK4utOZEJ3rShtmFu61uolol54M61Q
	fBQee6TWM8y2DHIWbtHSCaWbUG7dTDN7NvvjwZtX/jcwiRvYc8UfA7TvfxREL+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eP6LEN
	ugMzQP65lbbgdrvgcTPADAPnNW9+pMc9Cted8lm6xkGKAKKa5LnJ79mHFnsVnrfC
	PZt5lh3mYTaTlDE0HsPV+sq0bgqwQ2JaQPCw41odKldcYTZCFWAIERCeiCtl5Cly
	9tB8+/gra4NKVEaSXvXXA5Y2CKRO5dNF2FtPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FB4FBACC;
	Mon, 21 Jan 2013 18:32:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE33DBAC8; Mon, 21 Jan 2013
 18:32:30 -0500 (EST)
In-Reply-To: <201301212330.10824.jn.avila@free.fr> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Mon, 21 Jan 2013 23:30:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D31987BC-6422-11E2-B847-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214175>

"Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:

> At least, "it works for me".

I suspect that your approach will still not fix the case in which
you build a branch with a new command git-check-ignore, and then
check out another branch that does not yet have that command without
first running "make clean".

Does the following really pass with your patch?

	git checkout origin/next
        make
        git checkout origin/maint
	git apply your_patch.mbox
        make
        cd t && sh ./t9902-completion.sh

> +	__git_cmdlist () { git help -a| egrep -m 1 -B1000 PATH | egrep '^  =
[a-zA-Z0-9]'; }

'egrep' is not even in POSIX in the first place but grep -E ought to
be a replacement for it, so I'll let it pass, but "-m1 -B1000"?
Please stay within portable options.

    git help -a |
    sed -n -e '/^  [a-z]/p' -e '/^git commands available from elsewhere=
/q'/'

might be a good enough substitute, I think, if we were to take your
approach, but I suspect it needs a lot more to limit the output in
the test mode.
