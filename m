Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008CBC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B703D224DF
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgLGAbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:31:12 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37518 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGAbM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:31:12 -0500
Received: by mail-ej1-f65.google.com with SMTP id ga15so17022746ejb.4
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 16:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIWasDufQCi2jDYassSST9K/Pd2YGzTLtPBcUTMQzio=;
        b=cAdNJWV7BHf8RcOdMRcTL3W4JDG/sCIzNEm4rFS4ok8S4Fi5yzJst5ccnLyZIJrZJd
         hXxrjsu1tuWXppCnCPlky/eSHLhCKDgdA/7h5mZE2llBbMvcrBLPUxTxTbCjgyNtBF++
         XOg72vFWQuQN+O5w94azRpLQxfAFUIanftlXoVj0ruvTQ/fa2y+IeG4DG3BDN4bubTQt
         nwkIfiHi3eeEevP3YxAI2ksRawASXMWFO7R2e6UwcJujsNb+5I+c8ONWCL1mS1Ejzn+p
         wO7lkOtutRtObCkwdNQye3vZfkghPVj1yaOrixvL3XBXrvg2Akxy2B23uVx/bfY16Y8g
         J3jA==
X-Gm-Message-State: AOAM530wKmy5U+faWIH04qe1fQnjLhA3FUrMWY7NqA/BieQkJC7XvWq8
        hfBCLdrQDGk0ST83LBVVOfgsoR8UM7197nK/vkQ=
X-Google-Smtp-Source: ABdhPJz2pDUQnsgoVPsKnN5NzIz6j8JD2VWoBp4qN14XRFSsJto/AZhCvFPIPUW/0De1O7e0dKmg4a1Pw7nyafvQhDw=
X-Received: by 2002:a17:906:608:: with SMTP id s8mr16885885ejb.371.1607301024586;
 Sun, 06 Dec 2020 16:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20201206225349.3392790-1-sandals@crustytoothpaste.net> <20201206225349.3392790-3-sandals@crustytoothpaste.net>
In-Reply-To: <20201206225349.3392790-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Dec 2020 19:30:13 -0500
Message-ID: <CAPig+cS-2Vw84rejMFAiDeF8dd5gtBOmQZUMpOy2ufA8nU7W7g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] rev-parse: add option for absolute or relative
 path formatting
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 5:58 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [...]
> To help out the scripter, let's provide an option which turns most of
> the paths printed by git rev-parse to be either relative to the current
> working directory or absolute and canonical.  Document which options are
> affected and which are not so that users are not confused.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> @@ -212,6 +212,15 @@ Options for Files
> +--path-format=(absolute|relative)::
> +       Controls the behavior of certain other options following it on the command
> +       line. If specified as absolute, the paths printed by those options will be
> +       absolute and canonical. If specified as relative, the paths will be relative
> +       to the current working directory if that is possible.  The default is option
> +       specific.

I read the commit message and looked at the implementation so I know
that this option can be specified multiple times, but this
documentation only vaguely hints at it by saying "options following
it". We could do a better job of imparting that knowledge to the
reader by saying so explicitly, perhaps like this:

    Controls the behavior of some path-printing options. If
    'absolute', [...]. If 'relative', [...]. May be specified multiple
    times, each time affecting the path-printing options which
    follow it. The default path format is option-specific.

Since this option can be specified multiple times, should it also
recognize `default` to request the default behavior in addition to
`absolute` and `relative`? (Genuine question. Maybe real-world
use-cases wouldn't need it, but it would be easy to support and make
it functionally complete.)

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> @@ -583,6 +583,73 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
> +static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
> +{
> +               struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
> +               if (!is_absolute_path(path)) {
> +                       strbuf_realpath_missing(&realbuf, path, 1, 1);
> +                       path = realbuf.buf;
> +               }
> +               if (!is_absolute_path(prefix)) {
> +                       strbuf_realpath_missing(&prefixbuf, prefix, 1, 1);
> +                       prefix = prefixbuf.buf;
> +               }
> +               puts(relative_path(path, prefix, &buf));
> +               strbuf_release(&buf);

Leaking `realbuf` and `prefixbuf` here.
