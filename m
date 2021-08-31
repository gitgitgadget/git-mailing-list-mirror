Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3AC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A28060F91
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhHaOm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhHaOmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:42:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C9C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:41:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n5so28036563wro.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uIYnfOvSz7r09nov8d+IoVKCAezVJEnfupcQE8OgVgA=;
        b=X9iGTLMKnvHR3T8mJLS5lpbc6a6oG6Q1HzcHGxpmn+Wk4LZonRytr4QZwfD1DhVZVM
         D7S2mvJbRR8lJ7CsbG+Xy0qDgKQOg/tBiBKKs2q7OAFdlrqCpTCY573Lt2aDHjDh0j0D
         CMUw3nlGG8VWHJmDtbQ9gYY/SkggMyw176H433wKfJb8U/95avdPz7KsfSIs/AB9SgCB
         57xNcYd8+R/OAkgT1DrCUbM+qhY7ciLIyDC19uFY4VJSfEX/NSlHhuowHp+O5YeAWryh
         funksp9RPikdTaRZltqf6ZXFHz+MPHI/F3xssd1yZvoAjT1jUEN1PBiOw5koz7acMEKQ
         Dnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uIYnfOvSz7r09nov8d+IoVKCAezVJEnfupcQE8OgVgA=;
        b=nis2vGMY9FzwNl72eQpb/gqOBLv3fPRrGASBXnGKiq9q0XM2uFy9Bwp36ovq4nkOxZ
         mASVtEcqHXVJ7WFRRx61u/4l0snLhW/pcLNOoL5hG133UoDu4+ffgQkjZJSXjxPq82sd
         ea9oJSZpKKWBlXByxd1yUac7+g7nhE5SZQOByuhkBO+5jN8MbG02DKviWtKveg83Gs9s
         wFYopRDxzGyvb8KAfGUruiReQ9N0JidowmJ1ZK2EVArI1q/4C3jcamrrU0YkTfpzGPue
         M2mbM9jsU1xgQokMwwiwVYN2hp4pj9u+jaFwQZJMOqjjCsTnlMUlHWOCDJXeUyueyweX
         S+MA==
X-Gm-Message-State: AOAM533T9PiuU964rdgjulLNTbIedwNRLu26hIoFWNlA1rKun9V3jkfJ
        Fs15kVN01fw1UoAe7kqIE30hvNyHN7AP6w==
X-Google-Smtp-Source: ABdhPJzs0wX5rkPrruh5tgaAWrHdmwzNJnfBI1e85AhN5rE/NPoFj0RgUm79kJa76GtMcXgvRFJQWA==
X-Received: by 2002:a5d:6ca4:: with SMTP id a4mr32777130wra.140.1630420888366;
        Tue, 31 Aug 2021 07:41:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t14sm2524489wmi.12.2021.08.31.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:41:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2] test-lib: set GIT_CEILING_DIRECTORIES to protect the
 surrounding repository
Date:   Tue, 31 Aug 2021 16:40:39 +0200
References: <20210828121329.1971762-1-szeder.dev@gmail.com>
 <20210829092536.2582899-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210829092536.2582899-1-szeder.dev@gmail.com>
Message-ID: <87pmttwuaw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 29 2021, SZEDER G=C3=A1bor wrote:

> Every once in a while a test somehow manages to escape from its trash
> directory and modifies the surrounding repository, whether because of
> a bug in git itself, a bug in a test [1], or e.g. when trying to run
> tests with a shell that is, in general, unable to run our tests [2].
>
> Set GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/.." as an additional
> safety measure to protect the surrounding repository at least from
> modifications by git commands executed in the tests (assuming that
> handling of ceiling directories during repository discovery is not
> broken, and, of course, it won't save us from regular shell commands,
> e.g. 'cd .. && rm -f ...').
>
> [1] e.g. https://public-inbox.org/git/20210423051255.GD2947267@szeder.dev
> [2] $ git symbolic-ref HEAD
>     refs/heads/master
>     $ ksh ./t2011-checkout-invalid-head.sh
>     [... a lot of "not ok" ...]
>     $ git symbolic-ref HEAD
>     refs/heads/other
>
>     (In short: 'ksh' doesn't support the 'local' builtin command,
>     which is used by 'test_oid', causing it to return with error
>     whenever it's called, leaving ZERO_OID set to empty, so when the
>     test 'checkout main from invalid HEAD' runs 'echo $ZERO_OID
>     >.git/HEAD' it writes a corrupt (not invalid) HEAD, and subsequent
>     git commands don't recognize the repository in the trash directory
>     anymore, but operate on the surrounding repo.)
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> Changes since v1:
>  - Set "$TRASH_DIRECTORY/.." instead of $GIT_BUILD_DIR.
>  - Minor commit message tweaks.
>
>  t/test-lib.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index abcfbed6d6..fc1e521519 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1343,7 +1343,8 @@ fi
>  GIT_TEMPLATE_DIR=3D"$GIT_BUILD_DIR"/templates/blt
>  GIT_CONFIG_NOSYSTEM=3D1
>  GIT_ATTR_NOSYSTEM=3D1
> -export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_=
NOSYSTEM
> +GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/.."
> +export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_=
NOSYSTEM GIT_CEILING_DIRECTORIES
>=20=20
>  if test -z "$GIT_TEST_CMP"
>  then

For what it's worth I'm very happy with this, and have been running this
in my own daily build of git, I've occasionally ran into e.g. needing to
manually clean up my own git.git's config file because some test escaped
its trash directory.
