Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6943BC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 21:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiDKV7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiDKV7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 17:59:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567711C02
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 14:57:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so33606482ejc.7
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zbe2p+TmecqnMh4CrYTmjLwsyAiznTO/ojCrLk96Z1g=;
        b=Io5MeoXws1Ho3dbw2xfs1IvvZ/NNEFIp8BOx76N2hteIyeYZyRYb0k0qb3cfr0/77Z
         8RkDFQUChkPAinHXHa9XFfgO7CajsZnSepLeR9Wz2qNn+Ek1tmljWBu1zYVLQQmBHWgR
         0DvDGKZs60haRGnxX8lo6nib0YKdyZZj8g00CSZ3UkNOHMIzfyLau2IjHQkaS7MP8w1a
         vCK1S6gio6l+6avFGYUjI9kID/NrVqeLjGQVhs9DrVLtuBYIAXQ9znhRdHMT97ap3kvQ
         9omQ7Gz2HVQ3IDhSGgoDRwosM3K/X2cMzv07RSLX6fbHJBkdFOdbeuXQ5GB+5LnY++Aw
         7/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zbe2p+TmecqnMh4CrYTmjLwsyAiznTO/ojCrLk96Z1g=;
        b=uujqKPKruC83lisGYfDClXWKwmmJeztxngml0nsJ+w2dTKdlshQGz+U7ADYjMc7CJ1
         MRNj4OvkL+bDQqKJMq+4kffBFEqcWQNDRy3NArrw2gCVqerf2wz2PhklAevgUcCewhty
         j2nZs3Q9AnA+yo5GCXyRaXIhlQHxFIELAe5+vFo2e2mPteaMwCXWc2yXp786K6JVeuCO
         z93cAeOxwmvCSvqG7ZH6B7JRpJDKKS2LONuKNkDHtb3EkhABTRenSXwJkjob5tIIfpLh
         vrZUgWNIXGD01kmSR/Mkgj++Ofcu8Dk0bTGWdBTmiB4oA/wsASBg8bPqCePrt57SEJkw
         bqzg==
X-Gm-Message-State: AOAM532lCBn9y7Svs/XAXa1gjJYUi1wIHVAJM4Ku20ad5zbDidKHVk4Y
        3J7ePgDM4qC4SluJlcIEbugBvCik/cc=
X-Google-Smtp-Source: ABdhPJxfbRVhPYtlVNjZtW9V0dShISM0wVPHXdLcFi5fIhy4EkOI7h6mgC8yKIBWBrFbgRSNVvptEA==
X-Received: by 2002:a17:906:6a25:b0:6e8:a86e:d6e with SMTP id qw37-20020a1709066a2500b006e8a86e0d6emr2364613ejc.311.1649714246280;
        Mon, 11 Apr 2022 14:57:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n27-20020a1709062bdb00b006da975173bfsm12601035ejg.170.2022.04.11.14.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:57:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ne22H-004NDF-Ap;
        Mon, 11 Apr 2022 23:57:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
Date:   Mon, 11 Apr 2022 23:50:11 +0200
References: <pull.1210.git.1649507317350.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1210.git.1649507317350.gitgitgadget@gmail.com>
Message-ID: <220411.86bkx7i8qi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 09 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As the address sanitizer checks for a superset of the issues detected
> by setting MALLOC_CHECK_ (which tries to detect things like double
> frees and off-by-one errors) there is no need to set the latter when
> compiling with -fsanitize=address.
>
> This fixes a regression introduced by 131b94a10a ("test-lib.sh: Use
> GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34", 2022-03-04)
> which causes all the tests to fail with the message
>
>     ASan runtime does not come first in initial library list;
>     you should either link runtime to your application or
>     manually preload it with LD_PRELOAD.
>
> when git is compiled with SANITIZE=address on systems with glibc >=
> 2.34. I have tested SANITIZE=leak and SANITIZE=undefined and they do
> not suffer from this regression so the fix in this patch should be
> sufficient.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
>     
>     I'm submitting this now as it fixes a regression introduced in the
>     current cycle. Having said that there is an easy workaround (once one
>     has discovered GIT_TEST_NO_MALLOC_CHECK) so I'd be happy to wait until
>     the start of the next cycle given I've just missed -rc1.

I wonder why we have to justify that we'll only turn on
TEST_NO_MALLOC_CHECK if it's SANITIZE=address.

I.e. we also have SANITIZE=undefined, wouldn't it be more future-proof
to just say that these analysis options are mutually exclusive by
default?

That would have the bonus of e.g. making SANITIZE=leak faster, it's
already slow enough without the extra help of glibc's instrumentation.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1210%2Fphillipwood%2Fwip%2Ftest-malloc-asan-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1210/phillipwood/wip/test-malloc-asan-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1210
>
>  Makefile      | 5 ++++-
>  t/test-lib.sh | 5 +++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 91738485626..76d187991d2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1267,8 +1267,9 @@ PTHREAD_CFLAGS =
>  SPARSE_FLAGS ?= -std=gnu99
>  SP_EXTRA_FLAGS = -Wno-universal-initializer
>  
> -# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
> +# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak,address targets
>  SANITIZE_LEAK =
> +SANITIZE_ADDRESS =
>  
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
> @@ -1314,6 +1315,7 @@ SANITIZE_LEAK = YesCompiledWithIt
>  endif
>  ifneq ($(filter address,$(SANITIZERS)),)
>  NO_REGEX = NeededForASAN
> +SANITIZE_ADDRESS = YesCompiledWithIt
>  endif
>  endif
>  
> @@ -2861,6 +2863,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
>  	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
> +	@echo SANITIZE_ADDRESS=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_ADDRESS)))'\' >>$@+

Then this could just add SANITIZERS=$(SANITIZERS), we still need
SANITIZE_LEAK as we care about that specifically, but This mostly sounds
sensible, but for this:

> -# Add libc MALLOC and MALLOC_PERTURB test
> -# only if we are not executing the test with valgrind
> +# Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
> +# the test with valgrind and have not compiled with SANITIZE=address.
>  if test -n "$valgrind" ||
> +   test -n "$SANITIZE_ADDRESS" ||
>     test -n "$TEST_NO_MALLOC_CHECK"
>  then
>  	setup_malloc_check () {

We could check $SANITIZERS here instead.
