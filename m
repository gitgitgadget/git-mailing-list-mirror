From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] convert.c: correct attr_action
Date: Mon, 22 Feb 2016 00:04:05 -0800
Message-ID: <xmqqd1rp893e.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1456117898-30357-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Feb 22 09:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXlTe-0001mj-3p
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 09:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbcBVIEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 03:04:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753511AbcBVIEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 03:04:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B11543029;
	Mon, 22 Feb 2016 03:04:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NitbTJA5htCZwU0VlGvrTi7xI5g=; b=sM+NIY
	nLWC22uF+rC+bmfWLmv8r7CECoxZxDZf2HpE7PQH3FuZ8syTp4rHA2pNyKLmx9f4
	ysccRPF0E5yp9YI6fJnkBajqQTW5QLlWNjA9xsBTQ9Ri8CRCN6c1KNz/QOU9ca/k
	FdetjtAGIPUErbalpBpd2aZeniMSthnDwxbSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P1JXW4MW9s2hQsHEDl9zEM8vMm5dIiCB
	OxdbPC5zmB4/wAIdvxfx2DsZ+c+c42YMSGUHddL6dkCjsLOM/B5zasZ+bzqacF7o
	fXG2jl6H8qj1cCuMuEcSsFbWWaCOZhfOaBVIXa52VEviWYAwsQrjnOWdFypLmICU
	fRWUNsGTBlI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 826A043028;
	Mon, 22 Feb 2016 03:04:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 00AA543027;
	Mon, 22 Feb 2016 03:04:06 -0500 (EST)
In-Reply-To: <1456117898-30357-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 22 Feb 2016 06:11:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D89D45A8-D93A-11E5-8D80-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286892>

tboegi@web.de writes:

> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index fc4c628..f9c92c6 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -159,6 +159,39 @@ stats_ascii () {
>  
>  }
>  
> +attr_ascii () {
> +	case "$1" in
> +	"-text") echo "-text"	;;

 - I do not think you need to quote the case label.

 - Why the excessive trailing whitespaces before double-semicolons?

> +	lf)	echo "text eol=lf" ;;
> +	crlf)	echo "text eol=crlf" ;;
> +	text)
> +		case "$2" in
> +		"")	echo "text" ;;
> +		lf)	echo "text eol=lf" ;;
> +		crlf)	echo "text eol=crlf" ;;
> +		*) echo invalid_attr2 "$2" ;;
> +		esac
> +		;;
> +	auto)
> +		case "$2" in
> +		"")	echo "text=auto" ;;
> +		lf)	echo "text=auto eol=lf" ;;
> +		crlf)	echo "text=auto eol=crlf" ;;
> +		*) echo invalid_attr2 "$2"	;;
> +		esac
> +		;;
> +	"")
> +		case "$2" in
> +		"")	echo "" ;;
> +		lf)	echo "text eol=lf" ;;
> +		crlf)	echo "text eol=crlf" ;;
> +		*) echo invalid_attr2 "$2" ;;
> +		esac
> +		;;

I wonder if the above is easier to read if written like this:

	case "$1,$2" in
        "-text,*")		echo "-text" ;;
        lf,*)   	        echo text eol=lf" ;;
	...
	auto,)			echo "text=auto" ;;
	auto,lf | auto,crlf)	echo "text=auto eol=$2" ;;
	auto,*)			echo invalid_attr2 "$2" ;;
	...
        esac

as $1 and $2 are not arbitrary words, but you know exactly from what
vocabulary they are taken.
