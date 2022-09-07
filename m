Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F9C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 22:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIGWkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiIGWkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 18:40:21 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38F63F0E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662590393;
        bh=1I26IWSws0ga7fR6twiLPBHvWjwTBQyeJmjkef5jy0U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Dfs0GfBuYSIcykMu3u0y8FBcEjxEz9FGEl+tKccmgip9jmDlY7z2X9Y+8ymbPpbiA
         leyh+vu9a/MdUdZXhL7q3s69Dek40afl29HI7QqgQMWBWclIsd6qKPAcjOKxKanpFS
         Z3HJCJ/WzVkeCrbK4RkBDYGzz4DXRm5TLjt363ew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.34] ([79.203.25.52]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHUC-1pGR5l1SIK-00xP5A; Thu, 08
 Sep 2022 00:39:53 +0200
Message-ID: <22402f5d-c463-acee-f57d-e507f23822ca@web.de>
Date:   Thu, 8 Sep 2022 00:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Re* [PATCH] tests: replace mingw_test_cmp with a helper in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
 <xmqqwnbv7trp.fsf@gitster.g> <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
 <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de> <xmqq7d2fywvr.fsf@gitster.g>
 <xmqqlequsvt4.fsf_-_@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqlequsvt4.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:acclyx02qTYQnsLGRlv7IuhjDAiDdh32W5o9X6DHhvUxrsgUkws
 HWp+G/onXWa37hyr1BdN6LNGLLCn3MQr+BCSLGu0CpKSDKerh7E8irN9ER4+Ui0YqtNAVII
 G61Gyb11SS86s156M3b8NTdmeREySBj69BEOAhiMArWZUERV1ow/idzm1AVsqs+4Y6K/Aij
 EgFdd3fZ2J2umj6+yLotg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bd9cIxVqBYc=:R2jq0o659jGNlsyVFON/gA
 V/E9HgnHGbHTQXjcYlTB6KJwHDs1I3tIJkaA12ZXU1FGfIcsDb9WGALRcu3711FGuz/b3nCIn
 J5XP2xsZgt0lBLoYCGqhjfwt2a4AdWx72V0AhPn8qDu2U6gsFXZjnXgj95IFZ4kvyuP04wuSb
 CDkBWIu8x/70kdyzpEoS0SE4TJ+VKyy4TqVOkJZvX92SRTB6KrCTc0Uv+DGZ8yslO7DCwo2xY
 +QcQadJw6d+zRAMTA5tLyegY6C4qVU43qx2ra3qBRp6n23KWlmcpNQrPG76FN9g089qSCT6A1
 rnj4VsJms6vINN7iLky1p1mE2ZnE8SnLl/4VSVIP7rzV3fF4qUMCKVKmP8hZ+zbUdNcuQNiIi
 hAFBVMdA0wx2vxryiW8Z2YnYtZp/E+8j5HKVN+gMrCH0NDREASsSkztD01de1gtar5AxspzxW
 AV/1u1vwOOEtd8nzzZRh+9zG0Vq2l92ya0/qPRUk5VbyZ6CRweKf/MzVE23lOeDp/lQMi+7yi
 sZzPE9bWOuoX+1tKPB2jen600qqHTJRUGUtWhgWP1RDRtUBtA3/t55xyLLpbLXcGKRpeP8vm8
 eUPP0Urgd16sf/2DAH8be/OSXh5ETpKmmHeMJmIyd96EYhafrf6Lbg51ZCU75RZAB1stoBDiN
 7kmgfjuPpxd84KG4IotvPAYzonPcXX544fnZ8/yYqLZ54vjtmhESpLXBtwy0LP/IJdnPrja3M
 ykX2Fuw4k+Kr/ouFUzQRmEYvB5o5pPobQ49wEjGHmBWOEVL0dkFAJPDoNzvezS2vgK0yeGJVe
 AVtW94W0BgMsdqj+0k5/u/Ciub/2xd5RPpjMVwq5aOxNnmyhLWmEwVW2O9PADpLR1nFG/xEfk
 yU8gSdlHTyCS5dacg7AaxBVsUwmBEg/sg8GQbzvngi+i3kmJByBvI9nap8jhindwFf1xNZKpy
 HjwGGqP/fzv6TxehAMntA4n8qGwQdWKqku0LSzhr9grwfzI6qEaWmHjW+yGDJSBDCyWfWSRKR
 8nCrCimtxT2S0opsA/0dtMV9t/0aVKI0gcSJTPCNsYkt2EsWy3TMetIdoWQ7TwxuQEEdEvqEp
 ipxlsFi9Ug/+hWpNTXex3S0DHJq+UvwpATdksGQOO8PSGblY2LPItojnS2++C8Lc4bitXyRV3
 lTVs0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.09.2022 um 23:45 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> "git diff --no-index - -" also doesn't complain, by the way.
>>
>> True, but in this case hopefully it is worth to call it out, as both
>> this code that uses "diff --no-index" and "diff --no-index" itself
>> came from the same author ;-)
>>
>> I think "git diff --no-index - -" should just exit 0 after slurping
>> all its input (i.e. allow it to be placed downstream of a pipe
>> without blocking the upstream), but it is also fine to exit with 0
>> without reading a single byte from the standard input.  Of course
>> the latter is easier to implement ;-)
>
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] diff: "--no-index - -" compares the same standard input
>
> Conceptually, "git diff --no-index - A" slurps the standard input to
> the EOF and compares it with the contents of A, so it is a natural
> extension for "git diff --no-index - -" to slurp the standard input
> to the end, and compares it with itself, which should always yield
> "true".
>
> There can be two plausible implementations.  We could read and
> discard the input to the end and exit 0.  It would allow us to avoid
> sigpipe on the upstream command
>
>     $ dd if=3D/dev/zero bs=3D1m count=3D1 | git diff --no-index - -
>
> As we can tell the outcome without even consuming a single byte from
> the standard input, we can just notice the two input files specified
> are "-" and immediately exit.  It would allow us to give a correct
> answer to
>
>     $ git diff --no-index - - </dev/full
>
> but can kill the command on the upstream side of a pipe that feeds
> us.
>
> We pick the latter (i.e. not touching the input at all), simply
> because it is more efficient.  Data producer that can be placed on
> the upstream side of a pipe should always be prepared for a consumer
> that does not consume all its output (e.g. "head" and pager) anyway.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff-no-index.c          | 11 +++++++++++
>  t/t4053-diff-no-index.sh | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 18edbdf4b5..940b66b4c8 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -278,6 +278,17 @@ int diff_no_index(struct rev_info *revs,
>  			p =3D to_free[i] =3D prefix_filename(prefix, p);
>  		paths[i] =3D p;
>  	}
> +	if (paths[0] =3D=3D file_from_standard_input &&
> +	    paths[1] =3D=3D file_from_standard_input) {
> +		/*
> +		 * "git diff --no-index - -".  We are asked to compare
> +		 * what came from the standard input with itself; we
> +		 * know they are the same without even reading a
> +		 * single byte.
> +		 */
> +		ret =3D 0;
> +		goto out;
> +	}
>
>  	fixup_paths(paths, &replacement);
>
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 3feadf0e35..d089d9c2b1 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -156,6 +156,16 @@ test_expect_success 'diff --no-index normalizes mod=
e: no changes' '
>  	test_must_be_empty out
>  '
>
> +test_expect_success 'diff --no-index with standard input' '
> +	echo foo >x &&
> +	echo bar >z &&
> +	git diff --no-index - x <x &&
> +	git diff --no-index x - <x &&
> +	test_must_fail git diff --no-index - x <z &&
> +	test_must_fail git diff --no-index x - <z &&
> +	git diff --no-index - - <x
> +'

This test passes even without the changes to diff-no-index.c above.
Because diff.c::diff_fill_oid_info() sets an all-zero object ID for
stdin on both sides, I guess, so the comparison is skipped even though
the data is read already for the first dash and the data size of the
second one is thus zero?

> +
>  test_expect_success POSIXPERM 'diff --no-index normalizes mode: chmod +=
x' '
>  	chmod +x y &&
>  	cat >expected <<-\EOF &&
> @@ -180,6 +190,7 @@ test_expect_success POSIXPERM 'diff --no-index norma=
lizes: mode not like git mod
>  '
>
>  test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mod=
e not like git mode (symlink)' '
> +	rm -f z &&
>  	ln -s y z &&
>  	X_OID=3D$(git hash-object --stdin <x) &&
>  	Z_OID=3D$(printf y | git hash-object --stdin) &&
