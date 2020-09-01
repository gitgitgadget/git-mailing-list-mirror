Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5137C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD562071B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RJ24C1hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgIAW2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIAW2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 18:28:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9CC061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 15:28:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11so2844572ybp.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xmTVw5XP0gGj5hOxoBbMHcATbrADic61fFd/eYzeWt0=;
        b=RJ24C1hGf/2omRe9ckMgqui3oF/3eT8camCtbXT8q9jzHUxwtnw4kf5/U40e16vXfr
         iY+fA3JvAJkURE0+4/52LjRdsYR8plojKcaRS90HIDEP6HYg5USIkY4HsUsQu/lx8tS4
         V8M9jgaHvxwE1mmZ5WDFpg3YIkx9CDU4/4z2nyzfsG/bTW4qO5tKTvBqsMuY3NAwsuUT
         svUduLtaDFCbValtC1+ybXDL3jS/gyWKSe1txoq7386JLHVqOovoSIaESXQ0rduUMewq
         /fSSg6fa/PWx8Pb1JTcUUCPpWq8884JArPodhLCvaKQ3JqlE5tYko6Zx01BAIQR+n8z2
         LS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xmTVw5XP0gGj5hOxoBbMHcATbrADic61fFd/eYzeWt0=;
        b=jiszTp/0dtIPNYwJh2yVsabOusfy/W38wbouW3FVe3iTPRmza81lJwurlD23YcA+fU
         IwM6Vx5V+JOH92SzDD+XB4FsiZfbJDswCUcl6yhyXX9AThh3r0yjd99zp4fdZ326VKPt
         gwXXYZnMH6wxqF/Cwd35QkcO/5AzIAuUAi4LU2PR18p445HZzdkut7Cf8VllMjgc7rDC
         csRnkfR1QbK20DlgOO3eQD4pAbk1o4lzMWc4fIVAFE8lWGw3EqzyU4NByNcc38NH+TxC
         eR+hjvsbGvWnU2oh2GwtMEZRiSzOa5wsxxGgB1SWWl4LmxL4M0gN2U+RUi4D46wREm5w
         ioCw==
X-Gm-Message-State: AOAM531S8ga21t43h2CrfWm0+gEhsXfBFKwjNdLvsEWK9iR0Hik25UAw
        WiJnQrAWQfiyMjwZgWbqlE1bt9BmUsTs9kCtfF2ZC+tVdgSlQqX14n1fC+bLFSd+zWSJSIrGwOl
        4Oz/azn6SJ0ceXk49AZKjUj3qrs1b44d7UHqnN4Fx9L+aWkuBoPbWODwYP1W0eMLhZ+UcmJKiYQ
        g2
X-Google-Smtp-Source: ABdhPJybO2SlFTnaUNkiebPVWX6cqQwKx+9vvtVigNs5GCiMAV47jYpQwXDbnOILCwkGTqYe1bY1HK2DHb3oTr8ybiv0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b443:: with SMTP id
 c3mr6126458ybg.118.1598999294933; Tue, 01 Sep 2020 15:28:14 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:28:06 -0700
In-Reply-To: <20200513004058.34456-1-jonathantanmy@google.com>
Message-Id: <cover.1598998706.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 0/3] Fix for git checkout @{u} (non-local) then git status
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio writes [1]:

> I even wonder why dwim_ref() is not defined like so in a header:
> 
> 	#define dwim_ref(s, l, o, r) \
> 		repo_dwim_ref(the_repository, (s), (l), (o), (r))
> 
> Which would force a change like the one we are discussing to keep
> them in parallel and keep the promise that only difference between
> the two is that dwim_ref() works with the_repository and the other
> can take an arbitrary repository.  Perhaps that can be a preliminary
> clean-up patch before these two patches ;-)

OK done - that's patch 2 here. (I used "static inline" instead of a
preprocessor #define because I prefer not to use the preprocessor whenever
possible, but switching to #define is fine too.)

> Reducing the size of the diff is a good justification only when the
> end result is the same.  If it burdens future developers more, that
> is "I write less at the expense of forcing others to write more",
> which is not quite the same thing.

OK - that makes sense.

[1] https://lore.kernel.org/git/xmqqzh6ag1ih.fsf@gitster.c.googlers.com/

Jonathan Tan (3):
  sha1-name: replace unsigned int with option struct
  refs: move dwim_ref() to header file
  wt-status: tolerate dangling marks

 archive.c             |  4 ++--
 branch.c              |  2 +-
 builtin/checkout.c    |  4 ++--
 builtin/fast-export.c |  2 +-
 builtin/log.c         |  2 +-
 builtin/merge.c       |  2 +-
 builtin/reset.c       |  2 +-
 builtin/rev-parse.c   |  2 +-
 builtin/show-branch.c |  2 +-
 builtin/stash.c       |  2 +-
 bundle.c              |  2 +-
 cache.h               | 27 ++++++++++++++++++--------
 commit.c              |  2 +-
 refs.c                | 20 +++++++++----------
 refs.h                | 12 ++++++++++--
 remote.c              |  2 +-
 revision.c            |  3 ++-
 sha1-name.c           | 45 ++++++++++++++++++++++++++++---------------
 t/t7508-status.sh     | 12 ++++++++++++
 wt-status.c           |  2 +-
 20 files changed, 98 insertions(+), 53 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  6b3e3077e6 refs: move dwim_ref() to header file
1:  59b91a206d ! 2:  8f489d9633 wt-status: tolerate dangling marks
    @@ Commit message
     
         Therefore, when calculating the status of a worktree, tolerate dangling
         marks. This is done by adding an additional parameter to
    -    repo_dwim_ref().
    +    dwim_ref() and repo_dwim_ref().
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    + ## archive.c ##
    +@@ archive.c: static void parse_treeish_arg(const char **argv,
    + 		const char *colon = strchrnul(name, ':');
    + 		int refnamelen = colon - name;
    + 
    +-		if (!dwim_ref(name, refnamelen, &oid, &ref))
    ++		if (!dwim_ref(name, refnamelen, &oid, &ref, 0))
    + 			die(_("no such ref: %.*s"), refnamelen, name);
    + 	} else {
    +-		dwim_ref(name, strlen(name), &oid, &ref);
    ++		dwim_ref(name, strlen(name), &oid, &ref, 0);
    + 	}
    + 
    + 	if (get_oid(name, &oid))
    +
    + ## branch.c ##
    +@@ branch.c: void create_branch(struct repository *r,
    + 		die(_("Not a valid object name: '%s'."), start_name);
    + 	}
    + 
    +-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref)) {
    ++	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
    + 	case 0:
    + 		/* Not branching from any existing branch */
    + 		if (explicit_tracking)
    +
    + ## builtin/checkout.c ##
    +@@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
    + 	 * If this is a ref, resolve it; otherwise, look up the OID for our
    + 	 * expression.  Failure here is okay.
    + 	 */
    +-	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname))
    ++	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname, 0))
    + 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
    + 
    + 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
    +@@ builtin/checkout.c: static void die_expecting_a_branch(const struct branch_info *branch_info)
    + 	struct object_id oid;
    + 	char *to_free;
    + 
    +-	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free) == 1) {
    ++	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
    + 		const char *ref = to_free;
    + 
    + 		if (skip_prefix(ref, "refs/tags/", &ref))
    +
    + ## builtin/fast-export.c ##
    +@@ builtin/fast-export.c: static void get_tags_and_duplicates(struct rev_cmdline_info *info)
    + 		if (e->flags & UNINTERESTING)
    + 			continue;
    + 
    +-		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name) != 1)
    ++		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name, 0) != 1)
    + 			continue;
    + 
    + 		if (refspecs.nr) {
    +
    + ## builtin/log.c ##
    +@@ builtin/log.c: static char *find_branch_name(struct rev_info *rev)
    + 		return NULL;
    + 	ref = rev->cmdline.rev[positive].name;
    + 	tip_oid = &rev->cmdline.rev[positive].item->oid;
    +-	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref) &&
    ++	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref, 0) &&
    + 	    skip_prefix(full_ref, "refs/heads/", &v) &&
    + 	    oideq(tip_oid, &branch_oid))
    + 		branch = xstrdup(v);
    +
    + ## builtin/merge.c ##
    +@@ builtin/merge.c: static void merge_name(const char *remote, struct strbuf *msg)
    + 	if (!remote_head)
    + 		die(_("'%s' does not point to a commit"), remote);
    + 
    +-	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref) > 0) {
    ++	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref, 0) > 0) {
    + 		if (starts_with(found_ref, "refs/heads/")) {
    + 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
    + 				    oid_to_hex(&branch_head), remote);
    +
    + ## builtin/reset.c ##
    +@@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
    + 			char *ref = NULL;
    + 			int err;
    + 
    +-			dwim_ref(rev, strlen(rev), &dummy, &ref);
    ++			dwim_ref(rev, strlen(rev), &dummy, &ref, 0);
    + 			if (ref && !starts_with(ref, "refs/"))
    + 				ref = NULL;
    + 
    +
    + ## builtin/rev-parse.c ##
    +@@ builtin/rev-parse.c: static void show_rev(int type, const struct object_id *oid, const char *name)
    + 			struct object_id discard;
    + 			char *full;
    + 
    +-			switch (dwim_ref(name, strlen(name), &discard, &full)) {
    ++			switch (dwim_ref(name, strlen(name), &discard, &full, 0)) {
    + 			case 0:
    + 				/*
    + 				 * Not found -- not a ref.  We could
    +
    + ## builtin/show-branch.c ##
    +@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
    + 			die(Q_("only %d entry can be shown at one time.",
    + 			       "only %d entries can be shown at one time.",
    + 			       MAX_REVS), MAX_REVS);
    +-		if (!dwim_ref(*av, strlen(*av), &oid, &ref))
    ++		if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
    + 			die(_("no such ref %s"), *av);
    + 
    + 		/* Has the base been specified? */
    +
    + ## builtin/stash.c ##
    +@@ builtin/stash.c: static int get_stash_info(struct stash_info *info, int argc, const char **argv)
    + 	end_of_rev = strchrnul(revision, '@');
    + 	strbuf_add(&symbolic, revision, end_of_rev - revision);
    + 
    +-	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref);
    ++	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref, 0);
    + 	strbuf_release(&symbolic);
    + 	switch (ret) {
    + 	case 0: /* Not found, but valid ref */
    +
    + ## bundle.c ##
    +@@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
    + 
    + 		if (e->item->flags & UNINTERESTING)
    + 			continue;
    +-		if (dwim_ref(e->name, strlen(e->name), &oid, &ref) != 1)
    ++		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
    + 			goto skip_write_ref;
    + 		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
    + 			flag = 0;
    +
      ## cache.h ##
     @@ cache.h: struct interpret_branch_name_options {
      	 * allowed, even ones to refs outside of those namespaces.
    @@ cache.h: struct interpret_branch_name_options {
      int repo_interpret_branch_name(struct repository *r,
      			       const char *str, int len,
     
    + ## commit.c ##
    +@@ commit.c: struct commit *get_fork_point(const char *refname, struct commit *commit)
    + 	struct commit *ret = NULL;
    + 	char *full_refname;
    + 
    +-	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname)) {
    ++	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname, 0)) {
    + 	case 0:
    + 		die("No such ref: '%s'", refname);
    + 	case 1:
    +
      ## refs.c ##
     @@ refs.c: const char *git_default_branch_name(void)
       * to name a branch.
    @@ refs.c: static char *substitute_branch_name(struct repository *r,
      	int   refs_found  = expand_ref(r, str, len, oid, ref);
      	free(last_branch);
      	return refs_found;
    -@@ refs.c: int repo_dwim_ref(struct repository *r, const char *str, int len,
    - 
    - int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
    - {
    --	return repo_dwim_ref(the_repository, str, len, oid, ref);
    -+	return repo_dwim_ref(the_repository, str, len, oid, ref, 0);
    - }
    - 
    - int expand_ref(struct repository *repo, const char *str, int len,
     @@ refs.c: int repo_dwim_log(struct repository *r, const char *str, int len,
      		  struct object_id *oid, char **log)
      {
    @@ refs.h: struct strvec;
     +int repo_dwim_ref(struct repository *r, const char *str, int len,
     +		  struct object_id *oid, char **ref, int nonfatal_dangling_mark);
      int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
    - int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
    + static inline int dwim_ref(const char *str, int len, struct object_id *oid,
    +-			   char **ref)
    ++			   char **ref, int nonfatal_dangling_mark)
    + {
    +-	return repo_dwim_ref(the_repository, str, len, oid, ref);
    ++	return repo_dwim_ref(the_repository, str, len, oid, ref,
    ++			     nonfatal_dangling_mark);
    + }
      int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
    + 
    +
    + ## remote.c ##
    +@@ remote.c: static void set_merge(struct branch *ret)
    + 		    strcmp(ret->remote_name, "."))
    + 			continue;
    + 		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
    +-			     &oid, &ref) == 1)
    ++			     &oid, &ref, 0) == 1)
    + 			ret->merge[i]->dst = ref;
    + 		else
    + 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
     
      ## sha1-name.c ##
     @@ sha1-name.c: static int get_oid_basic(struct repository *r, const char *str, int len,
    @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
      	}
      
     -	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
    -+	if (repo_dwim_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &ref, 1) == 1 &&
    ++	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref, 1) == 1 &&
      	    /* sha1 is a commit? match without further lookup */
      	    (oideq(&cb.noid, &oid) ||
      	     /* perhaps sha1 is a tag, try to dereference to a commit */
-- 
2.28.0.402.g5ffc5be6b7-goog

