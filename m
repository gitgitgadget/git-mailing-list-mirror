Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F34C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 19:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A503216C4
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgKCTGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:06:53 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46270 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTGw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 14:06:52 -0500
Received: by mail-ej1-f65.google.com with SMTP id w13so12331394eju.13
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 11:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wn6YMSF2aaAMXrLLKb3ZzRLJHLcfj4xy7qK8+gEcjZI=;
        b=uYoim1mAW5xXPqmiKsx7d+GP0GbfyaeujMaczBF94Oq6I7k9YxQjGAI4R+nTfq2hSn
         ptYb04eBXEDEjaYjTgIkuEFXbQkRpIBQe8myK3eg0A1hBASUTYyH5wvUQ/sSXfZYPiM+
         0ZTbIfkRZOLLs8hbifUUGcWGXti99mpjgp7xKfYR/8Htx/AhrqXLOLUJeaRJh3Ywt8oG
         1uTbxo5i6vn5jkxNlEVFMKTwr+vJ5lPK1To0wk97DUyZp2BykO/aubMpp61ICJc8nxTE
         tlo9pzR4SqKcYgmxvc/YHWeOEIbJzgzcbv4umC88X55PAgIYoHnNMJ/xTvxDOiqTNqFz
         +kWw==
X-Gm-Message-State: AOAM531YiuRBs/Tl4O/FAnHVNMlXdGbyEB7yzHkd4KgcuXZH+0aqAoir
        HOm4POFkHPpLq5FAI0ck+2de8JVMBk6QjfTcSyo=
X-Google-Smtp-Source: ABdhPJw/meGtc7XQhK+I1I0dOo+4pHjo4A5LlhZpl7x3O4PAk6vRE7IrCDlYIRrRYeUmGMZOTFBvBzGqbg4Rm1bTLhk=
X-Received: by 2002:a17:906:6949:: with SMTP id c9mr9334389ejs.482.1604430409181;
 Tue, 03 Nov 2020 11:06:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com> <a9221cc4aa12192e9a691f8e1b77a3cc2d7e4952.1604412197.git.gitgitgadget@gmail.com>
In-Reply-To: <a9221cc4aa12192e9a691f8e1b77a3cc2d7e4952.1604412197.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Nov 2020 14:06:38 -0500
Message-ID: <CAPig+cRE3RNkUCrmmTvVC4mm1crT+1OEU5zSwu80pjXmDdAkfg@mail.gmail.com>
Subject: Re: [PATCH 3/3] maintenance: use Windows scheduled tasks
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

On Tue, Nov 3, 2020 at 9:05 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> There is a deficiency in the current design. Windows has two kinds of
> applications: GUI applications that start by "winmain()" and console
> applications that start by "main()". Console applications are attached
> to a new Console window if they are not already associated with a GUI
> application. This means that every hour the scheudled task launches a
> command window for the scheduled tasks. Not only is this visually
> obtrusive, but it also takes focus from whatever else the user is
> doing!

I wonder if you could use the technique explained in [1] to prevent
the console window from popping up.

[1]: https://pureinfotech.com/prevent-command-window-appearing-scheduled-tasks-windows-10/

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -441,6 +441,40 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
> +test_expect_success MINGW 'start and stop Windows maintenance' '
> +       echo "echo \$@ >>args" >print-args &&
> +       chmod a+x print-args &&

Same comments as my review of [2/3] regarding $@ and write_script().

> +       rm -f args &&
> +       GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
> +       cat args &&

Is this 'cat' leftover debugging gunk?

> +       # start registers the repo
> +       git config --get --global maintenance.repo "$(pwd)" &&
> +
> +       rm expect &&
> +       for frequency in hourly daily weekly
> +       do
> +               echo "/create /tn Git Maintenance ($frequency) /f /xml .git/objects/schedule-$frequency.xml" >>expect \
> +                       || return 1
> +       done &&

Rather than using >> within the loop, it's often simpler to capture
the output of the for-loop in its entirety:

    for frequency in hourly daily weekly
    do
        echo "/create ..." || return 1
    done >expect &&

However, in this case 'printf' may be even simpler:

    printf "/create /tn ... .git/objects/schedule-%s.xml\n" \
        hourly daily weekly >expect &&

> +       GIT_TEST_CRONTAB="/bin/sh print-args"  git maintenance stop &&

Too many spaces before the 'git' command.
