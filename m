Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8C61F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeDSRVQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:21:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47056 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeDSRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 13:21:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1-v6so16065863wrj.13
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SWB72GH0YPOKeBLNbx40fbhi8Cte0ftgk62yGwWH4uw=;
        b=g/fuNUPpGICHH88EJ8EiiFoDoU0Cbn/NP5/pGf+Z0ZtwUL6amMXr47WjSt+hkrS9tV
         VPhEeGdRE3XXMmfLWJiITr4dOH08bS5UyFe2TuTcQGxy0S+E44UxI381MT7gRc+3jY+B
         m9hLBkKSpTxfSkNAdv8ZssAq7O8CWEq7ultOkPMHJuqDb4At4MLBVN0pX8nZLwa+t8pk
         AugcxxIQxMZXpZ0huVFb4YVa4E2AbNyyo4vVxbwC6NJ0U4j7f0PNs35qtfNib3EtY+4Y
         J4K2Takj0s1vjZ1jEnFgfxOAXeOYf8WLLZfGPmzQWOKjWpFV1Xc2Onj4/SbHfQkHrzig
         PLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=SWB72GH0YPOKeBLNbx40fbhi8Cte0ftgk62yGwWH4uw=;
        b=fgAFbkNZwyvGGYKQPppUFS07X+0bmmq9bqwd/ZCaR/Z0Jde2FdJjtha6BDuN19zo8B
         NZPuwsHjR4rQpJgIAvIVSoAz/VtuDHnzJjMpQgSGuJ1pniIm53UP8KKxuTnaEa/IyaEF
         8Y+8omxT4AtrBUlNkAOSmeXyWgfRBMHNoDqcO/Zgul7ULAage6qNkU65YL+2UFLNPpcg
         ccFuovdDKjkGo53RoI2d8ehzQHGQsY0F2tpfNHKK8RfW/ZEvycRlSXkwsYzu4pUNkIZ9
         0Rz3l7XrPS7Pscnkit6+c3jlvPwwG7UCfJWCikOwpSjvxEDU5pQjhJyEZK6JPvZ70iDW
         0NxA==
X-Gm-Message-State: ALQs6tCqzfyob8yS73SVdjpRJwv853ASflWhw6sxnbomzUGGuOevYdgM
        JvNCi4LBOeHyQX6qFMk/JAI=
X-Google-Smtp-Source: AIpwx48Iexs6f6roXhdBhED4kLEaZ/SrZdoqlsb/tmxYSLYghjRKlJlu3+UlgS0+p+5VEY9Ye6ja5Q==
X-Received: by 10.28.12.129 with SMTP id 123mr5036250wmm.75.1524158474499;
        Thu, 19 Apr 2018 10:21:14 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id b105-v6sm7138351wrd.64.2018.04.19.10.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 10:21:12 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 04/12] commit-graph: parse commit from chosen graph
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-5-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 19:21:12 +0200
In-Reply-To: <20180417181028.198397-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 18:10:40 +0000")
Message-ID: <86bmeff6yf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Before checking a commit-graph file against the object database, we

Actually there is quite a few checks more that can be done without
accessing the object database... I'll take a look at later commits why
this one is that relatively early in the series.

> need to parse all commits from the given commit-graph file. Create
> parse_commit_in_graph_one() to target a given struct commit_graph.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index c5e5a0f860..6d0d303a7a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -308,17 +308,27 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  	}
>  }
>  
> -int parse_commit_in_graph(struct commit *item)
> +int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
>  {
>  	uint32_t pos;
>  
>  	if (item->object.parsed)
> -		return 0;
> +		return 1;

I am confused and befuddled by those apparent changes between returning
0 or returning 1 when object was parsed.

> +
> +	if (find_commit_in_graph(item, g, &pos))
> +		return fill_commit_in_graph(item, g, pos);
> +
> +	return 0;
> +}
> +
> +int parse_commit_in_graph(struct commit *item)
> +{
>  	if (!core_commit_graph)
>  		return 0;
> +
>  	prepare_commit_graph();
> -	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> -		return fill_commit_in_graph(item, commit_graph, pos);
> +	if (commit_graph)
> +		return parse_commit_in_graph_one(commit_graph, item);
>  	return 0;
>  }

Seems all right.
