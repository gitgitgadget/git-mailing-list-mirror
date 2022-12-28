Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A3C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 20:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiL1Uxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 15:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1Uxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 15:53:45 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3AF6555
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672260817; bh=Lc5tYjhKSTnK7+bFczGl17wT4IdxPQkChJDMdwDJa64=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=l3g5QuRv4CsE5BBVgRVeynQXv82CkIQtzmC9qx/Pdp8fiqmjKVAZIbhgvjiQSuwcf
         SdnaSyHHH7Jis49IEVvsh9xCWILejTIpCQGS9MwvnXjY54ngw4HGOgZ66OTyFT87/x
         8Wmnf7pIuaE+ilYO+n/zqUalgQFUCT8t1/bwjoPm4korAJoCnb6yai82jgqRmXe68b
         DM0sLpMSpJBlF32zP5pssYyXVNXWL+rx0ZfldLEcNh7UChR1Is10Ffnv14yjDXyqTW
         7WMDhReuYDkTJe3xJ22iawn6AIeG3WLH2QsWcyHP94oHbWqWyWQRkIn3KJ9zcvhqJK
         xsbcSCRzZHVew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALeD-1p0QAM0QRv-00Blfw; Wed, 28
 Dec 2022 21:53:37 +0100
Message-ID: <de30d137-5857-deb8-b497-56205a65b787@web.de>
Date:   Wed, 28 Dec 2022 21:53:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 11/20] worktree: fix a trivial leak in prune_worktrees()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-11.20-ee05254eb6a-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-11.20-ee05254eb6a-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M9Lyg1b/hB20Vdn3fmgxeowWK2Fbjz6/OIWxylbidzQrqCkOI6h
 RnyFH6aX6dEAKAAa8AoZO4TJNKxCNy90jUquBcFsGBVv6TkbeHTnn8hVQRlQRaKYF/nT/f+
 zZJ3blcLWc5smRtr+nQVWdIm/TdGAO1mvyD62qv6UrFCgx5N1hfL9J94FTpk9+7I9RE1p+u
 0/gBPbbIi57/tCg/zmh7g==
UI-OutboundReport: notjunk:1;M01:P0:Fxw53vxFGjM=;49Yw7+cOaLR0atgmCWEeRiCY+dA
 eqQQsrlru8fEc48+0bac8+OUaUdP3yLyV/a1P+6KBlu/9oRd1c6OQCFu65K5aTHdTda1YMFps
 YSi8JtV7XNC2S8hnVu2eOnTeCJ/LKRzmSFJG1zU1c+4AuCr2oRBmN+d2tFxZq0WkCuIZUf58d
 2OuAZMHJjZPMF6NCJeMKJRL3UCa+8QVh2kzttHRyiy+lJ5NKnOWGOuEmR/rb/EK4y+Y3QYark
 ou2HEZxvEcLtYYxwaJ6/g/0LgSqzo5BoslWCR+WV3TPhnvzqDXh3jnURKT/hNWH6weIBPFm41
 xjvP4OQ7O1PU27nT232C1guahw5CnPuSMqGn/Sh7WVwWWSX8KlfF35f+dhd+E3P6R9DW1GKUI
 AIs7nrls4WU8YNzEjAfcCjNT74fy8tfg6pHz5DWHTOyclS+2yUdAJphcnq+WRfmKAUMkcaxNe
 V1KxOpw6IcoYjIw4DPpOcfZKwHdDNEaLyozZT+NCwL9p8GfMiNZnf4H6HSVmhRE3kvSU6zW0K
 2GwVFuO2nAeKlIfdX2ZBNfEdVgPPl+l8ZWe91ZyyhwD3vt5WY8zwPfsP0Zg/qymJtxuxuwPy3
 qpk8p1SY2g4dhTby2SAa8TKdJAIPdKMHCLOupbqnr/NwrDgNFXBXM7XD74WZYTL9icxHQFiGN
 nqGYPg7O+kOtoscO8CRs05MtyA0+hHF4p7exImY1XLMkKJzy5ungUAysczpt1dUG4lqKe5dB2
 5o1wJSf83K3A28rnI8Cf14aGzE7M2ERL5jRD1qsE2+k8IDeAFPElMo286352FO36tNZ2QCxE/
 N6qyBIhHoKnzHjlTv6hbY7Yogiiovg5U1ViqGTY04hvB9MVqTDVG2defqn+ZGPPskVKUsqxrC
 ufVb3nwmbzNFU5EICN7NPKLMMWLadqsWmHMxKRWwbRg/OFj9SjLvJQ6k7W6oURVqfGcsI5OZ7
 TVMMHA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> We were leaking both the "struct strbuf" in prune_worktrees(), as well
> as the "path" we got from should_prune_worktree(). Since these were
> the only two uses of the "struct string_list" let's change it to a
> "DUP" and push these to it with "string_list_append_nodup()".

Seems odd at first to only use _nodup() on a _DUP list, but is valid.

> For the string_list_append_nodup() we could also string_list_append()
> the main_path.buf, and then strbuf_release(&main_path) right away. But
> doing it this way avoids an allocation, as we already have the "struct
> strbuf" prepared for appending to "kept".

Similarly we could release the path that should_prune_worktree() gives us
after adding it.

The patch looks good to me.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/worktree.c         | 6 +++---
>  t/t2401-worktree-prune.sh  | 1 +
>  t/t2406-worktree-repair.sh | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 591d659faea..865ce9be22b 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -173,7 +173,7 @@ static void prune_worktrees(void)
>  {
>  	struct strbuf reason =3D STRBUF_INIT;
>  	struct strbuf main_path =3D STRBUF_INIT;
> -	struct string_list kept =3D STRING_LIST_INIT_NODUP;
> +	struct string_list kept =3D STRING_LIST_INIT_DUP;
>  	DIR *dir =3D opendir(git_path("worktrees"));
>  	struct dirent *d;
>  	if (!dir)
> @@ -184,14 +184,14 @@ static void prune_worktrees(void)
>  		if (should_prune_worktree(d->d_name, &reason, &path, expire))
>  			prune_worktree(d->d_name, reason.buf);
>  		else if (path)
> -			string_list_append(&kept, path)->util =3D xstrdup(d->d_name);
> +			string_list_append_nodup(&kept, path)->util =3D xstrdup(d->d_name);
>  	}
>  	closedir(dir);
>
>  	strbuf_add_absolute_path(&main_path, get_git_common_dir());
>  	/* massage main worktree absolute path to match 'gitdir' content */
>  	strbuf_strip_suffix(&main_path, "/.");
> -	string_list_append(&kept, strbuf_detach(&main_path, NULL));
> +	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
>  	prune_dups(&kept);
>  	string_list_clear(&kept, 1);
>
> diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
> index 3d28c7f06b2..568a47ec426 100755
> --- a/t/t2401-worktree-prune.sh
> +++ b/t/t2401-worktree-prune.sh
> @@ -5,6 +5,7 @@ test_description=3D'prune $GIT_DIR/worktrees'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success initialize '
> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> index 5c44453e1c1..8970780efcc 100755
> --- a/t/t2406-worktree-repair.sh
> +++ b/t/t2406-worktree-repair.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'test git worktree repair'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
