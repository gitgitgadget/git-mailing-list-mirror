Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889EC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36F62071B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Fi75hehr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIAW23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIAW2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 18:28:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF15C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 15:28:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mv5so1171612pjb.5
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uuiNqnW5TTtd8bHDfUgmNZMwtqr32TMQhK5TUP2WTpY=;
        b=Fi75hehr+wNPXdJDm7xCR9BTYW5t1bsSDZqhiQf+W7VBLs5oBwR1LclvnGhbfVLwVf
         008BvcYjrPS2LGFwZ9d6HW4kqku7TDMDat8GdLcojG5d1Y3NEWHLQgEVm4Vdr6IZtQjE
         qkQa5kF8IGJ/uggYKEA0u8w+JzT9KHwi+QVJXDq6N4kNTPsHlwW/Q16fYjeCcaVrPuiU
         VpX3wlnrrUWRU3LKVZqIytbIFug9NpIq/oUidXf04I3RoV/IlxMXGSmTCorlBoUUHAql
         L516Urmx/4MgIfaaBCYIOpcpbKhyz1DiB/3SjBIimaLj9r4Z3LKlJyGFTQWe2phoSRsJ
         7rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uuiNqnW5TTtd8bHDfUgmNZMwtqr32TMQhK5TUP2WTpY=;
        b=cuwS6+eVz8HSXgtoQB03nnI7Z/mmyd5WaNx6ljYVgCb5s6Vh2h8JgybqXp3m/Cl9PW
         E9phyPs66FpbOC5u7QagPIhyoQ9/rpnOgBVUoI/ORc34a3gN0TSa1Rxuzw33aczU9UMy
         jivI/I+SHCCIhzj1roiDWKCF11RJEZ0UgDJ73EQF3TjLCfcBbChA88rjXrUjHjpHg+Tg
         3Ff/STvgTwMwV+MuELeeuN6UOJ2kZ0QMqM/kdG63KBCsJV98MqvHyk4hHRnoGXSFOAFQ
         9iqgdmnbmeV8fbUvSitPHkC3O1fzjvDFLeZxwRR5n5kWpytzE2HJ6KxjYQp4/U/83P1q
         DSXw==
X-Gm-Message-State: AOAM53254Y1hEfm2uW7zoyvql3zY04xcTs+i9ad3QV9qx9m/PdoDU6c4
        Ty+cl0mLULnLtaiZgAXO8IUOM9yhYa0+3Dub5Z/U4yodYZwQFSOyzDHPUntd3X1xYgRBhgkBZqE
        z+AefGNJJHjYlES6fna5hKS/Zj9Hkl2kVVtQeUkR6S9R6aIazf4wk1FWUV9/aLNQIuNPvwrwp2l
        m0
X-Google-Smtp-Source: ABdhPJx9O6eGJgPcy9OvOVk8AyRsEXi6HFdw+2TQAvoQcDomfSzuHxoi0sMgiy6gDvYcmcTr5xa5Upmakt1HrlG+4vxb
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3891:: with SMTP id
 mu17mr3508981pjb.160.1598999300148; Tue, 01 Sep 2020 15:28:20 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:28:09 -0700
In-Reply-To: <cover.1598998706.git.jonathantanmy@google.com>
Message-Id: <8f489d963333acfb08cdfadea267c9583e3e586f.1598998707.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com> <cover.1598998706.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 3/3] wt-status: tolerate dangling marks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user checks out the upstream branch of HEAD, the upstream branch
not being a local branch, and then runs "git status", like this:

  git clone $URL client
  cd client
  git checkout @{u}
  git status

no status is printed, but instead an error message:

  fatal: HEAD does not point to a branch

(This error message when running "git branch" persists even after
checking out other things - it only stops after checking out a branch.)

This is because "git status" reads the reflog when determining the "HEAD
detached" message, and thus attempts to DWIM "@{u}", but that doesn't
work because HEAD no longer points to a branch.

Therefore, when calculating the status of a worktree, tolerate dangling
marks. This is done by adding an additional parameter to
dwim_ref() and repo_dwim_ref().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
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
 cache.h               |  7 +++++++
 commit.c              |  2 +-
 refs.c                | 14 +++++++++-----
 refs.h                |  8 +++++---
 remote.c              |  2 +-
 sha1-name.c           | 16 +++++++++++-----
 t/t7508-status.sh     | 12 ++++++++++++
 wt-status.c           |  2 +-
 19 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/archive.c b/archive.c
index fb39706120..0de6048bfc 100644
--- a/archive.c
+++ b/archive.c
@@ -397,10 +397,10 @@ static void parse_treeish_arg(const char **argv,
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
-		if (!dwim_ref(name, refnamelen, &oid, &ref))
+		if (!dwim_ref(name, refnamelen, &oid, &ref, 0))
 			die(_("no such ref: %.*s"), refnamelen, name);
 	} else {
-		dwim_ref(name, strlen(name), &oid, &ref);
+		dwim_ref(name, strlen(name), &oid, &ref, 0);
 	}
 
 	if (get_oid(name, &oid))
diff --git a/branch.c b/branch.c
index 7095f78058..9c9dae1eae 100644
--- a/branch.c
+++ b/branch.c
@@ -281,7 +281,7 @@ void create_branch(struct repository *r,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref)) {
+	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bba64108af..1f10cc93dd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -651,7 +651,7 @@ static void setup_branch_path(struct branch_info *branch)
 	 * If this is a ref, resolve it; otherwise, look up the OID for our
 	 * expression.  Failure here is okay.
 	 */
-	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname))
+	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
@@ -1345,7 +1345,7 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 	struct object_id oid;
 	char *to_free;
 
-	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free) == 1) {
+	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
 		if (skip_prefix(ref, "refs/tags/", &ref))
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f37895d4c..1b8fca3ee0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -943,7 +943,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (e->flags & UNINTERESTING)
 			continue;
 
-		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name) != 1)
+		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name, 0) != 1)
 			continue;
 
 		if (refspecs.nr) {
diff --git a/builtin/log.c b/builtin/log.c
index b58f8da09e..4ec7f57cf4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1061,7 +1061,7 @@ static char *find_branch_name(struct rev_info *rev)
 		return NULL;
 	ref = rev->cmdline.rev[positive].name;
 	tip_oid = &rev->cmdline.rev[positive].item->oid;
-	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref) &&
+	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref, 0) &&
 	    skip_prefix(full_ref, "refs/heads/", &v) &&
 	    oideq(tip_oid, &branch_oid))
 		branch = xstrdup(v);
diff --git a/builtin/merge.c b/builtin/merge.c
index 74829a838e..2af70b5605 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -500,7 +500,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
-	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref) > 0) {
+	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref, 0) > 0) {
 		if (starts_with(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 				    oid_to_hex(&branch_head), remote);
diff --git a/builtin/reset.c b/builtin/reset.c
index 8ae69d6f2b..c635b062c3 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -423,7 +423,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			char *ref = NULL;
 			int err;
 
-			dwim_ref(rev, strlen(rev), &dummy, &ref);
+			dwim_ref(rev, strlen(rev), &dummy, &ref, 0);
 			if (ref && !starts_with(ref, "refs/"))
 				ref = NULL;
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 669dd2fd6f..ed200c8af1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -136,7 +136,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 			struct object_id discard;
 			char *full;
 
-			switch (dwim_ref(name, strlen(name), &discard, &full)) {
+			switch (dwim_ref(name, strlen(name), &discard, &full, 0)) {
 			case 0:
 				/*
 				 * Not found -- not a ref.  We could
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7eae5f3801..d6d2dabeca 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -741,7 +741,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(Q_("only %d entry can be shown at one time.",
 			       "only %d entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
-		if (!dwim_ref(*av, strlen(*av), &oid, &ref))
+		if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
 			die(_("no such ref %s"), *av);
 
 		/* Has the base been specified? */
diff --git a/builtin/stash.c b/builtin/stash.c
index 4bdfaf8397..3f811f3050 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -185,7 +185,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	end_of_rev = strchrnul(revision, '@');
 	strbuf_add(&symbolic, revision, end_of_rev - revision);
 
-	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref);
+	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref, 0);
 	strbuf_release(&symbolic);
 	switch (ret) {
 	case 0: /* Not found, but valid ref */
diff --git a/bundle.c b/bundle.c
index 995a940dfd..cb0e5931ac 100644
--- a/bundle.c
+++ b/bundle.c
@@ -403,7 +403,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), &oid, &ref) != 1)
+		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
 			goto skip_write_ref;
 		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
 			flag = 0;
diff --git a/cache.h b/cache.h
index 4f16a57ba4..cee8aa5dc3 100644
--- a/cache.h
+++ b/cache.h
@@ -1569,6 +1569,13 @@ struct interpret_branch_name_options {
 	 * allowed, even ones to refs outside of those namespaces.
 	 */
 	unsigned allowed;
+
+	/*
+	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
+	 * branch in question does not have such a reference, return -1 instead
+	 * of die()-ing.
+	 */
+	unsigned nonfatal_dangling_mark : 1;
 };
 int repo_interpret_branch_name(struct repository *r,
 			       const char *str, int len,
diff --git a/commit.c b/commit.c
index 4ce8cb38d5..119892abbc 100644
--- a/commit.c
+++ b/commit.c
@@ -921,7 +921,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	struct commit *ret = NULL;
 	char *full_refname;
 
-	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname)) {
+	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname, 0)) {
 	case 0:
 		die("No such ref: '%s'", refname);
 	case 1:
diff --git a/refs.c b/refs.c
index 0fa6067340..e06ee22a8a 100644
--- a/refs.c
+++ b/refs.c
@@ -598,10 +598,13 @@ const char *git_default_branch_name(void)
  * to name a branch.
  */
 static char *substitute_branch_name(struct repository *r,
-				    const char **string, int *len)
+				    const char **string, int *len,
+				    int nonfatal_dangling_mark)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct interpret_branch_name_options options = { 0 } ;
+	struct interpret_branch_name_options options = {
+		.nonfatal_dangling_mark = nonfatal_dangling_mark
+	};
 	int ret = repo_interpret_branch_name(r, *string, *len, &buf, &options);
 
 	if (ret == *len) {
@@ -615,9 +618,10 @@ static char *substitute_branch_name(struct repository *r,
 }
 
 int repo_dwim_ref(struct repository *r, const char *str, int len,
-		  struct object_id *oid, char **ref)
+		  struct object_id *oid, char **ref, int nonfatal_dangling_mark)
 {
-	char *last_branch = substitute_branch_name(r, &str, &len);
+	char *last_branch = substitute_branch_name(r, &str, &len,
+						   nonfatal_dangling_mark);
 	int   refs_found  = expand_ref(r, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
@@ -661,7 +665,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 		  struct object_id *oid, char **log)
 {
 	struct ref_store *refs = get_main_ref_store(r);
-	char *last_branch = substitute_branch_name(r, &str, &len);
+	char *last_branch = substitute_branch_name(r, &str, &len, 0);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index 8cbef96a8d..e03c106320 100644
--- a/refs.h
+++ b/refs.h
@@ -151,12 +151,14 @@ struct strvec;
 void expand_ref_prefix(struct strvec *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
-int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **ref, int nonfatal_dangling_mark);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 static inline int dwim_ref(const char *str, int len, struct object_id *oid,
-			   char **ref)
+			   char **ref, int nonfatal_dangling_mark)
 {
-	return repo_dwim_ref(the_repository, str, len, oid, ref);
+	return repo_dwim_ref(the_repository, str, len, oid, ref,
+			     nonfatal_dangling_mark);
 }
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
diff --git a/remote.c b/remote.c
index c5ed74f91c..420150837b 100644
--- a/remote.c
+++ b/remote.c
@@ -1558,7 +1558,7 @@ static void set_merge(struct branch *ret)
 		    strcmp(ret->remote_name, "."))
 			continue;
 		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
-			     &oid, &ref) == 1)
+			     &oid, &ref, 0) == 1)
 			ret->merge[i]->dst = ref;
 		else
 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
diff --git a/sha1-name.c b/sha1-name.c
index a7a9de66c4..0b23b86ceb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -809,7 +809,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref);
+			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
@@ -860,11 +860,11 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref);
+		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, 0);
 	else if (reflog_len)
 		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
 	else
-		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref);
+		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, 0);
 
 	if (!refs_found)
 		return -1;
@@ -1496,8 +1496,14 @@ static int interpret_branch_mark(struct repository *r,
 		branch = branch_get(NULL);
 
 	value = get_data(branch, &err);
-	if (!value)
-		die("%s", err.buf);
+	if (!value) {
+		if (options->nonfatal_dangling_mark) {
+			strbuf_release(&err);
+			return -1;
+		} else {
+			die("%s", err.buf);
+		}
+	}
 
 	if (!branch_interpret_allowed(value, options->allowed))
 		return -1;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e81759319f..45e1f6ff68 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -846,6 +846,18 @@ test_expect_success 'status refreshes the index' '
 	test_cmp expect output
 '
 
+test_expect_success 'status shows detached HEAD properly after checking out non-local upstream branch' '
+	test_when_finished rm -rf upstream downstream actual &&
+
+	test_create_repo upstream &&
+	test_commit -C upstream foo &&
+
+	git clone upstream downstream &&
+	git -C downstream checkout @{u} &&
+	git -C downstream status >actual &&
+	test_i18ngrep "HEAD detached at [0-9a-f]\\+" actual
+'
+
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
diff --git a/wt-status.c b/wt-status.c
index 7ce58b8aae..a99b7a0c59 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1569,7 +1569,7 @@ static void wt_status_get_detached_from(struct repository *r,
 		return;
 	}
 
-	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
+	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref, 1) == 1 &&
 	    /* sha1 is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-- 
2.28.0.402.g5ffc5be6b7-goog

