Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEE11F461
	for <e@80x24.org>; Thu, 27 Jun 2019 04:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfF0Eri (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 00:47:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32964 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfF0Eri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 00:47:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so6107178wme.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 21:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oR0llFqdv4FbuZTTRmUeXOhcKtH5emLiVZPhJjj5Hlo=;
        b=kya4Ai1iIdN1aEH+yIH5I5qUa3JT9d9sP4bTlOXSbhuQX6l/oRl0gJWdGDQ+acfySf
         4EupM0GcKEXIH7k+vbiemUgzuwhxx3YY1KQMMuVAVRti+ezo3XZHtMItVFG68bKkbRi5
         tr1gRsNZkELJEQEUroyj/erLei4qDow9WzJOOrqtCHyeRDGMk60LwiYnHl1efI735j36
         4+xXk0SW0xCBRCtnjvL3DEO0VsQWj0TF7DlVmWbqVZymb6HgnPWksBk5f38NlRPBduSU
         2RUbi7/M0iBzHmK43OQX96lxI3aIgjgV3vY20SpFljz8RraUn8gxziwCLOGql/i7tkAz
         zKIg==
X-Gm-Message-State: APjAAAWpirnoAsgSwNQhk67Ga08WN9n8MW3m9Ld3d3mROt9v8d3bDwwO
        +1OvF7EbJ46oz3xkcf5YUa1fLOp0q25XXfkXjZc=
X-Google-Smtp-Source: APXvYqyjJuCYkqYmAtnDtVJCv49Gj2T694gJyd2uKrW47j47z7RKTQDHfN2Lqw1W/U4oIdGf6XdEZO3vofQM2iZFOWE=
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr1552899wmc.95.1561610856536;
 Wed, 26 Jun 2019 21:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-3-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-3-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 00:47:25 -0400
Message-ID: <CAPig+cQxt7rZRkQLpUZabwfLfWpzvVrWNd11RkQvt83K8zPZ7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] walken: add usage to enable -h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> It's expected that Git commands support '-h' in order to provide a
> consistent user experience (and this expectation is enforced by the
> test suite). '-h' is captured by parse_options() by default; in order to
> support this flag, we add a short usage text to walken.c and invoke
> parse_options().
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -5,9 +5,34 @@
> +const char * const walken_usage[] = {
> +       N_("git walken"),
> +       NULL,
> +};

Unless you expect to reference this from multiple functions, there is
no need for it to reside here; instead, it can live inside
cmd_walken(). (And, if you do leave it in the global scope for some
reason, it should be 'static'.)

>  int cmd_walken(int argc, const char **argv, const char *prefix)
>  {
> +       struct option options[] = {
> +               OPT_END()
> +       };
