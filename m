Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1868C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjC1OAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1N7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10723A5F0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so7501871wms.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vDO+bTGNjndgBrXRgxCPXqw0yfWB7wc/ki+K9J9uNU=;
        b=VGJ41Glfr05AscU34NfvW7shXnMeMxFvIb84sXjFSuBjPcAwcOzoLsBzUtRdyKNrWd
         nFX22+Z5/98My088aHidmebofoBnZKOCe/6pIOiihfDSF0eNwrawCCtia1jSQF/EFubz
         +6+NtGvjztROlySRdBfCQYdX8ruDKq7NW/olVMX1aIPGywH0/0LO7JAy1KeKjrtHgqtE
         z8OOmP+urfc3W/cg0k7cdXrHKBdIOvy+jojYYcKvmkC0AIg9nni/fZ7mhnyds6aoyl+4
         /3WU0lB0HmV2ecKiJk4URU/KBNhew6G0oBEdU14yPQb+QcROCtVLo6vycBWnSKJnTCOk
         ai2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vDO+bTGNjndgBrXRgxCPXqw0yfWB7wc/ki+K9J9uNU=;
        b=fb3wMK30aoz/isjbUWKL8Gblpgkt6aTLiifQGjLmZ+pUSdKqevnO9JN3AM3boB/5jk
         nfyjk00i1uvpjW92sxbxBneOCzVAz1m2bvtfVYJXT6rQ/TtpX2uEbSNcPEw3oEfQ8wTt
         F4tw/59Rkf3rUr7khldTifLvdSnnyA0LHX4CeroBtJAuyGMS5Cdfaq784+RwErkfgxSn
         oZP5KMEeXEgfJxVeXW8SzpdgrhLpizxk3oFXAn44Xxc6Tit/7rl6xZ7sPcOtFRMRK6Xh
         kXwDL/PnxigqE5h1+7O8ilqNdHnIMXr1keec5nP1kcaG6GHxkUHMeCukhQhMJpTBxWt7
         JOig==
X-Gm-Message-State: AO0yUKU+dzuSZBEt3g+JZUfULhmM4LZ2th37fDqSkyPECN+a4+NbpTfh
        JfM9a3uR75zei5N2vw+LUnVoVIJSBshjEw==
X-Google-Smtp-Source: AK7set8EGf95+gTjtWSdeT2NeVckcdw8gy3U8BrxrrBQqRabs37d8Ol5X2Kiloixd4cUGApGDQAFQg==
X-Received: by 2002:a1c:7309:0:b0:3ee:697e:cf0b with SMTP id d9-20020a1c7309000000b003ee697ecf0bmr12157702wmb.14.1680011961137;
        Tue, 28 Mar 2023 06:59:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/17] cocci: apply the "refs.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:54 +0200
Message-Id: <patch-v2-13.17-a08d7f8eccf-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"refs.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c                                       | 5 +++--
 branch.c                                        | 3 ++-
 builtin/checkout.c                              | 6 ++++--
 builtin/fast-export.c                           | 3 ++-
 builtin/log.c                                   | 3 ++-
 builtin/merge.c                                 | 3 ++-
 builtin/reset.c                                 | 3 ++-
 builtin/rev-parse.c                             | 4 +++-
 builtin/show-branch.c                           | 3 ++-
 builtin/stash.c                                 | 3 ++-
 bundle.c                                        | 3 ++-
 commit.c                                        | 3 ++-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 refs.h                                          | 6 ------
 remote.c                                        | 5 +++--
 wt-status.c                                     | 3 ++-
 17 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/archive.c b/archive.c
index 98de324362a..933e5b39b92 100644
--- a/archive.c
+++ b/archive.c
@@ -458,10 +458,11 @@ static void parse_treeish_arg(const char **argv,
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
-		if (!dwim_ref(name, refnamelen, &oid, &ref, 0))
+		if (!repo_dwim_ref(the_repository, name, refnamelen, &oid, &ref, 0))
 			die(_("no such ref: %.*s"), refnamelen, name);
 	} else {
-		dwim_ref(name, strlen(name), &oid, &ref, 0);
+		repo_dwim_ref(the_repository, name, strlen(name), &oid, &ref,
+			      0);
 	}
 
 	if (repo_get_oid(the_repository, name, &oid))
diff --git a/branch.c b/branch.c
index efea29af1ac..179353e7653 100644
--- a/branch.c
+++ b/branch.c
@@ -542,7 +542,8 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 		die(_("not a valid object name: '%s'"), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
+	switch (repo_dwim_ref(the_repository, start_name, strlen(start_name),
+			      &oid, &real_ref, 0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ad6d5304b64..fcede4600a5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -717,7 +717,8 @@ static void setup_branch_path(struct branch_info *branch)
 	 * If this is a ref, resolve it; otherwise, look up the OID for our
 	 * expression.  Failure here is okay.
 	 */
-	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname, 0))
+	if (!repo_dwim_ref(the_repository, branch->name, strlen(branch->name),
+			   &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
@@ -1438,7 +1439,8 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 	char *to_free;
 	int code;
 
-	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
+	if (repo_dwim_ref(the_repository, branch_info->name,
+			  strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
 		if (skip_prefix(ref, "refs/tags/", &ref))
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 166f51b100a..2f728a44115 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -919,7 +919,8 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (e->flags & UNINTERESTING)
 			continue;
 
-		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name, 0) != 1)
+		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
+				  &oid, &full_name, 0) != 1)
 			continue;
 
 		if (refspecs.nr) {
diff --git a/builtin/log.c b/builtin/log.c
index 28085547aa8..ba24fa4bfdb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1218,7 +1218,8 @@ static char *find_branch_name(struct rev_info *rev)
 		return NULL;
 	ref = rev->cmdline.rev[positive].name;
 	tip_oid = &rev->cmdline.rev[positive].item->oid;
-	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref, 0) &&
+	if (repo_dwim_ref(the_repository, ref, strlen(ref), &branch_oid,
+			  &full_ref, 0) &&
 	    skip_prefix(full_ref, "refs/heads/", &v) &&
 	    oideq(tip_oid, &branch_oid))
 		branch = xstrdup(v);
diff --git a/builtin/merge.c b/builtin/merge.c
index 559aab1c380..6538a4bae95 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -519,7 +519,8 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
-	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref, 0) > 0) {
+	if (repo_dwim_ref(the_repository, remote, strlen(remote), &branch_head,
+			  &found_ref, 0) > 0) {
 		if (starts_with(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 				    oid_to_hex(&branch_head), remote);
diff --git a/builtin/reset.c b/builtin/reset.c
index cd4165537c5..c2a390b3a01 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -467,7 +467,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			char *ref = NULL;
 			int err;
 
-			dwim_ref(rev, strlen(rev), &dummy, &ref, 0);
+			repo_dwim_ref(the_repository, rev, strlen(rev),
+				      &dummy, &ref, 0);
 			if (ref && !starts_with(ref, "refs/"))
 				FREE_AND_NULL(ref);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4969815ca79..5662101a102 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -138,7 +138,9 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 			struct object_id discard;
 			char *full;
 
-			switch (dwim_ref(name, strlen(name), &discard, &full, 0)) {
+			switch (repo_dwim_ref(the_repository, name,
+					      strlen(name), &discard, &full,
+					      0)) {
 			case 0:
 				/*
 				 * Not found -- not a ref.  We could
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7aea28f5b06..70bc461638c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -747,7 +747,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(Q_("only %d entry can be shown at one time.",
 			       "only %d entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
-		if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
+		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
+				   &ref, 0))
 			die(_("no such ref %s"), *av);
 
 		/* Has the base been specified? */
diff --git a/builtin/stash.c b/builtin/stash.c
index 447c3b678f3..60052ec9d7b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -212,7 +212,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	end_of_rev = strchrnul(revision, '@');
 	strbuf_add(&symbolic, revision, end_of_rev - revision);
 
-	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref, 0);
+	ret = repo_dwim_ref(the_repository, symbolic.buf, symbolic.len,
+			    &dummy, &expanded_ref, 0);
 	strbuf_release(&symbolic);
 	switch (ret) {
 	case 0: /* Not found, but valid ref */
diff --git a/bundle.c b/bundle.c
index bce0c7f99e8..73f0b1b89d6 100644
--- a/bundle.c
+++ b/bundle.c
@@ -383,7 +383,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
+		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
+				  &oid, &ref, 0) != 1)
 			goto skip_write_ref;
 		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
 			flag = 0;
diff --git a/commit.c b/commit.c
index cfd14f7d975..8e22bebd0e1 100644
--- a/commit.c
+++ b/commit.c
@@ -999,7 +999,8 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	struct commit *ret = NULL;
 	char *full_refname;
 
-	switch (dwim_ref(refname, strlen(refname), &oid, &full_refname, 0)) {
+	switch (repo_dwim_ref(the_repository, refname, strlen(refname), &oid,
+			      &full_refname, 0)) {
 	case 0:
 		die("No such ref: '%s'", refname);
 	case 1:
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index d5b644a8687..b20a3e70845 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -105,6 +105,10 @@
 |
 - has_promisor_remote
 + repo_has_promisor_remote
+// refs.h
+|
+- dwim_ref
++ repo_dwim_ref
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index e17a60198c5..8bf30798a04 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// refs.h
-- dwim_ref
-+ repo_dwim_ref
 // rerere.h
-|
 - rerere
 + repo_rerere
 // revision.h
diff --git a/refs.h b/refs.h
index 935cdd1ece3..2998244b615 100644
--- a/refs.h
+++ b/refs.h
@@ -159,12 +159,6 @@ int expand_ref(struct repository *r, const char *str, int len, struct object_id
 int repo_dwim_ref(struct repository *r, const char *str, int len,
 		  struct object_id *oid, char **ref, int nonfatal_dangling_mark);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
-static inline int dwim_ref(const char *str, int len, struct object_id *oid,
-			   char **ref, int nonfatal_dangling_mark)
-{
-	return repo_dwim_ref(the_repository, str, len, oid, ref,
-			     nonfatal_dangling_mark);
-}
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
 /*
diff --git a/remote.c b/remote.c
index 9219ebb8962..c51180bebb4 100644
--- a/remote.c
+++ b/remote.c
@@ -1810,8 +1810,9 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
-			     &oid, &ref, 0) == 1)
+		if (repo_dwim_ref(the_repository, ret->merge_name[i],
+				  strlen(ret->merge_name[i]), &oid, &ref,
+				  0) == 1)
 			ret->merge[i]->dst = ref;
 		else
 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
diff --git a/wt-status.c b/wt-status.c
index 0f0b92eece4..84726d26dc9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1665,7 +1665,8 @@ static void wt_status_get_detached_from(struct repository *r,
 		return;
 	}
 
-	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref, 1) == 1 &&
+	if (repo_dwim_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &ref,
+			  1) == 1 &&
 	    /* oid is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps oid is a tag, try to dereference to a commit */
-- 
2.40.0.rc1.1034.g5867a1b10c5

