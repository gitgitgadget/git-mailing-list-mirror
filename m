Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95FC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 09:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCGJza (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjCGJzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 04:55:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129052F53
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 01:54:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s11so49892015edy.8
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 01:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678182878;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iliqePgAV9hhzfmbe8IgjDy2Itu5cOypEvfesDUIG4I=;
        b=qZf0eBUEGmQrcZ8g1dur+ZH6PN248INp48ymj+IpXVk0qDaflc575RDJxBhBANLNvY
         nTb21DtweEDep3ayZCk6obPIT8z3Z1mqKIIpfmfBl6kEbr+rUjkaWrEl4Udsrj4GeE//
         xfsNiznyjn9qcoWfU+OZ++dVAY7PlLmNPyiEW2nEHT0JlpUNc+D/TLS7V2Pziz03anO5
         c19+tfVIIHl/GreRf6hoIV2T+jwPSCX0u6aq2A63DZ9hVmUR2KREbtxk7OfmYzXwAr/q
         Tb5UyxW7YXqN3B5b3lWctnx8HdMspR21IB4OGQV3xDL7Ufyj9jX678q50z62j8dWG6ib
         qNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182878;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iliqePgAV9hhzfmbe8IgjDy2Itu5cOypEvfesDUIG4I=;
        b=H9dOG88YSylVIKh/pYzBOmkX4Gdsxz7KxkE83L++TwXnHJEyKheEU7Gg3GXnfrZn+f
         HbLObTbAZMEJ8qG34IAnUIteB9xDbwMh3tA1zXYjKPXmruPS/8CsNa642sxzbJQoz5QT
         D1840G7DLSEdvKLO61v124dTkVkzNAIUBTXN0cp7ulaBsG0XI+1Mp1F8oVIttB1UcIIX
         wAF7i2V6ecUdks4S+Q+vpHpkXYTgYVmk1Jh5fsp1IlHjMqWKi+YvzvReGkx4Ppz7tJB2
         fK/G9KTTRhtnxaSK+cD+nrnZmtNmlKwu5QAIcO8wxO6aCn7FKraYfI7GZCxUWCPmgc2Q
         vpDw==
X-Gm-Message-State: AO0yUKX7ZnhNW7Wvtz7w6yFx6M2mYbKxHD2omaWMaFCoaJRh4aesHKVo
        zFcFnyCGEJpoN1cPMlI9L5ACm21nRVU=
X-Google-Smtp-Source: AK7set9kp7b98w4vGS9NFxKICfzhlFb3rdBI6lHUndf6M7U8MkZGkVw2FWOCelWui/JczjLzJMi/dQ==
X-Received: by 2002:a17:907:6f18:b0:8f8:5779:f1af with SMTP id sy24-20020a1709076f1800b008f85779f1afmr14788884ejc.15.1678182877592;
        Tue, 07 Mar 2023 01:54:37 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v8-20020a50c408000000b004c09f0ba24dsm6440993edf.48.2023.03.07.01.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 01:54:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZU1k-000aLd-1U;
        Tue, 07 Mar 2023 10:54:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v9 6/6] diff-lib: parallelize run_diff_files for submodules
Date:   Tue, 07 Mar 2023 09:41:28 +0100
References: <20230209000212.1892457-1-calvinwan@google.com>
 <20230302215237.1473444-1-calvinwan@google.com>
 <20230302220251.1474923-6-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230302220251.1474923-6-calvinwan@google.com>
Message-ID: <230307.86a60o28f7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 02 2023, Calvin Wan wrote:

Some of this is stuff I probably should have noted in earlier rounds,
sorry, but then again the diff-churn in those made it harder to review,
now that that's mostly out of the way (yay!) ....

> +submodule.diffJobs::
> +	Specifies how many submodules are diffed at the same time. A
> +	positive integer allows up to that number of submodules diffed
> +	in parallel. A value of 0 will give some reasonable default.
> +	If unset, it defaults to 1. The diff operation is used by many

Nit: Maybe start a new paragraph as of "The diff..."?

> +	other git commands such as add, merge, diff, status, stash and
> +	more. Note that the expensive part of the diff operation is

Nit: Maybe change 'add', 'merge' etc. to linkgit:git-add[1], or quote
them?

> +	reading the index from cache or memory. Therefore multiple jobs

With how much we conflate "the cache" and "index" saying "the index from
cache" might be especially confusing. I think we can just skip " from
cache or memory" here.

>  static int match_stat_with_submodule(struct diff_options *diffopt,
>  				     const struct cache_entry *ce,
>  				     struct stat *st, unsigned ce_option,
> -				     unsigned *dirty_submodule)
> +				     unsigned *dirty_submodule, int *defer_submodule_status,

Nit: The other one is an "unsigned", shouldn't "defer_submodule_status"
also be (more on this below).

> +				     unsigned *ignore_untracked)
>  {
>  	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> +	int defer = 0;
> +
>  	if (S_ISGITLINK(ce->ce_mode)) {
>  		struct diff_flags orig_flags = diffopt->flags;
>  		if (!diffopt->flags.override_submodule_config)
>  			set_diffopt_flags_from_submodule_config(diffopt, ce->name);

The meaty functional change here looks *much* better, thanks! I.e. this
is pretty much what I suggested in
https://lore.kernel.org/git/230208.861qn01s4g.gmgdl@evledraar.gmail.com/

> -		if (diffopt->flags.ignore_submodules)
> +		if (diffopt->flags.ignore_submodules) {

Not worth a re-roll in itself, but FWIW I think this change would be
marginally easier to follow with *a* preceding refactoring change, but
per the above &
https://lore.kernel.org/git/230209.867cwrzk1l.gmgdl@evledraar.gmail.com/
I just didn't think v7's 6/7
(https://lore.kernel.org/git/20230207181706.363453-7-calvinwan@google.com/)
was what we needed there.

I.e. in this case a leading change that would add these braces would
make this a bit easier to read...

>  			changed = 0;
> -		else if (!diffopt->flags.ignore_dirty_submodules &&

...ditto this line, which would stay the same.

> -			 (!changed || diffopt->flags.dirty_submodules))
> -			*dirty_submodule = is_submodule_modified(ce->name,
> -								 diffopt->flags.ignore_untracked_in_submodules);

Here you are incorrectly changing the indentation of this away from our
usual coding style, which...

> +		} else if (!diffopt->flags.ignore_dirty_submodules &&
> +			   (!changed || diffopt->flags.dirty_submodules)) {
> +			if (defer_submodule_status && *defer_submodule_status) {

Hrm, if if I remove that "&& *defer_submodule_status" all of our tests
pass, the only two callers of this function are one where this is NULL,
and where it's non-NULL but pre-initilized to 1, and the caller will
check if it's then flipped to 0.

> +				defer = 1;
> +				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
> +			} else {
> +				*dirty_submodule = is_submodule_modified(ce->name,
> +					 diffopt->flags.ignore_untracked_in_submodules);

...needlessly inflates the diff here, at least under -w and move
detection, as we correctly detect the "*dirty_submodule" line as the
same, but the "diffopt->flags" line also has a re-indentation change
unrelated to adding the "else" scope.

> +			}
> +		}
>  		diffopt->flags = orig_flags;
>  	}
> +
> +	if (defer_submodule_status)
> +		*defer_submodule_status = defer;

Having read this whole thing to the end again I think this on top would
be much simpler (if I'm right about it being functionally equivalent),
and would address some of the above:
	
	diff --git a/diff-lib.c b/diff-lib.c
	index 7fe6ced9501..d5c823f512a 100644
	--- a/diff-lib.c
	+++ b/diff-lib.c
	@@ -78,7 +78,6 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
	 				     unsigned *ignore_untracked)
	 {
	 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
	-	int defer = 0;
	 
	 	if (S_ISGITLINK(ce->ce_mode)) {
	 		struct diff_flags orig_flags = diffopt->flags;
	@@ -88,8 +87,8 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
	 			changed = 0;
	 		} else if (!diffopt->flags.ignore_dirty_submodules &&
	 			   (!changed || diffopt->flags.dirty_submodules)) {
	-			if (defer_submodule_status && *defer_submodule_status) {
	-				defer = 1;
	+			if (defer_submodule_status) {
	+				*defer_submodule_status = 1;
	 				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
	 			} else {
	 				*dirty_submodule = is_submodule_modified(ce->name,
	@@ -99,8 +98,6 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
	 		diffopt->flags = orig_flags;
	 	}
	 
	-	if (defer_submodule_status)
	-		*defer_submodule_status = defer;
	 	return changed;
	 }
	 
	@@ -153,7 +150,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
	 		unsigned int newmode;
	 		struct cache_entry *ce = istate->cache[i];
	 		int changed;
	-		int defer_submodule_status = 1;
	+		int defer_submodule_status = 0;
	 
	 		if (diff_can_quit_early(&revs->diffopt))
	 			break;

We could also just leave it, but I for one found it a bit hard to follow
that this interface seems to be a tri-state (NULL, set to 0, set to 1),
but really it's dual-state, i.e. NULL or a "tell me to defer this" bit.
	
>  	return changed;
>  }
>  
> @@ -124,6 +140,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			      ? CE_MATCH_RACY_IS_DIRTY : 0);
>  	uint64_t start = getnanotime();
>  	struct index_state *istate = revs->diffopt.repo->index;
> +	struct string_list submodules = STRING_LIST_INIT_NODUP;
>  
>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>  
> @@ -136,7 +153,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		unsigned int newmode;
>  		struct cache_entry *ce = istate->cache[i];
>  		int changed;
> -		unsigned dirty_submodule = 0;
> +		int defer_submodule_status = 1;

Hrm, having suggested the diff above I just noticed this now, I ended up
inverting this, but found the "defer_submodule_status" name a bit odd,
can't we just keep "unsigned dirty_submodule"? (that would also address
the change from "unsigned" to "int" noted above, which is seeminly
unnecessary).

But maybe I'm missing a subtlety here, and we should have "deferred
status" as apposed to "dirty submodule", but in any case the new one
looks like it doesn't need negative values.

> +	}
> +	if (submodules.nr) {
> +		unsigned long parallel_jobs;
> +		struct string_list_item *item;
> +
> +		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
> +			parallel_jobs = 1;
> +		else if (!parallel_jobs)
> +			parallel_jobs = online_cpus();

Given that online_cpus() returns int the "unsigned long" is slightly odd
here, but it's because git_config_get_ulong() exist, but we have no
git_config_get_uint(), so this is OK (but could be cleaned up as some
#leftoverbits).

> +		if (get_submodules_status(&submodules, parallel_jobs))
> +			die(_("submodule status failed"));

Here we're adding get_submodules_status(), and returning the actual
error code from "status", but then ignoring it here, and returning 128
for any non-zero.

I think this would be better as either:

	code = get_submodules_status(...);
	die_message(...)
	exit(code);

Or to just have the function itself return !!status, i.e. a "ok" or "not
ok".

Admittedly a nit, but I have spent quite a bit of time chasing down
various exit-code losses in the submodule code, and it would be nice if
we just carry the code up, or more explicitly ignore it, but don't add
code that seems to care about it, but really doesn't.

I also changed this "die" to a "BUG" and our tests passed, so we have no
tests for when "status" failed, will such a thing even happen in
practice?

> +		for_each_string_list_item(item, &submodules) {
> +			struct submodule_status_util *util = item->util;
> +
> +			record_file_diff(&revs->diffopt, util->newmode,
> +					 util->dirty_submodule, util->changed,
> +					 istate, util->ce);
> +		}
>  	}
> +	string_list_clear(&submodules, 1);
>  	diffcore_std(&revs->diffopt);
>  	diff_flush(&revs->diffopt);
>  	trace_performance_since(start, "diff-files");
> @@ -322,7 +379,7 @@ static int get_stat_data(const struct index_state *istate,
>  			return -1;
>  		}
>  		changed = match_stat_with_submodule(diffopt, ce, &st,
> -						    0, dirty_submodule);
> +						    0, dirty_submodule, NULL, NULL);
>  		if (changed) {
>  			mode = ce_mode_from_stat(ce, st.st_mode);
>  			oid = null_oid();
> diff --git a/submodule.c b/submodule.c
> index 426074cebb..6f6e150a3f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1373,6 +1373,13 @@ int submodule_touches_in_range(struct repository *r,
>  	return ret;
>  }
>  
> +struct submodule_parallel_status {
> +	size_t index_count;
> +	int result;
> +
> +	struct string_list *submodule_names;
> +};

Hrm, actually reading a bit more I think part of my comments above are
incorrect, i.e. this "result" seems like an exit code, but really in the
guts of the API we're ignoring the actual code we get, and just setting
this to 1.

Per the above I think it might be OK to ignore the exit code (or not),
but I really wish we did this more explicitly, e.g. if you want to
ignore it call this something like "failed", not "result", and make it
an "unsigned int failed:1" to firmly indicate that it's a boolean at the
API level.

> +struct status_task {
> +	const char *path;

I think we should call this "ce_path", but more on that below.

> +	struct strbuf out;
> +	int ignore_untracked;

Continued type mismatch commentary: Elsewhere in this diff this is
"unsigned", and this compiles for me if I make it "unsigned int
ignore_untracked:1", so let's set it to such a flag instead?

> +static int status_finish(int retvalue, struct strbuf *err,
> +			 void *cb, void *task_cb)
> +{
> +	struct submodule_parallel_status *sps = cb;
> +	struct status_task *task = task_cb;
> +	struct string_list_item *it =
> +		string_list_lookup(sps->submodule_names, task->path);
> +	struct submodule_status_util *util = it->util;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +
> +	if (retvalue) {
> +		sps->result = 1;
> +		strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);
> +	}
> +
> +	string_list_split(&list, task->out.buf, '\n', -1);

I think I noted in some earlier round that taking a string and splitting
it by \n was a bit wasteful in the test code, but this uses the same
pattern.

Maybe it's not a performance concern here either, but won't we
potentially have to parse some very large statuses here?

Aside from that, I haven't tried or reviewed this bit in detail, but
this seems to be making things harder than they need to be. Why are we
buffering up all of the output into "out" here, only to split it by "\n"
later on, and then consider each line as a status line?

Shouldn't we be allocating this string_list to begin with, and append to
it in the "status_on_stderr_output" callback instead?

> +	for_each_string_list_item(item, &list) {
> +		if (parse_status_porcelain(item->string,
> +					   strlen(item->string),
> +					   &util->dirty_submodule,
> +					   util->ignore_untracked))

OK, this seemingly buggy bit of error handling seems to actually be OK
on further review, because we'll BUG() out in the function if it fails,
so the non-zero return here just means "we're done here".

> +			break;
> +	}

Style: drop the braces here, as this is just a for/if/body with a single
body line.

> +int get_submodules_status(struct string_list *submodules,
> +			  int max_parallel_jobs)
> +{
> +	struct submodule_parallel_status sps = {
> +		.submodule_names = submodules,
> +	};
> +	const struct run_process_parallel_opts opts = {
> +		.tr2_category = "submodule",
> +		.tr2_label = "parallel/status",
> +
> +		.processes = max_parallel_jobs,
> +
> +		.get_next_task = get_next_submodule_status,
> +		.start_failure = status_start_failure,
> +		.on_stderr_output = status_on_stderr_output,
> +		.task_finished = status_finish,
> +		.data = &sps,
> +	};
> +
> +	string_list_sort(sps.submodule_names);
> +	run_processes_parallel(&opts);
> +
> +	return sps.result;

All OK, except as noted above the "result" here is just "did we fail?".

> +}
> +
>  int submodule_uses_gitfile(const char *path)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> diff --git a/submodule.h b/submodule.h
> index b52a4ff1e7..08d278a414 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -41,6 +41,13 @@ struct submodule_update_strategy {
>  	.type = SM_UPDATE_UNSPECIFIED, \
>  }
>  
> +struct submodule_status_util {
> +	int changed, ignore_untracked;
> +	unsigned dirty_submodule, newmode;
> +	struct cache_entry *ce;
> +	const char *path;

Re "ce_path" above: What's the point of adding a "path" here if we
already have "ce"? You just seem to assign "path" to "ce->name"
always. I tried this fix-up on top & it worked:
	
	diff --git a/diff-lib.c b/diff-lib.c
	index d5c823f512a..39d8179f0ed 100644
	--- a/diff-lib.c
	+++ b/diff-lib.c
	@@ -294,7 +294,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
	 					.ignore_untracked = ignore_untracked,
	 					.newmode = newmode,
	 					.ce = ce,
	-					.path = ce->name,
	 				};
	 				struct string_list_item *item;
	 
	diff --git a/submodule.c b/submodule.c
	index 3eba00f1533..c220d85815a 100644
	--- a/submodule.c
	+++ b/submodule.c
	@@ -2002,11 +2002,11 @@ get_status_task_from_index(struct submodule_parallel_status *sps,
	 		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
	 		struct status_task *task;
	 
	-		if (!verify_submodule_git_directory(util->path))
	+		if (!verify_submodule_git_directory(util->ce->name))
	 			continue;
	 
	 		task = xmalloc(sizeof(*task));
	-		task->path = util->path;
	+		task->path = util->ce->name;
	 		task->ignore_untracked = util->ignore_untracked;
	 		strbuf_init(&task->out, 0);
	 		sps->index_count++;
	diff --git a/submodule.h b/submodule.h
	index 3b6abca05cd..3427c495573 100644
	--- a/submodule.h
	+++ b/submodule.h
	@@ -45,7 +45,6 @@ struct submodule_status_util {
	 	int changed, ignore_untracked;
	 	unsigned dirty_submodule, newmode;
	 	struct cache_entry *ce;
	-	const char *path;
	 };
	 
	 int is_gitmodules_unmerged(struct index_state *istate);

I'd be all for actually narrowing the scope of data we get in general,
i.e. do we need all of the "ce" members? I didn't check, but doing this
just seems like needless duplication.

> @@ -94,6 +101,8 @@ int fetch_submodules(struct repository *r,
>  		     int command_line_option,
>  		     int default_option,
>  		     int quiet, int max_parallel_jobs);
> +int get_submodules_status(struct string_list *submodules,
> +			  int max_parallel_jobs);

It would be nice to get some API docs for the new function, re its
"result" behavior etc. noted above

>  unsigned is_submodule_modified(const char *path, int ignore_untracked);
>  int submodule_uses_gitfile(const char *path);
>  
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index 40164ae07d..1c747cc325 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -34,6 +34,25 @@ test_expect_success setup '
>  	subtip=$3 subprev=$2
>  '
>  
> +test_expect_success 'diff in superproject with submodules respects parallel settings' '
> +	test_when_finished "rm -f trace.out" &&
> +	(
> +		GIT_TRACE=$(pwd)/trace.out git diff &&
> +		grep "1 tasks" trace.out &&
> +		>trace.out &&
> +
> +		git config submodule.diffJobs 8 &&
> +		GIT_TRACE=$(pwd)/trace.out git diff &&
> +		grep "8 tasks" trace.out &&
> +		>trace.out &&
> +
> +		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 diff &&
> +		grep "preparing to run up to [0-9]* tasks" trace.out &&
> +		! grep "up to 0 tasks" trace.out &&
> +		>trace.out
> +	)
> +'
> +
>  test_expect_success 'git diff --raw HEAD' '
>  	hexsz=$(test_oid hexsz) &&
>  	git diff --raw --abbrev=$hexsz HEAD >actual &&
> @@ -70,6 +89,18 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree)' '
>  	test_cmp expect.body actual.body
>  '
>  
> +test_expect_success 'git diff HEAD with dirty submodule (work tree, parallel)' '
> +	(
> +		cd sub &&
> +		git reset --hard &&
> +		echo >>world
> +	) &&
> +	git -c submodule.diffJobs=8 diff HEAD >actual &&
> +	sed -e "1,/^@@/d" actual >actual.body &&
> +	expect_from_to >expect.body $subtip $subprev-dirty &&
> +	test_cmp expect.body actual.body
> +'
> +
>  test_expect_success 'git diff HEAD with dirty submodule (index)' '
>  	(
>  		cd sub &&
> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index d050091345..7da64e4c4c 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -412,4 +412,29 @@ test_expect_success 'status with added file in nested submodule (short)' '
>  	EOF
>  '
>  
> +test_expect_success 'status in superproject with submodules respects parallel settings' '
> +	test_when_finished "rm -f trace.out" &&
> +	(
> +		GIT_TRACE=$(pwd)/trace.out git status &&
> +		grep "1 tasks" trace.out &&
> +		>trace.out &&
> +
> +		git config submodule.diffJobs 8 &&
> +		GIT_TRACE=$(pwd)/trace.out git status &&
> +		grep "8 tasks" trace.out &&
> +		>trace.out &&
> +
> +		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 status &&
> +		grep "preparing to run up to [0-9]* tasks" trace.out &&
> +		! grep "up to 0 tasks" trace.out &&
> +		>trace.out
> +	)
> +'
> +
> +test_expect_success 'status in superproject with submodules (parallel)' '
> +	git -C super status --porcelain >output &&
> +	git -C super -c submodule.diffJobs=8 status --porcelain >output_parallel &&
> +	diff output output_parallel

Shouldn't this be a "test_cmp" instead of "diff", and use "actual" and
"expect" instead of "output" and "output_parallel"?

I'd also rename the test to something like "output with
submodule.diffJobs=N equals submodule.diffJobs=1".

Except is that even correct? Don't we need to set submodule.diffJobs=1
explicitly so it doesn't default to online_cpus() here? Maybe I missed
an earlier config setup...
