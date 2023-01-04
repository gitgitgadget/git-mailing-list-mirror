Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A5C53210
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjADVvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjADVvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:51:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D7113FA1
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:51:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l26so25088396wme.5
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jz7bVE/wpp9cMR7nLe5/CsMilMiqHpNNP+irT5x64NY=;
        b=ZN8SlIGUQnsK7CQjdt5JLJ/Iy3ojYLA3i8FymqFxtlkz0/CTPlcim4bI8JIeEsuNjv
         acmMvUy0KhxZcWl1aH/6pdihyAWsR+6NYZXhZAGifqmP4n66QsMzLkto03Rcg9sDXJbe
         2o9pIKw0VjfMdOssofosQrXo3bcjJ3mBS+FD9T0iTClYUWuHd+d4BsvsKh/19xK4En58
         pHWFx4ApJuZmvwsWYfH0rq5aSIf3lYBRmkOE4iIUgUK9bQ70NplBiBqYejbPkNQ/cw5E
         gk+hYefq8uG9Z7lOhSHSkmSQkTR0oq0gTmcvM84uDWyN/EDGfxpESQ6lofFs9F41fhBr
         RnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jz7bVE/wpp9cMR7nLe5/CsMilMiqHpNNP+irT5x64NY=;
        b=Kp6+SJzU/D27eoC8eeHaP3+eUYn3K1aYGaDH2CVEOGtYOu9OMZb4WL12jvjqzBu0b/
         FueiUfvgjVdNhMInCP8uFSaaqI9LrGUD6yLZXOclYxqKYQv1GpMg7QlnkKCy1zMS3m87
         AropZdE3BbO6spzJynwPxf00fGULLpYkCmEYuG3JvEUCdq5/ZT13Hn/uQnfS3BSN29OM
         Bxzw6ccuiXJtSF+rElGIA8fP4Y1sFJEIcFQy9xZMOPSQvUtaHZFTOMd9j/GkF5lB/EOw
         JiLY/Fmo5EsrzAJVe7EEpR2HPvWlvqocubzDiPfXoj3d+PJkSKyS07h0z9hGdfWYh14b
         5Apw==
X-Gm-Message-State: AFqh2kpv56gw3HeegYItOJHDMYJXI+gS+94duQe5Pn19zzikKkZkIepu
        IgOj9jOax2qd6ATjq9gs/uI=
X-Google-Smtp-Source: AMrXdXtn4eESgKRj74pFzLDsCFrbXk0B0IQV+wuKGFT7pSOQnW2k1vqs68EeA3P843sTtNAsgAeZPw==
X-Received: by 2002:a05:600c:1d98:b0:3d3:3d51:7d4b with SMTP id p24-20020a05600c1d9800b003d33d517d4bmr35892376wms.29.1672869064821;
        Wed, 04 Jan 2023 13:51:04 -0800 (PST)
Received: from gmgdl (dsl-59-113.bl26.telepac.pt. [176.78.59.113])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003cfbbd54178sm4058978wms.2.2023.01.04.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:51:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pDBf5-00CU80-1o;
        Wed, 04 Jan 2023 22:51:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] ci(github): restore "print test failures" step name
Date:   Wed, 04 Jan 2023 22:41:32 +0100
References: <pull.1453.git.1672741640587.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1453.git.1672741640587.gitgitgadget@gmail.com>
Message-ID: <230104.86mt6yt1dk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 03 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As well as removing the explicit shell setting d8b21a0fe2 (CI: don't
> explicitly pick "bash" shell outside of Windows, fix regression,
> 2022-12-07) also reverted the name of the print test failures step
> introduced by 5aeb145780f (ci(github): bring back the 'print test
> failures' step, 2022-06-08). This is unfortunate as 5aeb145780f added a
> message to direct contributors to the "print test failures" step when a
> test fails and that step is no-longer known by that name on the
> non-windows ci jobs.
>
> In principle we could update the message to print the correct name for
> the step but then we'd have to deal with having two different names for
> the same step on different jobs. It is simpler for the implementation
> and contributors to use the same name for this step on all jobs.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     ci(github): restore "print test failures" step name
>=20=20=20=20=20
>     =C3=86var seems to think the name change in 5aeb145780f was unintenti=
onal [1]
>     but looking at the original commit I don't think that's the case.
>=20=20=20=20=20
>     [1]
>     https://lore.kernel.org/git/221208.86sfhq6pmg.gmgdl@evledraar.gmail.c=
om/

Reading it again I think you're right, i.e. that the migration of
everything to "bash" was unintentional & a result of copy/pasting, but
the initial goal was to mention the "print test failures" step....

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index e67847a682c..126eac8239d 100644
> --- a/.github/workflows/main.yml
> @@ -265,8 +265,9 @@ jobs:
>      - uses: actions/checkout@v3
>      - run: ci/install-dependencies.sh
>      - run: ci/run-build-and-tests.sh
> -    - run: ci/print-test-failures.sh
> +    - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> +      run: ci/print-test-failures.sh
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
>        uses: actions/upload-artifact@v3
> @@ -298,8 +299,9 @@ jobs:
>        if: matrix.vector.jobname =3D=3D 'linux32'
>      - run: ci/install-docker-dependencies.sh
>      - run: ci/run-build-and-tests.sh
> -    - run: ci/print-test-failures.sh
> +    - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> +      run: ci/print-test-failures.sh
>      - name: Upload failed tests' directories
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D '' && matrix.vecto=
r.jobname !=3D 'linux32'
>        uses: actions/upload-artifact@v3
>
> base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b

...but as far as moving forward, why make every other job be
inconsistent in naming this one step, rather than just making the
Windows ones consistent with rest?

I.e. why not:

	diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
	index e67847a682c..2bfb841206e 100644
	--- a/.github/workflows/main.yml
	+++ b/.github/workflows/main.yml
	@@ -119,8 +119,7 @@ jobs:
	     - name: test
	       shell: bash
	       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
	-    - name: print test failures
	-      if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
	+    - if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
	       shell: bash
	       run: ci/print-test-failures.sh
	     - name: Upload failed tests' directories
	diff --git a/ci/lib.sh b/ci/lib.sh
	index db7105e8a8d..d6450fd4957 100755
	--- a/ci/lib.sh
	+++ b/ci/lib.sh
	@@ -183,7 +183,7 @@ then
	 			test_name=3D"${test_exit%.exit}"
	 			test_name=3D"${test_name##*/}"
	 			printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[=
m\\n"
	-			echo "The full logs are in the 'print test failures' step below."
	+			echo "The full logs are in the 'ci/print-test-failures.sh' step below."
	 			echo "See also the 'failed-tests-*' artifacts attached to this run."
	 			cat "t/test-results/$test_name.markup"
=09=20

The implicit argument being made here & in the original 5aeb145780f is
that it's a good thing to give explicit "names"'s to all of these steps.

For some of the steps I agree, e.g. "test" is probably better than
". /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10" or whatever,
and e.g. "generate Visual Studio solution" is definitely better than
some multi-line shellscript (I'm not sure how the UX would even turn
that into a collapsible title).

But in the case of "ci/print-test-failures.sh",
"ci/run-build-and-tests.sh", "ci/install-dependencies.sh" etc. the
script name is already self-descriptive, so giving it a name just serves
to obscure the connection between the step & the script implementing it,
which is otherwise immediately apparent.

So I think it's better to just remove the "name" label in those cases
where the Windows jobs can use such a script, which we're already not
naming in the *nix jobs.

It's a minor point either way, and your change would also be an
improvement. I just think it's better to aim for e.g. this snippet (from
the current main.yml):

    - run: ci/install-docker-dependencies.sh
    - run: ci/run-build-and-tests.sh
    - run: ci/print-test-failures.sh

Rather than providing "name" fields for them all, and doubling the line
count for no apparent (at least to me) reason.
