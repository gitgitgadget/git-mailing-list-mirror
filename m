Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D9F211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 03:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeLEDKz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 22:10:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54869 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 22:10:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FFBA11802D;
        Tue,  4 Dec 2018 22:10:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vu4eXXjmhrckUJCU3HzhG5MDjhU=; b=hEtU7L
        PF1PtVQm5e15yfgGkl9fGk+wV0EIP5ogxsEk8IiPC613A9RD/2hCPdPMxtI4GyHo
        cnCrwv0Pzvj3E5oSbFjHCeuHQKYK2h6vrAIq+0h3LyzNPjLwC+HYsK3so4Wf6/p/
        jiVEx8y6vU8D8TxOV+nTEWzdB9o7B+ueDMyd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R/elkh856p0r/98ol4DbOjxNQv25iBQy
        Z3S2smwqDadu4XieJiA7aSE7n232i0Oz/9ST1d+bAYl5VYSAiw/NJHbJjpakLXGN
        xDIKwANUx0JnwJ40TPHIDtYVzAYQXUWoCro68aOyTrpV7br7MBEcFaXAqnKq3eYH
        Xg3SWgZbOBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56FF711802C;
        Tue,  4 Dec 2018 22:10:46 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C03E611802B;
        Tue,  4 Dec 2018 22:10:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCHv2 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
References: <20181129002756.167615-1-sbeller@google.com>
Date:   Wed, 05 Dec 2018 12:10:44 +0900
In-Reply-To: <20181129002756.167615-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 28 Nov 2018 16:27:47 -0800")
Message-ID: <xmqqa7lkeki3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B942004-F83B-11E8-8FA8-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is a resend of sb/submodule-recursive-fetch-gets-the-tip,
> with all feedback addressed. As it took some time, I'll send it
> without range-diff, but would ask for full review.

Is that a "resend" or reroll/update (or whatever word that does not
imply "just sending the same thing again")?

FWIW, here is the range diff between 104f939f27..@{-1} and master..
after replacing the topic with this round.


 3:  304b2dab29 !  3:  08a297bd49 submodule.c: sort changed_submodule_names before searching it
    @@ -28,7 +28,7 @@
     @@
      	/* default value, "--submodule-prefix" and its value are added later */
      
    - 	calculate_changed_submodule_paths();
    + 	calculate_changed_submodule_paths(r);
     +	string_list_sort(&changed_submodule_names);
      	run_processes_parallel(max_parallel_jobs,
      			       get_next_submodule,

Just the call nearby in the context has become repository-aware; no
change in this series.

 4:  f7345dad6d !  4:  16dd6fe133 submodule.c: tighten scope of changed_submodule_names struct
...
    ++	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
     +	string_list_sort(&spf.changed_submodule_names);
      	run_processes_parallel(max_parallel_jobs,
      			       get_next_submodule,

I do recall having to do these adjustments while merging, so not
having to do so anymore with rebasing is a welcome change ;-)

 5:  5613d81d1e !  5:  bcd7337243 submodule: store OIDs in changed_submodule_names
...
Likewise.

 7:  e2419f7e30 !  7:  26f80ccfc1 submodule: migrate get_next_submodule to use repository structs
    @@ -4,7 +4,8 @@
     
         We used to recurse into submodules, even if they were broken having
         only an objects directory. The child process executed in the submodule
    -    would fail though if the submodule was broken.
    +    would fail though if the submodule was broken. This is tested via
    +    "fetching submodule into a broken repository" in t5526.
     
         This patch tightens the check upfront, such that we do not need
         to spawn a child process to find out if the submodule is broken.
    @@ -34,6 +35,7 @@
     +		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
     +		if (repo_init(ret, gitdir.buf, NULL)) {
     +			strbuf_release(&gitdir);
    ++			free(ret);
     +			return NULL;

Leakfix?  Good.

     +		}
     +		strbuf_release(&gitdir);
    @@ -75,11 +77,10 @@
     +		if (repo) {
      			child_process_init(cp);
     -			cp->dir = strbuf_detach(&submodule_path, NULL);
    - 			prepare_submodule_repo_env(&cp->env_array);
     +			cp->dir = xstrdup(repo->worktree);
    + 			prepare_submodule_repo_env(&cp->env_array);

Hmph, I offhand do not see there would be any difference if you
assigned to cp->dir before or after preparing the repo env, but is
there a reason these two must be done in this updated order that I
am missing?  Very similar changes appear multiple times in this
range-diff.

      			cp->git_cmd = 1;
      			if (!spf->quiet)
    - 				strbuf_addf(err, "Fetching submodule %s%s\n",
     @@
      			argv_array_push(&cp->args, default_argv);
      			argv_array_push(&cp->args, "--submodule-prefix");
    @@ -94,8 +95,12 @@
     +			 * the submodule is not initialized
     +			 */
     +			if (S_ISGITLINK(ce->ce_mode) &&
    -+			    !is_empty_dir(ce->name))
    -+				die(_("Could not access submodule '%s'"), ce->name);
    ++			    !is_empty_dir(ce->name)) {
    ++				spf->result = 1;
    ++				strbuf_addf(err,
    ++					    _("Could not access submodule '%s'"),
    ++					    ce->name);
    ++			}

OK, not dying but returning to the caller to handle the error.

 9:  7454fe5cb6 !  9:  04eb06607b fetch: try fetching submodules if needed objects were not fetched
    @@ -17,11 +17,6 @@
         Try fetching a submodule by object id if the object id that the
         superproject points to, cannot be found.
     
    -    The try does not happen when the "git fetch" done at the
    -    superproject is not storing the fetched results in remote
    -    tracking branches (i.e. instead just recording them to
    -    FETCH_HEAD) in this step. A later patch will fix this.
    -
         builtin/fetch used to only inspect submodules when they were fetched
         "on-demand", as in either on/off case it was clear whether the submodule
         needs to be fetched. However to know whether we need to try fetching the
    @@ -29,6 +24,10 @@
         function check_for_new_submodule_commits(), so we'll also run that code
         in case the submodule recursion is set to "on".
     
    +    The submodule checks were done only when a ref in the superproject
    +    changed, these checks were extended to also be performed when fetching
    +    into FETCH_HEAD for completeness, and add a test for that too.
    +

OK.

         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ -41,30 +40,39 @@
      
...

The range-diff output for this step is unreadble for me, but the
code around this area does not seem to appear in the comparison
between the result of applying these directly to master and the
result of merging the previous round to master, so perhaps this is
just an indication that later follow-up fix has been squashed into
this step or something, which I shouldn't have to worry about.

      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
    @@ -73,8 +81,10 @@
      	int result;
      
      	struct string_list changed_submodule_names;
    -+	struct get_next_submodule_task **fetch_specific_oids;
    -+	int fetch_specific_oids_nr, fetch_specific_oids_alloc;
    ++
    ++	/* The submodules to fetch in */
    ++	struct fetch_task **oid_fetch_tasks;
    ++	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;

OK.  The task struct has been renamed and the new name makes more
sense ("getting the next submodule" is less important than "what we
are going to do to that submodule").

...      
    -+struct get_next_submodule_task {
    ++struct fetch_task {
     +	struct repository *repo;
     +	const struct submodule *sub;
     +	unsigned free_sub : 1; /* Do we need to free the submodule? */
...
     +	return (const struct submodule *) ret;
     +}
     +
    -+static struct get_next_submodule_task *get_next_submodule_task_create(
    -+	struct repository *r, const char *path)
    ++static struct fetch_task *fetch_task_create(struct repository *r,
    ++					    const char *path)
     +{
    -+	struct get_next_submodule_task *task = xmalloc(sizeof(*task));
    ++	struct fetch_task *task = xmalloc(sizeof(*task));
     +	memset(task, 0, sizeof(*task));
     +
     +	task->sub = submodule_from_path(r, &null_oid, path);
     +	if (!task->sub) {
    -+		task->sub = get_default_submodule(path);
    ++		/*
    ++		 * No entry in .gitmodules? Technically not a submodule,
    ++		 * but historically we supported repositories that happen to be
    ++		 * in-place where a gitlink is. Keep supporting them.
    ++		 */
    ++		task->sub = get_non_gitmodules_submodule(path);
    ++		if (!task->sub) {
    ++			free(task);
    ++			return NULL;
    ++		}
    ++
     +		task->free_sub = 1;

OK.

    -+		if (!task->sub) {
    -+			free(task);
    +-		}
    ++		task = fetch_task_create(spf->r, ce->name);
    ++		if (!task)
     +			continue;
    - 		}

OK, so the code used to signal the need to work with the presense of
task->sub but now task's NULLness is used, so no need to free.

    @@ -231,24 +253,26 @@
     +			return 1;
      		} else {
     +
    -+			get_next_submodule_task_release(task);
    ++			fetch_task_release(task);
     +			free(task);
     +

OK.

    -+		/* NEEDSWORK: have get_default_remote from s--h */
    ++		/* NEEDSWORK: have get_default_remote from submodule--helper */

;-)

