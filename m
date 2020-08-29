Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06978C433E7
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF973207BB
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g5dE0BpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgH2BCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgH2BCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D47C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:02:33 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x13so1569769pgf.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nfjY+zv6PEt9bNSZ3tt7074LXmFAUnOtbTbPP95QTvo=;
        b=g5dE0BpCxj79w7YFsJZZriasmjgm6efRIRaNAEjXbqcdNu7IJERsyEeL0KTeQIXSec
         /XwLJw/G4FbEuM7znrKfRYCclZJ4DpA0MCk7ygMDmmN+6UjmEY0znw+sbmOVkDBcq8j2
         y2ibOSp5Csd31Hq6R6UFkWqNlFpwLlBvBDPfV/GXs8rs8pA4vwkDmZI7KldbudafZO6w
         tXs1ar8cUwOnY6nOmGKo1yLw4/LEhKpygEH4byiNlFiE2uPuI5DsCJg8eNzJpPnlIwMY
         ToLB6QB0f97bVrBmWnO5lP7xpQUD5tkl4ZtSaUWwhSesmH5ba5qli+lOJ/JV7UZ9JyY/
         LsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nfjY+zv6PEt9bNSZ3tt7074LXmFAUnOtbTbPP95QTvo=;
        b=WoJS25knavCUthoz7WmybpWHx2Ohx3tr8jhcEeRLUKuQDJacDIYLwB1DrSUA5AJJpH
         U/JLXXtC5cybisvGvFvOnkPs504Qbd7HDvRaEfJbR+J9Zf/1lR9dGofczLg6ldKtWxKC
         PbMKCQUSHcFVZqnHsl5lVhZhWS69RV2BhNpdBLXEylCTIcRQ68JfCmD+kvjPp4oOvzMw
         RcrPTgLOd0U9FtJ0AJ0d7qRaZaZ0583BDWB5v6Xrxa6It3iNWIr5kTft5VUUzscArGgQ
         PUqj81fAwoX4ACI5KmPNBQTvMzHwsj79oPEr6ZqxVzcFoRh90HgNNWcNNaQ1BXbmZivw
         RR0g==
X-Gm-Message-State: AOAM530CYKhFuO3i/1vpkiqp2T1Jy0zTgf4OMIrofKp8+DIbimv+LQ8L
        5GWFy5cKYfAN+CPlEEKAWtR5RpFlENeVATHCOQoEqDxvY0z4c/VEI0/mKQR4vjltPdWsEjZtr5Q
        VTQwjfDHzoc69p9+fZMKx5qVc9hHQSzXOGYHq6OOmfHw9juXMomksgA630mwYm8M/joW2wzUGX7
        4y
X-Google-Smtp-Source: ABdhPJzcIHU0PEK7JfOGycnMvt6anoSZ9nb4GfzT/vRWIjPO6CIg+pGpFMKY27LRuCBgBNsbcHB7xzjBBIr8embYCHkA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a63:af1d:: with SMTP id
 w29mr991057pge.176.1598662952818; Fri, 28 Aug 2020 18:02:32 -0700 (PDT)
Date:   Fri, 28 Aug 2020 18:02:27 -0700
In-Reply-To: <cover.1598662525.git.jonathantanmy@google.com>
Message-Id: <59b91a206d9d7bf64825cb48c747730e28b10a79.1598662525.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com> <cover.1598662525.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 2/2] wt-status: tolerate dangling marks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
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
repo_dwim_ref().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h           |  7 +++++++
 refs.c            | 16 ++++++++++------
 refs.h            |  3 ++-
 sha1-name.c       | 16 +++++++++++-----
 t/t7508-status.sh | 12 ++++++++++++
 wt-status.c       |  2 +-
 6 files changed, 43 insertions(+), 13 deletions(-)

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
diff --git a/refs.c b/refs.c
index cf09cd039f..b6f1a2f452 100644
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
@@ -625,7 +629,7 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
-	return repo_dwim_ref(the_repository, str, len, oid, ref);
+	return repo_dwim_ref(the_repository, str, len, oid, ref, 0);
 }
 
 int expand_ref(struct repository *repo, const char *str, int len,
@@ -666,7 +670,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 		  struct object_id *oid, char **log)
 {
 	struct ref_store *refs = get_main_ref_store(r);
-	char *last_branch = substitute_branch_name(r, &str, &len);
+	char *last_branch = substitute_branch_name(r, &str, &len, 0);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index 29e28124cd..b94a7fd4f7 100644
--- a/refs.h
+++ b/refs.h
@@ -149,7 +149,8 @@ struct strvec;
 void expand_ref_prefix(struct strvec *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
-int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **ref, int nonfatal_dangling_mark);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
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
index 7ce58b8aae..ae16faf40d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1569,7 +1569,7 @@ static void wt_status_get_detached_from(struct repository *r,
 		return;
 	}
 
-	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
+	if (repo_dwim_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &ref, 1) == 1 &&
 	    /* sha1 is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-- 
2.28.0.402.g5ffc5be6b7-goog

