Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C251F453
	for <e@80x24.org>; Tue, 23 Oct 2018 13:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeJWWSI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 18:18:08 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45993 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWWSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 18:18:08 -0400
Received: by mail-vk1-f194.google.com with SMTP id k77so341269vke.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=b7CPkPMb48NqA/raZ2D9XNeLdIWo7pxIdoxk9vvSwT4=;
        b=llnDACxSVMOn1ZMI0TM351wA4TDfwWI5X5jcu/NHkM1NO6hZzedRikF/rPyOOPUIul
         Lhy41yUC9W8fg0t/zIIe3sxiQYQm3wfmdOwgMyDC5KY9TOC09tkRmpo+46pnhBKE5dAC
         oHUI0afRFK8Dvarr49wBxX384zI4LTiq9V1nLl5I7OB883AcmMKTq9zqgoSLads8ea8u
         nqdsu+5gch/Cy9utDMw1VPP/QdzpDEZ1uLfWoyh8uBgy77N9aek57fDmg2ja+miXJij+
         3BhfE7aDb+WlQkGMwgji3LOjntrqsNIkNOfLnjmtJe8W+KZP7kznax/fUOBDFJo53hD3
         niHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b7CPkPMb48NqA/raZ2D9XNeLdIWo7pxIdoxk9vvSwT4=;
        b=mTiDRIrsd564FY0wniSO02leFcyW49w7inujEB37P911QFZctNPU6MbSYOQFMjQqS+
         3QOm2+uERG4A3ch4yDl+gBx2rQjlXJF4dLIf96hdvlfWVGPA+7e0MchCdN7bI6Su0o95
         4JlBUqLB7zUBoMzy8iC5E0BuP+O0RFe+7lexFEln3JL+RyHeCDFxU2LRXopqc0I0tUcm
         3P9/mRcuEKtLrDs7IlteRebBM/A3yQBWdYd1J+U7XENL+N9T1d/NugfU1BWYJOnlIBse
         lYyXk9g85rrpBJitJLz8D0FX6yKQo8xFIkr1p5IN3BHEALo4JCSSJMQncYdDD+NCywP9
         f5QA==
X-Gm-Message-State: AGRZ1gJywrF9STgAbqlKUCdF6mUnPzD9M3qjSp+V/rsLoO3Ukw8jDRZX
        8seed+5XZJBhtWk7IXpVoLQ=
X-Google-Smtp-Source: AJdET5fcmlvScuvkKKwrU6LXX3Cuvzwt7QaPPxKQ91SnptIRhOUTxW5irYbng6/zjDaS7YJPRS8tBA==
X-Received: by 2002:a1f:b90a:: with SMTP id j10-v6mr3987875vkf.14.1540302872597;
        Tue, 23 Oct 2018 06:54:32 -0700 (PDT)
Received: from [10.12.132.103] (208-1-61-165.static.celitofiber.net. [208.1.61.165])
        by smtp.gmail.com with ESMTPSA id f128-v6sm258505vkc.37.2018.10.23.06.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 06:54:31 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] revision.c: generation-based topo-order algorithm
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
 <pull.25.v4.git.gitgitgadget@gmail.com>
 <aa0bb2221d437f595f6d0c16b125072fde289c15.1539729393.git.gitgitgadget@gmail.com>
 <86sh0y5cgk.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6501930f-4097-1b81-6d0d-be54f050a5a4@gmail.com>
Date:   Tue, 23 Oct 2018 09:54:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <86sh0y5cgk.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/22/2018 9:37 AM, Jakub Narebski wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The current --topo-order algorithm requires walking all
>> reachable commits up front, topo-sorting them, all before
>> outputting the first value. This patch introduces a new
>> algorithm which uses stored generation numbers to
>> incrementally walk in topo-order, outputting commits as
>> we go. This can dramatically reduce the computation time
>> to write a fixed number of commits, such as when limiting
>> with "-n <N>" or filling the first page of a pager.
>>
>> When running a command like 'git rev-list --topo-order HEAD',
>> Git performed the following steps:
>>
>> 1. Run limit_list(), which parses all reachable commits,
>>     adds them to a linked list, and distributes UNINTERESTING
>>     flags. If all unprocessed commits are UNINTERESTING, then
>>     it may terminate without walking all reachable commits.
>>     This does not occur if we do not specify UNINTERESTING
>>     commits.
>>
>> 2. Run sort_in_topological_order(), which is an implementation
>>     of Kahn's algorithm. It first iterates through the entire
>>     set of important commits and computes the in-degree of each
>>     (plus one, as we use 'zero' as a special value here). Then,
>>     we walk the commits in priority order, adding them to the
>>     priority queue if and only if their in-degree is one. As
>>     we remove commits from this priority queue, we decrement the
>>     in-degree of their parents.
> Because in-degree has very specific defined meaning of number of
> children, i.e. the number of _incoming_ edges, I would say "if and only
> if their in-degree-plus-one is one".  It is more exact, even if it looks
> a bit funny.
>
>> 3. While we are peeling commits for output, get_revision_1()
>>     uses pop_commit on the full list of commits computed by
>>     sort_in_topological_order().
> All right, so those are separate steps (separate walks): prepare and
> parse commits, topologically sort list of commits from previous step,
> output sorted list of commits from previous step.

I would rephrase your explanation above as: prepare and parse commits, 
compute in-degrees, and peel commits of in-degree zero.

>> In the new algorithm, these three steps correspond to three
>> different commit walks. We run these walks simultaneously,
>> and advance each only as far as necessary to satisfy the
>> requirements of the 'higher order' walk.
> What does 'higher order' walk means: steps 3, 2, 1, in this order,
> i.e. output being the highest order, or something different?

Yes. We only walk "level 2" in order to satisfy how far we are in "level 3".

> Sidenote: the new algorithm looks a bit like Unix pipeline, where each
> step of pipeline does not output much more than next step needs /
> requests.

That's essentially the idea.

>>                                           We know when we can
>> pause each walk by using generation numbers from the commit-
>> graph feature.
> Do I understand it correctly that this is mainly used in Kahn's
> algorithm to find out through the negative-cut index of generation
> number which commits in the to-be-sorted list cannot have an in-degree
> of zero (or otherise cannot be next commit to be shown in output)?

In each step of the algorithm, we operate under the assumption that 
certain vertices have "all necessary information".

In the case of "level 3", we need to know that all descendants were 
walked and our in-degree calculation is correct. We guarantee this by 
ensuring that "level 2" has walked beyond that commit's generation number.

In the case of "level 2", we need to know that we have parsed all 
descendants and determined their simplifications (if necessary, such as 
in file-history) and if they are UNINTERESTING. We guarantee this by 
ensuring that "level 1" has walked beyond that commit's generation number.

In the previous algorithm, these guarantees were handled by doing each 
step on all reachable commits before moving to the next level.

>> Recall that the generation number of a commit satisfies:
>>
>> * If the commit has at least one parent, then the generation
>>    number is one more than the maximum generation number among
>>    its parents.
>>
>> * If the commit has no parent, then the generation number is one.
>>
>> There are two special generation numbers:
>>
>> * GENERATION_NUMBER_INFINITY: this value is 0xffffffff and
>>    indicates that the commit is not stored in the commit-graph and
>>    the generation number was not previously calculated.
>>
>> * GENERATION_NUMBER_ZERO: this value (0) is a special indicator
>>    to say that the commit-graph was generated by a version of Git
>>    that does not compute generation numbers (such as v2.18.0).
>>
>> Since we use generation_numbers_enabled() before using the new
>> algorithm, we do not need to worry about GENERATION_NUMBER_ZERO.
>> However, the existence of GENERATION_NUMBER_INFINITY implies the
>> following weaker statement than the usual we expect from
>> generation numbers:
>>
>>      If A and B are commits with generation numbers gen(A) and
>>      gen(B) and gen(A) < gen(B), then A cannot reach B.
>>
>> Thus, we will walk in each of our stages until the "maximum
>> unexpanded generation number" is strictly lower than the
>> generation number of a commit we are about to use.
> And this "maximum unexpanded generation number" must be greater or equal
> to 1, thanks to assuming generation_numbers_enabled().
>
>
> Let's start by writing down the original version of the Kahn's algorith
> (which is not the only way to calculate topological ordering; another
> method is to use depth-first searches).
>
>    L ← Empty list that will contain the sorted elements
>    S ← Set of all nodes with no incoming edge
>    while S is non-empty do
>        remove a node n from S
>        add n to tail of L
>        for each node m with an edge e from n to m do
>            remove edge e from the graph
>            if m has no other incoming edges then
>                insert m into S
>    if graph has edges then
>        return error   _(graph has at least one cycle)_
>    else
>        return L       _(a topologically sorted order)_
>
> In the case of Git, we display only commits reachable from the starting
> commits, so only those starting commits can have no incoming edge, by
> the definition of the reachable commit (note that some starting commits
> can be reachable from other starting commits).
>
> Note that in Git by construction we cannot have cycles in the objects
> graph, and that 'remove edge e [= n -> m] from the graph' simply means
> decreasing the [effective] in-degree of node m.
>
>> The walks are as follows:
>>
>> 1. EXPLORE: using the explore_queue priority queue (ordered by
>>     maximizing the generation number), parse each reachable
>>     commit until all commits in the queue have generation
>>     number strictly lower than needed. During this walk, update
>>     the UNINTERESTING flags as necessary.
> All right, that looks sensible.  Parse commits and update the
> UNINTERESTING flags only up to what might be needed.
>
> Though I would add for each walk what are post-conditions, i.e. what
> requirements list of returned commits does fullfill.  In the case of the
> EXPLORE walk it would be that commits are in the "reachable from start
> commts" set, parsed and not UNINTERESTING.  And that there are all such
> commits there with generation number greater or equal if needed (and
> their parents).
>
>
> Wouldn't this though make the output always start at the commit with
> maximal generation number (such commit or commits would need to have an
> in-degree of zero, i.e. no incoming edges), instead of whatever order is
> requested (if date order contradicts generation number order) or in the
> command line arguments order?

The final order is prioritized in the "level 3" walk, which either uses 
an incrementing counter (--topo-order), commit date (--date-order), or 
author date (--author-date-order) as the priority.

>> 2. INDEGREE: using the indegree_queue priority queue (ordered
>>     by maximizing the generation number), add one to the in-
>>     degree of each parent for each commit that is walked. Since
>>     we walk in order of decreasing generation number, we know
>>     that discovering an in-degree value of 0 means the value for
>>     that commit was not initialized, so should be initialized to
>>     two. (Recall that in-degree value "1" is what we use to say a
>>     commit is ready for output.)
> The post-condition is that all returned commits have their in-degree
> plus one calculated.
>
> Mixing actual in-degree (number of incoming edges, zero means no
> incoming edge and candidate for the next commit in topological order),
> and details of implementation (using value of zero for uninitialized,
> and thus actually storing in-degree plus one) makes this description a
> bit hard to follow.
>
> Note that the additional complication is that if commits have generation
> number INFINITY, then we cannot say anything about reachability among
> commits with this special generation number.  That means that until we
> process all commits with generation number INFINITY, we don't know which
> ones have no incoming edges (a real in-degree of zero).  If they are not
> INFINITY, the stronger version of the reachability condition for
> generation number holds, and thus we know that if we pop the commit and
> it has uninitialized in-degree and generation number not INFINITY, then
> it has no-incoming edges (in-degree of zero).
>
> That does not matter much, but for the fact that before outputting list
> of commits / returning from the function we need to ensure that all out
> commits have defined in-degree value.  All that have in-degree undefined
> when indegree_queue is empty, because of reachability and generation
> numbers constraints, actually have an in-degree of zero (no incoming
> edges).

This is why we walk until exploring _beyond_ a given generation number. 
Generation number INFINITY is not special with that restriction, as made 
clear in the earlier discussion of generation numbers.

We expect there to be commits with generation number INFINITY, because 
users will not be updating their commit-graph with every single 'git 
commit' command. This mode is covered in our test cases.

>
>>                                   As we iterate the parents of a
>>     commit during this walk, ensure the EXPLORE walk has walked
>>     beyond their generation numbers.
> All right. looks sensible from the point of view of trying to do
> streaming of sorted commits.
>
>> 3. TOPO: using the topo_queue priority queue (ordered based on
>>     the sort_order given, which could be commit-date, author-
>>     date, or typical topo-order which treats the queue as a LIFO
>>     stack), remove a commit from the queue and decrement the
>>     in-degree of each parent. If a parent has an in-degree of
>>     one, then we add it to the topo_queue. Before we decrement
>>     the in-degree, however, ensure the INDEGREE walk has walked
>>     beyond that generation number.
> This description missed an important constraint, namely that all commits
> in the topo_order queue have real in-degree of zero, i.e. no incoming
> edges.  The topo_order queue is set S in the Kahn's algorithm.
>
> Also, we need to know how to populate the topo_queue at start with at
> least one commit.  How it is initially populated?  That is very
> important question.
>
>> The implementations of these walks are in the following methods:
>>
>> * explore_walk_step and explore_to_depth
>> * indegree_walk_step and compute_indegrees_to_depth
>> * next_topo_commit and expand_topo_walk
> All right, one one hand: good calling convention.  On the other hand:
> why the difference in naming?
>
>> These methods have some patterns that may seem strange at first,
>> but they are probably carry-overs from their equivalents in
>> limit_list and sort_in_topological_order.
>>
>> One thing that is missing from this implementation is a proper
>> way to stop walking when the entire queue is UNINTERESTING, so
>> this implementation is not enabled by comparisions, such as in
>> 'git rev-list --topo-order A..B'. This can be updated in the
>> future.
> All right, lets start with easier step.
>
>> In my local testing, I used the following Git commands on the
>> Linux repository in three modes: HEAD~1 with no commit-graph,
>> HEAD~1 with a commit-graph, and HEAD with a commit-graph. This
>> allows comparing the benefits we get from parsing commits from
>> the commit-graph and then again the benefits we get by
>> restricting the set of commits we walk.
>>
>> Test: git rev-list --topo-order -100 HEAD
>> HEAD~1, no commit-graph: 6.80 s
>> HEAD~1, w/ commit-graph: 0.77 s
>>    HEAD, w/ commit-graph: 0.02 s
>>
>> Test: git rev-list --topo-order -100 HEAD -- tools
>> HEAD~1, no commit-graph: 9.63 s
>> HEAD~1, w/ commit-graph: 6.06 s
>>    HEAD, w/ commit-graph: 0.06 s
>>
>> This speedup is due to a few things. First, the new generation-
>> number-enabled algorithm walks commits on order of the number of
>> results output (subject to some branching structure expectations).
>> Since we limit to 100 results, we are running a query similar to
>> filling a single page of results. Second, when specifying a path,
>> we must parse the root tree object for each commit we walk. The
>> previous benefits from the commit-graph are entirely from reading
>> the commit-graph instead of parsing commits. Since we need to
>> parse trees for the same number of commits as before, we slow
>> down significantly from the non-path-based query.
>>
>> For the test above, I specifically selected a path that is changed
>> frequently, including by merge commits. A less-frequently-changed
>> path (such as 'README') has similar end-to-end time since we need
>> to walk the same number of commits (before determining we do not
>> have 100 hits). However, get the benefit that the output is
>> presented to the user as it is discovered, much the same as a
>> normal 'git log' command (no '--topo-order'). This is an improved
>> user experience, even if the command has the same runtime.
> First, do I understand it correctly that in first case the gains from
> new algorithms are so slim because with commit-graph file and no path
> limiting we don't hit repository anyway; we walk less commits, but
> reading commit data from commit-graph file is fast/

If you mean 0.77s to 0.02s is "slim" then yes, it is because the 
commit-graph command already made a full walk of the commit history 
faster. (I'm only poking at this because the _relative_ improvement is 
significant, even if the command was already sub-second.)

> Second, I wonder if there is some easy way to perform automatic latency
> tests, i.e. how fast does Git show the first page of output...

I have talked with Jeff Hostetler about this, to see if we can have a 
"time to first page" traced with trace2, but we don't seem to have 
access to that information within Git. We would need to insert it into 
the pager. The "-100" is used instead.

>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   object.h   |   4 +-
>>   revision.c | 199 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   revision.h |   2 +
>>   3 files changed, 197 insertions(+), 8 deletions(-)
> Daunting change to review.
>
>> diff --git a/object.h b/object.h
>> index 0feb90ae61..796792cb32 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -59,7 +59,7 @@ struct object_array {
>>   
>>   /*
>>    * object flag allocation:
>> - * revision.h:               0---------10                              2526
>> + * revision.h:               0---------10                              25----28
>>    * fetch-pack.c:             01
>>    * negotiator/default.c:       2--5
>>    * walker.c:                 0-2
>> @@ -78,7 +78,7 @@ struct object_array {
>>    * builtin/show-branch.c:    0-------------------------------------------26
>>    * builtin/unpack-objects.c:                                 2021
>>    */
>> -#define FLAG_BITS  27
>> +#define FLAG_BITS  29
> What are those two additional object flags needed for revision.h /
> revision.c after this change?
>
> Ah, those are TOPO_WALK_EXPLORED and TOPO_WALK_INDEGREE.
>
>>   
>>   /*
>>    * The object type is stored in 3 bits.
>> diff --git a/revision.c b/revision.c
>> index 36458265a0..472f3994e3 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -26,6 +26,7 @@
>>   #include "argv-array.h"
>>   #include "commit-reach.h"
>>   #include "commit-graph.h"
>> +#include "prio-queue.h"
>>   
>>   volatile show_early_output_fn_t show_early_output;
>>   
>> @@ -2895,30 +2896,216 @@ static int mark_uninteresting(const struct object_id *oid,
>>   	return 0;
>>   }
>>   
>> -struct topo_walk_info {};
>> +define_commit_slab(indegree_slab, int);
>> +
>> +struct topo_walk_info {
>> +	uint32_t min_generation;
>> +	struct prio_queue explore_queue;
>> +	struct prio_queue indegree_queue;
>> +	struct prio_queue topo_queue;
>> +	struct indegree_slab indegree;
> All right.
>
>> +	struct author_date_slab author_date;
> Why this slab is needed in topo_walk_info struct?
>
>> +};
>> +
>> +static inline void test_flag_and_insert(struct prio_queue *q, struct commit *c, int flag)
>> +{
>> +	if (c->object.flags & flag)
>> +		return;
>> +
>> +	c->object.flags |= flag;
>> +	prio_queue_put(q, c);
>> +}
> This is an independent change, though I see that it is quite specific
> (as opposed to quite generic prio_queue_peek() operation added earlier
> in this series), so it does not make much sense as standalone change.
>
> It inserts commit into priority queue only if it didn't have flags set,
> and sets the flag (so we won't add it to the queue again, not without
> unsetting the flag), am I correct?

Yes, this pattern of using a flag to avoid duplicate entries in the 
priority queue appears in multiple walks. It wasn't needed before. We 
call it four times in the code below.
>> +
>> +static void explore_walk_step(struct rev_info *revs)
>> +{
>> +	struct topo_walk_info *info = revs->topo_walk_info;
>> +	struct commit_list *p;
>> +	struct commit *c = prio_queue_get(&info->explore_queue);
>> +
>> +	if (!c)
>> +		return;
>> +
>> +	if (parse_commit_gently(c, 1) < 0)
>> +		return;
> All right, all commits taken out of explore_queue are parsed.  This is
> used to ensure that all commits qith generation number greater than some
> set cutoff are parsed.
>
>> +
>> +	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
>> +		record_author_date(&info->author_date, c);
>> +
>> +	if (revs->max_age != -1 && (c->date < revs->max_age))
>> +		c->object.flags |= UNINTERESTING;
> These two conditionals looks a bit strange to me; they are hardcoded
> specific cases of query.  But that might be just me...

These special cases are important for making all of the different option 
flags to rev-list work with the algorithm. They are pulled directly from 
limit_list().

>
>> +
>> +	if (process_parents(revs, c, NULL, NULL) < 0)
>> +		return;
> I see that we are using process_parents(), formerly i.e. before patch
> 5/7 add_parents_to_list(), with NULL 'list' parameter for the first
> time.
>> +
>> +	if (c->object.flags & UNINTERESTING)
>> +		mark_parents_uninteresting(c);
>> +
>> +	for (p = c->parents; p; p = p->next)
>> +		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
> Do we need to insert parents to the queue even if they were marked
> UNINTERESTING?

We need to propagate the UNINTERESTING flag to our parents. That 
propagation happens in process_parents().

>
> I guess that we use test_flag_and_insert() instead of prio_queue_put()
> to avoid duplicate entries in the queue.  I think the queue is initially
> populated with the starting commits, but those need not to be
> unreachable from each other, and walking down parents we can encounter
> starting commit already in the queue.  Am I correct?

We can also reach commits in multiple ways, so the initial conditions 
are not the only ways to insert duplicates.

>> +}
> Let's compare this new function with the limit_list() used in the old
> algorithm for --topo-order walk (and even now for A..B walks), or to be
> more exact with the contents of the while loop.
>
> 1. limit_list() doesn't have the check if the commit exists, and
>     does not use parse_commit_gently().  Why the difference, i.e. where
>     revs->commits gets parsed, and why explore_walk_step() cannot rely on
>     this?
>
>     I get that the goal is to not have parse commits if not needed, so it
>     is good that it is moved to explore_walk_step().
>
> 2. limit_list() is also missing running record_author_date() when
>     sorting output by author date.  I guess that explore_walk_step()
>     needs this because commit-graph file does not include this
>     information.
>
> 3. Handling of revs->max_age by marking commit as UNINTERESTING if
>     needed is the same in limit_list() and in explore_walk_step().
>
> 4. limit_list() but not explore_walk_step() handles revs->min_age near
>     the end pf the loop by terminating the loop.  I guess for this case
>     we have revs->limited set, and we use old algorithm, isn't it?
>
>     Something to remember when adding A..B handling to new algorithm.
>
> 5. add_parents_to_list() / process_parents() is nearly the same in
>     limit_list() and in explore_walk_step(), but for the fact that the
>     new function doesn't use 'list' parameter.
>
> 6. Both limit_list() and explore_walk_step() use
>     mark_parents_uninteresting() on uninteresting commits.
>
>     However, limit_list() breaks out of the loop, and uses
>     interesting_cache with slop.  I guess that those two facts are
>     connected, right?
>
> 7. Then explore_walk_step() inserts parents to the priority queue if
>     they are not present there already, with test_flag_and_insert(),
>     which rough equivalent in limit_list() would be using
>     commit_list_insert().
>
> 8. limit_list() has also some code for show_early_output, which I guess
>     explore_walk_step() does not need to handle.
>
>> +
>> +static void explore_to_depth(struct rev_info *revs,
>> +			     uint32_t gen)
>> +{
>> +	struct topo_walk_info *info = revs->topo_walk_info;
>> +	struct commit *c;
>> +	while ((c = prio_queue_peek(&info->explore_queue)) &&
>> +	       c->generation >= gen)
> I have originally thought that if we extract prio_queue_get() and
> test_flag_and_insert() / prio_queue_put() out of explore_walk_step() and
> put it into this loop, i.e. into the calling function, we could avoid
> code duplication between explore_walk_step() and limit_list()... but I
> guess that is impossible anyway.
>
>> +		explore_walk_step(revs);
>> +}
> Nice, tight, and easy to understand function.  Though perhaps 'gen'
> could be called 'gen_cutoff' or 'min_gen', or 'min_gen_cufott'.
>
>> +
>> +static void indegree_walk_step(struct rev_info *revs)
>> +{
>> +	struct commit_list *p;
>> +	struct topo_walk_info *info = revs->topo_walk_info;
>> +	struct commit *c = prio_queue_get(&info->indegree_queue);
>> +
>> +	if (!c)
>> +		return;
>> +
>> +	if (parse_commit_gently(c, 1) < 0)
>> +		return;
> All right, we need to parse commit 'c' to have its generation number,
> and we need to do the same in explore_walk_step() because we walk
> possibly unparsed parents.
>
>> +
>> +	explore_to_depth(revs, c->generation);
> If we walk everything up to current commit depth, then we have walked
> all commits that can affect in-degree of current commit.  Good.
>
>> +
>> +	if (parse_commit_gently(c, 1) < 0)
>> +		return;
> Why do we parse the same commit again???

Good point! Accidental duplicate lines.

>> +
>> +	for (p = c->parents; p; p = p->next) {
>> +		struct commit *parent = p->item;
>> +		int *pi = indegree_slab_at(&info->indegree, parent);
> Sidenote: I would call this 'indegree_plus_one', not 'indegree'.  But
> maybe I am too pedantic here.
>
>> +
>> +		if (*pi)
>> +			(*pi)++;
> If in-degree of parent is defined, then increase it.
>
>> +		else
>> +			*pi = 2;
> If in-degree of parent is not defined, then it is first incoming edge,
> and in-degree plus one is thus 2 (i.e. 1 + INDEGREE_ZERO).
>
>> +
>> +		test_flag_and_insert(&info->indegree_queue, parent, TOPO_WALK_INDEGREE);
>> +
>> +		if (revs->first_parent_only)
>> +			return;
>> +	}
> This loop looks all right to me: we insert the parents if they do not
> exist in the queue, and we handle --first-parent correctly.
>
>> +}
>> +
>> +static void compute_indegrees_to_depth(struct rev_info *revs)
>> +{
>> +	struct topo_walk_info *info = revs->topo_walk_info;
>> +	struct commit *c;
>> +	while ((c = prio_queue_peek(&info->indegree_queue)) &&
>> +	       c->generation >= info->min_generation)
>> +		indegree_walk_step(revs);
>> +}
> All right, this looks correct.  It is identical with explore_to_depth(),
> but for the change of queue member of topo_walk_info and step function.
>
> Sidenote: if C had true macros (higher-order functions), then it might
> be worth encoding this structure in a macro.  Preprocessor macros though
> would make the code more obscure, not less.
>
>>   
>>   static void init_topo_walk(struct rev_info *revs)
>>   {
>>   	struct topo_walk_info *info;
>> +	struct commit_list *list;
> Hmmm, I wonder what do we need this 'list' for.
>
>>   	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
>>   	info = revs->topo_walk_info;
>>   	memset(info, 0, sizeof(struct topo_walk_info));
>>   
>> -	limit_list(revs);
>> -	sort_in_topological_order(&revs->commits, revs->sort_order);
>> +	init_indegree_slab(&info->indegree);
>> +	memset(&info->explore_queue, '\0', sizeof(info->explore_queue));
>> +	memset(&info->indegree_queue, '\0', sizeof(info->indegree_queue));
>> +	memset(&info->topo_queue, '\0', sizeof(info->topo_queue));
> Why this memset uses '\0' as a filler value and not 0?  The queues are
> not strings.
>
>> +
>> +	switch (revs->sort_order) {
>> +	default: /* REV_SORT_IN_GRAPH_ORDER */
>> +		info->topo_queue.compare = NULL;
>> +		break;
>> +	case REV_SORT_BY_COMMIT_DATE:
>> +		info->topo_queue.compare = compare_commits_by_commit_date;
>> +		break;
>> +	case REV_SORT_BY_AUTHOR_DATE:
>> +		init_author_date_slab(&info->author_date);
>> +		info->topo_queue.compare = compare_commits_by_author_date;
>> +		info->topo_queue.cb_data = &info->author_date;
>> +		break;
>> +	}
> O.K., that are all possible values for revs->sort_order (all possible
> values of the rev_sort_order enum).
>
>> +
>> +	info->explore_queue.compare = compare_commits_by_gen_then_commit_date;
>> +	info->indegree_queue.compare = compare_commits_by_gen_then_commit_date;
> All right, those lower level priority queues are sorted by generation
> number (with commit date as tie breaker).
>
>> +
>> +	info->min_generation = GENERATION_NUMBER_INFINITY;
>> +	for (list = revs->commits; list; list = list->next) {
> This list loops over all starting commits, isn't it.
>
>> +		struct commit *c = list->item;
>> +		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
>> +		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
>> +
>> +		if (parse_commit_gently(c, 1))
>> +			continue;
> Why do we insert commits that cannot be parsed to those two queues?
>
>> +		if (c->generation < info->min_generation)
>> +			info->min_generation = c->generation;
> All right, we have parsed commit 'c' so we know its generation numbers.
>
>> +	}
> Here all starting commits are inserted into both expore_queue (for
> parsing and walk), and to indegree_queue (for in-degree calculations).
> All right.
>
>> +
>> +	for (list = revs->commits; list; list = list->next) {
>> +		struct commit *c = list->item;
>> +		*(indegree_slab_at(&info->indegree, c)) = 1;
>> +
>> +		if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
>> +			record_author_date(&info->author_date, c);
>> +	}
> This is a separate loop to initialize and possibly record data in slabs
> for indegree and author_date info.
>
> I wonder why it is in a separate loop.  Is it to make code cleaner, to
> separate different concerns into separate loops?
>
>> +	compute_indegrees_to_depth(revs);
> It looks a bit strange that depth is not passed as a parameter, but its
> value is embedded inside revs structure, but I guess it is done this way
> to keep it in sync.
>
> Though it is a bit *inconsistent* to have explore_to_depth() having
> 'gen' parameter, but compute_indegrees_to_depth() not having it.  There
> is '_to_depth()' in a name, and there is no 'depth' parameter...
>
>
> Here we have computed indegrees of all starting commits, walking the
> commit graph if necessary.
>
>> +
>> +	for (list = revs->commits; list; list = list->next) {
>> +		struct commit *c = list->item;
>> +
>> +		if (*(indegree_slab_at(&info->indegree, c)) == 1)
>> +			prio_queue_put(&info->topo_queue, c);
>> +	}
> And here we add all commits with no incoming edges, i.e. with real
> in-degree of zero, and "indegree plus one" equal 1, or INDEGREE_ZERO.
>
> This is the starting point of Kahn's algorithm (assuming that in-degrees
> will be calculated correctly while running it).  All right.
>
>> +
>> +	/*
>> +	 * This is unfortunate; the initial tips need to be shown
>> +	 * in the order given from the revision traversal machinery.
>> +	 */
>> +	if (revs->sort_order == REV_SORT_IN_GRAPH_ORDER)
>> +		prio_queue_reverse(&info->topo_queue);
> Right, with REV_SORT_IN_GRAPH_ORDER the priority queue is actually a
> stack, and access through this stack reverses the order of commits as it
> was originally in the list (last commit was added last, and stack is
> LIFO structure, last added element is retrieved first).
>
> I think thet here some sort of complication with regards to
> REV_SORT_IN_GRAPH_ORDER is unavoidable, unless priority queue is
> enhanced to work as an ordinary FIFO queue in addition to making it work
> as LIFO stack.
>
>>   }
>>   
>>   static struct commit *next_topo_commit(struct rev_info *revs)
>>   {
>> -	return pop_commit(&revs->commits);
>> +	struct commit *c;
>> +	struct topo_walk_info *info = revs->topo_walk_info;
>> +
>> +	/* pop next off of topo_queue */
>> +	c = prio_queue_get(&info->topo_queue);
> All right, pop_commit() transforms straighforwardly to
> prio_queue_get().
>
>> +
>> +	if (c)
>> +		*(indegree_slab_at(&info->indegree, c)) = 0;
> Why do we need to mark indegree of commit to be returned as undefined
> here (INDEGREE_UNINITIALIZED)?
>
>> +
>> +	return c;
>>   }
>>
> Before the change, expand_topo_walk() simply added parents to the list,
> and actual sorting was done by sort_in_topological_order().
>
>>   static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
>>   {
>> -	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
>> +	struct commit_list *p;
>> +	struct topo_walk_info *info = revs->topo_walk_info;
>> +	if (process_parents(revs, commit, NULL, NULL) < 0) {
> All right, here we remove storing commits in revs->commits list, the
> third parameter changed from &revs->commits to NULL.
>
>>   		if (!revs->ignore_missing_links)
>>   			die("Failed to traverse parents of commit %s",
>> -			    oid_to_hex(&commit->object.oid));
>> +				oid_to_hex(&commit->object.oid));
> The above looks like spurious and accidental whitespace change, isn't
> it?

Correct. Thanks for finding it.

>
>> +	}
>> +
> All right, the loop below looks like the inner loop of the Kahn's
> algorithm, i.e.:
>
>        for each node m with an edge e from n to m do
>            remove edge e from the graph
>            if m has no other incoming edges then
>                insert m into S
>
>
>> +	for (p = commit->parents; p; p = p->next) {
>> +		struct commit *parent = p->item;
>> +		int *pi;
>> +
>> +		if (parse_commit_gently(parent, 1) < 0)
>> +			continue;
> All right, we need to parse parent commit to ensure that we can access
> its generation number.
>
>> +
>> +		if (parent->generation < info->min_generation) {
>> +			info->min_generation = parent->generation;
>> +			compute_indegrees_to_depth(revs);
>> +		}
> The above ensures that the parent will have correctly calculated
> in-degree.  Looks all right.
>
>> +
>> +		pi = indegree_slab_at(&info->indegree, parent);
>> +
>> +		(*pi)--;
>            remove edge e from the graph
>
>> +		if (*pi == 1)
>> +			prio_queue_put(&info->topo_queue, parent);
> If parent has no incoming edges (indegree == 1 == INDEGREE_ZERO), then
> insert it into topo_queue.
>
>            if m has no other incoming edges then
>                insert m into S
>
>> +
>> +		if (revs->first_parent_only)
>> +			return;
>>   	}
>>   }
> Looks all right.

Thanks for taking the time on this huge patch!

Thanks,
-Stolee
