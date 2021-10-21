Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9BC433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6348610C8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJUPgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:36:03 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:33706 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJUPgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 11:36:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 54C7510A6;
        Thu, 21 Oct 2021 17:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        in-reply-to:references:message-id:date:date:subject:subject
        :mime-version:from:from:content-transfer-encoding:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1634830423; x=1636644824; bh=l0AFBG8gZFzTph9a3mcBL+Iw9nmHd6vWwI0
        IFy9uWrI=; b=GJjh0so0yunIk0nJs9pcpeVC8a6VwMXY1nWcOS+H+tbN9u+Oroc
        BqZSzfs4eaVDfPFXvLSPBf+FWpZ6vLu/wklASyn+CC/enoxPlBidjbOPW9tpNhrK
        dSfMU588KrlBvt3udQijYCOviB+/ZRkHdcZuE+2g1JuwkcRFRwUmv33aSChNucIq
        JlALhoGd07C5H3rO+7Ka+yBsnk1Z7YnbPTvHT3RWBYepzFCBGByrTFxERNtd0UCE
        b6HhV+hlVzsfCUxHr8QTWHSVwH1LrRTFazQeqHxoJSO4XDCWGTBJx4/BgsY+thv0
        H9oHwl4i2Y1vB1L8Lfwu18es72W8gpXzLNtHiAA9VeFPZquszFKMznR+utmuNS9a
        i1s/1dB2RqhAnfxK9NVXE8T5A60P2thx6g7Go0xL3mtwRXc4Iaii4fURGUBWqRpi
        k1yv0px5OCyjX32nyttM3jVemSx+JiAENP/Ot3jCbU7RVOsSuAYQj5uR3WzAMg3G
        yMTWMLGlgsci0W9rGCxOsiTNiEwGYbHvJEX19yi7wHO7ATKQpHwEUnvMHrNdz8kz
        TgxrO59dEN1V2Q2bTOKTeZq4r/rbP58SDVnojtakBQ37aEVmGyH9MO+SEtC5Kpkq
        Bn++ehKbZn+VaJ8+ikFVrki/6awwC7Yl7iK7xnsHTvxWV+nQ/KhjGjNg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w0LGdV1ksuk6; Thu, 21 Oct 2021 17:33:43 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 560446BB;
        Thu, 21 Oct 2021 17:33:43 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id B8C902388;
        Thu, 21 Oct 2021 17:33:42 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andrzej Hunt <andrzej@ahunt.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] leak tests: free() before die for two API functions
Date:   Thu, 21 Oct 2021 17:33:41 +0200
Message-Id: <FD837FF9-E83F-42AA-AC13-EADD161D20BE@ahunt.org>
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 21 Oct 2021, at 13:42, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>=20
> =EF=BB=BFCall free() just before die() in two API functions whose tests ar=
e
> asserted under SANITIZE=3Dleak. Normally this would not be needed due to
> how SANITIZE=3Dleak works, but in these cases my GCC version (10.2.1-6)
> will fail tests t0001 and t0017 under SANITIZE=3Dleak depending on the
> optimization level.

I=E2=80=99m curious - to me this seems like a compiler/sanitiser bug, can it=
 also be reproduced with clang, or even newer versions of gcc? Similarly, ca=
n it be reproduced with your gcc version, using ASAN+LSAN (as opposed to LSA=
N by itself)? I remember seeing some false positives in the past for some pe=
rmutations of compilers and sanitisers, but I=E2=80=99ve lost track of the d=
etails.

These kinds of fixes seem noisy if it=E2=80=99s just to work around what app=
ears to be a bug (and to be philosophical: we wouldn=E2=80=99t want to do th=
e same for all =E2=80=9Cleaks=E2=80=9D up the call stack if a specific compi=
ler complained about them after a die() - after all there will be many more a=
llocations that didn=E2=80=99t get free=E2=80=99d floating around - so why i=
s it OK for these =E2=80=9Cleaks=E2=80=9D?)

If it this is a gcc-specific or LSAN-only-specific bug, I would suggest givi=
ng up on that combination for leak checking instead of adding such workaroun=
ds. After all the code seems correct - and while such compiler-specific work=
arounds are probably justified for user-visible bugs, these fixes seem to ju=
st be silencing a non-issue that only happens with what is probably a  =E2=80=
=9Cbroken=E2=80=9D setup?

(=46rom what I can remember, I never saw these when running t00* using clang=
 11 or 12, always using LSAN+ASAN, but that was a while back. I=E2=80=99ve n=
ot spent much time using gcc.)

>=20
> See 956d2e4639b (tests: add a test mode for SANITIZE=3Dleak, run it in
> CI, 2021-09-23) for the commit that marked t0017 for testing with
> SANITIZE=3Dleak, and c150064dbe2 (leak tests: run various built-in tests
> in t00*.sh SANITIZE=3Dleak, 2021-10-12) for t0001 (currently in "next").
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> config.c | 4 +++-
> refs.c   | 5 ++++-
> 2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/config.c b/config.c
> index 2dcbe901b6b..93979d39b21 100644
> --- a/config.c
> +++ b/config.c
> @@ -159,11 +159,13 @@ static int handle_path_include(const char *path, str=
uct config_include_data *inc
>    }
>=20
>    if (!access_or_die(path, R_OK, 0)) {
> -        if (++inc->depth > MAX_INCLUDE_DEPTH)
> +        if (++inc->depth > MAX_INCLUDE_DEPTH) {
> +            free(expanded);
>            die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
>                !cf ? "<unknown>" :
>                cf->name ? cf->name :
>                "the command line");
> +        }
>        ret =3D git_config_from_file(git_config_include, path, inc);
>        inc->depth--;
>    }
> diff --git a/refs.c b/refs.c
> index 7f019c2377e..52929286032 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -590,8 +590,11 @@ char *repo_default_branch_name(struct repository *r, i=
nt quiet)
>    }
>=20
>    full_ref =3D xstrfmt("refs/heads/%s", ret);
> -    if (check_refname_format(full_ref, 0))
> +    if (check_refname_format(full_ref, 0)) {
> +        free(ret);
> +        free(full_ref);
>        die(_("invalid branch name: %s =3D %s"), config_display_key, ret);
> +    }
>    free(full_ref);
>=20
>    return ret;
> --=20
> 2.33.1.1486.gb2bc4955b90
>=20

