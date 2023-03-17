Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA3C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCQPgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCQPgN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D0A3347F
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so21921345edb.9
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWBJlXyycxrca7uEi65uhGERD/HdB39ISRa2skHpMwg=;
        b=liwj001TWw6HUsnNXpCKs1J0X72//F/03vRdC1/YbJE5fvpu42qP2rzyL8HF17BRI6
         FfjHrA+Fxts3u35jz/6lvaddjTNomTtB7t3sH82b8uUw4IEUyt5pY8wSBn58k36F4Zvo
         FDP5ULArqUDoHCxkTHLGQj0dbeM43mYMKvbd7O7G7fXUxhVopd/z2hTS27ax2ZpAY3Hs
         IVdcEOPrGDvvYSAcGDsE40WnNDE6Ml+l2OCw1R3TG7xAhq6WKM+NBAJjQUu0NMC00CSu
         kI7Tunm3hfmRtQp0lSHzm0dLZlo8abc56WrdWliPMJ1ZQJKhN260Ao9oKptZJmAYanzE
         3uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWBJlXyycxrca7uEi65uhGERD/HdB39ISRa2skHpMwg=;
        b=vm8AcRjrwIkfFpiItjZWLjBwViAlXSBztS2BDcUzd+TtKpUgOEU1Jajyo85ILgIOU7
         U3IE9A1QDxHi6tVug/ASVrFNG5BfzulPhWWg6yzLZFZTJKMlEuXGNC62i4iB2hdkvZJ/
         XO+i83+4yeEgzuB7X2eBEMwcAwnbesfabw7OcqoVszdCpVlSRSp4+kLTlnvBT2bjIBpO
         cXSvszqW6W5u+knhYpv6+LhUz6l4YjWzQQAhQpOn0rQpXJrr6uGVgq5P5c4bcN0D5Ou1
         6L+h/Qzrfza8F6OiyVBah6xbOx+KoHviY+UStL7r+jStznNlUG57CBe2p20KArraxGkX
         Rx8w==
X-Gm-Message-State: AO0yUKV6U9tZT7RUn8UPtloDlNeYz8q7svIwa3ZVQxT/Zg1zFnWgWMUX
        G2bLjl0gcVG5wbwFgXOljwTYyhH3rrAZNw==
X-Google-Smtp-Source: AK7set+1/vkVxOrHnyTY/G/JODe9ksgz159pUp73G8i/77Ccq+6mwADfIeLazt2+WRhLPUAQkg9xQQ==
X-Received: by 2002:aa7:dbce:0:b0:500:2cac:332c with SMTP id v14-20020aa7dbce000000b005002cac332cmr3521902edt.25.1679067336934;
        Fri, 17 Mar 2023 08:35:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/17] cocci: apply the "refs.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:17 +0100
Message-Id: <patch-13.17-aae743233ab-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
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
index d43687a5c44..716a18567bc 100644
--- a/archive.c
+++ b/archive.c
@@ -456,10 +456,11 @@ static void parse_treeish_arg(const char **argv,
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
index 2efb5fbaa5f..a01e465b114 100644
--- a/branch.c
+++ b/branch.c
@@ -541,7 +541,8 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 		die(_("not a valid object name: '%s'"), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
+	switch (repo_dwim_ref(the_repository, start_name, strlen(start_name),
+			      &oid, &real_ref, 0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1d1f33e33e7..cb7cd315b34 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -703,7 +703,8 @@ static void setup_branch_path(struct branch_info *branch)
 	 * If this is a ref, resolve it; otherwise, look up the OID for our
 	 * expression.  Failure here is okay.
 	 */
-	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname, 0))
+	if (!repo_dwim_ref(the_repository, branch->name, strlen(branch->name),
+			   &branch->oid, &branch->refname, 0))
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
@@ -1424,7 +1425,8 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 	char *to_free;
 	int code;
 
-	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
+	if (repo_dwim_ref(the_repository, branch_info->name,
+			  strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
 		if (skip_prefix(ref, "refs/tags/", &ref))
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6515bd2ad8b..550f078a8ed 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -918,7 +918,8 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (e->flags & UNINTERESTING)
 			continue;
 
-		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name, 0) != 1)
+		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
+				  &oid, &full_name, 0) != 1)
 			continue;
 
 		if (refspecs.nr) {
diff --git a/builtin/log.c b/builtin/log.c
index 3dde77bde27..acf3faecd81 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1204,7 +1204,8 @@ static char *find_branch_name(struct rev_info *rev)
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
index 197e152aba9..69666546ca2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -517,7 +517,8 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
-	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref, 0) > 0) {
+	if (repo_dwim_ref(the_repository, remote, strlen(remote), &branch_head,
+			  &found_ref, 0) > 0) {
 		if (starts_with(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 				    oid_to_hex(&branch_head), remote);
diff --git a/builtin/reset.c b/builtin/reset.c
index 75b447ffdc6..b65f379440b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -465,7 +465,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			char *ref = NULL;
 			int err;
 
-			dwim_ref(rev, strlen(rev), &dummy, &ref, 0);
+			repo_dwim_ref(the_repository, rev, strlen(rev),
+				      &dummy, &ref, 0);
 			if (ref && !starts_with(ref, "refs/"))
 				FREE_AND_NULL(ref);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 5685cf0ea7d..663f282c5f7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -136,7 +136,9 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
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
index d60e536a53b..af680485d58 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -746,7 +746,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(Q_("only %d entry can be shown at one time.",
 			       "only %d entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
-		if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
+		if (!repo_dwim_ref(the_repository, *av, strlen(*av), &oid,
+				   &ref, 0))
 			die(_("no such ref %s"), *av);
 
 		/* Has the base been specified? */
diff --git a/builtin/stash.c b/builtin/stash.c
index 6c062e52048..364273f1012 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -211,7 +211,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	end_of_rev = strchrnul(revision, '@');
 	strbuf_add(&symbolic, revision, end_of_rev - revision);
 
-	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref, 0);
+	ret = repo_dwim_ref(the_repository, symbolic.buf, symbolic.len,
+			    &dummy, &expanded_ref, 0);
 	strbuf_release(&symbolic);
 	switch (ret) {
 	case 0: /* Not found, but valid ref */
diff --git a/bundle.c b/bundle.c
index 9b57bade7a6..dca96e51ee0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -382,7 +382,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), &oid, &ref, 0) != 1)
+		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
+				  &oid, &ref, 0) != 1)
 			goto skip_write_ref;
 		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
 			flag = 0;
diff --git a/commit.c b/commit.c
index dd22e76c3e1..0e2fc7dbab8 100644
--- a/commit.c
+++ b/commit.c
@@ -996,7 +996,8 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
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
index 12f6bea6252..a03b03e467e 100644
--- a/remote.c
+++ b/remote.c
@@ -1808,8 +1808,9 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
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
index c55c51b1924..dcd1d0cee4c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1664,7 +1664,8 @@ static void wt_status_get_detached_from(struct repository *r,
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

