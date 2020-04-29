Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A8AC83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E8521D92
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6J4sBR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgD2NM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgD2NM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 09:12:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C71C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:12:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so1747309qth.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rh0Rbe/YZYJONKkIfspe6cEmLo5/jXkHZ2RC3bBjuWY=;
        b=Y6J4sBR3DR3M7BGQHLipCwVSg/R0QjbFOEu4m6rMcVew0OqZGFOa30psuRMZuNDZyK
         aZuvbH47EmLM1nxA8GLeKrB8Y45zBJjrnmuPMda0prdX+UMgXoV4cUR1r8k+jkaWQUU+
         xfNOrGT+eAT49A452tg+ZlVmQXfYT0dF941VH4sw+qnJj/AwAGefQCdteXvJcMozhL3f
         FDT4X2UKsFZoSypuYO7SrBFG4gMYD2aj4/hk4PdwJzuPmNnYNggmPCzvFLL+86gq62Hi
         byuRemP7b4PCDtbNjKnIBRUePvjNQ87XbOZF0NqbIY1BMk8E2dkuQCx61kmwyLNAE2iY
         NMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rh0Rbe/YZYJONKkIfspe6cEmLo5/jXkHZ2RC3bBjuWY=;
        b=ng6+wuyBKw/8MWANbsy05YdYJ2GV4YsgvcBxd4n/zOdQsQZlnFODFBsbc5bomZFsaw
         k6afDFKeOeIoY7pje4Vd49TpOyUxQEcywc8GVS1rfnpa18KUEpcjQ3g1LgsDN6NEx4YQ
         LSF1IPoFqNYHftvqlZXaJDSe5nr2E7SmCKbnylr4HDLz9eq6qeaJOr3dX2QAnayFj9Se
         n9jwxSR70ft5IKEwF+swr3uf6y03EjKR7pmj5+YgT250sjZNTCMRYkSegDS/Web+JsJt
         GQ3GoLpPUR9HYP1moxVkkORpGfmTsvArN4ZbpOJdcqk2/tipRzU7q8809NZemnw7JdyT
         l3Lw==
X-Gm-Message-State: AGi0Pub5qtWhzShRhAGTS8cI1BpMsQ7kn4LnXpd6AU/FNegMfXaMfD0P
        8dcAHzjWeUIrNgvK+V6lwR3RIg9i5o0=
X-Google-Smtp-Source: APiQypKd1oyJmvrBF5feOBarMDU+rENPbMYLZemLz2nOWCma6Cz+LW+atfhtqtoRP7fNHQanOazQjg==
X-Received: by 2002:ac8:180f:: with SMTP id q15mr33302410qtj.42.1588165977799;
        Wed, 29 Apr 2020 06:12:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u11sm16105185qtj.10.2020.04.29.06.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 06:12:56 -0700 (PDT)
Subject: Re: [PATCH v2] Teach git-rev-list --simplify-forks
To:     Antonio Russo <antonio.e.russo@gmail.com>,
        git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08d5460b-d80b-28a3-19dd-d438afbdfba9@gmail.com>
Date:   Wed, 29 Apr 2020 09:12:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/29/2020 4:01 AM, Antonio Russo wrote:
> When used with --graph, instead of displaying the full graph, display a
> spanning subgraph produced by a depth-first search of the graph visiting
> parents from left to right.  Edges to already visited commits are
> discarded.  This process is repeated for every commit to be displayed.
> 
> This is valuable to reduce visual clutter when there are many merges
> that were not rebased onto each other and the user is primarily
> interested in the state of the branch being merged into.

My earlier comment to recommend how to fix the test failures intended
to demonstrate that this area of code requires a bit of precision. I
took some time to review this patch, but I find it needs some significant
updates.

tl;dr: The way you manipulate the commit parents seems incorrect to me,
but perhaps there is enough prior art in the way we simplify parents to
make that acceptable. Someone else will need to chime in on that part.

It may be possible to do this "drop edges" entirely inside of graph.c
(the graph rendering code) instead of revision.c, which would automatically
work with the performance gains from the newer topo-walk algorithm.

There are enough deviations from code and test style that this will
need a significant revision regardless.
 
> This second revision of the patch sets revs->limited.  This forces the
> graph of commits to be loaded, and simplfiy_forks() therefore reliably
> traverses it.  This addresses the test failures mentioned before (see [1]).

This will have a significant performance impact on the option, as you will
not see even the first result until the DFS has completed.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 04ad7dd36e..cbac09028c 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -363,6 +363,14 @@ Default mode::
>  	merges from the resulting history, as there are no selected
>  	commits contributing to this merge.
> 
> +--simplify-forks::
> +	Convert the commit graph into a spanning subgraph produced by a
> +	depth-first-search of the history graph, searching the leftmost
> +	parent first, and discarding edges to commits already visited.
> +	Useful with `--graph` to visualize repositories with many merges
> +	when you are interested in was added to master, and not when the
> +	branch was last rebased.

Describing the option via the algorithm may not be the best way to
inform the user of what they will see. It also will not be informative
if the implementation changes to not perform the algorithm described
here, because that algorithm is not incremental (it is O(N) where N is
the total number of reachable commits, not ~O(n) where n is the number
of commits that will actually show up).

An easy test is to time your command with "-n 1".

I'm also not crazy about "when the branch was last rebased". You
probably mean "..when you are not interested in which merge base
was used for each merge."

Also, this does nothing without "--graph" right? Perhaps it should
enable it?

Here is a suggested alternative:

--simplify-forks::
	Show commits that are introduced by each merge before showing
	the first parent of the merge, as in `--graph`, but remove
	edges from those commits to commits reachable from the first
	parent. This helps to visualize repositories with many merges
	when you are not interested in which merge base was used for
	each merge. It also reduces the width of the graph visualization
	compared to `--graph`.

With this description, perhaps it is worth renaming the option? Perhaps
"--ignore-merge-bases"? The word "simplify" implies something like
dropping commits from history, but you are instead dropping _edges_ from
the graph.

>  --ancestry-path::
>  	When given a range of commits to display (e.g. 'commit1..commit2'
>  	or 'commit2 {caret}commit1'), only display commits that exist
> diff --git a/revision.c b/revision.c
> index 5bc96444b6..51dbe21847 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2082,6 +2082,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->simplify_by_decoration = 1;
>  		revs->limited = 1;
>  		revs->prune = 1;
> +	} else if (!strcmp(arg, "--simplify-forks")) {
> +		revs->limited = 1;
> +		revs->simplify_forks = 1;

I recommend dropping the revs->limited setting here and instead fixing the
performance instead. But maybe that should be a second patch on top of this
one.

>  	} else if (!strcmp(arg, "--date-order")) {
>  		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
>  		revs->topo_order = 1;
> @@ -3095,6 +3098,63 @@ static void simplify_merges(struct rev_info *revs)
>  	}
>  }
> 
> +static void simplify_forks(struct rev_info *revs)
> +{
> +	struct commit_list *stack, *list_lr, *iter_list;
> +	struct commit_list **parents;

You want "struct commit_list *parents" here for simpler use.

> +	struct commit *commit, *parent;
> +
> +	stack = NULL;
> +	list_lr = NULL;
> +
> +	clear_object_flags(SIMP_FORK_VISITED);
> +
> +	for(iter_list = revs->commits; iter_list; iter_list = iter_list->next) {

This method could use a split into at least two. I count three levels of nested
loops here, so please break them up into smaller methods.

> +		/* process every commit to be displayed exactly once */
> +		if(iter_list->item->object.flags & SIMP_FORK_VISITED)
> +			continue;
> +		clear_object_flags(SIMP_FORK_VISITING);

This drops the flag from all commits. This will cause quadratic performance
if combined with "--all". Drop this and instead clear the flag yourself as you
visit commits.

> +		commit_list_insert(iter_list->item, &stack);
> +		iter_list->item->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
> +		while(stack) {
> +			commit = pop_commit(&stack);
> +			/* process the parent nodes: removing links to
> +			 * commits already visited (creating a spanning tree)
> +			 */
> +			parents = &(commit->parents);
> +			while(*parents) {

You have some whitespace issues. Put a space between "while" and "(". Same with "if"s below.

> +				parent = (*parents)->item;
> +				if(parent->object.flags & SIMP_FORK_VISITING) {
> +					/* We have already visited this commit, from the same root.
> +					 * We do not explore it at all.
> +					 */
> +					pop_commit(parents);

I don't think you want pop_commit() here. You want to have "parents = parents->next" at the end.

Now, if this is how you are "simplifying" the edges in the final output, then I think this is
destructive and unsafe! You are literally modifying "commit->parents" so if another operation in
Git tries to read those parents it will see the wrong data.

Think about a different way to achieve your goal here, perhaps in the rendering portion of
graph.c instead of here.

> +				} else if(parent->object.flags & SIMP_FORK_VISITED) {
> +					/* We visited this commit before, but from a different root.
> +					 * Leave it attached, but do not explore it further.
> +					 */
> +					parents = &((*parents)->next);
> +				} else {
> +					/* We have not visited this commit yet. Explore it, as usual.
> +					 */
> +					parent->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
> +					commit_list_insert(parent, &list_lr);
> +					parents = &((*parents)->next);
> +				}

It is very unclear that your loop terminates. Instead, use
"parents = parents->next" at the end of the loop block to
make is extremely clear that the loop behaves as expected.

Of course, this assumes that you are not being destructive
to the commit parents as you explore.

> +			}
> +
> +			/* feed the parents, right to left (reversed) onto the
> +			 * stack to do a depth-first traversal of the commit graph
> +			 */

nit: multi-line comment style [1]

[1] https://github.com/git/git/blob/86ab15cb154862b6fa5cc646dac27532f881e1fb/Documentation/CodingGuidelines#L285-L291

> +			while(list_lr) {
> +				commit_list_insert(pop_commit(&list_lr), &stack);
> +			}

nit: No curly braces around single-line blocks. [2]

[2] https://github.com/git/git/blob/86ab15cb154862b6fa5cc646dac27532f881e1fb/Documentation/CodingGuidelines#L239-L243

> +		}
> +	}
> +
> +	clear_object_flags(SIMP_FORK_VISITED | SIMP_FORK_VISITING);
> +}
> +
>  static void set_children(struct rev_info *revs)
>  {
>  	struct commit_list *l;
> @@ -3392,6 +3452,8 @@ int prepare_revision_walk(struct rev_info *revs)
>  	if (revs->limited) {
>  		if (limit_list(revs) < 0)
>  			return -1;
> +		if (revs->simplify_forks)
> +			simplify_forks(revs);
>  		if (revs->topo_order)
>  			sort_in_topological_order(&revs->commits, revs->sort_order);
>  	} else if (revs->topo_order)
> diff --git a/revision.h b/revision.h
> index c1af164b30..f1abdb26b0 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -51,6 +51,11 @@
>  #define TOPO_WALK_EXPLORED	(1u<<27)
>  #define TOPO_WALK_INDEGREE	(1u<<28)
> 
> +/* Re-use the TOPO_WALK flagspace for simplify_forks
> + */
> +#define SIMP_FORK_VISITED	(1u<<27)
> +#define SIMP_FORK_VISITING	(1u<<28)

I don't like that you are re-using these, as it is dangerous for later
collisions. At the moment, these flags are not used in the same code paths
because you specify "limited = 1" and that code path does not use TOPO_WALK_*
macros.

>  #define DECORATE_SHORT_REFS	1
>  #define DECORATE_FULL_REFS	2
> 
> @@ -132,6 +137,7 @@ struct rev_info {
>  			no_walk:2,
>  			remove_empty_trees:1,
>  			simplify_history:1,
> +			simplify_forks:1,
>  			show_pulls:1,
>  			topo_order:1,
>  			simplify_merges:1,
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
> index f5e6e92f5b..d99214b6df 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -85,6 +85,28 @@ test_expect_success '--graph --all' '
>  	test_cmp expected actual
>  	'
> 
> +# Make sure that simplify_histpry_forks produces a spanning tree
> +test_expect_success '--graph --simplify-forks --all' '
> +	rm -f expected &&
> +	echo "* $A7" >> expected &&
> +	echo "*   $A6" >> expected &&
> +	echo "|\  " >> expected &&
> +	echo "| * $C4" >> expected &&
> +	echo "| * $C3" >> expected &&
> +	echo "* $A5" >> expected &&
> +	echo "*-.   $A4" >> expected &&
> +	echo "|\ \  " >> expected &&
> +	echo "| | * $C2" >> expected &&
> +	echo "| | * $C1" >> expected &&
> +	echo "| * $B2" >> expected &&
> +	echo "| * $B1" >> expected &&
> +	echo "* $A3" >> expected &&
> +	echo "* $A2" >> expected &&
> +	echo "* $A1" >> expected &&

Do not use too many echos like this. Instead use t4215-log-skewed-merges.sh
as an example [3].

[3] https://github.com/git/git/blob/86ab15cb154862b6fa5cc646dac27532f881e1fb/t/t4215-log-skewed-merges.sh#L24-L37

I also hope that you can find more complicated cases to
test, including:

 1. A merge that brings in a merge (think a feature branch)
 2. A merge that brings in a twisted merge (think a user using "git pull").

Here are some example --graph and --simplify-forks outputs to try. I
have not tested these myself, but I believe they are interesting test
cases that can trip up other algorithms.

Merge bringing a merge (non-twisted):

 --graph	--simplify-forks
 *		*
 |\		|\
 | *		| *
 | |\		| |\
 | | *		| | *
 | * |		| *
 * | |		*
 |/ /		*
 * /		*
 |/
 *

Twisted merge:

 --graph	--simplify-forks
 *		*
 |\		|\
 | *		| *
 | |\		| *
 | * |		*
 | | |		*
 * |/		*
 |/|
 * |
 |/
 *

Thanks,
-Stolee

