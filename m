Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0EC4361B
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977A961056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhCaTKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhCaTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC30C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso1704149wmi.0
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk1XFXdKxAaohWFNfiUHUwwBDhbxGHCpa+8TS7P6tZ8=;
        b=DZ0sDvQVpKVwis3fhvuvKEQeC/GY9GH8pRHL9Xy/X3nrjbKy2O78aIK4xcXHbtR41P
         6OQtdllozLmNQmZ4SBp2xaSUTdlvzE6yHNNT0VoiyJH3WoaAqmTlngob1lmF4Pd920hM
         jElBrT1ScMSUMTaJ+VokpTxJ1V0U7x9de0/Dkx53IKEee6WTza0AECgbiFNoGgkC7twS
         RsNTL+7elgKnHV4SiMdXYaFDm73BgcB6UTp0k736ShxTQKdVbhGOA2fwclZSn5hqLlIz
         3kA+XzkGiKc8o3CUS9+DD+iFlx5xsvfy+r/xcj/Oyh3eGFVDTycznu1Dx/nThne8DL0T
         Xrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk1XFXdKxAaohWFNfiUHUwwBDhbxGHCpa+8TS7P6tZ8=;
        b=omZcBvf09+umf/2gZ1aiS5CF2X//r+wk7nTq4JYaQlaN6GH04z2AEyUNEUNcvXZtgd
         /FZLI2ekoguKqSMq4oQgbFhIZxSXh1QN04bhCo0a/G9K8lJl1bMwAqbLV7pQa1wlZ+Bt
         HAwLY5lAUjWwkwAFEiJOBdYYsTJ8nv/pK8S+DFdhIW4tG2yTTxlXzfzKQBfSPmquRcZj
         uj7/OQPIYgWfC3xKMYY2ifUZKjd0UTZ5j97ASFpOaIKf4l187Q7y8eft8ndPzGvvGSmS
         Fb8FmdLH4a49MBy26Y4pu/VCpE1JLRByKytpCgzfeCthb9GGZ/ld0/fMJQu5Vmebo42G
         ImZA==
X-Gm-Message-State: AOAM531ZQfZ2TI7VaX1OEiNQjvENT0xPLzv8yQ3WkMC65ZH8GybwQ6BP
        rJ9OYXjG73Jvy1LebfzzRW+5YNZ1OCDGpA==
X-Google-Smtp-Source: ABdhPJzOy+H+WTGOVqvwrzPh+NolkPmEvcRsGM8l8kpsGy4CrjtAq485JIYMSV1hKdJ9man7/6wt5A==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr4442771wmg.176.1617217803460;
        Wed, 31 Mar 2021 12:10:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:10:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 16/18] tree-walk.h API: add a get_tree_entry_path() function
Date:   Wed, 31 Mar 2021 21:09:44 +0200
Message-Id: <patch-16.19-3ba77fd3a47-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a get_tree_entry_path() variant in addition to
get_tree_entry_path_mode(). This is for those callers that don't need
the "mode" filled for them.

There are callers here which don't need the "struct object_id" filled
either, but let's leave that for now. I'm focusing downstream code
that depends on "mode" (or "enum object_type").

The code being modified here was introduced in:

 - shift_tree(): 68faf68938e (A new merge stragety[sic] 'subtree'.,
    2007-02-15) for the shift_tree()

 - tree_has_path(): 96e7ffbdc31 (merge-recursive: check for directory
   level conflicts, 2018-04-19)

 - init_notes(): fd53c9eb445 (Speed up git notes lookup, 2009-10-09)

 - diagnose_invalid_oid_path(): 009fee4774d (Detailed diagnosis when
   parsing an object name fails., 2009-12-07)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c     | 4 +---
 merge-recursive.c | 6 ++----
 notes.c           | 3 +--
 object-name.c     | 3 +--
 tree-walk.c       | 9 +++++++++
 tree-walk.h       | 3 +++
 6 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index d4457eba997..240922f7080 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -288,12 +288,10 @@ void shift_tree(struct repository *r,
 
 	if (add_score < del_score) {
 		/* We need to pick a subtree of two */
-		unsigned short mode;
-
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry_path(r, hash2, del_prefix, shifted))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
diff --git a/merge-recursive.c b/merge-recursive.c
index c2e9f5d22d0..28ed69ddfaa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1882,11 +1882,9 @@ static int tree_has_path(struct repository *r, struct tree *tree,
 			 const char *path)
 {
 	struct object_id hashy;
-	unsigned short mode_o;
-
-	return !get_tree_entry_mode(r,
+	return !get_tree_entry_path(r,
 				    &tree->object.oid, path,
-				    &hashy, &mode_o);
+				    &hashy);
 }
 
 /*
diff --git a/notes.c b/notes.c
index e6244624055..6766b1b478f 100644
--- a/notes.c
+++ b/notes.c
@@ -994,7 +994,6 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes_fn combine_notes, int flags)
 {
 	struct object_id oid, object_oid;
-	unsigned short mode;
 	struct leaf_node root_tree;
 
 	if (!t)
@@ -1021,7 +1020,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry_mode(the_repository, &object_oid, "", &oid, &mode))
+	if (get_tree_entry_path(the_repository, &object_oid, "", &oid))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
diff --git a/object-name.c b/object-name.c
index 7e3b2d6d739..9ff5f83c1ff 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1693,7 +1693,6 @@ static void diagnose_invalid_oid_path(struct repository *r,
 				      int object_name_len)
 {
 	struct object_id oid;
-	unsigned short mode;
 
 	if (!prefix)
 		prefix = "";
@@ -1704,7 +1703,7 @@ static void diagnose_invalid_oid_path(struct repository *r,
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
-		if (!get_tree_entry_mode(r, tree_oid, fullname, &oid, &mode)) {
+		if (!get_tree_entry_path(r, tree_oid, fullname, &oid)) {
 			die(_("path '%s' exists, but not '%s'\n"
 			    "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'?"),
 			    fullname,
diff --git a/tree-walk.c b/tree-walk.c
index 30e3bb64e49..d0dc0c35318 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -628,6 +628,15 @@ int get_tree_entry_mode(struct repository *r,
 	return retval;
 }
 
+int get_tree_entry_path(struct repository *r,
+			const struct object_id *tree_oid,
+			const char *name,
+			struct object_id *oid)
+{
+	unsigned short mode;
+	return get_tree_entry_mode(r, tree_oid, name, oid, &mode);
+}
+
 /*
  * This is Linux's built-in max for the number of symlinks to follow.
  * That limit, of course, does not affect git, but it's a reasonable
diff --git a/tree-walk.h b/tree-walk.h
index a01f2f226ec..c60667cba8f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -172,8 +172,11 @@ struct traverse_info {
  * You always need a pointer to an appropriate variable to fill in
  * (NULL won't do!). That variable is:
  *
+ * get_tree_entry_path(): <no extra argument, just get the common 'path'>
  * get_tree_entry_mode(): unsigned short mode
  */
+int get_tree_entry_path(struct repository *, const struct object_id *, const char *,
+			struct object_id *);
 int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
 			unsigned short *);
-- 
2.31.1.474.g72d45d12706

