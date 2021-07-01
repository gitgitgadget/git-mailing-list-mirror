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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423DC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F97E613F0
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhGAWpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhGAWpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 18:45:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CA3C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 15:42:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l24so13015301ejq.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZlKMsnNK0RGJlOQBCIGYlek+hWolkLG0dieZeGl+454=;
        b=KivcJNxFi51hYYcKXqQbxyf7wR6yl8EcNYYU4pqt3VLqDOh8E9N9iwmwAgP+3yrZux
         tyOLKVUZ5+LeUFiSrThcSWA76hjKfGbsWKmj4ENXceEB9q8g6hROM8oh5MTcUz5sec71
         vy7vTILbNJ7EbLQz3WYlNbUsHYHh2fdfjSLwZDoNVnSOEf90YwtZuhdbTq+JNS2ptPWZ
         0ZgoO10HRnP95d04jFykrQzaVvv81SvbkcQhz2fQC7HMVkz3699O6tgBBsG6ual9u7RL
         ZKPlglw/KuBdUyBhk7I5KY0dUYnbKSF8Dz6h6+w/sN+GYteYsur9qctTyw5fsqiE+XHS
         7N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZlKMsnNK0RGJlOQBCIGYlek+hWolkLG0dieZeGl+454=;
        b=MF5SaRnKV3ViyRWCtv53EMsOeUrjXSkLSm+LdJO6+4Q5ZHDD9DEWmyE3wmxuc8UDhw
         R5x1wo8Alm/zbiYAf4Bb5aVWR10tqWvc0/2pW5Q88Y8ymqNcQWXr9bVpHlVvlVOm8hHA
         2FuZ1nCKs1zZnK4Ifk3Rbfioe7TGHtZAc5nLsr/KQJgGn6s/mn3lV06uOgaADf0+V9C8
         KGFNv/4I/4NvDn5tdvY12QnFi8A9l7kGPdaVEowURJlBdBOvL/in0WQzBD3zbu/pYi5i
         H0OQAguAvyXm0yY3Y6MKuhxieeZM7lvdP8ickC+JIckhEK2e1L8H1fhKc3OtjM0dY6cd
         nH2Q==
X-Gm-Message-State: AOAM533KAJElrA3aUiCWPQdrXgAb0jpybruoyJgpJBaG6gENoEl0HueE
        RK7T17+lhu+yQB+fHK4oqINusNE8I7RMEQ==
X-Google-Smtp-Source: ABdhPJxMUvC4P1fLvv7LL7LcbFZkkA1C97XurBvjBuoKY1j6vALBWtRgiLsH2mLzsPm0pCtnVbLfzw==
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr2196758ejb.253.1625179365316;
        Thu, 01 Jul 2021 15:42:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s4sm483273edu.49.2021.07.01.15.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:42:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 10/34] t/helper/fsmonitor-client: create IPC client
 to talk to FSMonitor Daemon
Date:   Fri, 02 Jul 2021 00:41:22 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <c2adac8ed4b4f324b54b147e1fcb1aa4a74e80dd.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <c2adac8ed4b4f324b54b147e1fcb1aa4a74e80dd.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87y2apbqqk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create an IPC client to send query and flush commands to the daemon.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                         |   1 +
>  t/helper/test-fsmonitor-client.c | 121 +++++++++++++++++++++++++++++++
>  t/helper/test-tool.c             |   1 +
>  t/helper/test-tool.h             |   1 +
>  4 files changed, 124 insertions(+)
>  create mode 100644 t/helper/test-fsmonitor-client.c
>
> diff --git a/Makefile b/Makefile
> index 8fe1e42a435..c45caacf2c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -709,6 +709,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
>  TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
>  TEST_BUILTINS_OBJS += test-example-decorate.o
>  TEST_BUILTINS_OBJS += test-fast-rebase.o
> +TEST_BUILTINS_OBJS += test-fsmonitor-client.o
>  TEST_BUILTINS_OBJS += test-genrandom.o
>  TEST_BUILTINS_OBJS += test-genzeros.o
>  TEST_BUILTINS_OBJS += test-hash-speed.o
> diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
> new file mode 100644
> index 00000000000..f7a5b3a32fa
> --- /dev/null
> +++ b/t/helper/test-fsmonitor-client.c
> @@ -0,0 +1,121 @@
> +/*
> + * test-fsmonitor-client.c: client code to send commands/requests to
> + * a `git fsmonitor--daemon` daemon.
> + */
> +
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "fsmonitor-ipc.h"
> +
> +#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
> +int cmd__fsmonitor_client(int argc, const char **argv)
> +{
> +	die("fsmonitor--daemon not available on this platform");
> +}
> +#else

Re my earlier comments on excessive ifdefs: In this case don't we just
want to not compile test-fsmonitor-client at all unless
HAVE_FSMONITOR_DAEMON_BACKEND is true.

You'll get the same error as though you ran "helper/test-tool
does-not-exist", but the tests check for the prerequisite earlier
anyway, so why get this far on an unsupported platform for a pure test
helper?
