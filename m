Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D12C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981A0206F0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="enI4jgaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgAGMI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:08:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:34365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgAGMI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578398898;
        bh=OccOukFz8lRdTOKsBCCzUk6HyO6MMkEusvX+lKylbTc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=enI4jgaa+lMyy9Ve4p2MEOBkpiZEoizJSn1UEju+wf4fwERKIG2uCbpRTZNJQk71p
         1nV0do/m+y/jM/AWuQdTVAkMAQTUgNIXUR5G4PksmY4wQEBHkez1zt/IGW/WV+/E9Y
         8YeJlU6cpbzRfIa+rDzrbjj+NJ26KyMie8aiZHN0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1j4wxd2O8R-00P5xc; Tue, 07
 Jan 2020 13:08:18 +0100
Date:   Tue, 7 Jan 2020 13:08:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Sergey Rudyshin <540555@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Rudyshin <540555@gmail.com>
Subject: Re: [PATCH 1/1] Preserve topological ordering after merges This
 modifies the algorithm of topopological ordering. The problem with the
 current algoritm is that it displays the graph below as follows
In-Reply-To: <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001071305330.46@tvgsbejvaqbjf.bet>
References: <pull.514.git.1578393057.gitgitgadget@gmail.com> <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:E4ukfdcimw8PC7VUrV/vAE9gicsHNYtbg+x4To2QKMTu7ySDxsy
 4wO1HLLfNpVJYIDzNRTOiH0iIpv2HT1BSFVtqHWMssUBp30KQQ8fbR5w0/nSAmhpALVErjk
 eTLGNl0jXRFiQ+8DpgcqARfGk4Qs9ueDXS/13LA5Zdps/6XAGj/jqaUbQirDHA9hcPmhEMl
 +znkP43JJXXbXmKygEZlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uIMjUx2l6AM=:l/4HImdDYFc29Oq8sA2ab8
 UzwEmWy7AL5qOFAco/gdCum4AnrGEUXzjDvIL56A5ZQxjLwnWaUoNjAbUf8p2votjSg/ZpovM
 4RPTdXKa7I4RMEeF5KF7dMgApPKOg8v55nyuRFosN08zNrMs8y7YNWzY/xRBsXZ8vAZQpYcw9
 MofHT4UxTcURU7Cmz6aSyv9irtv21jo5RrOaTWsLlWzfsv4MoRYy5E60jzhC4IfLLzgD+eXZT
 gc9aSKwtfvzR7GOiqAHACp1QIhWBqp6zta6qcl90eWw7n8bVO0DT6FRCKMn+TqRnAOYhLAb27
 lxvJKm6xKpUfKw8I9RzA9QnkOroVWAFBdJRjPYHU5b9169KcOOmlOEOaXMCQKOiNgtYw45AAi
 x0iP05JgBRiDjejDcr4wD3VQ9+DVUfoyGP9IopNZ37Quaj7p6QWfV/bybCITUMoNpo+PIgFXw
 9kA6Et2JNOAakJ2N2Wu5xGI+WcHrSeazA2zFmZjg7eWAlIXNwoXAoME2bdkaZlNfIUxaWMNcZ
 WGJL4csZ2fiFq8MoRfenrViiHpuZZFdgHzI1NmeWUVPGC/NZX1OLtfD9iLQkYdUpxwV81+L/Z
 YUaSa2V+PNeL2xVUBoOyEe8Uz7wLPtRhg7o6SzY/CDo4uVpBByUTQve6QalFdkJOlNHjB7lI4
 GO5UR2YMF8ItBwNZUmL8Bb5w+0DriYpuKse4CNmXh8f0wuXNtNiKfGUf2S835TLqY16+Fu5XK
 jlPbkbmIZqi9Jg2momPh12f3HGfOZHrs4r9xO0SsvrOU3t/+bBeiVZ3bTlJS56FoCQk2rmc/o
 J9Tky2Ql9vVCkSorQlsh9q5KTduEfFAhmgNj6/3+0pATMm7boBeE6nlZSTy3e38peE/FTNaa6
 Lo45jyKn5FQt3NXxeF7BI2Agkcd3gWS9j3p2sf/WVZzK52f0dhWjMhyLdrcRr2SiLxNG67/4b
 BVs88juimdxjo7JD7MZPLIRTnfFTsOXWClrEcCfs50uKmdnYGJyct8srmsgsT6Yf28fkULMaz
 3QgepEDv2zFXmkHe81KCBsRdc3O+Rewbe7pt0zRDN9Dh7sO+Sbu7qrPJukskg60+/r30V5mDy
 RKbJsKHEmjOR8MoCwHRfnXWco1mrJw0h5sfcXL020kctgpanuKKo8Y5kVzSWKzLk9gJ+erVfn
 BntuEYyyjeajdQNGIYyyhN7YhT4EbSPc9WW+eAYsdU1iZpqWHacbn4A41WK02nnuNn9CG6XdY
 3x/ULVYizfKtRpUJtj4eDkXSIQATt6OsTWJKB/XZ166iFgS5e1efqCq9orks=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

please note that the commit message's first line should not be longer than
76 characters per line, and it should be followed by an empty line. I
think that you forgot the empty line, looking at
https://github.com/gitgitgadget/git/pull/514/commits/542a02020c8578d0e004c=
b9c929bced8719b902a

Ciao,
Johannes

On Tue, 7 Jan 2020, Sergey Rudyshin via GitGitGadget wrote:

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
>
> Here is an example:
> * walk to to the root via "first" parents;
> * go E -> C -> A;
> * print A because it has no parents;
> * step back to C;
> * print C because it has no other parents;
> * then step back to E;
> * go D -> B -> A;
> * do not print A because A is already printed;
> * step back to B;
> * print B;
> * so on.
>
> This change makes option "--topo-order" obsolete, because
> there is only one way to order parents of a single commit.
> "--date-order" and "--author-date-order" are preserved and make sense
> only for the case when multiple commits are given
> to be able to sort those commits.
>
> Signed-off-by: Sergey Rudyshin <540555@gmail.com>
> ---
>  Documentation/git-rev-list.txt             |   4 +-
>  Documentation/rev-list-options.txt         |  41 +++---
>  commit.c                                   | 149 ++++++++++++++-------
>  commit.h                                   |   4 +-
>  t/t4202-log.sh                             |  15 +--
>  t/t4215-log-skewed-merges.sh               |  44 +++---
>  t/t6003-rev-list-topo-order.sh             |  54 ++++----
>  t/t6012-rev-list-simplify.sh               |   8 +-
>  t/t6016-rev-list-graph-simplify-history.sh |  41 +++---
>  t/t6600-test-reach.sh                      |   6 +-
>  10 files changed, 214 insertions(+), 152 deletions(-)
>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list=
.txt
> index 025c911436..ad1fda7a54 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -3,7 +3,7 @@ git-rev-list(1)
>
>  NAME
>  ----
> -git-rev-list - Lists commit objects in reverse chronological order
> +git-rev-list - Lists commit objects in reverse topological order
>
>
>  SYNOPSIS
> @@ -17,7 +17,7 @@ DESCRIPTION
>  List commits that are reachable by following the `parent` links from th=
e
>  given commit(s), but exclude commits that are reachable from the one(s)
>  given with a '{caret}' in front of them.  The output is given in revers=
e
> -chronological order by default.
> +topological order by default.
>
>  You can think of this as a set operation.  Commits given on the command
>  line form a set of commits that are reachable from any of them, and the=
n
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list=
-options.txt
> index bfd02ade99..7ab2f451ae 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -643,39 +643,42 @@ ifndef::git-shortlog[]
>  Commit Ordering
>  ~~~~~~~~~~~~~~~
>
> -By default, the commits are shown in reverse chronological order.
> +By default, the commits are shown in reverse topological order.
> ++
> +Meaning that no parents are shown before all of its children and
> +merges do not change the previous order.
> ++
> +E.g., if commit M0 produces topologically ordered list of
> +commits L0 then commit M1 created by merging any commit into M0
> +produces list L1 which starts with L0
> ++
> +In case if multiple commits are given via the command line
> +the following parameters determine the order among them:
>
>  --date-order::
> -	Show no parents before all of its children are shown, but
> -	otherwise show commits in the commit timestamp order.
> +	show commits in the commit timestamp order.
>
>  --author-date-order::
> -	Show no parents before all of its children are shown, but
> -	otherwise show commits in the author timestamp order.
> +	show commits in the author timestamp order.
>
>  --topo-order::
> -	Show no parents before all of its children are shown, and
> -	avoid showing commits on multiple lines of history
> -	intermixed.
> +	show commits in the commit timestamp order.
> +	this is deprecated and will be
> +	removed in the future.
>  +
>  For example, in a commit history like this:
>  +
>  ----------------------------------------------------------------
> -
> -    ---1----2----4----7
> -	\	       \
> -	 3----5----6----8---
> -
> +   1----2-----------5
> +    \    \         /
> +     -----\---3---4---6
> +           \     /
> +            ----
>  ----------------------------------------------------------------
>  +
>  where the numbers denote the order of commit timestamps, `git
>  rev-list` and friends with `--date-order` show the commits in the
> -timestamp order: 8 7 6 5 4 3 2 1.
> -+
> -With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
> -3 1); some older commits are shown before newer ones in order to
> -avoid showing the commits from two parallel development track mixed
> -together.
> +following order: 1 2 3 4 5 6.
>
>  --reverse::
>  	Output the commits chosen to be shown (see Commit Limiting
> diff --git a/commit.c b/commit.c
> index 434ec030d6..01e9d07db9 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -738,6 +738,12 @@ int compare_commits_by_author_date(const void *a_, =
const void *b_,
>  	return 0;
>  }
>
> +static int compare_commits_by_author_date_rev(const void *a_, const voi=
d *b_,
> +				   void *cb_data)
> +{
> +	return compare_commits_by_author_date(b_, a_, cb_data);
> +}
> +
>  int compare_commits_by_gen_then_commit_date(const void *a_, const void =
*b_, void *unused)
>  {
>  	const struct commit *a =3D a_, *b =3D b_;
> @@ -767,36 +773,83 @@ int compare_commits_by_commit_date(const void *a_,=
 const void *b_, void *unused)
>  	return 0;
>  }
>
> +static int compare_commits_by_commit_date_rev(const void *a_, const voi=
d *b_, void *unused)
> +{
> +	return compare_commits_by_commit_date (b_, a_, unused);
> +}
> +
> +struct maze {
> +	struct commit *ret;
> +	struct commit *out;
> +};
> +
> +define_commit_slab(maze_slab, struct maze *);
> +
> +/*
> + * returns the next commit while exploring the maze
> + * current commit has the information:
> + * 	- what was the last commit we went for (OUT)
> + * 	- from which commit we came in (RET)
> + * trying to find a parent next to OUT
> + * if it does not exists returns RET
> + * otherwise returns the found parent
> + */
> +static struct commit *get_next(struct commit *commit, struct maze *mz, =
struct indegree_slab *indegree)
> +{
> +	struct commit_list *parents =3D commit->parents;
> +	struct commit *next =3D NULL;
> +	int found =3D 0;
> +
> +	while (parents) {
> +		struct commit *parent =3D parents->item;
> +
> +		if (*indegree_slab_at(indegree, parent)) {
> +
> +			if (!mz->out || found) {
> +				next =3D parent;
> +				break;
> +			} else if  (mz->out =3D=3D parent) {
> +				found =3D 1;
> +			}
> +		}
> +		parents =3D parents->next;
> +	}
> +
> +	if (!next) next =3D mz->ret;
> +
> +	return next;
> +}
> +
>  /*
>   * Performs an in-place topological sort on the list supplied.
>   */
>  void sort_in_topological_order(struct commit_list **list, enum rev_sort=
_order sort_order)
>  {
>  	struct commit_list *next, *orig =3D *list;
> -	struct commit_list **pptr;
> +	struct commit_list **pptr =3D list;
>  	struct indegree_slab indegree;
> -	struct prio_queue queue;
> +	struct prio_queue queue_tips;
>  	struct commit *commit;
>  	struct author_date_slab author_date;
> +	struct maze_slab maze;
> +	struct maze *mz;
>
>  	if (!orig)
>  		return;
>  	*list =3D NULL;
>
>  	init_indegree_slab(&indegree);
> -	memset(&queue, '\0', sizeof(queue));
> +	init_maze_slab(&maze);
> +	memset(&queue_tips, '\0', sizeof(queue_tips));
>
>  	switch (sort_order) {
> -	default: /* REV_SORT_IN_GRAPH_ORDER */
> -		queue.compare =3D NULL;
> -		break;
> -	case REV_SORT_BY_COMMIT_DATE:
> -		queue.compare =3D compare_commits_by_commit_date;
> +	default:
> +		queue_tips.compare =3D compare_commits_by_commit_date_rev;
>  		break;
>  	case REV_SORT_BY_AUTHOR_DATE:
>  		init_author_date_slab(&author_date);
> -		queue.compare =3D compare_commits_by_author_date;
> -		queue.cb_data =3D &author_date;
> +		queue_tips.compare =3D compare_commits_by_author_date_rev;
> +		queue_tips.cb_data =3D &author_date;
>  		break;
>  	}
>
> @@ -804,9 +857,10 @@ void sort_in_topological_order(struct commit_list *=
*list, enum rev_sort_order so
>  	for (next =3D orig; next; next =3D next->next) {
>  		struct commit *commit =3D next->item;
>  		*(indegree_slab_at(&indegree, commit)) =3D 1;
> -		/* also record the author dates, if needed */
> -		if (sort_order =3D=3D REV_SORT_BY_AUTHOR_DATE)
> -			record_author_date(&author_date, commit);
> +		mz =3D xmalloc(sizeof(struct maze));
> +		mz->ret =3D NULL;
> +		mz->out =3D NULL;
> +		*(maze_slab_at(&maze, commit)) =3D mz;
>  	}
>
>  	/* update the indegree */
> @@ -832,51 +886,56 @@ void sort_in_topological_order(struct commit_list =
**list, enum rev_sort_order so
>  	for (next =3D orig; next; next =3D next->next) {
>  		struct commit *commit =3D next->item;
>
> -		if (*(indegree_slab_at(&indegree, commit)) =3D=3D 1)
> -			prio_queue_put(&queue, commit);
> +		if (*(indegree_slab_at(&indegree, commit)) =3D=3D 1) {
> +			/* also record the author dates, if needed */
> +			if (sort_order =3D=3D REV_SORT_BY_AUTHOR_DATE)
> +				record_author_date(&author_date, commit);
> +			prio_queue_put(&queue_tips, commit);
> +		}
>  	}
>
> -	/*
> -	 * This is unfortunate; the initial tips need to be shown
> -	 * in the order given from the revision traversal machinery.
> -	 */
> -	if (sort_order =3D=3D REV_SORT_IN_GRAPH_ORDER)
> -		prio_queue_reverse(&queue);
> -
>  	/* We no longer need the commit list */
>  	free_commit_list(orig);
>
>  	pptr =3D list;
>  	*list =3D NULL;
> -	while ((commit =3D prio_queue_get(&queue)) !=3D NULL) {
> -		struct commit_list *parents;
> -
> -		for (parents =3D commit->parents; parents ; parents =3D parents->next=
) {
> -			struct commit *parent =3D parents->item;
> -			int *pi =3D indegree_slab_at(&indegree, parent);
>
> -			if (!*pi)
> +	while ((commit =3D prio_queue_get(&queue_tips)) !=3D NULL) {
> +		struct commit *prev_commit =3D NULL;
> +		while (commit) {
> +			mz =3D *(maze_slab_at(&maze, commit));
> +			if (!prev_commit) {
> +				/* either a new tip or
> +				 * after entering an already visited commit
> +				 */
> +			}
> +			else if (!mz->out) {
> +				/* happens only once for every commit
> +				 * note that for tips RET is set to NULL
> +				 */
> +				mz->ret =3D prev_commit;
> +			}
> +			else if (prev_commit !=3D mz->out) {
> +				/* entered an already visited commit
> +				 * step back
> +				 */
> +				commit =3D prev_commit;
> +				prev_commit =3D NULL;
>  				continue;
> -
> -			/*
> -			 * parents are only enqueued for emission
> -			 * when all their children have been emitted thereby
> -			 * guaranteeing topological order.
> -			 */
> -			if (--(*pi) =3D=3D 1)
> -				prio_queue_put(&queue, parent);
> +			}
> +			mz->out =3D get_next(commit, mz, &indegree);
> +			if (mz->out =3D=3D mz->ret) {
> +				/* upon leaving a commit emit it */
> +				*pptr =3D commit_list_insert(commit, pptr);
> +			}
> +			prev_commit =3D commit;
> +			commit =3D mz->out;
>  		}
> -		/*
> -		 * all children of commit have already been
> -		 * emitted. we can emit it now.
> -		 */
> -		*(indegree_slab_at(&indegree, commit)) =3D 0;
> -
> -		pptr =3D &commit_list_insert(commit, pptr)->next;
>  	}
>
>  	clear_indegree_slab(&indegree);
> -	clear_prio_queue(&queue);
> +	clear_maze_slab(&maze);
> +	clear_prio_queue(&queue_tips);
>  	if (sort_order =3D=3D REV_SORT_BY_AUTHOR_DATE)
>  		clear_author_date_slab(&author_date);
>  }
> diff --git a/commit.h b/commit.h
> index 221cdaa34b..1fe3cc240e 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -209,7 +209,7 @@ struct commit *pop_commit(struct commit_list **stack=
);
>  void clear_commit_marks(struct commit *commit, unsigned int mark);
>  void clear_commit_marks_many(int nr, struct commit **commit, unsigned i=
nt mark);
>
> -
> +/* TODO get rid of rev_sort_order in a favour of positional parameters =
*/
>  enum rev_sort_order {
>  	REV_SORT_IN_GRAPH_ORDER =3D 0,
>  	REV_SORT_BY_COMMIT_DATE,
> @@ -222,8 +222,6 @@ enum rev_sort_order {
>   *   invariant of resulting list is:
>   *      a reachable from b =3D> ord(b) < ord(a)
>   *   sort_order further specifies:
> - *   REV_SORT_IN_GRAPH_ORDER: try to show a commit on a single-parent
> - *                            chain together.
>   *   REV_SORT_BY_COMMIT_DATE: show eligible commits in committer-date o=
rder.
>   */
>  void sort_in_topological_order(struct commit_list **, enum rev_sort_ord=
er);
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 2c9489484a..46f04b36a3 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -635,17 +635,16 @@ test_expect_success 'set up more tangled history' =
'
>  cat > expect <<\EOF
>  *   Merge tag 'reach'
>  |\
> -| \
> +| * reach
> +| |
>  |  \
>  *-. \   Merge tags 'octopus-a' and 'octopus-b'
>  |\ \ \
> -* | | | seventh
>  | | * | octopus-b
> -| |/ /
> -|/| |
> -| * | octopus-a
> -|/ /
> -| * reach
> +| | |/
> +| * / octopus-a
> +| |/
> +* / seventh
>  |/
>  *   Merge branch 'tangle'
>  |\
> @@ -673,7 +672,7 @@ cat > expect <<\EOF
>  * initial
>  EOF
>
> -test_expect_success 'log --graph with merge' '
> +test_expect_success 'log --graph with merge tag reach' '
>  	git log --graph --date-order --pretty=3Dtformat:%s |
>  		sed "s/ *\$//" >actual &&
>  	test_cmp expect actual
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index 18709a723e..91630c0cae 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -5,7 +5,7 @@ test_description=3D'git log --graph of skewed merges'
>  . ./test-lib.sh
>
>  check_graph () {
> -	cat >expect &&
> +	sed "s/ *$//" >expect &&
>  	git log --graph --pretty=3Dtformat:%s "$@" >actual.raw &&
>  	sed "s/ *$//" actual.raw >actual &&
>  	test_cmp expect actual
> @@ -185,20 +185,21 @@ test_expect_success 'log --graph with right-skewed=
 merge following a left-skewed
>
>  	check_graph --date-order <<-\EOF
>  	*   4_H
> -	|\
> +	|\
>  	| *   4_G
> -	| |\
> +	| |\
> +	| | * 4_C
>  	| * | 4_F
> -	|/| |
> +	|/| |
>  	| * |   4_E
> -	| |\ \
> -	| | * | 4_D
> -	| |/ /
> -	|/| |
> -	| | * 4_C
> -	| |/
> +	| |\ \
> +	| | |/
> +	| |/|
> +	| | * 4_D
> +	| |/
> +	|/|
>  	| * 4_B
> -	|/
> +	|/
>  	* 4_A
>  	EOF
>  '
> @@ -221,21 +222,20 @@ test_expect_success 'log --graph with octopus merg=
e with column joining its penu
>
>  	check_graph <<-\EOF
>  	*   5_H
> -	|\
> +	|\
>  	| *-.   5_G
> -	| |\ \
> +	| |\ \
>  	| | | * 5_F
>  	| | * |   5_E
> -	| |/|\ \
> -	| |_|/ /
> -	|/| | /
> -	| | |/
> -	* | | 5_D
> +	| |/|\ \
> +	| |_|/ /
> +	|/| | /
> +	| | |/
>  	| | * 5_C
> -	| |/
> -	|/|
> -	| * 5_B
> -	|/
> +	| * | 5_B
> +	| |/
> +	* / 5_D
> +	|/
>  	* 5_A
>  	EOF
>  '
> diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-orde=
r.sh
> index 24d1836f41..19cb79bc29 100755
> --- a/t/t6003-rev-list-topo-order.sh
> +++ b/t/t6003-rev-list-topo-order.sh
> @@ -87,12 +87,12 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> -a1
>  b3
>  b2
>  b1
> +a3
> +a2
> +a1
>  a0
>  l2
>  l1
> @@ -105,15 +105,15 @@ l5
>  l4
>  l3
>  a4
> -b4
> -a3
> -a2
>  c3
>  c2
> +c1
> +b4
>  b3
>  b2
> -c1
>  b1
> +a3
> +a2
>  a1
>  a0
>  l2
> @@ -127,12 +127,12 @@ l5
>  l4
>  l3
>  a4
> -b4
>  c3
>  c2
> +c1
> +b4
>  b3
>  b2
> -c1
>  b1
>  a3
>  a2
> @@ -205,12 +205,12 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> -a1
>  b3
>  b2
>  b1
> +a3
> +a2
> +a1
>  a0
>  l2
>  EOF
> @@ -224,12 +224,12 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> -a1
>  b3
>  b2
>  b1
> +a3
> +a2
> +a1
>  a0
>  l2
>  EOF
> @@ -237,10 +237,10 @@ EOF
>  test_output_expect_success 'prune near topo' 'git rev-list --topo-order=
 a4 ^c3' <<EOF
>  a4
>  b4
> +b3
>  a3
>  a2
>  a1
> -b3
>  EOF
>
>  test_output_expect_success "head has no parent" 'git rev-list --topo-or=
der  root' <<EOF
> @@ -297,8 +297,8 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> +b3
> +b2
>  EOF
>
>  test_output_expect_success "max-count 10 - non topo order" 'git rev-lis=
t --max-count=3D10 l5' <<EOF
> @@ -376,12 +376,12 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> -a1
>  b3
>  b2
>  b1
> +a3
> +a2
> +a1
>  a0
>  l2
>  l1
> @@ -399,12 +399,12 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> -a1
>  b3
>  b2
>  b1
> +a3
> +a2
> +a1
>  a0
>  l2
>  l1
> @@ -428,12 +428,12 @@ c3
>  c2
>  c1
>  b4
> -a3
> -a2
> -a1
>  b3
>  b2
>  b1
> +a3
> +a2
> +a1
>  a0
>  l2
>  l1
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index a10f0df02b..9f687b6b22 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -122,16 +122,16 @@ check_result () {
>
>  check_result 'L K J I H F E D C G B A' --full-history --topo-order
>  check_result 'L K I H G F E D C B J A' --full-history
> -check_result 'L K I H G F E D C B J A' --full-history --date-order
> -check_result 'L K I H G F E D B C J A' --full-history --author-date-ord=
er
> +check_result 'L K J I H F E D C G B A' --full-history --date-order
> +check_result 'L K J I H F E D C G B A' --full-history --author-date-ord=
er
>  check_result 'K I H E C B A' --full-history -- file
>  check_result 'K I H E C B A' --full-history --topo-order -- file
>  check_result 'K I H E C B A' --full-history --date-order -- file
> -check_result 'K I H E B C A' --full-history --author-date-order -- file
> +check_result 'K I H E C B A' --full-history --author-date-order -- file
>  check_result 'I E C B A' --simplify-merges -- file
>  check_result 'I E C B A' --simplify-merges --topo-order -- file
>  check_result 'I E C B A' --simplify-merges --date-order -- file
> -check_result 'I E B C A' --simplify-merges --author-date-order -- file
> +check_result 'I E C B A' --simplify-merges --author-date-order -- file
>  check_result 'I B A' -- file
>  check_result 'I B A' --topo-order -- file
>  check_result 'I B A' --date-order -- file
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-li=
st-graph-simplify-history.sh
> index f5e6e92f5b..5750c6f0fd 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -235,27 +235,28 @@ test_expect_success '--graph ^C3' '
>  # I don't think the ordering of the boundary commits is really
>  # that important, but this test depends on it.  If the ordering ever ch=
anges
>  # in the code, we'll need to update this test.
> -test_expect_success '--graph --boundary ^C3' '
> +test_expect_success '--graph --boundary --all ^C3' '
>  	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "| |     " >> expected &&
> -	echo "|  \\    " >> expected &&
> -	echo "*-. \\   $A4" >> expected &&
> -	echo "|\\ \\ \\  " >> expected &&
> -	echo "| * | | $B2" >> expected &&
> -	echo "| * | | $B1" >> expected &&
> -	echo "* | | | $A3" >> expected &&
> -	echo "o | | | $A2" >> expected &&
> -	echo "|/ / /  " >> expected &&
> -	echo "o / / $A1" >> expected &&
> -	echo " / /  " >> expected &&
> -	echo "| o $C3" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "o $C2" >> expected &&
> +	cat >> expected <<-TESTDATA &&
> +	* $A7
> +	*   $A6
> +	|\
> +	| * $C4
> +	* | $A5
> +	| |
> +	|  \
> +	*-. \   $A4
> +	|\ \ \
> +	| * | | $B2
> +	| * | | $B1
> +	* | | | $A3
> +	| | | o $C3
> +	| | |/
> +	| | o $C2
> +	o | $A2
> +	|/
> +	o $A1
> +	TESTDATA
>  	git rev-list --graph --boundary --all ^C3 > actual &&
>  	test_cmp expected actual
>  	'
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index b24d850036..a6d389c4fd 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -339,6 +339,8 @@ test_expect_success 'rev-list: ancestry-path topo-or=
der' '
>  	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..=
commit-6-6
>  '
>
> +# TODO get rid of the "sort" below
> +# if commitGraph is enabled then sort_in_topological_order is not envok=
ed
>  test_expect_success 'rev-list: symmetric difference topo-order' '
>  	git rev-parse \
>  		commit-6-6 commit-5-6 commit-4-6 \
> @@ -349,8 +351,8 @@ test_expect_success 'rev-list: symmetric difference =
topo-order' '
>  		commit-6-1 commit-5-1 commit-4-1 \
>  		commit-3-8 commit-2-8 commit-1-8 \
>  		commit-3-7 commit-2-7 commit-1-7 \
> -	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
> +	| sort >expect &&
> +	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6 | so=
rt
>  '
>
>  test_expect_success 'get_reachable_subset:all' '
> --
> gitgitgadget
>
>
