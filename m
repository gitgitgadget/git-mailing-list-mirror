Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B258C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F67C206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP8W00op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgAGMOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:14:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45901 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGMOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:14:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so42358367qkl.12
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdV4L8VljVS586SpbWTKI8uhiTi3DvA/eMPXSctBrxw=;
        b=aP8W00oprr1BVFG8+qB5vhiaHDBr52W4SWC/yuZ0ejbTF7/qJrIDBKKdexsu8qIiCa
         IZIJ41nO+1V62nPvQcPr/1EBOlk3vKV96996mGN+7yV9U4ATquaf1ItWpk3etEx6fKO7
         ICNtKOeLHgmrjeMcE2jwilYrZUxpXvCLdym24Kw6eeXY3i4IMQRuUyPsei/1VkinSlas
         IV6C99ZjX5rko6BH45z15d6+/MoR6Z2waa74obl9siUbs1YbVzhswYSJy0S+h88MzWP6
         cbh8UyWlTNyGkEjOEJLWbdRxvEhJkqJVi12IgB6gy7y/rnsvdogyFK6EbIo3zoVEcbWG
         Xibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdV4L8VljVS586SpbWTKI8uhiTi3DvA/eMPXSctBrxw=;
        b=ggZYeGrBU1uecp1b1YOzR9n19LDP0ZA8MGBnGvkphE0NX1xH6JQ6A3xcwMNO7pW4fA
         uFlK/7EZrYUYkm7Q7K2uZX+KE8i8KzqgfP3j2EtmRgECOj7TWfdhDX6SCb9uwyqP8GsB
         M6uJ+F0mQcVEOQrjMji0ihLtWHIcinK0jwW1KDcvP/KT/ZkOsMSmMmE+hxQ7utiZgK3v
         ZrfC8mb0febfZPuKcuZw2QoN4hUXwip3J+JVOruGvBl1DKHTV0FawlJ2CqX9PY2nmJWE
         rpu5DZj2ZYLkppRzC4zK4fK4HnL5RjaSJa0BATPO4p3NaDEubi3hR5iHaG3G0muTmJ2S
         /3EA==
X-Gm-Message-State: APjAAAUSsqc8WAlOzZUT3sgfurchpYVShpKdYt+IctIT635vqf67f8Gy
        d+orOKBKXRssLcf8RjBlZaPGmfg9
X-Google-Smtp-Source: APXvYqzoTc0MeSCQ/3U4gJ533Rpee7dYKwz/2Qe5rK8zxmdDHC7GQ30yL6unoLqGbmo5bay2jlEq1g==
X-Received: by 2002:a37:684a:: with SMTP id d71mr79758084qkc.201.1578399270979;
        Tue, 07 Jan 2020 04:14:30 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id u16sm22183382qku.19.2020.01.07.04.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 04:14:29 -0800 (PST)
Subject: Re: [PATCH 1/1] Preserve topological ordering after merges This
 modifies the algorithm of topopological ordering. The problem with the
 current algoritm is that it displays the graph below as follows
To:     Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Sergey Rudyshin <540555@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
 <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6c86f1e9-b70b-10b1-f2c5-589312f73a4c@gmail.com>
Date:   Tue, 7 Jan 2020 07:14:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 5:30 AM, Sergey Rudyshin via GitGitGadget wrote:
> From: Sergey Rudyshin <540555@gmail.com>
> 
> * E
> |\
> | * D
> | |\
> | |/
> |/|
> * | C
> | * B
> |/
> * A
> 
> commit B is placed between A and C, which is wrong
> because E stays that D and B comes after C
> 
> the only correct solution here is
> 
> * E
> |\
> | * D
> | |\
> | |/
> |/|
> | * B
> * | C
> |/
> * A
> 
> while it seems that it contradicts to
> D stating that C should be between D and B
> The new algorithm solves this issue

This ordering concern makes sense _somewhat_, because D is the
second parent of D and that wants to say "Show everything in C..D
before showing C". The issues is that since C is the second parent
of D, the topo-ordering says "Show everything in B..C before showing
things reachable from B". It is unfortunate that these constraints
collide.

Perhaps your description could do a better job clarifying this
issue and how your algorithm change fixes the problem.

However, I'm not sure we even want to make the change, as this
is still a valid topological order (parents appear after children).
When we have an ambiguous pair (like B and C) the order can differ.
The --topo-order option tries to group commits by when they were
introduced, and that's the reason for presenting the commits reachable
from the later parents before presenting the commits from earlier
parents.

The only documentation we have is from [1]:

"Show no parents before all of its children are shown, and avoid
showing commits on multiple lines of history intermixed."

The first part of the sentence is still true, and the second part
is ambiguous of how to do that.

[1] https://git-scm.com/docs/git-log#Documentation/git-log.txt---topo-order

> This change makes option "--topo-order" obsolete, because
> there is only one way to order parents of a single commit.
> "--date-order" and "--author-date-order" are preserved and make sense
> only for the case when multiple commits are given
> to be able to sort those commits.

This part of the change needs to be removed. The default sort does
not preserve topological orderings (like --date-order does), and
so is much faster to output, especially without a commit-graph file.

>  void sort_in_topological_order(struct commit_list **list, enum rev_sort_order sort_order)

Since you are only editing this code, and not the incremental topo-order code, your
test changes will likely break when run with GIT_TEST_COMMIT_GRAPH=1. When the commit-graph
exists and generation numbers are calculated, we use a different algorithm for topo-order.

I've been meaning to clean up this "duplicated" logic by deleting this method in favor of
the incremental algorithm in all cases. It needs some perf testing to make sure that
refactor doesn't have too large of a perf hit in the case of no commit-graph.

>  	/* update the indegree */
> @@ -832,51 +886,56 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
>  	for (next = orig; next; next = next->next) {
>  		struct commit *commit = next->item;
>  
> -		if (*(indegree_slab_at(&indegree, commit)) == 1)
> -			prio_queue_put(&queue, commit);
> +		if (*(indegree_slab_at(&indegree, commit)) == 1) {
> +			/* also record the author dates, if needed */
> +			if (sort_order == REV_SORT_BY_AUTHOR_DATE)
> +				record_author_date(&author_date, commit);
> +			prio_queue_put(&queue_tips, commit);
> +		}

Your code change looks rather large for what I expected to be a much simpler change.
Likely the only thing we need is to avoid adding to the priority queue if we already
have the commit in the queue (maybe using a hashset storing the commits that we've
added to the queue). I believe the reason C appears before B in your example is that
it was added to the queue a second time, and the queue behaves like a stack in the
topo-order case.

Thanks,
-Stolee
