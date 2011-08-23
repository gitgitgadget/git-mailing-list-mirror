From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Prevent force-updating of the current branch
Date: Tue, 23 Aug 2011 11:20:59 -0700
Message-ID: <7v39gsrnuc.fsf@alter.siamese.dyndns.org>
References: <1313876989-16328-1-git-send-email-conrad.irwin@gmail.com>
 <1313876989-16328-2-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 20:21:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvvb7-0002J0-3l
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 20:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab1HWSVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 14:21:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128Ab1HWSVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 14:21:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 339F24B79;
	Tue, 23 Aug 2011 14:21:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PNTZzKogWcGPgogCqwy1IL5VaQw=; b=s93NSan2E3XL7VpPHBS4
	QODtw5NiGsUXLbUywVbFY4/TULFQ45WAger+Wh5k3CS7y04o77xFxf8s2rfYQn5f
	+w9qXdP0Q1RUBvM6rTp+ChviEEmUrcFT+v6BIfh8z+bfERBAcXdQkHBWTyRAMy4w
	PulqTf1q3KcbThvCL5e15nI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bAQX7yizsblV3Hct1Cqacv3ltBxx69YN7WyTsBts8UjUa6
	A99r4K4nbI8hyQiguv4FwYXbxUASouEcKw7DMuvKBk14+AYZSGeOY3pEtQcaMhPp
	2qluzJP7Voqc1q/NFzhxOWCFHwFZMwfvhyikIt4fV/A/aIaXsSsIh2HrVBOYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEEA34B77;
	Tue, 23 Aug 2011 14:21:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 177894B71; Tue, 23 Aug 2011
 14:21:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A79E05AA-CDB4-11E0-9F0D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179956>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> git branch -M <foo> <current-branch> could be used to change the branch
> to which HEAD points, without the necessary house-keeping that git reset
> normally does to make this operation sensible. It would leave the reflog
> in a confusing state (you would be warned when trying to read it) and
> had an apparently side-effect of staging the diff between <current branch>
> and <foo>.

The last two lines are redundant (it is "without the house-keeping of
reset"); I'll remove "and had an apparently...".

> git checkout -B <current branch> <foo> was also partly vulnerable to
> this bug; due to inconsistent pre-flight checks it would perform half of
> its task and then abort just before rewriting the branch. Again this
> manifested itself as the index file getting out-of-sync with HEAD.
>
> git checkout -f already guarded against this problem, and aborted with
> a fatal error.

I assume you mean "branch -f". I'll rewrite it so, and in the present
tense.

> git branch -M, git checkout -B and git branch -f now use the same checks
> before allowing a branch to be created. These prevent you from updating
> the current branch.

Looks good ;-). Also the patch looks good, too.

Thanks.
