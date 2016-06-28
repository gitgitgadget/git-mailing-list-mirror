Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142FA2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbcF1Qcb (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:32:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752060AbcF1Qca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 12:32:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D7F0244A4;
	Tue, 28 Jun 2016 12:32:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qaXv3Df+W0jp
	2pTtAPSW9mjLVx4=; b=duG4hzsfczq7jA4iB9bPfSsnjRZHkjng6qfqPXkB9qD3
	eN8g6YgSL5IuXk362CHL7t4j2WP49MJa/yhO/Q3J5qvMrnBZ4Rl8KGZngzF3sTJg
	tETH614yKcDnwUUufkDIEkOabJAS/oZbzKl4TD3a0paSB8ISv19GxLNi2Qlcxtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JPsM+h
	uCsD9GuY6kchf7Z+W59qqboRYGPFwViqk7T3Km/fGlqPr1UhaDxbV3GUs/yJ5zAq
	3YAF9ZEIEMTBjII0QX96SoS9mHv1VTj04OqaIREXL4nPp+Sy9YfjGwF522PZ3mXJ
	sWdnkNSxkr8wCZQR1nc4hBGbA1iEDTQS+53iI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 65A07244A3;
	Tue, 28 Jun 2016 12:32:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0CE1244A2;
	Tue, 28 Jun 2016 12:32:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<git-dpa@aegee.org>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] ./configure.ac: Detect SSL in libcurl using curl-config
References: <20160628120434.28105-1-git-dpa@aegee.org>
Date:	Tue, 28 Jun 2016 09:32:20 -0700
In-Reply-To: <20160628120434.28105-1-git-dpa@aegee.org> (=?utf-8?B?ItCU?=
 =?utf-8?B?0LjQu9GP0L0J0J/QsNC70LDRg9C30L7QsiIncw==?= message of "Tue, 28
 Jun 2016 12:04:34 +0000")
Message-ID: <xmqqeg7h9svf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3FABE36-3D4D-11E6-A63D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Дилян Палаузов  <git-dpa@aegee.org> writes:

> The API of libcurl does not mention Curl_ssl_init() and when curl is built
> with -flto, the Curl_ssl_init symbol is not exported.
>
> https://curl.haxx.se/libcurl/using/ suggests calling
>   curl-config --feature | grep SSL
> to see, if the installed curl has SSL support.  Another approach would
> be calling curl_version_info and checking the returned struct.
>
> This patch removes the check for the Curl_ssl_init exported symbol from
> libcurl and uses curl-config to detect SSL support in libcurl.
>
> Signed-Off-By: Дилян Палаузов <git-dpa@aegee.org>
> ---

This is a tangent, but the patch made me notice [*1*] that a user
cannot build Git without libcurl support if curl is installed on the
system, with something like:

	$ ./configure NO_CURL=NoThanks

I do not know if that is a problem (it certainly is NOT a new
problem introduced by your change).

Anyway, will queue.

Thanks.

[Footnote]

*1* The updated code does not have any branch based on $NO_CURL the
    original used to have, even though it does branch on
    $NO_OPENSSL, which is why I got curious.

>  configure.ac | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index c279025..5e9ba59 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -528,16 +528,6 @@ AC_CHECK_LIB([curl], [curl_global_init],
>  [NO_CURL=],
>  [NO_CURL=YesPlease])
>  
> -if test -z "${NO_CURL}" && test -z "${NO_OPENSSL}"; then
> -
> -AC_CHECK_LIB([curl], [Curl_ssl_init],
> -[NEEDS_SSL_WITH_CURL=YesPlease],
> -[NEEDS_SSL_WITH_CURL=])
> -
> -GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
> -
> -fi
> -
>  GIT_UNSTASH_FLAGS($CURLDIR)
>  
>  GIT_CONF_SUBST([NO_CURL])
> @@ -550,6 +540,17 @@ AC_CHECK_PROG([CURL_CONFIG], [curl-config],
>  
>  if test $CURL_CONFIG != no; then
>      GIT_CONF_SUBST([CURL_CONFIG])
> +    if test -z "${NO_OPENSSL}"; then
> +      AC_MSG_CHECKING([if Curl supports SSL])
> +      if test $(curl-config --features|grep SSL) = SSL; then
> +         NEEDS_SSL_WITH_CURL=YesPlease
> +         AC_MSG_RESULT([yes])
> +      else
> +         NEEDS_SSL_WITH_CURL=
> +         AC_MSG_RESULT([no])
> +      fi
> +      GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
> +    fi
>  fi
>  
>  fi
