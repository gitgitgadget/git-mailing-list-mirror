Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A5C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiCGLYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbiCGLYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:24:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1D74130E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:53:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw13so30865436ejc.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 02:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RGZ4mBELtP2GzZADEgYxmMHGx2tw8oJsFDD70s8KUQM=;
        b=duNc33ITm4CbWxVwYsCtCfxhP6jISGllUSGcyqlRiPPYYSDj05waD8z5/FVDlXnOOx
         5W+YEcYwcLdgihiXcWA7OnC2LfTwdyUhPyK4QRwUHluxSTUDPmrA1UIIkaH9B4ocwU1g
         z6sJAqwg7bum6fwy05yeXFQtGXJQrz8wM3l8KSlt+f/P/oHIDJF9qRtQof5q2f8tcQdJ
         bJOLfTSHNSMC2GmcMT3XUHVfE0RrBZz0iBMxg/p/pB+sd0rsWXAYpe+lJSqqJDgMr5Lg
         H0o8nh7emDZcFdM4lOHb7FftPgLMK6+SAo0fwydRkSyMVpMUDIQTQkVwflcr/DPE/plW
         ioLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RGZ4mBELtP2GzZADEgYxmMHGx2tw8oJsFDD70s8KUQM=;
        b=CdfklnTuSMT5PRQvvCsvsdPICbzPbbffvOEKXIw7KFTEIvhB0E0FTu3kawfnPqRj+y
         Ad2BuMntV7v72WzS8PSSD+icq/NnazQ7tJ9m1yAg/o61gg3HVT+jqJ1xeYL7GIn0T/xi
         YgRCczN004+CDMIr/H1TkhjJTF3GHWKpNVaEVUIqTObtchMyiG0HLbbxfC85nS8t2ko1
         cFKf6IUmHa2Iz3Ba7TFIiOXTw14T9czhDyVXXJ5Z3fbzg+ZQzvREpF6i9OfRsOcTEqs+
         m4zDvxDp8csHquF4giHQ0x7Ds0jgBp5ULEZgJywqdf5hvP8wAaBKi0HAyXh3Pipc4+Y5
         ed7A==
X-Gm-Message-State: AOAM532szuTWBZXBiRv9gdLNdgqMjOhdw39/hOXHdZaRYYuHaPK9SGSD
        6wUuJ/N3wSUXPI4u6Ta/3uRLNeBYqrw=
X-Google-Smtp-Source: ABdhPJzZAGsIoWjpVNceErUuM5byCEm4kaeWPkRY5crZkid9nz5oXn4WwAV993X+Ds8P/L0Vm39m/g==
X-Received: by 2002:a17:907:1c10:b0:6da:6316:d009 with SMTP id nc16-20020a1709071c1000b006da6316d009mr8571784ejc.621.1646650389908;
        Mon, 07 Mar 2022 02:53:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090681c800b006d9f7b69649sm4573531ejx.32.2022.03.07.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 02:53:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRAzE-001QWQ-Iv;
        Mon, 07 Mar 2022 11:53:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 19/30] help: include fsmonitor--daemon feature flag
 in version info
Date:   Mon, 07 Mar 2022 11:51:04 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <bc240a9e665841a622c96b8a245ce033684394f6.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bc240a9e665841a622c96b8a245ce033684394f6.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220307.86cziy2fvv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add the "feature: fsmonitor--daemon" message to the output of
> `git version --build-options`.
>
> The builtin FSMonitor is only available on certain platforms and
> even then only when certain Makefile flags are enabled, so print
> a message in the verbose version output when it is available.
>
> This can be used by test scripts for prereq testing.  Granted, tests
> could just try `git fsmonitor--daemon status` and look for a 128 exit
> code or grep for a "not supported" message on stderr, but these
> methods are rather obscure.
>
> The main advantage is that the feature message will automatically
> appear in bug reports and other support requests.
>
> This concept was also used during the development of Scalar for
> similar reasons.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  help.c        | 4 ++++
>  t/test-lib.sh | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/help.c b/help.c
> index 71444906ddf..9112a51e84b 100644
> --- a/help.c
> +++ b/help.c
> @@ -12,6 +12,7 @@
>  #include "refs.h"
>  #include "parse-options.h"
>  #include "prompt.h"
> +#include "fsmonitor-ipc.h"
>  
>  struct category_description {
>  	uint32_t category;
> @@ -695,6 +696,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
>  		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> +
> +		if (fsmonitor_ipc__is_supported())
> +			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
>  	}
>  }
>  
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e4716b0b867..46cd596e7f5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1799,3 +1799,9 @@ test_lazy_prereq SHA1 '
>  # Tests that verify the scheduler integration must set this locally
>  # to avoid errors.
>  GIT_TEST_MAINT_SCHEDULER="none:exit 1"
> +
> +# Does this platform support `git fsmonitor--daemon`
> +#
> +test_lazy_prereq FSMONITOR_DAEMON '
> +	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
> +'

As I found recently (referenced in another series) the test_lazy_prereq
doesn't currently catch segfaults etc. in git even if test_must_fail and
friends are used.

But it's still better to future-proof things and not add more cases of
git on the LHS of a pipe. So instead:

    git version .. >out &&
    grep ...

The prereqs are run in their own temporary directory, so creating those
files is OK.

Also: You run "grep" here twice, but as the code context shown we could
just run it once.

