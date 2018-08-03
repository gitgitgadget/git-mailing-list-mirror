Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCD51F597
	for <e@80x24.org>; Fri,  3 Aug 2018 03:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeHCFnG (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 01:43:06 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42991 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeHCFnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 01:43:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id y203-v6so484713ywd.9
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 20:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdA1A83otfBw5OefZk9cxCWKvpXH93V+NeIYCsZiJOk=;
        b=HDhpbBBJToSN5svsfdjHdGBcNGE3sp9aezcy+QU3Le2pl3mqRlaNzNL6X1FRNiGqas
         tYTx9v1iKjDW4WBTfwcOP3Eh8D4Eya73k+eQBn26n3lGpYuJVBS9soa25zMDelpdgqs5
         ZlDFrmjpgKhIr5DQ+/vpQNdofM79/vXChOJN9bueQwi8zfbeE0tz38MqGEeM/LV3hJyD
         iqaD4uEYz2w4zezEnk6BtGfq0MVaJcPKuK/mgDEGgtC2s4ZoKaHEcY/wK1ODEgQ1FHrM
         CN3JzdklGnVrAR0Fg9JMwcaP1okH8APeAU7w3ETr+mX7RdZlaOWI5dFBwaS3PUTR0I6V
         95DA==
X-Gm-Message-State: AOUpUlGWLCCO2vA5yOims5ceGiIEUev2Y1mf5ID7XlOnm/nbc5qar5KB
        3tLBuNwa0Lx+bPdkZMx83g7SGCmz4K8yHdc1V+Nt7ubr
X-Google-Smtp-Source: AAOMgpdn6LCcYD2wIb8wz/yPL0LoVZGDYhlUZBFBGFoE81r/LZ91lSW3yer+Qh4oSL74oy4sMCpuWAapreJFtL5sVAQ=
X-Received: by 2002:a0d:e253:: with SMTP id l80-v6mr1197792ywe.131.1533268129020;
 Thu, 02 Aug 2018 20:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180802121308.17371-1-hanwen@google.com> <20180802121308.17371-3-hanwen@google.com>
In-Reply-To: <20180802121308.17371-3-hanwen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 23:48:37 -0400
Message-ID: <CAPig+cQcLfN7TjUR6hzFT9h-VhE1o7VGkGkQdznDNxjTLNfzSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sideband: highlight keywords in remote sideband output
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 8:13 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> [PATCH 2/2] sideband: highlight keywords in remote sideband output

The -v option of git-format-patch makes it easy to let reviewers know
that this is a new version of a previously-submitted patch series.
This (I think) is the second attempt; if you need to send again, you
could use "git format-patch -v3 ...", which would result in "[PATCH v3
2/2] ...".

> The colorization is controlled with the config setting "color.remote".
>
> Supported keywords are "error", "warning", "hint" and "success". They
> are highlighted if they appear at the start of the line, which is
> common in error messages, eg.
>
>    ERROR: commit is missing Change-Id
>
> The rationale for this change is that Gerrit does server-side
> processing to create or update code reviews, and actionable error
> messages (eg. missing Change-Id) must be communicated back to the user
> during the push. User research has shown that new users have trouble
> seeing these messages.
> [...snip...]

Thanks, this commit message is much more helpful than the previous one.

If you end up re-rolling, you might consider swapping the order of
these paragraphs around a bit to first explain the problem the patch
is solving (i.e. the justification), then the solution and relevant
details. Documentation/SubmittingPatches has good advice about this.

Using Gerrit as the sole rationale is underselling this otherwise
general improvement. Instead, the commit message could sell the change
on its own merits and can then use Gerrit as an example.

> The Git push process itself prints lots of non-actionable messages
> (eg. bandwidth statistics, object counters for different phases of the
> process), and my hypothesis is that these obscure the actionable error
> messages that our server sends back. Highlighting keywords in the
> draws more attention to actionable messages.

So, for instance, you might want to use a rewrite of this paragraph to
open the commit message. Something like this, perhaps:

    A remote Git operation can print many non-actionable messages
    (e.g. bandwidth statistics, object counters for different phases
    of the process, etc.) and such noise can obscure genuine
    actionable messages, such as warnings and outright errors.

    As an example, Gerrit does server-side processing to create or
    update code reviews, and actionable error messages (such as
    "ERROR: commit is missing Change-Id") must be communicated back to
    the user during a push operation, but new users often have trouble
    spotting these error messages amid the noise.

    Address this problem by upgrading 'sideband' to draw attention to
    these messages by highlighting them with color.

    [...and so forth...]

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
> diff --git a/sideband.c b/sideband.c
> @@ -1,6 +1,103 @@
> +struct kwtable {
> +       /*
> +        * We use keyword as config key so it can't contain funny chars like
> +        * spaces. When we do that, we need a separate field for slot name in
> +        * load_sideband_colors().
> +        */

This comment is outdated; load_sideband_colors() does not exist in this patch.

I get what the first sentence of this comment is saying, but I'm
having trouble understanding what the second sentence is all about.

> +       const char *keyword;
> +       char color[COLOR_MAXLEN];
> +};
> +
> +static struct kwtable keywords[] = {
> +       { "hint",       GIT_COLOR_YELLOW },
> +       { "warning",    GIT_COLOR_BOLD_YELLOW },
> +       { "success",    GIT_COLOR_BOLD_GREEN },
> +       { "error",      GIT_COLOR_BOLD_RED },
> +};
> +
> +// Returns a color setting (GIT_COLOR_NEVER, etc).

Use /* old-style C comments */ in this codebase, not // C++ or new-style C.

> +static int use_sideband_colors(void)
> +{
> +       static int use_sideband_colors_cached = -1;
> +       const char *key = "color.remote";
> +
> +       if (use_sideband_colors_cached >= 0)
> +               return use_sideband_colors_cached;
> +
> +       if (!git_config_get_string(key, &value))
> +               use_sideband_colors_cached = git_config_colorbool(key, value);

So, if "color.remote" exists, then 'use_sideband_colors_cached' is
assigned. However, if "color.remote" does not exist, then it's never
assigned. Is this intended behavior? It seems like you'd want to fall
back to some other value rather than leaving it unassigned.

Which leads to the next question: The documentation says that this
falls back to "color.ui" if "color.remote" does not exist, however,
where is this fallback happening? Am I overlooking something obvious?

> +       for (i = 0; i < ARRAY_SIZE(keywords); i++) {
> +               strbuf_reset(&sb);
> +               strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
> +               if (git_config_get_string(sb.buf, &value))
> +                       continue;
> +               if (color_parse(value, keywords[i].color))
> +                       die(_("expecting a color: %s"), value);

This error message would be much more helpful if it also told the user
the name of the config key from which 'value' came.

> +       }

Do you need to be doing the work in the above for-loop if, after
computing 'use_sideband_colors_cached', it is determined that you
won't be using color?

> +       strbuf_release(&sb);
> +       return use_sideband_colors_cached;
> +}
> diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
> @@ -0,0 +1,47 @@
> +test_expect_success 'setup' '
> +       mkdir .git/hooks &&
> +       cat << EOF > .git/hooks/update &&
> +#!/bin/sh
> +echo error: error
> +echo hint: hint
> +echo success: success
> +echo warning: warning
> +echo prefixerror: error

I addition to checking other cases, such as "ERROR", as Junio
suggested, I'd think you'd also want to test:

    hinting: hint

to verify that it doesn't get colored.

> +exit 0
> +EOF
