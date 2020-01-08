Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724CC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E02C20705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ui9dSV/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgAHPLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:11:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42565 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgAHPLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 10:11:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so2694216lfl.9
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 07:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWSRsdQkOW+DJVwrKRxC1CBY2N3qephCtXIVN+2knsQ=;
        b=ui9dSV/KloyS/6R06svP84VAdyV4JstEzMl63cTcBz55nHtSNX0MdqV2bWqDTExR++
         ARsjPq9Afg8QjQjBVoXLK9riidOQZx2TFCXYddBR8lva5n/4FM24MZPTT1iusEcYrIL4
         2ttFZEFQDvb4cRnEld4P3obf89DazLqOJxveLgy+WSwTs9OcIHIsW2TyuUfqcvci5dKz
         suC1ipgLjvF3EXsQxk1sSkbRso8fKl1XAUbcbloBzTlDAXE+udfRiqQSah3EpdAdTlmp
         Xn1P2DyStWhWT/gtuQAxViI8foJ1a4AxQjYIExSrizLsfAOMo94ZR3Krj5TUslZDmfMe
         DqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWSRsdQkOW+DJVwrKRxC1CBY2N3qephCtXIVN+2knsQ=;
        b=Vg2v2onZgxligHfZXn9felfoBCRCOFC3FACOnn7IiWZ62QG+MJpf4f0553g2oF/9iV
         KaHauoWai6agbihtJ+55fvNILau9rhQ3781c06woKOj1fThePez/zIwJQGB6dW+e2RRn
         QO1LHGo1PfBUiLNiIVx5X0GwqutA7wt+mFegMSKwVPE3oPTNf+Rw8ZGY5bmY02oLWj/9
         FcWil9j/W5thoAmoryT7xtRexYOKPT/FyiojhO7ghYK6tALVefO7Yrokc6iOUbQZYK9B
         Cj4n/Xs5KBz7n26s/Hp7W6a0tgBGJRXcT1gjj4gEOrA1pdkn25RxNI7MXESRoycRddNh
         KtEQ==
X-Gm-Message-State: APjAAAX9Pbc6jUPFVw9V/uhgaoVjcR8/rdcX87ZxmYVPX7XDtaqjlJXq
        wonjM0GbaHPP0JeiXR+WNTJEYTA5Z60UBQ6D
X-Google-Smtp-Source: APXvYqxzW6B3SKfE/UMhltYfjZFR0B3hh4d6q8VeeTco3iKfRA1PW0YmB0r2xE9ss+QpOml+1tY51Q==
X-Received: by 2002:ac2:5147:: with SMTP id q7mr3162184lfd.87.1578496272083;
        Wed, 08 Jan 2020 07:11:12 -0800 (PST)
Received: from [192.168.0.104] (broadband-90-154-72-234.ip.moscow.rt.ru. [90.154.72.234])
        by smtp.gmail.com with ESMTPSA id l1sm1525299lfj.71.2020.01.08.07.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:11:11 -0800 (PST)
Subject: Re: [PATCH 1/1] Preserve topological ordering after merges This
 modifies the algorithm of topopological ordering. The problem with the
 current algoritm is that it displays the graph below as follows
To:     Derrick Stolee <stolee@gmail.com>,
        Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
 <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
 <6c86f1e9-b70b-10b1-f2c5-589312f73a4c@gmail.com>
From:   Sergey Rudyshin <540555@gmail.com>
Message-ID: <db0c60f3-a61d-51d3-1e29-0227365e7850@gmail.com>
Date:   Wed, 8 Jan 2020 18:11:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6c86f1e9-b70b-10b1-f2c5-589312f73a4c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,
thank you for you feedback!

07.01.2020 15:14, Derrick Stolee wrote:
> On 1/7/2020 5:30 AM, Sergey Rudyshin via GitGitGadget wrote:
>> From: Sergey Rudyshin <540555@gmail.com>
>>
>> * E
>> |\
>> | * D
>> | |\
>> | |/
>> |/|
>> * | C
>> | * B
>> |/
>> * A
>>
>> commit B is placed between A and C, which is wrong
>> because E stays that D and B comes after C
>>
>> the only correct solution here is
>>
>> * E
>> |\
>> | * D
>> | |\
>> | |/
>> |/|
>> | * B
>> * | C
>> |/
>> * A
>>
>> while it seems that it contradicts to
>> D stating that C should be between D and B
>> The new algorithm solves this issue
> 
> This ordering concern makes sense _somewhat_, because D is the
> second parent of D and that wants to say "Show everything in C..D
> before showing C". The issues is that since C is the second parent
> of D, the topo-ordering says "Show everything in B..C before showing
> things reachable from B". It is unfortunate that these constraints
> collide.
>  > Perhaps your description could do a better job clarifying this
> issue and how your algorithm change fixes the problem.
> 

The proposed algorithm allows to solve collisions you mentioned by 
sticking to the rule which can be summarized as "new commits do not 
change history".
And with that rule in mind choosing between C and B becomes obvious. C 
comes before B because there was a moment in the history when C existed 
and B did not.

Let's imagine the following scenario.
Some person maintains some branch.
At some point in time the branch contains only two commits A and C.
"git rev-list --topo-order" produces "A,C"
then the maintainer merges some branch and
"git rev-list --topo-order" starts to produces "A,B,C,..."
which is confusing.

The algorithm itself is similar to the wall follower used in maze solving.
If you imagine git graph like a maze where edges corresponds to 
corridors and nodes to junctions then using "right-hand rule" you would 
traverse the maze. When leaving a junctions if all corridors are visited 
  assigning the next number to the junctions you are effectively 
ordering them.

Let me repeat the example from my first letter
* walk to to the root via "first" parents;
* go E -> C -> A;
* print A because it has no parents;
* step back to C;
* print C because it has no other parents;
* then step back to E;
* go D -> B -> A;
* do not print A because A is already printed;
* step back to B;
* print B;
* so on.


> However, I'm not sure we even want to make the change, as this
> is still a valid topological order (parents appear after children).
> When we have an ambiguous pair (like B and C) the order can differ.
> The --topo-order option tries to group commits by when they were
> introduced, and that's the reason for presenting the commits reachable
> from the later parents before presenting the commits from earlier
> parents.
> 
> The only documentation we have is from [1]:
> 
> "Show no parents before all of its children are shown, and avoid
> showing commits on multiple lines of history intermixed."
> 
> The first part of the sentence is still true, and the second part
> is ambiguous of how to do that.
> 
> [1] https://git-scm.com/docs/git-log#Documentation/git-log.txt---topo-order
> 

Agreed that it is a a valid topological order but rather for a directed 
acyclic graph. Git has an additional property: edges (parents) are 
ordered. Which makes only one way to order it. Ignoring information that 
parents were ordered we had to invent three similar orderings, one of 
them was ambiguous. For some reason two options do not "avoid showing 
commits on multiple lines of history intermixed". A little confusing.

I think we have an opportunity here to remove options for sorting 
eventually thus simplifying leaning curve for users and give them some 
new features.

Let me step aside and tell why I am proposing this patch in the first 
place. I am a database developer. And me and my team, we have so called 
"migrations": a set of scripts which are to be applied to a database. 
Those scripts are to have a numbers in its filenames so that a tool 
could install them in a particular order (here is example 
https://flywaydb.org/getstarted/how). In our scenario multiple 
developers create those scripts on theirs branches. Those branches get 
merged into a single integration branch. If Git could preserve commit 
ordering after merges it would be possible to generate those filenames 
automatically. Now it can't. So here am i.


>> This change makes option "--topo-order" obsolete, because
>> there is only one way to order parents of a single commit.
>> "--date-order" and "--author-date-order" are preserved and make sense
>> only for the case when multiple commits are given
>> to be able to sort those commits.
> 
> This part of the change needs to be removed. The default sort does
> not preserve topological orderings (like --date-order does), and
> so is much faster to output, especially without a commit-graph file.
> 

Yes indeed. Will fix it.

>>   void sort_in_topological_order(struct commit_list **list, enum rev_sort_order sort_order)
> 
> Since you are only editing this code, and not the incremental topo-order code, your
> test changes will likely break when run with GIT_TEST_COMMIT_GRAPH=1. When the commit-graph
> exists and generation numbers are calculated, we use a different algorithm for topo-order.
> 

Yes this needs to be reconciled. But unfortunately have no experience in 
the code for commit graph.

> I've been meaning to clean up this "duplicated" logic by deleting this method in favor of
> the incremental algorithm in all cases. It needs some perf testing to make sure that
> refactor doesn't have too large of a perf hit in the case of no commit-graph.
>
Given that the new algorithm is pretty simple we could duplicate it 
there once again.

>>   	/* update the indegree */
>> @@ -832,51 +886,56 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
>>   	for (next = orig; next; next = next->next) {
>>   		struct commit *commit = next->item;
>>   
>> -		if (*(indegree_slab_at(&indegree, commit)) == 1)
>> -			prio_queue_put(&queue, commit);
>> +		if (*(indegree_slab_at(&indegree, commit)) == 1) {
>> +			/* also record the author dates, if needed */
>> +			if (sort_order == REV_SORT_BY_AUTHOR_DATE)
>> +				record_author_date(&author_date, commit);
>> +			prio_queue_put(&queue_tips, commit);
>> +		}
> 
> Your code change looks rather large for what I expected to be a much simpler change.
> Likely the only thing we need is to avoid adding to the priority queue if we already
> have the commit in the queue (maybe using a hashset storing the commits that we've
> added to the queue). I believe the reason C appears before B in your example is that
> it was added to the queue a second time, and the queue behaves like a stack in the
> topo-order case.
> 
Probably the new code itself could be simplified a bit.
Thanks for suggestion I'll try to think this way.

> Thanks,
> -Stolee
> 
