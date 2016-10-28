Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EDD2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 12:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760530AbcJ1MuN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 08:50:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53560 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760027AbcJ1MuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 08:50:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0F6447DE;
        Fri, 28 Oct 2016 08:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2G3E7scRxgah
        ZxOnbJ5opAoov70=; b=gUmJki8HzMjj1hP2MtPkSqhCTuoGsjKrxIolu8Od0BFm
        vbK8h97qScUPfqp4cjNl+0ZvtU2IhRrvgU0U9FGkzYW/wLWhYE9iZm3d8EuigTBv
        7f/0sdLrhH3KUAujLE5CfpSEPBhyI4Qibu5oV2P2LrG25AhtYyMu1pQFiqVs628=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QqukUb
        PdcyxP7vc/+nzeYF5+Y7l7qELyiDFGjxybXeyjBe80xRPwrAGuqX2qob+iPVQkme
        Mqsm2+JTKNpgEloJbahlRWh/H0r5sbOa1QA2MuQqrT9DpyjJ9MvCaZBdvJ9airyM
        AZP6Et6QT3mRUgEU647xRe7F0ncX9JR2iM8vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05264447DC;
        Fri, 28 Oct 2016 08:50:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72C98447DB;
        Fri, 28 Oct 2016 08:50:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] valgrind: support test helpers
References: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de>
Date:   Fri, 28 Oct 2016 05:50:07 -0700
In-Reply-To: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 28 Oct 2016 00:14:00 +0200")
Message-ID: <xmqqshrg3af4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F195D92-9D0D-11E6-ABF4-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Tests run with --valgrind call git commands through a wrapper script
> that invokes valgrind on them.  This script (valgrind.sh) is in turn
> invoked through symlinks created for each command in t/valgrind/bin/.
>
> Since e6e7530d (test helpers: move test-* to t/helper/ subdirectory)
> these symlinks have been broken for test helpers -- they point to the
> old locations in the root of the build directory.  Fix that by teaching
> the code for creating the links about the new location of the binaries,
> and do the same in the wrapper script to allow it to find its payload.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Hmph.  I somehow thought this was supposed to have been fixed by
503e224180 ("t/test-lib.sh: fix running tests with --valgrind",
2016-07-11) already.



>  t/test-lib.sh          |  9 ++++++++-
>  t/valgrind/valgrind.sh | 12 ++++++++++--
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index b859db6..a724181 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -809,7 +809,14 @@ then
>  		return;
> =20
>  		base=3D$(basename "$1")
> -		symlink_target=3D$GIT_BUILD_DIR/$base
> +		case "$base" in
> +		test-*)
> +			symlink_target=3D"$GIT_BUILD_DIR/t/helper/$base"
> +			;;
> +		*)
> +			symlink_target=3D"$GIT_BUILD_DIR/$base"
> +			;;
> +		esac
>  		# do not override scripts
>  		if test -x "$symlink_target" &&
>  		    test ! -d "$symlink_target" &&
> diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
> index 4215303..669ebaf 100755
> --- a/t/valgrind/valgrind.sh
> +++ b/t/valgrind/valgrind.sh
> @@ -1,11 +1,19 @@
>  #!/bin/sh
> =20
>  base=3D$(basename "$0")
> +case "$base" in
> +test-*)
> +	program=3D"$GIT_VALGRIND/../../t/helper/$base"
> +	;;
> +*)
> +	program=3D"$GIT_VALGRIND/../../$base"
> +	;;
> +esac
> =20
>  TOOL_OPTIONS=3D'--leak-check=3Dno'
> =20
>  test -z "$GIT_VALGRIND_ENABLED" &&
> -exec "$GIT_VALGRIND"/../../"$base" "$@"
> +exec "$program" "$@"
> =20
>  case "$GIT_VALGRIND_MODE" in
>  memcheck-fast)
> @@ -29,4 +37,4 @@ exec valgrind -q --error-exitcode=3D126 \
>  	--log-fd=3D4 \
>  	--input-fd=3D4 \
>  	$GIT_VALGRIND_OPTIONS \
> -	"$GIT_VALGRIND"/../../"$base" "$@"
> +	"$program" "$@"
