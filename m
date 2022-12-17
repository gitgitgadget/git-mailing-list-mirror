Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF49C3DA79
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 12:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiLQMqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 07:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLQMpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 07:45:55 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF98FEF
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671281147; bh=r/7UYt3qSeLHW4rzZX4p5AS0ieUYXyVb5IC9MM8f+J4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kegwzmhEfur2Auh1sbIahPzKFHCbsVFeYn+JB//IlFpVmZMhTD8qcdoo3G6+5G27i
         tiiWrHv3/ps93xR+oVpN3ikAlEHkilnccXdcu0RrR+WCB6i9HeXJqkoAqg1asKto1r
         sMD/1cmyW/Oje71Jvqf2itcIhNzf7pTZYks2+S2/qMRkRWPSApvNehXDvzXhPAPYh7
         MLOv8kJzaPw9/Kdfe9LdG+aOVbCTeYPFPF58DUsH81HzGnbhKIQdVp71pRaqQWbb+b
         uJRsOwKww6CxXWP4BdFKXaG+5aXanxXDKQaGi0b/Y5+jl0fwmkUzDSRp2K5ytgIHkA
         FNoPj0nqXS73Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JEu-1p4rsP31H0-003HJF; Sat, 17
 Dec 2022 13:45:47 +0100
Message-ID: <9a1731aa-e20c-b11e-ba38-349d321a11c3@web.de>
Date:   Sat, 17 Dec 2022 13:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 4/5] strvec API users: fix leaks by using
 "STRVEC_INIT_NODUP"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
 <RFC-patch-4.5-6051c309d0d-20221215T090226Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-4.5-6051c309d0d-20221215T090226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DmYOGec5vG/w/Vse4E7WU4MdCpzGQlW9XCFQnwhl7pTO8NWWc5F
 oORZCiwyKiTb/x/MWkMMppwcpMchVtzrcuzXcT5GiYt+B5NzSB+wizAomfuniQ9nbI9cyQy
 G7c68OZSU5UsVJUFc85la6Tt4VVA6VANBERj2gjAJhDYOtO9YLbZbL1fougK2AuFgKnVoGM
 JhbJTDXJ+BRZ8z6C720Lg==
UI-OutboundReport: notjunk:1;M01:P0:ClinRFxju00=;uYrhQdVXFr0acVAowVpwjiaVggg
 FPO3XhDB0ExfQEk0wHYQ6liT6LfUCi9j2S3iRaGcSf1LHrF3fqTmearuQ3BAtrxJB1xCMqn73
 wZSySCUMemZ7fehFKQg0C6OP20SMnke0n1jz562r3u8kdjba8GklqM8ekThdy2GeASlni17Uz
 CqxWV9crx+wLL+mppq6hSnSmOQaa5nNk9uLIYAoqn57XDLhQKpO6IxMFnAxNzgJiHibbDSMgc
 HLJ5fOMEgv96fhP2osSPbQg3H8qonOyqg8/Lui5SrnVHa1K8ZuAHYBvvYuvYkEL3D0Ls43yju
 H98cqrUXXoWIQAodp/nbqBzTsByFeH1eAsNLUPLRAvvhztj6nVSISFEMtKrL13vfaCnWwS57D
 10gPqHhvALTiMQFE4fLtNZXXHI/DNUBQBWiX/Bu+wsyDD2TsXoWbueiZd0L+dGuvAX4G+qW+Y
 jaK3P1RBLpN264n4TvNW588G1Ai7V3YC45PhbmkpF4+PKFqenPrb2V7CHo2Q05lrckUv3Bkfl
 bYX+K6PPmDzryjxOei6bLESScnLX2f5bk0OGz3i3K6GHbQD5amjsoR2JTccnhS+fSMpBiSGQG
 pIKyjCXS96VgSNPAFsqsyDBZdh9RK5fnA5IyWZqSYt6gXRigYuz5hclNNr1IP9KNyLj4A8imv
 B84PBHa5CNejHV+R7tVaz3jOvwFTHiHxteZHpJ9fGzbnvqTKgHPK+Wf+0/AoOkgG1nIza0cvZ
 WOvoMxW6JtQAak7Iy4eZpH+PkrneGiGeqxlQHdaSsBWOAAm15DTsGjownIp8hHED1Q/z928q5
 v2iKNSdHiyhwP0zFOBlNfKcbVK4nJDlLdP5RBPtNCuSozxPXDDieAALoSYKNvhArdfToRgZvb
 36waZdQ64UJNMm23E4SHA1yjYjSD/4u2FWojG915KPyai2ue9KPARI2U2wVp1kP4+O2kCjvYt
 8pmBRA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.12.22 um 10:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> For these cases where all of the strings we're pushing to the "struct
> strvec" are fixed strings we can fix widespread memory leaks by
> skipping the xstrdup() on strvec_push().
>
> More in-tree users could benefit from this to save needless
> xstrdup()-ing, but for all of these we were munging the "v" member, so
> the subsequent strvec_clear() wouldn't free the memory.
>
> Now there's no need to free the individual elements, but we'll still
> need to free the container with the strvec_clear().
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/am.c                  | 2 +-
>  builtin/annotate.c            | 2 +-
>  builtin/stash.c               | 2 +-
>  t/t0023-crlf-am.sh            | 1 +
>  t/t4152-am-subjects.sh        | 2 ++
>  t/t4254-am-corrupt.sh         | 2 ++
>  t/t4256-am-format-flowed.sh   | 1 +
>  t/t4257-am-interactive.sh     | 2 ++
>  t/t5403-post-checkout-hook.sh | 1 +
>  9 files changed, 12 insertions(+), 3 deletions(-)

Looks nice and easy, though the test updates are a bit distracting.
They are all enabled by the change to builtin/am.c, right?

>
> diff --git a/builtin/am.c b/builtin/am.c
> index 30c9b3a9cd7..691ec1d152d 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1471,7 +1471,7 @@ static int parse_mail_rebase(struct am_state *stat=
e, const char *mail)
>  static int run_apply(const struct am_state *state, const char *index_fi=
le)
>  {
>  	struct strvec apply_paths =3D STRVEC_INIT;
> -	struct strvec apply_opts =3D STRVEC_INIT;
> +	struct strvec apply_opts =3D STRVEC_INIT_NODUP;
>  	struct apply_state apply_state;
>  	int res, opts_left;
>  	int force_apply =3D 0;
> diff --git a/builtin/annotate.c b/builtin/annotate.c
> index de58deadfc7..99d97c1a8c0 100644
> --- a/builtin/annotate.c
> +++ b/builtin/annotate.c
> @@ -9,7 +9,7 @@
>
>  int cmd_annotate(int argc UNUSED, const char **argv, const char *prefix=
)
>  {
> -	struct strvec args =3D STRVEC_INIT;
> +	struct strvec args =3D STRVEC_INIT_NODUP;
>  	int ret;
>
>  	strvec_pushl(&args, argv[0], "-c", NULL);
> diff --git a/builtin/stash.c b/builtin/stash.c
> index e504e22e0b9..b15dd2ebb3c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1823,7 +1823,7 @@ int cmd_stash(int argc, const char **argv, const c=
har *prefix)
>  {
>  	pid_t pid =3D getpid();
>  	const char *index_file;
> -	struct strvec args =3D STRVEC_INIT;
> +	struct strvec args =3D STRVEC_INIT_NODUP;
>  	parse_opt_subcommand_fn *fn =3D NULL;
>  	struct option options[] =3D {
>  		OPT_SUBCOMMAND("apply", &fn, apply_stash),
> diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
> index f9bbb91f64e..575805513a3 100755
> --- a/t/t0023-crlf-am.sh
> +++ b/t/t0023-crlf-am.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'Test am with auto.crlf'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  cat >patchfile <<\EOF
> diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
> index 4c68245acad..9f2edba1f83 100755
> --- a/t/t4152-am-subjects.sh
> +++ b/t/t4152-am-subjects.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'test subject preservation with format-patch | am'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  make_patches() {
> diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
> index 54be7da1611..45f1d4f95e5 100755
> --- a/t/t4254-am-corrupt.sh
> +++ b/t/t4254-am-corrupt.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'git am with corrupt input'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  make_mbox_with_nul () {
> diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
> index 2369c4e17ad..1015273bc82 100755
> --- a/t/t4256-am-format-flowed.sh
> +++ b/t/t4256-am-format-flowed.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'test format=3Dflowed support of git am'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
> index aed8f4de3d6..f26d7fd2dbd 100755
> --- a/t/t4257-am-interactive.sh
> +++ b/t/t4257-am-interactive.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'am --interactive tests'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'set up patches to apply' '
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.=
sh
> index 978f240cdac..cfaae547398 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -7,6 +7,7 @@ test_description=3D'Test the post-checkout hook.'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
