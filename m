From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib.sh: minor readability improvements
Date: Wed, 27 Apr 2011 10:28:25 -0700
Message-ID: <7vmxjb8uyu.fsf@alter.siamese.dyndns.org>
References: <4DB810E1.3080102@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:28:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8Xa-00017D-QG
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759675Ab1D0R2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 13:28:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759626Ab1D0R2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:28:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92E594A22;
	Wed, 27 Apr 2011 13:30:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NIkIWRNoNdYluoABret9SjIpNX4=; b=xJaPy0
	J7YhQ8/F34LxTi8JyNgLyiFKFmF/rFB7x4UCEPDZfjLVX6B9fP7kjVlFFn7UUSha
	fSAgMqxbzJibopehE3GTH5TTxAZiEnCLWMhQ72xQgFnU16TsBpTJ2nv+N1mvqn6R
	R28LfrEUtddO6QCSWBFIesQJITy3tvEqnaeHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WNrGCAAER7CvmwFxNPbSXwoYxlPbAPWL
	JYWXQLbLBOFjn3zU+Hy4HFdwcwLms6fHx+6Yfrzx2zDH2WNjrq/fPx+uqAtP/kER
	/wP+Pkjrr5OmWlPzHTAbE9kE/tAfT+mIXpR5F7dLRJapyF5IEBYP+AHf7x93fCWe
	87iRp5xx2YE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 647204A20;
	Wed, 27 Apr 2011 13:30:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 62B334A1A; Wed, 27 Apr 2011
 13:30:29 -0400 (EDT)
In-Reply-To: <4DB810E1.3080102@debugon.org> (Mathias Lafeldt's message of
 "Wed, 27 Apr 2011 14:49:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D9478BC-70F4-11E0-BD8F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172250>

Mathias Lafeldt <misfire@debugon.org> writes:

> Tweak/apply parameter expansion. Also use here document to save
> test results instead of appending each line with ">>".

Thanks.  A few minor nits.

> Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
> ---
>  t/test-lib.sh |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index abc47f3..b30725f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -24,7 +24,7 @@ done,*)
>  *' --tee '*|*' --va'*)
>  	mkdir -p test-results
>  	BASE=test-results/$(basename "$0" .sh)
> -	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
> +	(GIT_TEST_TEE_STARTED=done ${SHELL-"sh"} "$0" "$@" 2>&1;

Looks unnecessary.  Superstition?

>  	 echo $? > $BASE.exit) | tee $BASE.out
>  	test "$(cat $BASE.exit)" = 0
>  	exit
> @@ -575,7 +575,7 @@ test_external () {
>  test_external_without_stderr () {
>  	# The temporary file has no (and must have no) security
>  	# implications.
> -	tmp="$TMPDIR"; if [ -z "$tmp" ]; then tmp=/tmp; fi
> +	tmp=${TMPDIR:-"/tmp"}
>  	stderr="$tmp/git-external-stderr.$$.tmp"
>  	test_external "$@" 4> "$stderr"
>  	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
> @@ -801,12 +801,14 @@ test_done () {
>  		mkdir -p "$test_results_dir"
>  		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
>  
> -		echo "total $test_count" >> $test_results_path
> -		echo "success $test_success" >> $test_results_path
> -		echo "fixed $test_fixed" >> $test_results_path
> -		echo "broken $test_broken" >> $test_results_path
> -		echo "failed $test_failure" >> $test_results_path
> -		echo "" >> $test_results_path
> +		cat >> "$test_results_path" <<EOF
> +total $test_count
> +success $test_success
> +fixed $test_fixed
> +broken $test_broken
> +failed $test_failure
> +
> +EOF

It may probably be even easier to read if you indented the whole thing,
using the dash before the here-doc marker, like so:

	cat >>"$test_results_path" <<-EOF
	total $test_count
        success $test_success
        ...
        EOF
