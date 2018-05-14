Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F841F406
	for <e@80x24.org>; Mon, 14 May 2018 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeENMrj (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 08:47:39 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41824 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbeENMrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 08:47:37 -0400
Received: by mail-qt0-f196.google.com with SMTP id g13-v6so15842047qth.8
        for <git@vger.kernel.org>; Mon, 14 May 2018 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l/xDyA/b54baw1cV4PerIWO+UdXbWHqAu6MOz10h6rU=;
        b=u9FQOFXwG+3xmHNyTKl5hUU2DDUjtraCIy9vFOHEigB/8Pdi6YuTPHsLntufSFBO0y
         VUrqPET0vKE2ZOuJe04m8vcArvAXUEotembVCfvzN/GK5EaihyzaEE8UYNJC34o8Gr7N
         tjfwzTmWR5H9iu759F0rCYJ4I0WictEhgUtNaAN6WtHv5acr9QqLKYeEzQTEAx62Z4lI
         iKgQp6yf2CCULgvwNdJQXkv2QRc8Vrbjvs3eEr4bRHaLHtciHA09IUl2PTAtVslVOoyE
         yHlxlk+B2e9ylgi5l5bXNJzLs1dLFD3JZYUD+SKlhNRPN+5tLhBDNYgSKqkbS4gqOFaJ
         8Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l/xDyA/b54baw1cV4PerIWO+UdXbWHqAu6MOz10h6rU=;
        b=OpUvuQgrkGMI30lR/FEiVwvytqAUylW1iyD+ErIAyMbSkNnlIf+FtWbKVEeuSfAfPp
         bQn6+U4ONzwqRl3jcgvR+WeFdqOjMakwDrovRFDOO7DbYeuBX4ao+Z5LsDmU39EujaAf
         VTCXTN6tDCfFsP3pPzGrFtuwqjTB6CkmLg7e1xwJ4hMq5V1kpNV7fSmKH/J7EkINPkBU
         AkI/WmN9tVDO1KG9ozHy1X/4JDuauKPtB5J6kn5T4qGl2Q0z96pc3MQ/70SpHX8ZdDfz
         nlBFPn6J8q041kwX3hrXrr9CrIjERxanB/6Zt5rUP+8eDFjQt6CDY5HWFwpWdgriE7rb
         f63A==
X-Gm-Message-State: ALKqPwekkVZNXam9lP908NcQjJhP9F5JCMcX4qVWcK+RU0MdJUyogQCI
        9t/2RHjcsatMhmU+Ktcahrg=
X-Google-Smtp-Source: AB8JxZpfuTuEX7oRaDRlcMJGZJPGTUhh0cvJetZPBEC4ICA85drjHCIrDDlmC3ByMYCT9EkM1gZXOw==
X-Received: by 2002:a0c:91c2:: with SMTP id r2-v6mr8705548qvr.43.1526302056360;
        Mon, 14 May 2018 05:47:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y84-v6sm6916847qkb.23.2018.05.14.05.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 05:47:35 -0700 (PDT)
Subject: Re: [PATCH 4/4] mark_parents_uninteresting(): avoid most allocation
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180511180029.GA11290@sigill.intra.peff.net>
 <20180511180314.GD12543@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8447da69-d28a-433c-f324-a6380b6ca991@gmail.com>
Date:   Mon, 14 May 2018 08:47:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511180314.GD12543@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/11/2018 2:03 PM, Jeff King wrote:
> Commit 941ba8db57 (Eliminate recursion in setting/clearing
> marks in commit list, 2012-01-14) used a clever double-loop
> to avoid allocations for single-parent chains of history.
> However, it did so only when following parents of parents
> (which was an uncommon case), and _always_ incurred at least
> one allocation to populate the list of pending parents in
> the first place.
>
> We can turn this into zero-allocation in the common case by
> iterating directly over the initial parent list, and then
> following up on any pending items we might have discovered.

This change appears to improve performance, but I was unable to measure 
any difference between this commit and the one ahead, even when merging 
ds/generation-numbers (which significantly reduces the other costs). I 
was testing 'git status' and 'git rev-list --boundary 
master...origin/master' in the Linux repo with my copy of master 70,000+ 
commits behind origin/master.

It's still a good change, but I was hoping to find a measurable benefit :(

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Again, try "-w" for more readability.
>
>   revision.c | 44 +++++++++++++++++++++++++-------------------
>   1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 89ff9a99ce..cbe041128e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -115,32 +115,38 @@ static void commit_stack_clear(struct commit_stack *stack)
>   	stack->nr = stack->alloc = 0;
>   }
>   
> -void mark_parents_uninteresting(struct commit *commit)
> +static void mark_one_parent_uninteresting(struct commit *commit,
> +					  struct commit_stack *pending)
>   {
> -	struct commit_stack pending = COMMIT_STACK_INIT;
>   	struct commit_list *l;
>   
> +	if (commit->object.flags & UNINTERESTING)
> +		return;
> +	commit->object.flags |= UNINTERESTING;
> +
> +	/*
> +	 * Normally we haven't parsed the parent
> +	 * yet, so we won't have a parent of a parent
> +	 * here. However, it may turn out that we've
> +	 * reached this commit some other way (where it
> +	 * wasn't uninteresting), in which case we need
> +	 * to mark its parents recursively too..
> +	 */
>   	for (l = commit->parents; l; l = l->next)
> -		commit_stack_push(&pending, l->item);
> +		commit_stack_push(pending, l->item);
> +}
>   
> -	while (pending.nr > 0) {
> -		struct commit *commit = commit_stack_pop(&pending);
> +void mark_parents_uninteresting(struct commit *commit)
> +{
> +	struct commit_stack pending = COMMIT_STACK_INIT;
> +	struct commit_list *l;
>   
> -		if (commit->object.flags & UNINTERESTING)
> -			return;
> -		commit->object.flags |= UNINTERESTING;
> +	for (l = commit->parents; l; l = l->next)
> +		mark_one_parent_uninteresting(l->item, &pending);
>   
> -		/*
> -		 * Normally we haven't parsed the parent
> -		 * yet, so we won't have a parent of a parent
> -		 * here. However, it may turn out that we've
> -		 * reached this commit some other way (where it
> -		 * wasn't uninteresting), in which case we need
> -		 * to mark its parents recursively too..
> -		 */
> -		for (l = commit->parents; l; l = l->next)
> -			commit_stack_push(&pending, l->item);
> -	}
> +	while (pending.nr > 0)
> +		mark_one_parent_uninteresting(commit_stack_pop(&pending),
> +					      &pending);
>   
>   	commit_stack_clear(&pending);
>   }

