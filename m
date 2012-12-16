From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] tests: Allow customization of how say_color() prints
Date: Sat, 15 Dec 2012 22:34:23 -0800
Message-ID: <7vobhuqzdc.fsf@alter.siamese.dyndns.org>
References: <50CCCB86.5080701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Dec 16 07:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk7rB-0005Um-Ni
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 07:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110Ab2LPGe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 01:34:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845Ab2LPGe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 01:34:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B9BA666F;
	Sun, 16 Dec 2012 01:34:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65vfNPFGBUV0S8W9jwIRTpwkeLo=; b=l5QCDk
	u8NMSCym5CiygvchTuUeww/fNfr8rG0Zrw4Br/f2WAqbfYatZI3Caey774B2CjUf
	vStY37mpYz7AdX6tyvKdUa1rt+/G3gEs6a+jZVE2DgA1eDYE/6WImK6ToDEc6Dv5
	a2xwPj4VDeWsMP+LoGekByztM21y4fqWY+PrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWKnvO24uWWxtiQdH2/zRicEs9Knondi
	+7DvgIPWtib4FBh633q30jXDfWReCslWgYBaSZvvg6lfhfFRxofABONrSw4GhU+Q
	S+Zg3zupntzRZdJH6jYtah7EnZb07/tA6aA8jvqSNEYJ//HbhpoIbjIBDY4G0VGR
	NHE0CFxSIpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48F72666E;
	Sun, 16 Dec 2012 01:34:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A781666D; Sun, 16 Dec 2012
 01:34:25 -0500 (EST)
In-Reply-To: <50CCCB86.5080701@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 15 Dec 2012 19:12:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A29AD1C6-474A-11E2-9B34-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211581>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f50f834..9dcf3c1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -202,6 +202,15 @@ do
>  	esac
>  done
>  
> +if test -z "$GIT_TEST_PRINT"
> +then
> +	GIT_TEST_PRINT="printf %s"
> +fi
> +if test -z "$GIT_TEST_PRINT_LN"
> +then
> +	GIT_TEST_PRINT_LN="printf %s\n"
> +fi
> +
>  if test -n "$color"
>  then
>  	say_color () {
> @@ -221,7 +230,7 @@ then
>  			test -n "$quiet" && return;;
>  		esac
>  		shift
> -		printf "%s" "$*"
> +		$GIT_TEST_PRINT "$*"
>  		tput sgr0
>  		echo
>  		)
> @@ -230,7 +239,7 @@ else
>  	say_color() {
>  		test -z "$1" && test -n "$quiet" && return
>  		shift
> -		printf "%s\n" "$*"
> +		$GIT_TEST_PRINT_LN "$*"
>  	}
>  fi

As you said, this is ugly and also unwieldy in that I do not see an
easy way for a platform/builder to define something that needs to
pass a parameter with $IFS in it in these two variables.

Why does your printf die in the first place???
