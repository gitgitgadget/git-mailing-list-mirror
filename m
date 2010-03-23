From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Teach -f/--force-rebase option to 'rebase -i'.
Date: Tue, 23 Mar 2010 15:42:07 -0700
Message-ID: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
References: <4BA8D263.8040602@xiplink.com>
 <1269361187-31291-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 23:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuCnq-0002En-23
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 23:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0CWWmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 18:42:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab0CWWmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 18:42:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DC30A4ED2;
	Tue, 23 Mar 2010 18:42:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MW5gQc067TDICrzlvy7LPKL5q6k=; b=G8hG23
	vdK5G1MuJvfAVXQuR6P+bRQ6tODEEo94CO+LJA2vXvF3QwZTA3sJGNalNPv/iRvD
	GhjzejCgSYwsddirMdtDlYFq4jM+bM7E3KfzltVUF2/RCgK+NcIb/9gsG4gmDtQW
	em3jKJBEnQ8KWB12QJrr38zI95WZOtcyYt0GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DK67atWXm7ZJUWCSyXO89gTdxCUEFWH1
	2xFNYOoWQq928XkLlyGL9McyQOHM540ti+l7B19wEc4/nt8GyMutS6O5+sBEaNhY
	kinecRQK40RIdzaAlYAoqHFU6ELkewHItW3uH53uHGo8j0ZypS3o1koxYmrfvWEn
	DHBMVNQFbLI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC360A4EC1;
	Tue, 23 Mar 2010 18:42:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDDDDA4EBF; Tue, 23 Mar
 2010 18:42:08 -0400 (EDT)
In-Reply-To: <1269361187-31291-1-git-send-email-marcnarc@xiplink.com> (Marc
 Branchaud's message of "Tue\, 23 Mar 2010 12\:19\:47 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 535593D4-36CD-11DF-A4B4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143056>

Marc Branchaud <marcnarc@xiplink.com> writes:

> This option tells rebase--interactive to cherry-pick all the commits in the
> rebased branch, instead of fast-forwarding over any unchanged commits.
>
> Also expanded -f's description in rebase's man page.
>
> -f offers an alterntive way to deal with reverted merges.  Instead of
> "reverting the revert" you can use "rebase -f [-i]" to recreate the branch
> with entirely new commits (they're new because at the very least the
> committer time is different).  This obviates the need to revert the
> reversion, as you can re-merge the new topic branch directly.  Added an
> addendum to revert-a-faulty-merge.txt describing the situation and how to
> use -f to handle it.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> It seems more natural to me to just teach -f to "rebase -i" instead of adding
> a new --no-ff option.
>
> This patch combines my initial "--no-ff" patch with the documentation changes
> in my "reword" patch.  I moved the unit test for "rebase -f -i" into
> t3404-rebase-interactive.sh.

Hmm, to be honest, this is not what I expected.

A non-interactive "rebase" will _refuse_ to do anything, because it knows
that the end result will be exactly the same, in a fast-forward situation.
In general, the option "--force" is "I know the precondition I am in will
trigger your logic to refuse this request---but please do so anyway", and
the use of that option in non-interactive one is in line with that
definition.  So "--force" makes perfect sense to non-interactive rebase.

But "rebase -i" cannot _refuse_ when the range to be rebased is already
fast-forward, as the whole point of the command is to be able to rewrite
chosen commits, and that "rewriting chosen commits" is the reason why it
makes sense for the command to fast-forward the earlier picks that were
not chosen to be rewritten.  But "forcing" doesn't make sense, if the
command does not even refuse to begin with.  So "--no-ff" is sensible
there.

What I meant was that as a measure to prepare for a future merge of
(corrected) side branch whose earlier merge was once reverted, it would
make sense to use "rebase -f" without any "interactive", compared to the
"start rebase -i, and to ensure it wouldn't fast-forward, lie to it that
you will reword the first one and do nothing in reality", which your
earlier documentation suggested.

If anything, teaching --no-ff to non-interactive rebase would also make
sense.  Just like saying "I know you will refuse if it is a fast forward,
but please do so anyway" with --force makes sense, it is sensible to say
"I know you will make this a no-op if it is a fast forward, but please
rewrite all of them" with --no-ff.
