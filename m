From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-grep: Update tests (mainly for -P)
Date: Mon, 23 May 2011 11:57:04 -0700
Message-ID: <7vei3pt3yj.fsf@alter.siamese.dyndns.org>
References: <1306064248-23092-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 01:03:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOe9o-0004He-HX
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672Ab1EWXDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 19:03:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1EWXDX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 19:03:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B05654AAB;
	Mon, 23 May 2011 19:05:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=y0LzinusbrN84HruBUy7RQ9A0
	D4=; b=rurIysIPKqoT2T9r4EcuXRXTTAQTG3h3nndJt4+SGeBdhgaSXufEd4wXb
	dnYNr4ms6eF+8zTTGngMSGM8XYkm6SOvPFKiKhWOa0pwTiRwMonVQUxMIbgf3IKI
	tgUEkkkluFHGnRGJJRhBgyykX2EQ7dZW1bfyK40WsidXEdy2sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=QBQf4ftq0cqIKf+u2dK
	/HdTSBBqgbzljDXCZKakEE3eeRefoxuDYkh+Ozua+BR0TUPBlEz04FM3GfKwyX2D
	elRsaJo8PW/QmzNQB5XX4pYV0pSdZhpm5ttstR3CDEBtcdBfx1FmmGnre+OnFC9T
	85IqMlMzqWwgVH1CPsBnp4bQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BB954AA5;
	Mon, 23 May 2011 19:05:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9541A4AA1; Mon, 23 May 2011
 19:05:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26903B88-8591-11E0-8612-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174288>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> This patch adds few more tests to git-grep concerning the
> -P/--perl-regexp option.
>
> While at it, add some generic tests for grep.extendedRegexp config
> option, for detecting invalid regexep and check if "last one wins" ru=
le
> works for selecting regexp type.
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
> This is the promised update to tests and is meant to be applied on to=
p of
> mk/grep-pcre.

Thanks, will queue.

>  t/t7810-grep.sh |   85 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 85 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index e845218..e061108 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -32,6 +32,11 @@ test_expect_success setup '
>  		echo Hello_world
>  		echo HeLLo_world
>  	} >hello_world &&
> +	{
> +		echo aab
> +		echo a+b
> +		echo a\\+b
> +	} >ab &&

At some point it would be a good idea to clean these up to use either
cascading && or

	cat >ab <<\-EOF &&
        ...
        EOF

everywhere.
