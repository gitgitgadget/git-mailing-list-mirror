Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F181F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIED3X (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:23 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:32873 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:23 -0400
Received: by mail-yb1-f202.google.com with SMTP id d202-v6so1805637ybh.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JSfCclm1c512PNn/uMTIgQEGof2GGmbDlxs3Q7jDwpg=;
        b=WvEszLk1N+oxnj/cylKXPXe/TOlFn/JtjbBkkfdhMwtNc3cqCtea5Kphhk1Ksn4Rmz
         rMDOH2ZLRZ7UTWyh736MjTwoAwdTmYRwZ98OHHAw5dd9zmaVH07jR9YuJ9Z86QTo75xW
         zEa6Qo/nFWaT/wJWhra2H83q+bn92r96kUXD+20rauIhqmPfiyvI34HkG1pwccmKvIxJ
         guFs09e385Or4fwbargFpz0KoTqfF6fAwbxJIEHbxd6Q97oiBIQGB1pfU7etlPRAmuf+
         qIHa1umiQnA+F3Pw8BDHL1j99tiOfHpwlZOy+blNReTX4boJ2TeXCFl4PSRnBy/U/QZn
         xC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JSfCclm1c512PNn/uMTIgQEGof2GGmbDlxs3Q7jDwpg=;
        b=WwmelzrptIzC8jBiRlIaGHiLiUeXEKBR9GJb5SuOSdBQ+ki58vyPHvuvQNpxeAh95M
         rNSSiGnh+TUGbDh/kJx86Qc+u7/geZQA3e2gCz3CBMmgqQXPYWEz0WDSdpg1htAA0jBW
         z9sxaoUVf7hZdLIYuFXeLQTTwj7z9sXBwJe7DKPpcrk4fOI/AR/37kmySbgFFjMIdePn
         rQLC5YuqZHs8Fz8nvbTZWFE79v8MD/9+gMLk4NtLqMJ2/XlMuDsP0SKZkVMc/NQcrbNB
         q0eJt5pfYtqN2UNUVNZdHAntePl/iKnRvvn+U8ksAJpfsQSO46Go6We1GXMhBqfkf/1Q
         uwyA==
X-Gm-Message-State: APzg51AMqM+k8zuBx4wKRMLsC6fzj1Q1/KxM3DtgaX8kowHbcYirjim8
        x/jdwgA5z/3FPqExhHkpIBuAISzfhXKZT43OXueuudnVciEDXr3uvT0nifha48Ny4JyA4LgFRfk
        K0iNFXGE5XBdNLB9iCDKZ3DK0iH4BTzQxJHehX31nFEALuVf+mId1ywzFerO7
X-Google-Smtp-Source: ANB0VdYAsW4DTq2Qdb4Cq3qxec5zwSQEeLKdkqRIzyKSXMOEkW97v51WPzShVLeJRm75XqNhcoWeYD5iY0Ps
X-Received: by 2002:a81:1d83:: with SMTP id d125-v6mr9444887ywd.114.1536102126101;
 Tue, 04 Sep 2018 16:02:06 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:42 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 04/11] submodule.c: convert submodule_move_head new argument
 to object id
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers use oid_to_hex to convert the desired oid to a string before
calling submodule_move_head. Defer the conversion to the
submodule_move_head as it will turn out to be useful in a bit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c        |  6 +++---
 submodule.c    | 12 ++++++------
 submodule.h    |  2 +-
 unpack-trees.c | 13 +++++--------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/entry.c b/entry.c
index 2a2ab6c8394..0b676f997b2 100644
--- a/entry.c
+++ b/entry.c
@@ -358,7 +358,7 @@ static int write_entry(struct cache_entry *ce,
 		sub = submodule_from_ce(ce);
 		if (sub)
 			return submodule_move_head(ce->name,
-				NULL, oid_to_hex(&ce->oid),
+				NULL, &ce->oid,
 				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
 
@@ -439,10 +439,10 @@ int checkout_entry(struct cache_entry *ce,
 					unlink_or_warn(ce->name);
 
 				return submodule_move_head(ce->name,
-					NULL, oid_to_hex(&ce->oid), 0);
+					NULL, &ce->oid, 0);
 			} else
 				return submodule_move_head(ce->name,
-					"HEAD", oid_to_hex(&ce->oid),
+					"HEAD", &ce->oid,
 					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
 
diff --git a/submodule.c b/submodule.c
index 50cbf5f13ed..da2ed8696f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1597,9 +1597,9 @@ static void submodule_reset_index(const char *path)
  * pass NULL for old or new respectively.
  */
 int submodule_move_head(const char *path,
-			 const char *old_head,
-			 const char *new_head,
-			 unsigned flags)
+			const char *old_head,
+			const struct object_id *new_oid,
+			unsigned flags)
 {
 	int ret = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1679,7 +1679,7 @@ int submodule_move_head(const char *path,
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
 		argv_array_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
 
-	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
+	argv_array_push(&cp.args, new_oid ? oid_to_hex(new_oid) : empty_tree_oid_hex());
 
 	if (run_command(&cp)) {
 		ret = error(_("Submodule '%s' could not be updated."), path);
@@ -1687,7 +1687,7 @@ int submodule_move_head(const char *path,
 	}
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
-		if (new_head) {
+		if (new_oid) {
 			child_process_init(&cp);
 			/* also set the HEAD accordingly */
 			cp.git_cmd = 1;
@@ -1696,7 +1696,7 @@ int submodule_move_head(const char *path,
 
 			prepare_submodule_repo_env(&cp.env_array);
 			argv_array_pushl(&cp.args, "update-ref", "HEAD",
-					 "--no-deref", new_head, NULL);
+					 "--no-deref", oid_to_hex(new_oid), NULL);
 
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/submodule.h b/submodule.h
index 7d476cefa7e..ef34d5a7ca8 100644
--- a/submodule.h
+++ b/submodule.h
@@ -124,7 +124,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 int submodule_move_head(const char *path,
 			const char *old,
-			const char *new_head,
+			const struct object_id *new_oid,
 			unsigned flags);
 
 void submodule_unset_core_worktree(const struct submodule *sub);
diff --git a/unpack-trees.c b/unpack-trees.c
index f25089b878a..75d1b294ade 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -256,7 +256,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
-				     const char *new_id,
+				     const struct object_id *new_id,
 				     struct unpack_trees_options *o)
 {
 	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
@@ -1517,7 +1517,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 
 		if (submodule_from_ce(ce)) {
 			int r = check_submodule_move_head(ce,
-				"HEAD", oid_to_hex(&ce->oid), o);
+				"HEAD", &ce->oid, o);
 			if (r)
 				return o->gently ? -1 :
 					add_rejected_path(o, error_type, ce->name);
@@ -1591,8 +1591,7 @@ static int verify_clean_submodule(const char *old_sha1,
 	if (!submodule_from_ce(ce))
 		return 0;
 
-	return check_submodule_move_head(ce, old_sha1,
-					 oid_to_hex(&ce->oid), o);
+	return check_submodule_move_head(ce, old_sha1, &ce->oid, o);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
@@ -1836,8 +1835,7 @@ static int merged_entry(const struct cache_entry *ce,
 
 		if (submodule_from_ce(ce)) {
 			int ret = check_submodule_move_head(ce, NULL,
-							    oid_to_hex(&ce->oid),
-							    o);
+							    &ce->oid, o);
 			if (ret)
 				return ret;
 		}
@@ -1865,8 +1863,7 @@ static int merged_entry(const struct cache_entry *ce,
 
 		if (submodule_from_ce(ce)) {
 			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
-							    oid_to_hex(&ce->oid),
-							    o);
+							    &ce->oid, o);
 			if (ret)
 				return ret;
 		}
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

