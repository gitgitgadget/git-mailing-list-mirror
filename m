Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55711C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 19:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbiBOTjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:39:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiBOTju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 14:39:50 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5081BF45
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 11:39:39 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id z16so125078pfh.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 11:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLTISibTpXxKMBFdWv5ml8n11WbT25n1LvQ2PGYeI/4=;
        b=y0524QWsD79uBsCeYRk63b6YP4yB2DxWDrdXxOWOtiku0ZVh8kFCwMQtRnaNrZ+zAp
         2L93LCi9uABfEQVYJIC6TrLvWxXdnbsdq66gurWwwaKfaHdsyKAf9FQVCd80aFtozVJH
         WYuNqHZVJPi2VlB6WKPJSxyMWrPwQO/kWVYU62zkUOyutgXFqxUpMPEc46XT4bE8SbQd
         8lJDsJ24CG+QVwvEPSdomImtQ7slgQyODm56DeLPYwB1YB5sf34ezG+CkOqppA3Bg+p8
         cPRU6spBilCXBaDyJHWZ3fKYFLTdB7GbY9h4w6dgB5mQvbyGyW6K0yDPkCzHhWmR/7S4
         RO2w==
X-Gm-Message-State: AOAM531pFFug9LsPuMvc/Y2lCzTfnmAZmX48RQ+UrXYdSimiN+t4Y8q1
        VT+TefABfo5skE8oUhbzi+u/Dx+qHbPQSayV2r0=
X-Google-Smtp-Source: ABdhPJznGr4wex2FGw/YKkFDXv+l2wHU4vUj3ZVevqnDlqX0Bwpg/Cdq8SjmhcS9dfis9Gb5LIAStpQWBZvfffgMRAw=
X-Received: by 2002:a63:5b1c:: with SMTP id p28mr361068pgb.227.1644953978971;
 Tue, 15 Feb 2022 11:39:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
 <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com> <a6dd5d72fce8cec430c0ec5da2dd9f0969a7fd91.1644862989.git.gitgitgadget@gmail.com>
In-Reply-To: <a6dd5d72fce8cec430c0ec5da2dd9f0969a7fd91.1644862989.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 14:39:27 -0500
Message-ID: <CAPig+cTwLhn1GZ_=6s0FXL0z=Q=p1w9ZGK0hAV8wfK9RsQYjnA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] cat-file: add --batch-command mode
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 1:23 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add a new flag --batch-command that accepts commands and arguments
> from stdin, similar to git-update-ref --stdin.

Some relatively minor comments below. Not sure any of them are serious
enough to warrant a reroll...

> The contents command takes an <object> argument and prints out the object
> contents.
>
> The info command takes a <object> argument and prints out the object
> metadata.

s/a <object>/an <object>/

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> @@ -96,6 +96,33 @@ OPTIONS
> +contents `<object>`::
> +       Print object contents for object reference `<object>`. This corresponds to
> +       the output of `--batch`.
> +
> +info `<object>`::
> +       Print object info for object reference `<object>`. This corresponds to the
> +       output of `--batch-check`.

Sorry if I wasn't clear in my earlier review, but when I suggested
s/<object>/`<object>`/, I was referring only to the body of each item,
not to the item itself (for which we do not -- I think -- ever use
`<...>`). So:

    content <object>::
        Print object contents ... `<object>`. ...

As mentioned in my earlier review, I think the SYNOPSIS also needs an
update to mention --batch-command.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> @@ -513,6 +514,129 @@ static int batch_unordered_packed(const struct object_id *oid,
> +static void dispatch_calls(struct batch_options *opt,
> +               struct strbuf *output,
> +               struct expand_data *data,
> +               struct queued_cmd *cmd,
> +               int nr)
> +{
> +       int i;
> +
> +       for (i = 0; i < nr; i++){

Style: for (...) {

> +               cmd[i].fn(opt, cmd[i].line, output, data);
> +               free(cmd[i].line);
> +       }
> +
> +       fflush(stdout);
> +}

If I recall correctly, Junio suggested calling free() within this
loop, but this feels like an incorrect separation of concerns since it
doesn't also reset the caller's `nr` to 0. If (for some reason),
dispatch_calls() is invoked twice in a row without resetting `nr` to 0
in between the calls, then the dispatched commands will be called with
a pointer to freed memory.

One somewhat ugly way to fix this potential problem would be for this
function to clear `nr`:

    static void dispatch_calls(..., int *nr)
    {
        for (...) {
            cmd[i].fn(...);
            free(cmd[i].line);
        }
        *nr = 0;
        flush(stdout);
    }

But, as this is a private helper, the code as presented in the patch
may be "good enough" even though it's a bit fragile.

> +static void batch_objects_command(struct batch_options *opt,
> +                                   struct strbuf *output,
> +                                   struct expand_data *data)
> +{
> +       while (!strbuf_getline(&input, stdin)) {
> +               if (!input.len)
> +                       die(_("empty command in input"));
> +               if (isspace(*input.buf))
> +                       die(_("whitespace before command: '%s'"), input.buf);
> +
> +               if (skip_prefix(input.buf, "flush", &cmd_end)) {
> +                       if (!opt->buffer_output)
> +                               die(_("flush is only for --buffer mode"));
> +                       if (*cmd_end)
> +                               die(_("flush takes no arguments"));

I didn't articulate it in my previous review since the thought was
only half-formed, but given "flushify", this will incorrectly complain
that "flush takes no arguments" instead of complaining "unknown
command: flushify" as is done below (or it will incorrectly complain
"flush is only for --buffer mode" if --buffer wasn't specified).

If I'm reading the code correctly, it seems as if these problems could
be avoided by treating `flush` as just another parse_cmd::commands[]
item so that it gets all the same parsing/checking as the other
commands rather than parsing it separately here.

> +                       dispatch_calls(opt, output, data, queued_cmd, nr);
> +                       nr = 0;
> +                       continue;
> +               }
> +
> +               for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +                       if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
> +                               continue;
> +
> +                       cmd = &commands[i];
> +                       if (cmd->takes_args) {
> +                               if (*cmd_end != ' ')
> +                                       die(_("%s requires arguments"),
> +                                           commands[i].prefix);
> +
> +                               p = cmd_end + 1;
> +                       } else if (*cmd_end) {
> +                               die(_("%s takes no arguments"),
> +                                   commands[i].prefix);
> +                       }

Good. Appears to be correctly handling the full matrix of
command-requires-arguments and the actual input having or not having
arguments.

> +                       break;
> +               }
> +
> +               if (!cmd)
> +                       die(_("unknown command: '%s'"), input.buf);

If you treat `flush` as just another parse_cmd::commands[], then right
here is where you would handle it (I think):

    if (strcmp(cmd->prefix, "flush")) {
        dispatch_calls(opt, output, data, queued_cmd, nr);
        nr = 0;
        continue;
    }

> +               if (!opt->buffer_output) {
> +                       cmd->fn(opt, p, output, data);
> +                       continue;
> +               }
> +
> +               ALLOC_GROW(queued_cmd, nr + 1, alloc);
> +               call.fn = cmd->fn;
> +               call.line = xstrdup_or_null(p);
> +               queued_cmd[nr++] = call;
> +       }
> +
> +       if (opt->buffer_output &&
> +           nr &&
> +           !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
> +               dispatch_calls(opt, output, data, queued_cmd, nr);
> +
> +       free(queued_cmd);
> +       strbuf_release(&input);
> +}
