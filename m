Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C39C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD4860FC2
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKCSPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKCSPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 14:15:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E75C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 11:12:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 5so11958811edw.7
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cIW6Hkf9JL45uV/O5PEwgvqhAvKzyarV9F+t67CjdZM=;
        b=JnTp0gM8yQ7tltiktj5JIcqm1MCyASG45SMSlUTG1Yk/9j7xUctqt1c+tWoTe9E+pM
         +ZOnEcdvO+YAH61uPb6hmaC3rWEMq+J5qGeUMXzKn6I0soMbiCdJ4/Q7/Bd1bVViIDFA
         OYK0JPCkq8pKKWpcLwudyBqqlkyu+yQvk9yBYB3a2irV0we2ixGKKitgrYXFrf2uwF+E
         owAkaHCiEK6PHSDQkzC5YrsRr7RmFY1Likldr4zSC//layq6k6nW5ZhPTRDyBlGM6Gd7
         bTj+YEP0DyUPnDsdFjwJFzR4W/ZafKk72f6DD0Oz6v6Il2CzZjrSSt0kIH8XxJfREENU
         e5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cIW6Hkf9JL45uV/O5PEwgvqhAvKzyarV9F+t67CjdZM=;
        b=AlsARMr6UtGqjS0zceDNv0KJV3H47nUNurnGsqAH9zMz5CsEcg2+6xE59Vfc/hwBw3
         aDn8GDw3/bVBFC+giSHQa+9+3aLXvcpk4mYwe8CnYoSo8vFqDXGNRm2U/Wkm14GJX2Wv
         gYGLPMI6lKuWgTskGYz07ndbzAvMQR0daMJbRCW7Ovzr6XOxSY4N8b5RoSoT0gnW4Ytg
         9+s80wQe+M21Yzrw41M1OEmkhKdHBXdous+ur3qIEouugMFIvVn8x2Ld599Ds5mYrNr5
         DAvSHc5PVfWCUCGnLeSGrbea5/FFGZp9Ry9AAWZgdIpaRM3fFMXmyTVsvNCB4SrPJ+U3
         QgAQ==
X-Gm-Message-State: AOAM532az1Poorwo7iy3tnzmm9jIov4REdvHXDNBifXgtkUReIpE004Z
        Kpm+SwISkiFYpK9+vyBAB1Y=
X-Google-Smtp-Source: ABdhPJyoc8d2bs7hv3o5+/vhpLTOEAWryZdTBSYatDbvh6qV8/rM2UrVMoFfXIHXY9YdAMW/5IO0nA==
X-Received: by 2002:a17:907:2da5:: with SMTP id gt37mr34405921ejc.316.1635963154357;
        Wed, 03 Nov 2021 11:12:34 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d3sm1672939edr.0.2021.11.03.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:12:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miKkS-0004Aj-F4;
        Wed, 03 Nov 2021 19:12:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: disallow directional formatting
Date:   Wed, 03 Nov 2021 17:36:12 +0100
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
 <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
Message-ID: <211103.86zgqlhzvz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 03 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As described in https://trojansource.codes/trojan-source.pdf, it is
> possible to abuse directional formatting (a feature of Unicode) to
> deceive human readers into interpreting code differently from compilers.
>
> For example, an "if ()" expression could be enclosed in a comment, but
> rendered as if it was outside of that comment. In effect, this could
> fool a reviewer into misinterpreting the code flow as benign when it is
> not.
>
> It is highly unlikely that Git's source code wants to contain such
> directional formatting in the first place, so let's just disallow it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci: disallow directional formatting
>=20=20=20=20=20
>     I just stumbled over
>     https://siliconangle.com/2021/11/01/trojan-source-technique-can-injec=
t-malware-source-code-without-detection/,
>     which details an interesting social-engineering attack: it uses
>     directional formatting in source code to pretend to human readers that
>     the code does something different than it actually does.
>=20=20=20=20=20
>     It is highly unlikely that Git's source code wants to contain such
>     directional formatting in the first place, so let's disallow it.
>=20=20=20=20=20
>     Technically, this is not exactly -rc material, but the paper was just
>     published, and I want us to be safe.
>=20=20=20=20=20
>     Changes since v1:
>=20=20=20=20=20
>      * The code was moved into a script in ci/.
>      * We use git ls-files now to exclude files marked as binary in the G=
it
>        attributes.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1071%2F=
dscho%2Fcheck-for-utf-8-directional-formatting-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1071/dscho=
/check-for-utf-8-directional-formatting-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1071
>
> Range-diff vs v1:
>
>  1:  6a1661fd887 ! 1:  bbf963695ba ci: disallow directional formatting
>      @@ Commit message
>           possible to abuse directional formatting (a feature of Unicode)=
 to
>           deceive human readers into interpreting code differently from c=
ompilers.
>=20=20=20=20=20=20=20
>      +    For example, an "if ()" expression could be enclosed in a comme=
nt, but
>      +    rendered as if it was outside of that comment. In effect, this =
could
>      +    fool a reviewer into misinterpreting the code flow as benign wh=
en it is
>      +    not.
>      +
>           It is highly unlikely that Git's source code wants to contain s=
uch
>      -    directional formatting in the first place, so let's disallow it.
>      +    directional formatting in the first place, so let's just disall=
ow it.
>=20=20=20=20=20=20=20
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20=20=20=20=20=20=20
>      @@ .github/workflows/main.yml: jobs:
>            - uses: actions/checkout@v2
>            - run: ci/install-dependencies.sh
>            - run: ci/run-static-analysis.sh
>      -+    - name: disallow Unicode directional formatting
>      -+      run: |
>      -+        # Use UTF-8-aware `printf` to feed a byte pattern to non-U=
TF-8-aware `git grep`
>      -+        # (Ubuntu's `git grep` is compiled without support for lib=
pcre, otherwise we
>      -+        # could use `git grep -P` with the `\u` syntax).
>      -+        ! LANG=3DC git grep -Il "$(LANG=3DC.UTF-8 printf \
>      -+          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\=
\|\u2067\\|\u2068\\|\u2069\\)')"
>      ++    - run: ci/check-directional-formatting.sh
>          sparse:
>            needs: ci-config
>            if: needs.ci-config.outputs.enabled =3D=3D 'yes'
>      +
>      + ## ci/check-directional-formatting.sh (new) ##
>      +@@
>      ++#!/bin/bash
>      ++
>      ++# This script verifies that the non-binary files tracked in the Gi=
t index do
>      ++# not contain any Unicode directional formatting: such formatting =
could be used
>      ++# to deceive reviewers into interpreting code differently from the=
 compiler.
>      ++# This is intended to run on an Ubuntu agent in a GitHub workflow.
>      ++#
>      ++# `git grep` as well as GNU grep do not handle `\u` as a way to sp=
ecify UTF-8.
>      ++# A PCRE-enabled `git grep` would handle `\u` as desired, but Ubun=
tu does
>      ++# not build its `git` packages with PCRE support.
>      ++#
>      ++# To work around that, we use `printf` to produce the pattern as a=
 byte
>      ++# sequence, and then feed that to `git grep` as a byte sequence (s=
etting
>      ++# `LC_CTYPE` to make sure that the arguments are interpreted as in=
tended).
>      ++#
>      ++# Note: we need to use Bash here because its `printf` interprets `=
\uNNNN` as
>      ++# UTF-8 code points, as desired. Running this script through Ubunt=
u's `dash`,
>      ++# for example, would use a `printf` that does not understand that =
syntax.
>      ++
>      ++# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
>      ++# U+2066..U+2069: LRI, RLI, FSI and PDI
>      ++regex=3D'(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|=
\u2069)'
>      ++
>      ++! git ls-files -z ':(attr:!binary)' |
>      ++LC_CTYPE=3DC xargs -0r git grep -Ele "$(LC_CTYPE=3DC.UTF-8 printf =
"$regex")" --
>
>
>  .github/workflows/main.yml         |  1 +
>  ci/check-directional-formatting.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100755 ci/check-directional-formatting.sh
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e8076..36b7a0bee38 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -289,6 +289,7 @@ jobs:
>      - uses: actions/checkout@v2
>      - run: ci/install-dependencies.sh
>      - run: ci/run-static-analysis.sh
> +    - run: ci/check-directional-formatting.sh
>    sparse:
>      needs: ci-config
>      if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> diff --git a/ci/check-directional-formatting.sh b/ci/check-directional-fo=
rmatting.sh
> new file mode 100755
> index 00000000000..ab894715cf1
> --- /dev/null
> +++ b/ci/check-directional-formatting.sh
> @@ -0,0 +1,25 @@
> +#!/bin/bash
> +
> +# This script verifies that the non-binary files tracked in the Git inde=
x do
> +# not contain any Unicode directional formatting: such formatting could =
be used
> +# to deceive reviewers into interpreting code differently from the compi=
ler.
> +# This is intended to run on an Ubuntu agent in a GitHub workflow.
> +#
> +# `git grep` as well as GNU grep do not handle `\u` as a way to specify =
UTF-8.
> +# A PCRE-enabled `git grep` would handle `\u` as desired, but Ubuntu does
> +# not build its `git` packages with PCRE support.

I just took you at your word before, but, no. It does have PCRE. It's
this Ubuntu version:
https://github.com/actions/virtual-environments/blob/main/images/linux/Ubun=
tu2004-README.md
i.e. "Ubuntu 20.04.3 LTS".

Debian's "git" package builds with libpcre, and Ubuntu's page about it
suggests it does the same: https://packages.ubuntu.com/focal/git

And if you try to push e.g. a grep for "git grep -P 'foo(?=3Dbar)' you'll
find that it works.

What we haven't done in "git grep" is to compile the pattern with
PCRE2_ALT_BSUX, which is probably what you ran into. I.e. it doesn't
grok \u by default, we should probably support that, but you don't need
it.

> +#
> +# To work around that, we use `printf` to produce the pattern as a byte
> +# sequence, and then feed that to `git grep` as a byte sequence (setting
> +# `LC_CTYPE` to make sure that the arguments are interpreted as intended=
).
> +#
> +# Note: we need to use Bash here because its `printf` interprets `\uNNNN=
` as
> +# UTF-8 code points, as desired. Running this script through Ubuntu's `d=
ash`,
> +# for example, would use a `printf` that does not understand that syntax.
> +
> +# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
> +# U+2066..U+2069: LRI, RLI, FSI and PDI
> +regex=3D'(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069=
)'
> +
> +! git ls-files -z ':(attr:!binary)' |
> +LC_CTYPE=3DC xargs -0r git grep -Ele "$(LC_CTYPE=3DC.UTF-8 printf "$rege=
x")" --

FWIW with that ls-files suggestion of mine I meant that would make sense
as a way to pipe it into Perl since doing this with a Unicode-aware
regex engine is less painful. I.e. you'd be able to just name the
Unicode range.

But since you didn't go for that surely this whole ls-files -> xargs ->
git grep pipeline isn't needed, and you'd just want:

    ! git -P grep -nE "$(LC_CTYPE=3DC.UTF-8 printf "$regex")" ':(attr:!bina=
ry)'

I added the -n for readability of the output, a matter of taste, and -P
to "git" for ease of ad-hoc testing. A test of that on the researcher's
trojan-source.git repo:
=20=20=20=20
    $ ! git -P grep -nE "$(LC_CTYPE=3DC.UTF-8 printf "$regex")" ':(attr:!bi=
nary)'; echo $?
    C#/commenting-out.csx:4:/*=E2=80=AE } =E2=81=A6if (isAdmin)=E2=81=A9 =
=E2=81=A6 begin admins only */
    C#/commenting-out.csx:6:/* end admins only =E2=80=AE { =E2=81=A6*/
    C#/stretched-string.csx:4:if (access_level !=3D "user=E2=80=AE =E2=81=
=A6// Check if admin=E2=81=A9 =E2=81=A6") {
    C++/commenting-out.cpp:5:    /*=E2=80=AE } =E2=81=A6if (isAdmin)=E2=81=
=A9 =E2=81=A6 begin admins only */
    C++/commenting-out.cpp:7:    /* end admins only =E2=80=AE { =E2=81=A6*/
    C++/stretched-string.cpp:6:    if (access_level.compare("user=E2=80=AE =
=E2=81=A6// Check if admin=E2=81=A9 =E2=81=A6")) {
    C/commenting-out.c:6:    /*=E2=80=AE } =E2=81=A6if (isAdmin)=E2=81=A9 =
=E2=81=A6 begin admins only */
    C/commenting-out.c:8:    /* end admins only =E2=80=AE { =E2=81=A6*/
    C/early-return.c:4:    /* Say hello; newline=E2=81=A7 /*/ return 0 ;
    C/stretched-string.c:6:    if (strcmp(access_level, "user=E2=80=AE =E2=
=81=A6// Check if admin=E2=81=A9 =E2=81=A6")) {
    Go/commenting-out.go:9:    /*=E2=80=AE } =E2=81=A6if (isAdmin)=E2=81=A9=
 =E2=81=A6 begin admins only */
    Go/commenting-out.go:11:    /* end admins only =E2=80=AE { =E2=81=A6*/
    Go/stretched-string.go:7:       if accessLevel !=3D "user=E2=80=AE =E2=
=81=A6// Check if admin=E2=81=A9 =E2=81=A6" {
    Java/CommentingOut.java:5:        /*=E2=80=AE } =E2=81=A6if (isAdmin)=
=E2=81=A9 =E2=81=A6 begin admins only */
    Java/CommentingOut.java:7:        /* end admins only =E2=80=AE { =E2=81=
=A6*/
    Java/StretchedString.java:5:        if (accessLevel !=3D "user=E2=80=AE=
 =E2=81=A6// Check if admin=E2=81=A9 =E2=81=A6") {
    JavaScript/commenting-out.js:4:/*=E2=80=AE } =E2=81=A6if (isAdmin)=E2=
=81=A9 =E2=81=A6 begin admins only */
    JavaScript/commenting-out.js:6:/* end admins only =E2=80=AE { =E2=81=A6=
*/
    JavaScript/stretched-string.js:4:if (accessLevel !=3D "user=E2=80=AE =
=E2=81=A6// Check if admin=E2=81=A9 =E2=81=A6") {
    Python/commenting-out.py:4:if access_level !=3D 'none=E2=80=AE=E2=81=A6=
': # Check if admin =E2=81=A9=E2=81=A6' and access_level !=3D 'user
    Python/early-return.py:5:    ''' Subtract funds from bank account then =
=E2=81=A7''' ;return
    Rust/commenting-out.rs:3:    /*=E2=80=AE } =E2=81=A6if is_admin=E2=81=
=A9 =E2=81=A6 begin admins only */
    Rust/commenting-out.rs:5:    /* end admins only =E2=80=AE { =E2=81=A6*/
    Rust/stretched-string.rs:3:    if access_level !=3D "user=E2=80=AE =E2=
=81=A6// Check if admin=E2=81=A9 =E2=81=A6" {
    Binary file website/public/trojan-source.pdf matches
    Binary file website/src/assets/img/faces/erik-lucatero-2.jpg matches
    1

That "Binary file..." being because they don't maintain an up-to-date
.gitattributes file.

The -e you've got is redundant since you have only one pattern. A relic
of trying to feed a list of these with "-e" to "git grep"?

But anyway, as noted you're not correct that we don't have PCRE with the
"git" in the CI, we just don't have \uxxxx, but you don't need that
optional syntax. Just use \N{U+xxxx}:

    ! git -P grep -nP '[\N{U+202a}-\N{U+202e}\N{U+2066}-\N{U+2069}]' ':(att=
r:!binary)'

All that being said I still don't see much of a point in doing this, but
if we are let's not make it needlessly complex, but actually, why not
some variant of:
=20=20=20=20
    $ ~/g/git/git grep -Pn '[\N{U+2000}-\N{U+206F}]' -- ':!(attr:binary)' '=
:!/po/' ':!*/po/*' ':!t/t0200/' ':!t/t0204*' ':!t/t5150-request-pull.sh'
    builtin/gc.c:1543: *   * if the input value *cmd isn=E2=80=99t the key =
of any of the comma-separated list
    builtin/gc.c:1555: *   GIT_TEST_MAINT_SCHEDULER set to =E2=80=9Cfoo:./m=
ock_foo.sh,bar:./mock_bar.sh=E2=80=9D
    builtin/submodule--helper.c:3262:                          N_("sets the=
 submodule=E2=80=99s name to the given string "
    contrib/credential/netrc/git-credential-netrc.perl:122:   The credentia=
l=E2=80=99s username, if we already have one. (username=3DX)
    t/helper/test-mergesort.c:364: * Function" by Bentley and McIlroy, Soft=
ware=E2=80=94Practice and Experience,
    t/helper/test-mergesort.c:365: * Volume 23, Issue 11, 1249=E2=80=931265=
 (November 1993).
    Binary file t/t0013/shattered-1.pdf matches

I.e. that notices that the "binary" is missing for that *.pdf, and that
we have some Unicode quoting we probably should get rid of anyway, it
also nicely excludes po/* in the pathspec, so any legitimate use of this
for RTL languages won't be prevented by this check.
