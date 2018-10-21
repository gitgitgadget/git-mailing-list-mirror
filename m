Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1043C1F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJUQWq (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40871 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUQWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id r83-v6so34224573ljr.7
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PyQPX0EzNSjUgvAQKnlu8lJtGLDIZ2XbHC08HR/v2w=;
        b=hySgAKfNoI340OOL8ww+6MexU8GBgpdwrff10U/+Du/2wIErD4SamJIvoLk0EcDSqf
         9HYU/69n/vxuQOBHOqRBC19w0X0NQFTj1gnRgaawVECJ6iNpBrJ7aFGP2q7vtB2k8mny
         NaShCmKmBSiwpvnwnfLrMV++wJdG59Cppg3yrJgDlOi/qCAeaKrZWnlVOUpASVoqA6y8
         daekEJdsyOgbJlO1FC1wVVvutoQ3dHx/r/oxJ6zNCKVkHhA0yX7jd4JlBstHE7Ziok6o
         aiQKDK2RL4RM8Bf6pIya5EJjae1tx0n+6ri91q/SR/lf+CldgRzZfMKHCkH66Pj+pHgR
         s3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PyQPX0EzNSjUgvAQKnlu8lJtGLDIZ2XbHC08HR/v2w=;
        b=e1y/oh9DExvz9X+7pMTRcFRY1aPUkXwEYlhuPDgXtzogelMAhNskt0jxShDlfzk8Rb
         ci9KAeD2CvEzwJgUfWUvMCEZL/acg+AC0JAumpSpCbgtHnpu6/4wO+2FCZsZICWeq5t0
         huXDTkYOWoCCpd/Iyl2Bx/C3nk/gI3P14IDqhWqZ5B67Yahb+tE7E1s0bvUh4x7p614E
         E9K/mRCbo8UbJNvB69ktIxLm4fPpSb4wBYE6gFC2ncRU96ksPtAX/K+fAvU9MYJotEc/
         U32yzEEFZhBPLZ1Qorr3FOSaFNdc19bu30xfDqUZsfk/Azfzh/sirsD1BZjhQbQiexQy
         jnRg==
X-Gm-Message-State: ABuFfog+Za3Sy6rbBu17lM5HPfgMWiIbdptGmuIfLiopwhKkajo7psw3
        JTnJdDE5lbtVmNcGvUs0VujiwZu9
X-Google-Smtp-Source: ACcGV63/ZSaDKpSpJEZ7bkaZYoT1APWJYTyYO3FGcsC9BKUzTlKIPMqbZDtJBtcdL60Tpph2H7X6lA==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr29491887ljj.6.1540109353126;
        Sun, 21 Oct 2018 01:09:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 5/8] revision.c: better error reporting on ref from different worktrees
Date:   Sun, 21 Oct 2018 10:08:56 +0200
Message-Id: <20181021080859.3203-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181021080859.3203-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the new ref aliases to pass refs from another worktree
around and access them from the current ref store instead. This does
not change any functionality, but when a problem arises, we would like
the reported messages to mention full ref aliases, like this:

    fatal: bad object worktrees/ztemp/HEAD
    warning: reflog of 'main-worktree/HEAD' references pruned commits

instead of

    fatal: bad object HEAD
    warning: reflog of 'HEAD' references pruned commits

which does not really tell where the refs are from.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 21 +++++++++++++--------
 worktree.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 worktree.h | 15 +++++++++++++++
 3 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index ea1d695e23..1737aad3ec 100644
--- a/revision.c
+++ b/revision.c
@@ -1178,7 +1178,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
-	struct ref_store *refs;
+	struct worktree *wt;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1215,7 +1215,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_revs = revs;
 	cb->all_flags = flags;
 	revs->rev_input_given = 1;
-	cb->refs = NULL;
+	cb->wt = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1278,15 +1278,20 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int handle_one_reflog(const char *refname,
+static int handle_one_reflog(const char *refname_in_wt,
 			     const struct object_id *oid,
 			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
+	struct strbuf refname = STRBUF_INIT;
+
 	cb->warned_bad_reflog = 0;
-	cb->name_for_errormsg = refname;
-	refs_for_each_reflog_ent(cb->refs, refname,
+	strbuf_worktree_ref(cb->wt, &refname, refname_in_wt);
+	cb->name_for_errormsg = refname.buf;
+	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+				 refname.buf,
 				 handle_one_reflog_ent, cb_data);
+	strbuf_release(&refname);
 	return 0;
 }
 
@@ -1301,8 +1306,8 @@ static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
 		if (wt->is_current)
 			continue;
 
-		cb->refs = get_worktree_ref_store(wt);
-		refs_for_each_reflog(cb->refs,
+		cb->wt = wt;
+		refs_for_each_reflog(get_worktree_ref_store(wt),
 				     handle_one_reflog,
 				     cb);
 	}
@@ -1315,7 +1320,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store(revs->repo);
+	cb.wt = NULL;
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
diff --git a/worktree.c b/worktree.c
index 4193496f2a..e6a65ec684 100644
--- a/worktree.c
+++ b/worktree.c
@@ -517,6 +517,45 @@ int parse_worktree_ref(const char *worktree_ref, const char **name,
 	return -1;
 }
 
+void strbuf_worktree_ref(const struct worktree *wt,
+			 struct strbuf *sb,
+			 const char *refname)
+{
+	switch (ref_type(refname)) {
+	case REF_TYPE_PSEUDOREF:
+	case REF_TYPE_PER_WORKTREE:
+		if (wt && !wt->is_current) {
+			if (is_main_worktree(wt))
+				strbuf_addstr(sb, "main-worktree/");
+			else
+				strbuf_addf(sb, "worktrees/%s/", wt->id);
+		}
+		break;
+
+	case REF_TYPE_MAIN_PSEUDOREF:
+	case REF_TYPE_OTHER_PSEUDOREF:
+		break;
+
+	case REF_TYPE_NORMAL:
+		/*
+		 * For shared refs, don't prefix worktrees/ or
+		 * main-worktree/. It's not necessary and
+		 * files-backend.c can't handle it anyway.
+		 */
+		break;
+	}
+	strbuf_addstr(sb, refname);
+}
+
+const char *worktree_ref(const struct worktree *wt, const char *refname)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	strbuf_worktree_ref(wt, &sb, refname);
+	return sb.buf;
+}
+
 int other_head_refs(each_ref_fn fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
@@ -525,13 +564,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	worktrees = get_worktrees(0);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct ref_store *refs;
+		struct object_id oid;
+		int flag;
 
 		if (wt->is_current)
 			continue;
 
-		refs = get_worktree_ref_store(wt);
-		ret = refs_head_ref(refs, fn, cb_data);
+		if (!refs_read_ref_full(get_main_ref_store(the_repository),
+					worktree_ref(wt, "HEAD"),
+					RESOLVE_REF_READING,
+					&oid, &flag))
+			ret = fn(worktree_ref(wt, "HEAD"), &oid, flag, cb_data);
 		if (ret)
 			break;
 	}
diff --git a/worktree.h b/worktree.h
index 440bb219dd..1164ca396f 100644
--- a/worktree.h
+++ b/worktree.h
@@ -117,4 +117,19 @@ extern const char *worktree_git_path(const struct worktree *wt,
  */
 int parse_worktree_ref(const char *worktree_ref, const char **name,
 		       int *name_length, const char **ref);
+
+/*
+ * Return a refname suitable for access from the current ref store.
+ */
+void strbuf_worktree_ref(const struct worktree *wt,
+			 struct strbuf *sb,
+			 const char *refname);
+
+/*
+ * Return a refname suitable for access from the current ref
+ * store. The result will be destroyed at the next call.
+ */
+const char *worktree_ref(const struct worktree *wt,
+			 const char *refname);
+
 #endif
-- 
2.19.1.647.g708186aaf9

