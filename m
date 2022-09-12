Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283FECAAD5
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiILQaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiILQaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 12:30:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8271C12F
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:30:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fs14so8576103pjb.5
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=qq9vBu3JGgCnro4CtzQEdtAYiL6bN8VBDQ5EBTnrqHU=;
        b=WT6d+/svXOalIy74+z11EMcaWRTteJlRMHuQ/7jbNfldp/lc7aW+eLzoFMKYcRXwJ5
         zANCgQpSPBfY0NTX55E3H7RUl55UvI9UvCFJewr/rnfaa/pHlkl9TGPLQH5T465nr+e5
         MQ2zQjoK+C9uuAygPwQFExMWsRGRtgAVSgbG5QcC18xApebHosUeiq5i9/HgbaciSH9F
         OZhlcj1vOdxclz4d3OlRotwF+Bms51AGnpwA2Ak/ckauL3qNvG3tnKvzptV694hQvaOH
         9MSC9YAlcosaJE2cdCBtNEzSVOcNwkT1exXrPEk0s+62HhM134AqLgNNNQx2zV8jaWNo
         HX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qq9vBu3JGgCnro4CtzQEdtAYiL6bN8VBDQ5EBTnrqHU=;
        b=4ioOI671yHA1DuB0a1o1ddel9uHfYulgsBldxJd1ONw3VfuM43seJaK/sWGFTuaMNB
         dfIOo21cAcpRSNom2itOe9fiGqg6hICztn7iKQO80C8qYNhpjhxhRzZ3/jgD0KVAhjy1
         eeUDO+ZOWQFlLOgN83gZD2CIQLAlh/OOcn3yC050YH1B+9MRnqG7CwINHPcXM/gbspY0
         wrna/YrfTB+RhNMSVEos+f94HrRBB8L+I9T4OLVOh0DzzC9mHVn2Da5Z0XZjEDf7wI+n
         kjjjakUeGwjw7zb8eYHaqVUP6ZYxl8DxRVvp3f7pUQ9LWAVNgFpgMmtrPZm4ScpUY+qB
         6x3Q==
X-Gm-Message-State: ACgBeo3HssiqwlSiWsqePhTFl+hYy0jqYaoH+li0iCyPEMiLExrg5hNH
        BOm4yv8nleSExnOU1tPokp8=
X-Google-Smtp-Source: AA6agR401X7pkrccG1E4GI7qGEHttfHDjfPeEvGmUQOL16aOHmj2nOuqCuV8dE1kVsvmHO8pMy+UPw==
X-Received: by 2002:a17:90b:4d12:b0:202:f027:557e with SMTP id mw18-20020a17090b4d1200b00202f027557emr296847pjb.1.1663000220348;
        Mon, 12 Sep 2022 09:30:20 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r12-20020a17090a1bcc00b001fdcb792181sm5361817pjr.43.2022.09.12.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:30:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Rene Kita <mail@rkta.de>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] blame: Make --show-name negatable
References: <20220912054515.29559-1-mail@rkta.de>
        <20220912054515.29559-2-mail@rkta.de>
        <CAFaJEquyFE86VVRy9jZ13xtjFpLbJaseFWf=Vo3CeKdnvScvcg@mail.gmail.com>
Date:   Mon, 12 Sep 2022 09:30:19 -0700
In-Reply-To: <CAFaJEquyFE86VVRy9jZ13xtjFpLbJaseFWf=Vo3CeKdnvScvcg@mail.gmail.com>
        (=?utf-8?Q?=22=C3=98ystein?= Walle"'s message of "Mon, 12 Sep 2022 15:25:13
 +0200")
Message-ID: <xmqqsfkwftd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> That was me! :-)
>
> Not long after I sent you a new link with the patch below, but I suppose
> you missed it. My first rough attempt was incomplete, changing the
> behavior from on/auto on to auto/off instead of the intended
> on/auto/off.

Not clear to this bystander what exactly is going on.  Is the patch
Rene relayed is your rough attempt that was incomplete?

> The docs changes look good to me (but should perhaps be squashed into the impl
> patch?). Not sure how many of the negatable long options that exist are
> actually documented as such, but imho. they should be.
>
> There are no added tests, but there are no tests for -f/--show-name in the
> first place and I just didn't get around to writing one...

Thanks.  Let's see if we can have an cleaned-up version with tests,
then.



>
> Øsse
>
> ---
>  builtin/blame.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index a9fe8cf7a6..cbaae91a8f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -49,6 +49,7 @@ static int blank_boundary;
>  static int incremental;
>  static int xdl_opts;
>  static int abbrev = -1;
> +static int show_name = -1;
>  static int no_whole_file_rename;
>  static int show_progress;
>  static char repeated_meta_color[COLOR_MAXLEN];
> @@ -621,7 +622,8 @@ static void find_alignment(struct blame_scoreboard
> *sb, int *option)
>          if (compute_auto_abbrev)
>              auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
>          if (strcmp(suspect->path, sb->path))
> -            *option |= OUTPUT_SHOW_NAME;
> +            if (show_name == -1)
> +                *option |= OUTPUT_SHOW_NAME;
>          num = strlen(suspect->path);
>          if (longest_file < num)
>              longest_file = num;
> @@ -867,7 +869,7 @@ int cmd_blame(int argc, const char **argv, const
> char *prefix)
>          OPT_BOOL(0, "show-stats", &show_stats, N_("show work cost
> statistics")),
>          OPT_BOOL(0, "progress", &show_progress, N_("force progress
> reporting")),
>          OPT_BIT(0, "score-debug", &output_option, N_("show output
> score for blame entries"), OUTPUT_SHOW_SCORE),
> -        OPT_BIT('f', "show-name", &output_option, N_("show original
> filename (Default: auto)"), OUTPUT_SHOW_NAME),
> +        OPT_BOOL('f', "show-name", &show_name, N_("show original
> filename (Default: auto)")),
>          OPT_BIT('n', "show-number", &output_option, N_("show original
> linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
>          OPT_BIT('p', "porcelain", &output_option, N_("show in a
> format designed for machine consumption"), OUTPUT_PORCELAIN),
>          OPT_BIT(0, "line-porcelain", &output_option, N_("show
> porcelain format with per-line commit information"),
> OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
> @@ -943,6 +945,9 @@ int cmd_blame(int argc, const char **argv, const
> char *prefix)
>      revs.diffopt.flags.follow_renames = 0;
>      argc = parse_options_end(&ctx);
>
> +    if (show_name == 1)
> +        output_option |= OUTPUT_SHOW_NAME;
> +
>      prepare_repo_settings(the_repository);
>      the_repository->settings.command_requires_full_index = 0;
