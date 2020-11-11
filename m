Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E69C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 08:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D85120678
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 08:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKKI7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:59:48 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:45960 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKI7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 03:59:47 -0500
Received: by mail-ej1-f65.google.com with SMTP id dk16so1674099ejb.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 00:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPe//0P2dHTCOLF2m3rIGBkKIC0R2olvVEXOwjoHCd8=;
        b=fFbo0QeTDgqNRYRGdIlJZ8BsfN3PPVLPnMLSzZCtgsEHJaQa7Z7utZeYuZaCajJwqs
         Jmu+t9NSJ/fYYujqYjiHdJohYkkkM67R0ffujkQ4ozefuBdaMpMyFoLU9+JcOWk/pWdl
         8e7uqoqxCE/fgN354eDhug7ysQ8zWAx+1gA40yffFicwmRFbSUa2bCDiAJbgEeWL1JNa
         usUZ1qQMXTN+o84Hr2zNuFn63jtg0VBee2gMrFcKpGnWs4k37Bnw+4b+5X89oefSrEJL
         OyBppqLMz5oJBCY0BaDhEWP2KNdkTxO0sGQzJtfMCpA3mwBVGK+VEJFTuq4GXIapUQez
         biCA==
X-Gm-Message-State: AOAM530nNnnCxNly0+s+yacfhTGGi+TcLqVUe7+keQ80mSKKiR/sPuRw
        28Hd2TdNSZHE/JvqOASWpS8SfF+Sxv7QFLXJknA=
X-Google-Smtp-Source: ABdhPJySVTIRs1raG2nYlQ/OUJN9cKxfb+oHZJqywd06TYG0LukamZLATB9POvF3w7/H4gXlC4Y43c+Thu+LvJw7Gl0=
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr23509811ejb.202.1605085186161;
 Wed, 11 Nov 2020 00:59:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <pull.776.v2.git.1604520368.gitgitgadget@gmail.com> <84eb44de31f04b2a94f57ee11d70be81f5bbeee2.1604520368.git.gitgitgadget@gmail.com>
In-Reply-To: <84eb44de31f04b2a94f57ee11d70be81f5bbeee2.1604520368.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Nov 2020 03:59:35 -0500
Message-ID: <CAPig+cRRQc=RNd=zGFvi2yiLD6PoLLBJQtFxkZ+QaVVA9MP1DA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] maintenance: use Windows scheduled tasks
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 3:06 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Git's background maintenance uses cron by default, but this is not
> available on Windows. Instead, integrate with Task Scheduler.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1698,6 +1698,187 @@ static int platform_update_schedule(int run_maintenance, int fd)
> +static int schedule_task(const char *exec_path, enum schedule_priority schedule)
> +{
> +       xmlpath =  xstrfmt("%s/schedule-%s.xml",
> +                          the_repository->objects->odb->path,
> +                          frequency);

Am I reading correctly that it is writing this throwaway XML file into
the Git object directory? Would writing to a temporary directory make
more sense? (Not worth a re-roll.)

> +       xmlfp = fopen(xmlpath, "w");
> +       if (!xmlfp)
> +               die(_("failed to open '%s'"), xmlpath);

Could use xfopen() as mentioned previously.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -442,6 +442,36 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
> +test_expect_success MINGW 'start and stop Windows maintenance' '
> +       for frequency in hourly daily weekly
> +       do
> +               printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
> +                       $frequency $frequency

Nit: You lost the `|| return 1` which was present in the previous
version. True, it's very unlikely that `printf` could fail, but having
the `|| return 1` there makes it easier for the reader's eye to glide
over the code without having to worry about whether it is handling
error conditions correctly, thus reduces cognitive load.

> +       done >expect &&

Rather than a loop, you could just use:

    printf "/create ... (%s) /f /xml ...schedule-%s.xml\n" \
        hourly hourly daily daily weekly weekly >expect &&

though it's subjective as to whether that is an improvement.
