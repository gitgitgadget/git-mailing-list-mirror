From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase -i: use full onto sha1 in reflog
Date: Thu, 09 Aug 2012 10:08:50 -0700
Message-ID: <7va9y4ouvx.fsf@alter.siamese.dyndns.org>
References: <89f79049a5fd737716ad51630a8c1ee4a27d747e.1344528082.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzWEF-0002Fz-6S
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 19:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab2HIRIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 13:08:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab2HIRIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 13:08:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 878237343;
	Thu,  9 Aug 2012 13:08:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=znhaU91jXKFK9w5vFSwLS7ok0yQ=; b=fxRv2G
	Vq6D32PoVih0oukZIneUjzbCFzN8zQUURfOhd9kSsAbO7ibjd5es1vLyyYNDLuUV
	B/5xR9jo1hdIL4u2smc3YWmHYLMhMFdavdAMniGo5Ai+SIwGRPKNe2UNH/A+ViM1
	5/2aoUXcGafwTrG3h2qJALGSlIBs3/uEfhE8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wR1X/Jhtr84PIDz0f6XMHlVRpV2BCbv0
	mB/IjUlTtd7KgjAT4aL8MfSGhsxqnzpWC7MWaGRVqt0s5ckKz3FVgC1Sz7sYcbs+
	uD3EbVRGnT/McYjIE5s9tmlXzuB3hI+MnDLWE1asYyaa9DAQvTEkgo5V1Aa0nwqm
	Nfc4XW5Xlfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 744927342;
	Thu,  9 Aug 2012 13:08:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C53FD7341; Thu,  9 Aug 2012
 13:08:51 -0400 (EDT)
In-Reply-To: <89f79049a5fd737716ad51630a8c1ee4a27d747e.1344528082.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 9 Aug 2012 18:05:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4907286-E244-11E1-A8EA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203168>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> 'git rebase' uses the full onto sha1 for the reflog message whereas 'git
> rebase -i' uses the short sha1. This is not only inconsistent, but can
> lead to problems when the reflog is inspected at a later time at which
> that abbreviation may have become ambiguous.
>
> Make 'rebase -i' use the full onto sha1, as well.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I don't remember having sent this out before but have been running with
> it since (including tests). I don't see it on the list either.
>
> While not for 1.7.12 obviously, it might still be good to have.

Makes sense, I agree it is not that urgent to include it in 1.7.12,
and I think it is not just "good to have" but "we should have done
so from day one and it cannot break anybody who is reading the
reflog".

Thanks.

>
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0d2056f..dbc9de6 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -573,7 +573,7 @@ do_next () {
>  	newhead=$(git rev-parse HEAD) &&
>  	case $head_name in
>  	refs/*)
> -		message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
> +		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
>  		git update-ref -m "$message" $head_name $newhead $orig_head &&
>  		git symbolic-ref \
>  		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
