Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F68C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF6E60FE9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349613AbhGSQ2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346854AbhGSQ1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:27:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65BC061787
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:34:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id u7so20690456ion.3
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0PC+Yq4emX3O0rTdw8AMi0U5ysaxPCYnsK7kmLEs70Q=;
        b=FWnMeu+Q3aAAevrPdCwMdpLWf6FsvqEZvpVZoJdjc6OAJqKC8VX3ekeLbS4p05DAzo
         7tIft0ciV+Ku8CMJNQbFahTDgOXb0OL2bWZuytMeqxCu0z/GME7JmSw0qG0oK05ds0S6
         jCQ8xOucnlG4R1us7J+bpj7d7B5VlO9u9yfkkyRfeO72a0xk5QtGNS9RfTkgwD9GtQzZ
         VBpEGWiwKCm7l2xg0y+cUo8o61k1JJcN7XQ3Jvknx8o17EUm4jpltTawLlvoDz0DQRO/
         nuNgMwSZf/45DX4t9MEV6NFkZqMpW3SUY+u9o0QpkP/wGeKjXENF69v66yB63fyWp1ra
         SnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0PC+Yq4emX3O0rTdw8AMi0U5ysaxPCYnsK7kmLEs70Q=;
        b=d7j7IwVWBmzEpyyuXALyn+nn79aNtJH0KzNdkE7zbusooBuKdnXa4cCcEaN3FG6ggD
         Ggl/e6uwjpXu8n6VZSRGq+1WYRsuwUWCQppSNrHozu0ooWOVo0gnIF4WhQiyoPqQZyDa
         Ylq/XWLfYn6Vj7ihcyeDjcE0C2pMK6LWN4EvRhb7kxLVOj3J5UcYc4O5xoEMSsuzuHkd
         Q9kAOtz08TNLwSEOtS+w2oXhvpVPfvJsWoTT/bKlPotoJqSjuBsWtY0QF6psDnI9H/M5
         X+f++ViocdPzNFlJnPmxk8HaXmm86oJZxfwElxzWKTO7BciWz+CZDkU2DJsUVGhBCVff
         lI9Q==
X-Gm-Message-State: AOAM533Kn/aaN3BIrrsBd+5kMUEVLnNxpGgFe7Lbj3u4efxXl6AT4Z1a
        ktjMTOzzbxRwbgQ+FthcccoDJg==
X-Google-Smtp-Source: ABdhPJyIFOOtCV0E8SAnlejqS1RKJOQovkdexTnCkUbB1QnCnAAOxYS2tfDpSxgdqoZ1zd2dyA9iCA==
X-Received: by 2002:a05:6638:3a12:: with SMTP id j18mr23002765jaj.75.1626713750039;
        Mon, 19 Jul 2021 09:55:50 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id i7sm9621671ilb.67.2021.07.19.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:55:49 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:55:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/5] commit-graph: early exit to "usage" on !argc
Message-ID: <YPWulAIYg+q9Bmr7@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-4.5-d776424e8c8-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.5-d776424e8c8-20210718T074936Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 09:58:08AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Rather than guarding all of the !argc with an additional "if" arm
> let's do an early goto to "usage". This also makes it clear that
> "save_commit_buffer" is not needed in this case.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index ff125adf2d5..16d2c517e72 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -331,16 +331,17 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			     builtin_commit_graph_options,
>  			     builtin_commit_graph_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (!argc)
> +		goto usage;
>
>  	save_commit_buffer = 0;
>
> -	if (argc > 0) {
> -		if (!strcmp(argv[0], "verify"))
> -			return graph_verify(argc, argv);
> -		if (!strcmp(argv[0], "write"))
> -			return graph_write(argc, argv);
> -	}
> +	if (!strcmp(argv[0], "verify"))
> +		return graph_verify(argc, argv);
> +	else if (argc && !strcmp(argv[0], "write"))
> +		return graph_write(argc, argv);

Unrelated to your patch here, but it may be nice to have an extra
error() for unrecognized sub-commands. I actually think that this
suggestion also comes from Peff originally, but it does make the "next
step" a lot clearer to users who otherwise would have seen a wall of
usage text.

Perhaps:

  else {
    error(_("unrecognized subcommand: %s"), argv[0]);
usage:
    usage_with_options(builtin_commit_graph_usage,
                       builtin_commit_graph_options);
  }

Thanks,
Taylor
