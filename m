Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EC11F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdGYXhg (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:37:36 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33899 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdGYXhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:37:35 -0400
Received: by mail-pg0-f54.google.com with SMTP id 123so76311405pgj.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+XP4fxTscr7mbhQ9LJ9KxK0jxGI68pQOdsjdnhUbvQ4=;
        b=fJa6i0TDHqRXyGw8+OKWoUe6PmydfWOy21d7D7NFgcgihp0/oh+y5LFF7t90wuHTZz
         HFHmHDgKWnL4H/9wmMKrBZRsHK5/VZHxqTIroS25Bq7A/XMM8K9/+09PYBLfd22QwIHT
         S4rV9LXZYTCmRT4crAAPKpVdcIZTqLOzec9+xQMoMLQGc4flWAdi3HflJXvuEBQyCylF
         fvT5sojC1B1fWOJvgPucOfy+kNTriv+h84qfYuMEecuBv/xCa0ymfJbIQ6r2COKhGHXL
         X4MLU7U1hWRy8DMMzbKpwZ4/fgj9rypDuwC95TkgKdfe90q/oBWuaDgINDR2rx/qkzZ+
         u3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+XP4fxTscr7mbhQ9LJ9KxK0jxGI68pQOdsjdnhUbvQ4=;
        b=d+9FrQvQFvFZlpNAtmH2aDzTXUAMmCThxcI/GougSOMnvvq6VE+IBiklyEebSfloQc
         LbyC0eZragnNH7fYlCdzdWIFmDu6gSXyIxNYvfZ9L/CRQFT21K8RJQGhdz55i6nN4H44
         XjTHUt3sk5jLfkrncZjIqlP0x81FbkgRezdQKdiQsNSoBPKzKFTj2czqq028A9az0djm
         21bgk3600vMAiiIvElSlhOsrptgP6W02mpYXJhHgJ8TM8lhaFzn9RfrvbmuPsj/OVpJX
         LHgFJKg4T2Ck+YTKOmUcAw9VWbV16bWt+UPrkzwCqdEEJLwV/4r+qOoSBjcSSKs95tP9
         ewPA==
X-Gm-Message-State: AIVw1105FhIe/sdPlOgIB4z8TZhe4f9lXmfDT2ETX2PuBLjaqvuHwBMX
        KdGyNQdfaOxTs2fMPDk0UlqTpE/4MD24
X-Received: by 10.84.225.134 with SMTP id u6mr534642plj.176.1501025854998;
 Tue, 25 Jul 2017 16:37:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 16:37:34 -0700 (PDT)
In-Reply-To: <20170725213928.125998-6-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 16:37:34 -0700
Message-ID: <CAGZ79kacdTFVJknTx+ceT8epytXSJDRVAwZO4HyzpsmVbK5VTQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] submodule--helper: don't overlay config in update-clone
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> Don't rely on overlaying the repository's config on top of the
> submodule-config, instead query the repository's config directly for the
> url and the update strategy configuration.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
...

> +struct submodule_update_strategy submodule_strategy_with_config_overlayed(struct repository *repo,
> +                                                                         const struct submodule *sub)
> +{
> +       struct submodule_update_strategy strat = sub->update_strategy;
> +       const char *update;
> +       char *key;
> +
> +       key = xstrfmt("submodule.%s.update", sub->name);
> +       if (!repo_config_get_string_const(repo, key, &update)) {
> +               strat.command = NULL;
> +               if (!strcmp(update, "none")) {
> +                       strat.type = SM_UPDATE_NONE;
> +               } else if (!strcmp(update, "checkout")) {
> +                       strat.type = SM_UPDATE_CHECKOUT;
> +               } else if (!strcmp(update, "rebase")) {
> +                       strat.type = SM_UPDATE_REBASE;
> +               } else if (!strcmp(update, "merge")) {
> +                       strat.type = SM_UPDATE_MERGE;
> +               } else if (skip_prefix(update, "!", &update)) {
> +                       strat.type = SM_UPDATE_COMMAND;
> +                       strat.command = update;
> +               } else {
> +                       die("invalid submodule update strategy '%s'", update);
> +               }
> +       }

Can this be simplified by reusing
    parse_submodule_update_strategy(value, dest)
?
