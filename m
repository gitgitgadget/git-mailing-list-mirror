From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Thu, 07 Jan 2010 12:19:54 -0800
Message-ID: <7vtyux3bx1.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <7vskal5c11.fsf@alter.siamese.dyndns.org>
 <20100106191825.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302>
 <7vocl7yxef.fsf@alter.siamese.dyndns.org>
 <20100107200509.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:20:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSyq3-0007v9-2q
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 21:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab0AGUUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172Ab0AGUUE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 15:20:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0AGUUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 15:20:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3878E88C;
	Thu,  7 Jan 2010 15:20:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Bm001DtcRQUcy0g8wE2WoICAyVQ=; b=lBq1cstjkosETJBkpeSy7S6
	CiWbDorMb5ZMhX+yiheG4VQuMYqtVqv0CnSuThwzlyFnIFdJjMsgzbCvH1oidMUC
	fW5gy/u9lRcmjHZ5NObd1Fp7cg3cd4/ccg+gngRt4beZHdd/YYQ7VCaVgsQDCQbk
	Td1BvenajXItRpDRsmn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RKxP1xPm9J1tdDooKSSBLZJjD6xLKFPlH2B5KI4uJj5d6PUfa
	1pN38NVvccF/x+fFgYhfmxbk4FeW2KlYvgj1pEOZRdxKwEDQYJQNByUgerLn79jN
	BxZWIpudxwW03alVAzd0hRUhr63xI2/Y7u4kmpjr7Mast6PB04jvEWy5UM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC96C8E886;
	Thu,  7 Jan 2010 15:19:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B8438E885; Thu,  7 Jan
 2010 15:19:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07BAE34A-FBCA-11DE-8A9F-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136383>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> When rewriting commits on a topic branch, sometimes it is easier to
> compare the version of commits before and after the rewrite if they are
> based on the same commit that forked from the upstream. An earlier commit
> by Junio (fixed up by the previous commit) gives "--onto A...B" syntax to
> rebase command, and rebases on top of the merge base between A and B;
> teach the same to the interactive version, too.
>
> Signed-off-by: しらいし ななこ <nanako3@lavabit.com>
> ---
>  git-rebase--interactive.sh       |   21 ++++++++++++++++++++-
>  t/t3415-rebase-onto-threedots.sh |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 23ded48..f7ae02c 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -482,6 +482,25 @@ get_saved_options () {
>  	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
>  }
>  
> +LF='
> +'
> +parse_onto () {
> +	case "$1" in
> +	*...*)
> +		if	left=${1%...*} right=${1#*...} &&
> +			onto=$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
> +		then
> +			case "$onto" in
> +			?*"$LF"?* | '')
> +				exit 1 ;;
> +			esac
> +			echo "$onto"
> +			exit 0
> +		fi
> +	esac
> +	git rev-parse --verify "$1^0"
> +}
> +
>  while test $# != 0
>  do
>  	case "$1" in

I am a bit unhappy about the duplication.  The text of this function is
different from the one in "rebase" proper, but they implement essentially
the same logic.  I was tempted to suggest having a common helper function,
but as Dscho mentioned "rebase -i" implementation does not share much with
"rebase" (even though it shares the external command line interface from
the end user's point of view), and I don't see a readily available place
(other than in git-sh-setup) to do so.

Ideas?
