Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC2C2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 09:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAEA20809
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 09:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgK0JIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 04:08:24 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33467 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgK0JIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 04:08:23 -0500
Received: by mail-ej1-f67.google.com with SMTP id 7so6624997ejm.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 01:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Dr6RJpsXbmU82K2vgrNoAHQgsievC3JGPXMsEerPEs=;
        b=GOVe7SBjmvGgn7pOJrz7XE8RWAW28LH0x7n4O05pCoNC7svUe16U8tuCi11PKj3EeA
         379jU2owpts9BhUmyXHgXv8m25+jMFTFci2OENBA1quAhBD/qh/9WDfevt0rIovbQNIK
         i8EVpD39zsPj8pcm69HlIsu8PTdo82HLEGoPcflm0s+MB7XnKie1vne0bFJBG0R4eZT2
         KYeugfTN03T0Yr1EZFy1wQ2TiWAu7xxdXUDJkfuLeUEunlHGxt0jlvC0ambypHgckFL4
         zf8cdnHK1h0B8MYUfyZemEuL9ubDja9+BaSGpLm4ADL2fPwXrEJAecbwPwdYbZSq/U8k
         bwnA==
X-Gm-Message-State: AOAM532yJqSPOueOI06uajACOpjZGBe8uS4oj7M+GKLS2UpSJEbPAUBs
        rP+XhyfAE+ULVgNmae8qZWrLEiRfuMaIVH4DpncKK4EF2Rw=
X-Google-Smtp-Source: ABdhPJxJH36NlXzZK7lLbJooZ8/k+h35g7ApqhbS6SWAp0STJQnJGsgZ4B0AdC4Yv9jtkNJva5pzKR2luSoADQ0tFVM=
X-Received: by 2002:a17:906:3617:: with SMTP id q23mr6516637ejb.371.1606468101629;
 Fri, 27 Nov 2020 01:08:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
 <pull.776.v5.git.1606191405.gitgitgadget@gmail.com> <ac9a28bea39b4d1897ad6a41331e52770c8c7531.1606191405.git.gitgitgadget@gmail.com>
In-Reply-To: <ac9a28bea39b4d1897ad6a41331e52770c8c7531.1606191405.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Nov 2020 04:08:10 -0500
Message-ID: <CAPig+cQ6vZzbb36t5Kn=NM9wXC8i1MpcGXfK=QwnNRoTQsQP0A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] maintenance: use Windows scheduled tasks
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 11:16 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Git's background maintenance uses cron by default, but this is not
> available on Windows. Instead, integrate with Task Scheduler.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/gc.c b/builtin/gc.c
> @@ -1671,6 +1671,162 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
> +static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
> +{
> +       const char *frequency = get_frequency(schedule);
> +
> +       tfile = xmks_tempfile("schedule_XXXXXX");
> +       if (!tfile || !fdopen_tempfile(tfile, "w"))
> +               die(_("failed to create temp xml file"));

Several comments:

The "x" prefix on xmks_tempfile() means that it will die() if it can't
open the tempfile, so the `!tfile` condition is pointless, thus it
could be written:

    if (!fdopen_tempfile(tfile, "w"))

The mks_tempfile_t*() functions with a trailing "t" will place the
temporary file in TMPDIR, whereas xmks_tempfile() used here places it
in the worktree directory, which is not as desirable. Ideally, this
would be using xmks_tempfile_t(), however, that function doesn't exist
yet in tempfile.h, so the best you can do (without the extra work of
also adding the missing function) is to use mks_tempfile_t(). That
doesn't die(), so `!tfile` would still be needed in the conditional.

In earlier versions, you incorporated `frequency` into the temporary
filename which was nice because it made the test easier to understand.
It's not hard to do so here, as well, nor to extract a useful filename
in the test (as I'll show below). For instance:

    struct strbuf tpath = STRBUF_INIT;
    strbuf_addf(&tpath, "schedule-%s-XXXXXX", frequency);
    tfile = mks_tempfile_t(tpath.buf);
    strbuf_release(&tpath);
    if (!tfile || !fdopen(tempfile(tfile, "w"))
        die(...);

> +       strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml", tfile->filename.buf, NULL);

Alternately, use the getter:

    strvec_pushl(..., get_tempfile_path(&tfile), ...);

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -453,6 +453,50 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
> +test_expect_success 'start and stop Windows maintenance' '
> +       write_script print-args <<-\EOF &&
> +       echo $* >>args
> +       while test $# -gt 0
> +       do
> +               case "$1" in
> +               /xml) shift; xmlfile=$1; break ;;
> +               *) shift ;;
> +               esac
> +       done
> +       lines=$(wc -l args | awk "{print \$1;}")

You're using `awk` to pluck out the line count and ignore the
filename, but the same can be accomplished by feeding the file as
stdin to `wc` rather than naming it as an argument, thus this is
equivalent:

    lines=$(wc -l <args)

However, this idea of constructing stable names for the files by
assigning them numerically incrementing values is unnecessary and
makes the test harder to understand.

> +       test -z "$xmlfile" || cp "$xmlfile" "schedule-$lines.xml"

If you take the suggestion earlier in this review of naming the file
"schedule-${frequency}-XXXXXX.xml", then you can strip it down to just
"schedule-${frequency}.xml" using the expression `${xmlfile%-*}.xml`.
There is no need for `$lines`. Thus, copying the file would become:

    test -z "$xmlfile" || cp "$xmlfile" "${xmlfile%-*}.xml"

> +       for i in 1 2 3
> +       do

Which means that you can use the more easily understood `hourly daily
weekly` enumeration here rather than `1 2 3`.

Having said all this, I'm not sure it's worth a re-roll. These sort of
tweaks can be done atop the current series if someone wants to tackle
it.
