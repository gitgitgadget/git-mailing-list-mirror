Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA37B1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 03:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeDZDWV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 23:22:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44041 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeDZDWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 23:22:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id o15-v6so55185717wro.11
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 20:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VechMvwuFRDLDGqkiw2ZerrlTSplVtLwsJX/XMoKRes=;
        b=rZPWV0g4hOgbG1dNFZQeKAeR67XR5qiC3ylJ7kdg4KqnNP9HgJo5gy5d5gUhm2Rwv9
         OCpE0AnUGa8SUKXZVadUm4TK1aHC1USDGU3c6I6JjBVceg1KhQidncE4LVP6vpw12BWc
         Nx5FJ9YWhSfMacsVxeM7dtoiDzihlaB/rmb244nPds5xbvZmsF5tL0sO4FB2/tHB94zw
         yxfyB0+G/hVQvxAOornP7sWht8ofmBCIrzQrtFTcXkke/4I0iLGihqyhutt9veOTXpux
         AVlffMTqkdKGUkTQ2ASWj16H76QOC53fd//BtJyuyIVP4MXz4Pl/72zXwIUnNj6gVJ08
         nprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VechMvwuFRDLDGqkiw2ZerrlTSplVtLwsJX/XMoKRes=;
        b=jaVa8CYjDaUsyuG0FultWTZ6DnclZfUlfh4mb5x8DEn08F2jceatrKr4eOgY6ZnCe3
         3TpdmXKUXPnFr+bbsDHUQAbPL7geXlV1hVhqjwxneKnlELxnafC96kZD8f10s0bKZQqO
         CH7uxBRZYHcFu+o4Bm5Y2AYRZbKWkIvCcEh1/P3iSEQxxkhRY6kp383NbMURvXCxhiDO
         dvE6lYolFQwQHnDa1UAPA7mewT8QDDLioEgPrne8xhXScH7/mQ6CX3bPLw7AEZTaG4xy
         tAh+EQhGP1NnJIjMZugiasYr3HVcHmf80woq5AEf4hA/cu2pRPanza6sFxy6ifTlIp5Y
         /DqA==
X-Gm-Message-State: ALQs6tDB/qxPLlHWhjpodXRXkic4iL81eq2nK3WRdCqmgqHvLhyQ1RRw
        jodAIXq2GxybnMZ5e1O/qBs=
X-Google-Smtp-Source: AIpwx4/s4a6xse0+3R+tQ8koHVfxjeYMp5pOgStq1iJmm5HId20LNSusiUfuQOSp1nUeAXffMy4zRg==
X-Received: by 2002:adf:b722:: with SMTP id l34-v6mr26675047wre.85.1524712938652;
        Wed, 25 Apr 2018 20:22:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v6-v6sm18374586wrd.54.2018.04.25.20.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 20:22:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>
Subject: Re: [PATCH v4 04/10] commit: use generations in paint_down_to_common()
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-5-dstolee@microsoft.com>
Date:   Thu, 26 Apr 2018 12:22:15 +0900
In-Reply-To: <20180425143735.240183-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:57 +0000")
Message-ID: <xmqqr2n23b4o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Define compare_commits_by_gen_then_commit_date(), which uses generation
> numbers as a primary comparison and commit date to break ties (or as a
> comparison when both commits do not have computed generation numbers).
>
> Since the commit-graph file is closed under reachability, we know that
> all commits in the file have generation at most GENERATION_NUMBER_MAX
> which is less than GENERATION_NUMBER_INFINITY.

I suspect that my puzzlement may be coming from my not "getting"
what you meant by "closed under reachability", but could you also
explain how _INF and _ZERO interact with commits with normal
generation numbers?  I've always assumed that genno will be used
only when comparing two commits with valid genno and otherwise we'd
fall back to the traditional date based one, but...

> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
> +{
> +	const struct commit *a = a_, *b = b_;
> +
> +	/* newer commits first */
> +	if (a->generation < b->generation)
> +		return 1;
> +	else if (a->generation > b->generation)
> +		return -1;

... this does not check if a->generation is _ZERO or _INF.  

Both being _MAX is OK (the control will fall through and use the
dates below).  One being _MAX and the other being a normal value is
also OK (the above comparisons will declare the commit with _MAX is
farther than less-than-max one from a root).

Or is the assumption that if one has _ZERO, that must have come from
an ancient commit-graph file and none of the commits have anything
but _ZERO?

> +	/* use date as a heuristic when generations are equal */
> +	if (a->date < b->date)
> +		return 1;
> +	else if (a->date > b->date)
> +		return -1;
> +	return 0;
> +}
> +
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
>  {
>  	const struct commit *a = a_, *b = b_;
> @@ -789,7 +807,7 @@ static int queue_has_nonstale(struct prio_queue *queue)
>  /* all input commits in one and twos[] must have been parsed! */
>  static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
>  {
> -	struct prio_queue queue = { compare_commits_by_commit_date };
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	struct commit_list *result = NULL;
>  	int i;
>  
> diff --git a/commit.h b/commit.h
> index aac3b8c56f..64436ff44e 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -341,6 +341,7 @@ extern int remove_signature(struct strbuf *buf);
>  extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
>  
>  int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
> +int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
>  
>  LAST_ARG_MUST_BE_NULL
>  extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
