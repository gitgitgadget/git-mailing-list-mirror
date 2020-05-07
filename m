Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C67C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89BB2070B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mFhCARtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEGOxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 10:53:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51966 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgEGOxz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 10:53:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3357BD7608;
        Thu,  7 May 2020 10:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tCQ4asrUwikQ
        Rq2mR7a4Gosh9ME=; b=mFhCARtIQyTggJh8doy2sYjWq/d3gRHHgHFCL6gST6D1
        dHoyKWc9vR5JdsrR3yGiq1EHBX7p7oE5wDbs3JunWZ06UKcnUyx2NbFqE9QfSsIl
        KqZgL21AqWrHp0c+Eh7C1X8hTAcmOVlgXYFw2Y5vhPqdE20tjT5yKeM+09asfg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CzNDRL
        Roxwp5j3B/qxtURwqHUP3eeNS4TEsKJIm+26HEjiaxM2n20mTplyEbMebyJ/jXTM
        SkdJ5dxyPSCqIdB1VxSZx7HJhdT1wU2FeodwZeVeW0sMh33Utz7NliMalbF8PAdg
        ACMlv0isrnn3ceVqDIDC2vDqjbDOU0VOSu1f4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CEA1D7607;
        Thu,  7 May 2020 10:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 61773D7606;
        Thu,  7 May 2020 10:53:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
References: <20200507055118.69971-1-carenas@gmail.com>
Date:   Thu, 07 May 2020 07:53:47 -0700
In-Reply-To: <20200507055118.69971-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 6 May 2020 22:51:18 -0700")
Message-ID: <xmqqr1vv4wzo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F5D5CD6-9072-11EA-8DA3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 662f9cf154 (tests: when run in Bash, annotate test failures with file
> name/line number, 2020-04-11), introduces a way to report the location
> (file:lineno) of a failed test case by traversing the bash callstack.
>
> The implementation requires bash and is therefore protected by a guard
> but NetBSD sh will still have to parse the function and therefore will
> result in:
>
>   ** t0000-basic.sh ***
>   ./test-lib.sh: 681: Syntax error: Bad substitution
>
> Enclose the bash specific code inside an eval to avoid parsing errors
> and while at it, simplify the logic so that instead of traversing the
> callstack just pop the two topmost entries that are required.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Is the rewritten bash-snippet in the evaled text what Dscho
suggested us to use, or is it totally yours?  I know Dscho helped to
shoot down some "simpler" reimplementations you came up with,
pointing out how they were broken, but it is unclear how we ended up
with this version.

I wish you didn't do the "while at it" rewrite in the same patch.
If it were only "put bash-only stuff in an evaled string", it would
have been a lot more comfortable applying it and merging quickly
down, as it would be clear that we won't be breaking bash codepath
and we'd be helping other shells.  With the "while at it", you made
it quite unclear.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/test-lib.sh | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1b221951a8..60b8e70678 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -677,14 +677,13 @@ die () {
> =20
>  file_lineno () {
>  	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> -	local i
> -	for i in ${!BASH_SOURCE[*]}
> -	do
> -		case $i,"${BASH_SOURCE[$i]##*/}" in
> -		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return=
;;
> -		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: =
${1+$1: }"; return;;
> -		esac
> -	done
> +	eval '
> +		local n=3D$(echo ${#BASH_SOURCE[*]})
> +		if test $n -ge 2
> +		then
> +			echo "${BASH_SOURCE[$n - 1]}:${BASH_LINENO[$n - 2]}: $1: "
> +		fi
> +	'
>  }
> =20
>  GIT_EXIT_OK=3D
