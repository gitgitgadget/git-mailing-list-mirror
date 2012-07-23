From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g.
 ImageMagick's
Date: Mon, 23 Jul 2012 13:47:57 -0700
Message-ID: <7v4noykxvm.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
 <500DA7F3.3000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPXz-0001KF-7u
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab2GWUsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:48:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab2GWUsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:48:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D0D78E4;
	Mon, 23 Jul 2012 16:48:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Pb3qpoENV/K96dfPFIrO7LYs4k=; b=E2wwnN
	xW3P+91N+avJAZlvl/avcdobKnGIe/2U6xHp1Tgqb0cw5jOURQZVHa6jrGXDsoap
	nx2SnCvlYm7kh9qK5JNxRrN8gEbG+rDPn8kxceNiyHPog4ktUCtgxSjLR0hPm9Jg
	3cAx14i3XYxE6knKC4gMlIPtjEGHqOgYghWhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Thn0xHwDGXxVap33IxMxT29ERVZyNGah
	28JKA+d50/DkN81RUwxeCreowCzGxnbVyUz9OLGwJzqbSQpFVKrPheg7v3SXPNUL
	DfUbcXkqFHrn+I3WavKVwHQXvxrH+tqyNnA6fOhNLX80l7id3WgfqQslcoEwnA2h
	5zUDD6Aw6hQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E959678E3;
	Mon, 23 Jul 2012 16:47:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E7C078E2; Mon, 23 Jul 2012
 16:47:59 -0400 (EDT)
In-Reply-To: <500DA7F3.3000403@gmail.com> (Sebastian Schuberth's message of
 "Mon, 23 Jul 2012 21:37:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B01220BC-D507-11E1-8874-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201977>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  mergetools/araxis | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mergetools/araxis b/mergetools/araxis
> index 64f97c5..f8899f8 100644
> --- a/mergetools/araxis
> +++ b/mergetools/araxis
> @@ -16,5 +16,12 @@ merge_cmd () {
>  }
>  
>  translate_merge_tool_path() {
> -	echo compare
> +	# Only accept "compare" in a path that contains "araxis" to not
> +	# accidently use e.g. ImageMagick's "compare".
> +	if type compare | grep -i araxis >/dev/null 2>&1
> +	then
> +		echo compare
> +	else
> +		echo "$1"
> +	fi
>  }

I do not use araxis, and I do not know how rigid its installation
procedure is to prevent the end user from naming a path that does
not have the string in it.

For example, when the user tells it to install in "/home/ss/bin", if
it installs its "compare" program in "/home/ss/bin/araxis/compare"
without allowing the "/araxis/" part to be stripped away, the above
heuristics is sufficiently safe.  Otherwise, it is not.

It is unclear from your proposed commit log message what assurance
do we have that it is installed under such a path and why the
heuristics the patch implements is the sane way forward.

Please convince me.
