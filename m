Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A6BC83F14
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjH1XHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjH1XGz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:06:55 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE81013E
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:06:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58d41109351so65063627b3.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693264012; x=1693868812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nt3cWpyDWkBNF2UMZGQZeSRzSe7Ah6X6bjBbYZ1eamo=;
        b=dwzy2BKLRGg8K4T05n9SUpq5al19OU9NDXn2Zd3HgOGX2lZrnW2DCE7UgW2aR5Lfe0
         /J45UbFTB+3Xmh92ryMzd90jZvQAAjKfuBuf20iGXljOkIWUQMzIplggB870eJ1rNDAb
         3/f3QVK3LkC+7MC+8SrrLt7xxmbv6Xo3WdsG+7S7MSgtLxfpOD4LT8z5NOUJdDPLWszs
         SGBBwnz7glJai1yIautdFFc7QQzvcKJCRJSHhSk+U3/d80i23ILjM5v/RY8/YMwimNXY
         Em/Ea7NyQHoON94TbclYF8ZWB6qfDxarY3/zqkDDvUe003sZic+E+CDqbzbmPuMy4Orf
         cuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693264012; x=1693868812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt3cWpyDWkBNF2UMZGQZeSRzSe7Ah6X6bjBbYZ1eamo=;
        b=Khq9uAPWcXRi8yXx53mk1LcqsgDTeppQ1iSkABMVwWpG5SzFPyAMPHav+EBrdCRj5Q
         Yr4/wU9l30PhWASgrI0t3GWGYHfFd/BxmPsyQGxF1oEfPxxtFlsKTl2xhOLDGpJgEjy+
         B1+/gjcNiS75zFLNVyzfqp1lhx6P6sU07+p5iRVTo9Le/qacu8qPmlCFJ41DyxG8IKy2
         F3at7oMUMPufzvhpHDxpKTbF8A0vZFeBxqMxLOr/5j4cwqGKettRO7RyXnIZGtzMm+AU
         oI8liwLpTjB4PjS6DwqJbbbrrdsfkbGQNvIuZ2iA9gA1IACsjSxyj+7OnvpyOUtKIEk3
         nryw==
X-Gm-Message-State: AOJu0YzCh0yXMnEpI/yUUF6qdHmI5f8tiNqS2rg+83KHOeW3orpCDpev
        LTqJN9N4xnI5Ub9SObr5kyz0mQ==
X-Google-Smtp-Source: AGHT+IFzeWjAJ9jqzZNUpl6gR2uGjdVDxidkhSZNpuz9Yh0ery6j2Si8INfsoWTps4/yY6GPC7bC/A==
X-Received: by 2002:a0d:db05:0:b0:583:821b:603a with SMTP id d5-20020a0ddb05000000b00583821b603amr1331709ywe.20.1693264011939;
        Mon, 28 Aug 2023 16:06:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j185-20020a0de0c2000000b00559fb950d9fsm2444345ywe.45.2023.08.28.16.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:06:51 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:06:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 01/22] sequencer: use repository parameter in
 short_commit_name()
Message-ID: <ZO0oit19WhJuvhH8@nand.local>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214629.GA3831137@coredump.intra.peff.net>
 <xmqqsf82g65k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf82g65k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 03:21:11PM -0700, Junio C Hamano wrote:
> > @@ -3172,7 +3171,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
> >  		item->offset_in_buf = todo_list->buf.len;
> >  		subject_len = find_commit_subject(commit_buffer, &subject);
> >  		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
> > -			short_commit_name(commit), subject_len, subject);
> > +			short_commit_name(opts->revs->repo, commit),
> > +			subject_len, subject);
> >  		repo_unuse_commit_buffer(the_repository, commit,
> >  					 commit_buffer);
>
> But how do we ascertain that opts->revs->repo is always safe to use
> (iow initialized to a sensible value)?  repo_init_revisions() takes
> a repository as its parameter and the first thing it does is to set
> it to the revs->repo, so it is safe for any "struct rev_info" that
> came from there, but REV_INFO_INIT omits initializer for the .repo
> member.
>
> The other two calls in this loop refer to the_repository so the
> current code would be safe even if opts->revs->repo is set or NULL,
> but that will no longer be true with the updated code.  I'd feel
> safer if at the beginning of the function we create a local variable
> "struct rev_info *repo" that is initialized to opts->revs->repo and
> use it throughout the function instead of the_repository.

This call comes from sequencer_pick_revisions() ->
walk_revs_populate_todo(), where opts is passed in from the caller of
the former function.

The sole caller of that function is run_sequencer() in builtin/revert.c.
The relevant portion of that function is:

    if (cmd) {
        opts->revs = NULL;
    } else {
        struct setup_revision_opt s_r_opt;
        opts->revs = xmalloc(sizeof(*opts->revs));
        repo_init_revisions(the_repository, opts->revs, NULL);
        opts->revs->no_walk = 1;
        opts->revs->unsorted_input = 1;
        /* ... */
    }

So as long as we end up in the else arm of this conditional, we'll have
called repo_init_revisions(), causing opts->revs->repo to be equal to
the_repository.

Thankfully, we have an assert(opts->revs) at the beginning of
sequencer_pick_revisions(), so we know that we always take the else arm
on this particular call path.

...but, sequencer_pick_revisions() itself takes a repository pointer, so
we could equally use that, or drop it, like so:

--- 8< ---
diff --git a/builtin/revert.c b/builtin/revert.c
index e6f9a1ad26..29e215c72a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -224,7 +224,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		return sequencer_rollback(the_repository, opts);
 	if (cmd == 's')
 		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	return sequencer_pick_revisions(opts);
 }

 int cmd_revert(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index 48475d1cc6..bc7e687623 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5201,14 +5201,15 @@ static int single_pick(struct repository *r,
 	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }

-int sequencer_pick_revisions(struct repository *r,
-			     struct replay_opts *opts)
+int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id oid;
+	struct repository *r;
 	int i, res;

 	assert(opts->revs);
+	r = opts->revs->repo;
 	if (read_and_refresh_cache(r, opts))
 		return -1;

diff --git a/sequencer.h b/sequencer.h
index 913a0f652d..10caa3dc93 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -158,8 +158,7 @@ void todo_list_filter_update_refs(struct repository *r,

 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
-int sequencer_pick_revisions(struct repository *repo,
-			     struct replay_opts *opts);
+int sequencer_pick_revisions(struct replay_opts *opts);
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
--- >8 ---

though it makes for an awkward API to have all of the other
sequencer-related functions take as their first argument a pointer to a
repository struct, leaving sequencer_pick_revisions() as the odd one
out.

So I'd probably just as soon drop that and do what Junio suggests:

--- 8< ---
diff --git a/sequencer.c b/sequencer.c
index 82dc3e160e..6c06b8e1bb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3143,22 +3143,24 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 }

 static int walk_revs_populate_todo(struct todo_list *todo_list,
-				struct replay_opts *opts)
+				   struct replay_opts *opts)
 {
 	enum todo_command command = opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT;
 	const char *command_string = todo_command_info[command].str;
 	const char *encoding;
 	struct commit *commit;
+	struct repository *r;

 	if (prepare_revs(opts))
 		return -1;
+	r = opts->revs->repo;

 	encoding = get_log_output_encoding();

 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = repo_logmsg_reencode(the_repository,
+		const char *commit_buffer = repo_logmsg_reencode(r,
 								 commit, NULL,
 								 encoding);
 		const char *subject;
@@ -3173,8 +3175,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
 			short_commit_name(opts->revs->repo, commit),
 			subject_len, subject);
-		repo_unuse_commit_buffer(the_repository, commit,
-					 commit_buffer);
+		repo_unuse_commit_buffer(r, commit, commit_buffer);
 	}

 	if (!todo_list->nr)
--- >8 ---

> > @@ -5564,7 +5564,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >  		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> >  			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
> >  				warning(_("skipped previously applied commit %s"),
> > -					short_commit_name(commit));
> > +					short_commit_name(revs->repo, commit));
> >  			skipped_commit = 1;
> >  			continue;
> >  		}
>
> This one I am fairly certain is a safe and correct conversion; the
> function would be segfaulting in its call to get_revision() if
> revs->repo were set to a bogus value.

Agreed.

Thanks,
Taylor
