Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3617C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhL1Q21 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Dec 2021 11:28:27 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38407 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhL1Q20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:28:26 -0500
Received: by mail-pl1-f169.google.com with SMTP id c3so724894pls.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/G0RNCrIdMDIjLUtjU5wPCG0m8MO+5kdtPvvYEvM+g8=;
        b=C+8ClEMUPvV7i9IjGaYwkem6EPQPIZApsIjxo3GzbF8D8oKX0IhUCPsZ9LVoO/qVH+
         g9FVYC1VKJdLooiDyqv1XLtXIc0aldd2gnvwDzF6Ka5Ab6bCzDDCQhtQ0q0nlEZxUeug
         jbWQDR9LCaVMbrJnCcQ+v30+aNzG3oaIsLNMiSWy8+kdkqb2wxX7Px+qSmSKf6QiaeFi
         xsBN9rB1CF/9oucSB1ymaLTTWy/f3CgrJb/G71vC4PqVNvSuTrcKsKrHDWMAx4fE8mUV
         Ynt96EUHdjvteIaNtf0egFb7zC9hAWgMIUyvvrmaTQQn3YaMv/nL6UoUitlutpSnPIw3
         ZLwA==
X-Gm-Message-State: AOAM532rhyNbif4LkuBExIYIMGarFSjqGFI/dc0DtdzJu+4t0RwEHdYr
        fUO01FXFJGY4gUpUSbpY+VrLimdTbxNlUOTKC1g=
X-Google-Smtp-Source: ABdhPJxxKO4ZAv4tBReQwe3t1sSNCdc28i4vsa/KTDBvvnXW/pH4F00jV0LojdCGj2pyApiPDbmCOy9XRqoZnvrCwQg=
X-Received: by 2002:a17:902:b942:b0:148:a2f7:9d72 with SMTP id
 h2-20020a170902b94200b00148a2f79d72mr22430340pls.145.1640708905891; Tue, 28
 Dec 2021 08:28:25 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <patch-6.7-a5ef9f69530-20211228T153456Z-avarab@gmail.com>
In-Reply-To: <patch-6.7-a5ef9f69530-20211228T153456Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Dec 2021 11:28:15 -0500
Message-ID: <CAPig+cR4B6+-zw2RAgkU6c5miDxyo5PP_dmqqp+6xpSGt=9obg@mail.gmail.com>
Subject: Re: [PATCH 6/7] help: add --no-[external-commands|aliases] for use
 with --all
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 10:36 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add the ability to only emit git's own usage information under
> --all. This also allows us to extend the "test_section_spacing" tests
> added in a preceding commit to test "git help --all"
> output.
>
> Previously we could not do that, as the tests might find a git-*
> command in the "$PATH", which would make the output differ from one
> setup to another.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> @@ -8,7 +8,7 @@ git-help - Display help information about Git
> -'git help' [-a|--all] [--[no-]verbose]
> +'git help' [-a|--all] [--[no-]verbose] [--[no-](external-commands|aliases)]

Are these two new options mutually exclusive as this synopsis line
seems to indicate? Glancing at the code, it looks like they can be
used together. So, perhaps the synopsis should just say:

    'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands]
[--[no-]aliases]

> diff --git a/builtin/help.c b/builtin/help.c
> @@ -51,9 +51,14 @@ static const char *html_path;
>         OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
>                     HELP_ACTION_ALL),
> +       OPT_BOOL(0, "external-commands", &show_external_commands,
> +                N_("show external commands in --all?")),
> +       OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all?")),
>         OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),

Nit: I don't see question marks on any of the existing options. It's
not clear what purpose they serve here.

> @@ -75,7 +80,7 @@ static struct option builtin_help_options[] = {
>  static const char * const builtin_help_usage[] = {
> -       N_("git help [-a|--all] [--[no-]verbose]]"),
> +       N_("git help [-a|--all] [--[no-]verbose]] [--[no-](external-commands|aliases)]"),

Same observation made above about mutual exclusion.
