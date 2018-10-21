Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A1C1F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJUQWt (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44885 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJUQWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id m18-v6so28081093lfl.11
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQSJ/OJiKdgDiHynUxM85a5wcFSvPZI24npdJx7rbnc=;
        b=EDctusfSNmL1YqLUnvz84vZOpjp1Eaqc5Qs9mczX6zX+67P22zmwVPfMHtxh1KAZ1l
         lzVYzNDG1X0vXSOmayRpjHbeNBMik+t2HyMZazXCa/mxwE2jc6sp0uAPYv+fwcKfOwRS
         YVqg88jbLWlTYFOOnRnhwQLBRHbBwcpTnNWnX5dGBzzxxECM+bkqoEB1sQaPf30vwQrx
         eA3uY3BOJZLfi2l6pkrYLWcHcBjRcXcJUCTlDgyncFYwp6AbJWw6ZGIskhXcmqK2s7nw
         Qljp9o+7bAUi+h5diEANOR/Uo/ejzuVLsA8l/5v4gMbCBBhikBpbmoNIUEyF0460d4wb
         Va5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQSJ/OJiKdgDiHynUxM85a5wcFSvPZI24npdJx7rbnc=;
        b=GilIxvcSBYGlGwsk5jn8t3zrp/DsdcDXGHAZxjhGpLFP0buMChtWCSdMOQXwubZi6G
         GazmmJjWDE7xb8AN0qlc7ZHou5Nb5uEVNaakJ3PC6bWWVquvWDJdPstCVICN5LmGHtPg
         xXCkHZQXxXD0TfVbxe9f1HsVigk5o6FdJmGV3QDskOZ2ADlZuVAtE9KPXOW2DJiDxwFt
         kMz+RIye2E+BnttzS6LNQD37ZF9JKdcjhybBAoJ7cbEG4VyYkyhmgmRt6KbY8469Jd34
         3d2i7J2NPXvfNbc000ukyADFtlx4HRiVgJd8/o4TmX6INA3txPFJsnlsAaVb4nPsgSYu
         7M7A==
X-Gm-Message-State: ABuFfojsEkNhtRU5d78rkwsl9zszS6pm3SIytKxHRRw+tYHtBaicwRRy
        gOt13XzuAQIEtc+OuHrfHlQ=
X-Google-Smtp-Source: ACcGV60O0VD5/mP+ElHnWOcw/ApPyt+P0fpZcwYP7Z8LTVfvHYUH3GnBzn49VvIaJD0ckVpQhXnkhw==
X-Received: by 2002:a19:1202:: with SMTP id h2mr992945lfi.122.1540109356597;
        Sun, 21 Oct 2018 01:09:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 8/8] reflog expire: cover reflog from all worktrees
Date:   Sun, 21 Oct 2018 10:08:59 +0200
Message-Id: <20181021080859.3203-9-pclouds@gmail.com>
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

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-reflog.txt |  7 +++++-
 builtin/reflog.c             | 46 ++++++++++++++++++++++++++++++++----
 t/t1410-reflog.sh            | 15 ++++++++++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 472a6808cd..ff487ff77d 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -20,7 +20,7 @@ depending on the subcommand:
 'git reflog' ['show'] [log-options] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
-	[--dry-run | -n] [--verbose] [--all | <refs>...]
+	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] ref@\{specifier\}...
 'git reflog exists' <ref>
@@ -72,6 +72,11 @@ Options for `expire`
 --all::
 	Process the reflogs of all references.
 
+--single-worktree::
+	By default when `--all` is specified, reflogs from all working
+	trees are processed. This option limits the processing to reflogs
+	from the current working tree only.
+
 --expire=<time>::
 	Prune entries older than the specified time. If this option is
 	not specified, the expiration time is taken from the
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b5941c1ff3..7a85e4b164 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -10,6 +10,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
+#include "worktree.h"
 
 /* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
@@ -52,6 +53,7 @@ struct collect_reflog_cb {
 	struct collected_reflog **e;
 	int alloc;
 	int nr;
+	struct worktree *wt;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -330,13 +332,27 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int is_head(const char *refname)
+{
+	switch (ref_type(refname)) {
+	case REF_TYPE_OTHER_PSEUDOREF:
+	case REF_TYPE_MAIN_PSEUDOREF:
+		if (parse_worktree_ref(refname, NULL, NULL, &refname))
+			BUG("not a worktree ref: %s", refname);
+		break;
+	default:
+		break;
+	}
+	return !strcmp(refname, "HEAD");
+}
+
 static void reflog_expiry_prepare(const char *refname,
 				  const struct object_id *oid,
 				  void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 
-	if (!cb->cmd.expire_unreachable || !strcmp(refname, "HEAD")) {
+	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->tip_commit = NULL;
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
@@ -388,8 +404,19 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 {
 	struct collected_reflog *e;
 	struct collect_reflog_cb *cb = cb_data;
+	struct strbuf newref = STRBUF_INIT;
+
+	/*
+	 * Avoid collecting the same shared ref multiple times because
+	 * they are available via all worktrees.
+	 */
+	if (!cb->wt->is_current && ref_type(ref) == REF_TYPE_NORMAL)
+		return 0;
+
+	strbuf_worktree_ref(cb->wt, &newref, ref);
+	FLEX_ALLOC_STR(e, reflog, newref.buf);
+	strbuf_release(&newref);
 
-	FLEX_ALLOC_STR(e, reflog, ref);
 	oidcpy(&e->oid, oid);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
@@ -512,7 +539,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
 	timestamp_t now = time(NULL);
-	int i, status, do_all;
+	int i, status, do_all, all_worktrees = 1;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
 
@@ -549,6 +576,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
+		else if (!strcmp(arg, "--single-worktree"))
+			all_worktrees = 0;
 		else if (!strcmp(arg, "--verbose"))
 			flags |= EXPIRE_REFLOGS_VERBOSE;
 		else if (!strcmp(arg, "--")) {
@@ -577,10 +606,19 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	if (do_all) {
 		struct collect_reflog_cb collected;
+		struct worktree **worktrees, **p;
 		int i;
 
 		memset(&collected, 0, sizeof(collected));
-		for_each_reflog(collect_reflog, &collected);
+		worktrees = get_worktrees(0);
+		for (p = worktrees; *p; p++) {
+			if (!all_worktrees && !(*p)->is_current)
+				continue;
+			collected.wt = *p;
+			refs_for_each_reflog(get_worktree_ref_store(*p),
+					     collect_reflog, &collected);
+		}
+		free_worktrees(worktrees);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388b0611d8..3e053532eb 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -368,4 +368,19 @@ test_expect_success 'continue walking past root commits' '
 	)
 '
 
+test_expect_success 'expire with multiple worktrees' '
+	git init main-wt &&
+	(
+		cd main-wt &&
+		test_tick &&
+		test_commit foo &&
+		git  worktree add link-wt &&
+		test_tick &&
+		test_commit -C link-wt foobar &&
+		test_tick &&
+		git reflog expire --verbose --all --expire=$test_tick &&
+		test_must_be_empty .git/worktrees/link-wt/logs/HEAD
+	)
+'
+
 test_done
-- 
2.19.1.647.g708186aaf9

