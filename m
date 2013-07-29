From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid using `echo -n` anywhere
Date: Mon, 29 Jul 2013 10:07:27 -0700
Message-ID: <7vr4ehz44w.fsf@alter.siamese.dyndns.org>
References: <CAFM=nTeRpZ=Y-+4KMCZd8Qj-9K105uSquh8Y=7mC3aqJiE0gbQ@mail.gmail.com>
	<1374927093-16663-1-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	"David A. Greene" <greened@obbligato.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3qv2-0006Hp-UX
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3G2RHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:07:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab3G2RHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:07:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E226734E97;
	Mon, 29 Jul 2013 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NjgPpRLLRjzoxSJiiA8oVzp4LZM=; b=K8/Vr8TiU+xNxZ+XWoz2
	NH+RclLMl3QFhnVv6yZisWLxwUE/9/K/KWn1P74UkcWQERCqboblueFIIGw1b5o4
	gaJTSFrspPXKPvq0yH0MNJgeOW5f8vOrX7Vj8+oCiAwslT0KtglB2P2+UAke18ee
	Phajw5v9yXbmzLdr5R7rFRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HPtdDpkn4fgMg9vdpPePHMKrdAG6TIu72zIyn+L2ws+ugz
	aE2Nr7k3lEDUFKwocxW19C4Bvqc86f7ZlSoBLF5TPRkALbfDX33CFrlvsVe/wn+b
	+xOxvYOO0ef+WCONZA6gu2EuQ3Zeaa0v0vFnIgv+5elRPrxIWfspNBr2KKvHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA5F534E96;
	Mon, 29 Jul 2013 17:07:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EF1034E93;
	Mon, 29 Jul 2013 17:07:29 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59D45F4C-F871-11E2-8283-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231300>

Lukas Fleischer <git@cryptocrack.de> writes:

> `echo -n` is non-portable. The POSIX specification says:
>
>     Conforming applications that wish to do prompting without <newline>
>     characters or that could possibly be expecting to echo a -n, should
>     use the printf utility derived from the Ninth Edition system.
>
> Since all of the affected shell scripts use a POSIX shell shebang,
> replace `echo -n` invocations with printf.
>
> Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
> ...
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index c61d535..ae44117 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -161,7 +161,7 @@ test_perf () {
>  		echo "$test_count" >>"$perf_results_dir"/$base.subtests
>  		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
>  		if test -z "$verbose"; then
> -			echo -n "perf $test_count - $1:"
> +			printf "%s" "perf $test_count - $1:"
>  		else
>  			echo "perf $test_count - $1:"
>  		fi
> @@ -170,7 +170,7 @@ test_perf () {
>  			if test_run_perf_ "$2"
>  			then
>  				if test -z "$verbose"; then
> -					echo -n " $i"
> +					printf " %d" "$i"

I'd prefer to see '%s' here; it is more faithful transliteration
from "echo -n".

Thanks, will queue with the above tweak.

>  				else
>  					echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
>  				fi
