Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7D8C433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D1B20771
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgGUQXi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Jul 2020 12:23:38 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43972 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgGUQXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 12:23:38 -0400
Received: by mail-wr1-f46.google.com with SMTP id a15so6856299wrh.10
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P+oXAVgyC6O7j9qhea/IREn3eggrCmhnFuTSWuFP0To=;
        b=hZ7GbrqW8OS8o7u80UXC4Sv2JVqN5S7JS2Uh9tKbGXgOk6Pfn3GapvCcdze+POg0gL
         2rZZ+n5safI5Tl48VbaJ/+1he74DjCQAkmN9f5jxFAcpBOKkYs08QGQU5gNbciXQ9J4y
         stWKbaRixK5Onk4HZ1Ejmq5p58ZaX4lDic2eVShx/Epsiqf0RnwjQcabEhWnZWfvV7cD
         e1MsbgIonywzhVeHnNvdYiVNhWQYirI2qfvFtkfYsbmE8O+VfZST7/3MzMy7TzjWA7hR
         LK5bR7m/C8taqR3owWg1tT1RLiRNXxhrXC0cJeZhMptJRUiLJALeZChUt5BV28TMObIs
         bndg==
X-Gm-Message-State: AOAM530zgcd4PIOu4ivL8FEkRRps7A2QweMTLU/hs3ZHUnKyDUkfJHzJ
        mkt1F5bqV4SNT/kgQmGiW8+2YPLcdcsFTU2O5THLZV4tWa8=
X-Google-Smtp-Source: ABdhPJwEw6i0Fcsntxlt5yLeSJqA5GNeaTlvO7rGm99MqCtV10qLu4Wab71WVtL84N8MwXwgO8/olqEdFvJHNgggpX0=
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr18722536wrn.120.1595348616345;
 Tue, 21 Jul 2020 09:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200721161225.6769-1-szeder.dev@gmail.com>
In-Reply-To: <20200721161225.6769-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Jul 2020 12:23:25 -0400
Message-ID: <CAPig+cQmjgmWx3Y_8WwOORsjW0Q7M-xXKonFW1qfHYLW3mD4Fw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] travis-ci: remove bogus 'pyenv' in the Linux jobs
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 21, 2020 at 12:12 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> In our test suite, when 'git p4' invokes a Git command as a
> subprocesses, then it should run the 'git' binary we are testing.
> Unfortunately, this is not the case in the 'linux-clang' and
> 'linux-gcc' jobs on Travis CI, where 'git p4' runs the system
> '/usr/bin/git' instead.
>
> Travis CI's default Linux image includes 'pyenv', and all Python
> invocations that involve PATH lookup go through 'pyenv', e.g. our
> 'PYTHON_PATH=$(which python3)' sets '/opt/pyenv/shims/python3' as
> PYTHON_PATH, which in turn will invoke '/usr/bin/python3'.  Alas, the
> 'pyenv' version included in this image is buggy, and prepends the
> directory containing the Python binary to PATH even if that is a
> system directory already in PATH near the end.  Consequently, 'git p4'
> in those jobs ends up with its PATH starting with '/usr/bin', and then
> runs '/usr/bin/git'.
>
> So remove 'pyenv' in Travis CI's Linux jobs to prevet it from

s/prevet/prevent/

> interfering with our 'git p4' tests.
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> @@ -36,6 +36,14 @@ linux-clang|linux-gcc)
> +
> +       if test true = "$TRAVIS" &&
> +          pyenv_root=$(pyenv root)
> +       then
> +               # pyenv in Travis CI's current default (xenial) Linux
> +               # image messes up PATH for 'git p4'.

I wonder if this comment should give more precise detail about exactly
how it "messes up" PATH.

> +               sudo rm -rf "$pyenv_root"
> +       fi
