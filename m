Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229821F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbeLTTpR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbeLTTpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so2982786wrt.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpJb117B1K2e4z/+lpG/mu2y6lsg2RVSsYgbj/YfSKI=;
        b=CRKBzSBVxRr/NFPR68CCAiS2FCGB7AXi9Ebb4EF3sFIeLuVmIVra26Omfgz1SYKUUL
         Prqfq2DlF0qj3aCpAYRCW6Fte5qvA14wiVYuaTIGzBDritZ+Fqk8AqM+H5mK27G+HiI6
         WxQQNjUTIqOUecDQLbwxYNCB+RXRxUc/YVoFe8pDXZry5J99yqfSXdmuvvp5MLJ4Mv/z
         9US0Rtl5XFNCf/rwC7HhGmUrClMqydrOvAmofihxiPmLpV/VDnA1YOkwqClStfY+lTHc
         SIBTSwkK8J8TRXjzzzC+EYbnmzqrdkdurphW8/SBpM41+jJNAZNHtE6PpIIkpsIs3ESW
         Yo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpJb117B1K2e4z/+lpG/mu2y6lsg2RVSsYgbj/YfSKI=;
        b=CQ5obGQmFYhjeUziR/H2SxLqO/hz6x1sMXh6DK6x+cU1HTAkj0ED9JADg2URtILYKc
         xpBvBSHo1i2Fd1Lo7kin7QturK5QHsTN/80NiJZfek8g3Pre7pCvDIk+uFLcnzn9ZAXb
         Fw7vVo1xwxjEPnbYlgqfrpmF4HNWdKxiyNHAj8chiNWj6KvDzc9v7M+7UthRfdjxT5Bh
         ARL8iD/wtKVR/e1mB59csdeJuJTJb/XHYFuq8lesGhxnVO/oJyUpVhNJtTTRa+i7Lh1S
         GHKuwdgrzEoQsO/KDvTtzYk7/ArPt/qmWUPwndiLQYQqO1pMYc4WAllnCPGmY9dvg07o
         wSwA==
X-Gm-Message-State: AA+aEWapjGkrzWVPQVfQEsZKxiWCIsSVFfgnMQdSjEGVfqkIQOdQKF23
        yzUmvGAi2uchOxsfgYznBtzvVcieuFc=
X-Google-Smtp-Source: AFSGD/Va2oQy2jj7QJY9n2jCrMbLb12EPoIZU68htrite3NkSg5Ky11aL9URlR4hEhQydwLUxwjpLQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr23215857wrq.69.1545335108603;
        Thu, 20 Dec 2018 11:45:08 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:07 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 21/26] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Thu, 20 Dec 2018 21:44:37 +0200
Message-Id: <17f45e4bb48bdf9588d87c7b134afd703dbd69e6.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commits introduces a optimization by avoiding calling the
same functions again. For example, `git stash push -u`
would call at some points the following functions:

 * `check_changes()` (inside `do_push_stash()`)
 * `do_create_stash()`, which calls: `check_changes()` and
`get_untracked_files()`

Note that `check_changes()` also calls `get_untracked_files()`.
So, `check_changes()` is called 2 times and `get_untracked_files()`
3 times.

The old function `check_changes()` now consists of two functions:
`get_untracked_files()` and `check_changes_tracked_files()`.

These are the call chains for `push` and `create`:

 * `push_stash()` -> `do_push_stash()` -> `do_create_stash()`

 * `create_stash()` -> `do_create_stash()`

To prevent calling the same functions over and over again,
`check_changes()` inside `do_create_stash()` is now placed
in the caller functions (`create_stash()` and `do_push_stash()`).
This way `check_changes()` and `get_untracked files()` are called
only one time.

https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 53 +++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 19ead63c46..4b63352927 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -884,18 +884,18 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 }
 
 /*
- * The return value of `check_changes()` can be:
+ * The return value of `check_changes_tracked_files()` can be:
  *
  * < 0 if there was an error
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
-static int check_changes(struct pathspec ps, int include_untracked)
+
+static int check_changes_tracked_files(struct pathspec ps)
 {
 	int result;
 	struct rev_info rev;
 	struct object_id dummy;
-	struct strbuf out = STRBUF_INIT;
 
 	/* No initial commit. */
 	if (get_oid("HEAD", &dummy))
@@ -923,14 +923,26 @@ static int check_changes(struct pathspec ps, int include_untracked)
 	if (diff_result_code(&rev.diffopt, result))
 		return 1;
 
+	return 0;
+}
+
+/*
+ * The function will fill `untracked_files` with the names of untracked files
+ * It will return 1 if there were any changes and 0 if there were not.
+ */
+
+static int check_changes(struct pathspec ps, int include_untracked,
+			 struct strbuf *untracked_files)
+{
+	int ret = 0;
+	if (check_changes_tracked_files(ps))
+		ret = 1;
+
 	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &out)) {
-		strbuf_release(&out);
-		return 1;
-	}
+						     untracked_files))
+		ret = 1;
 
-	strbuf_release(&out);
-	return 0;
+	return ret;
 }
 
 static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
@@ -1141,7 +1153,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		ret = 1;
 		goto done;
 	}
@@ -1166,8 +1178,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &untracked_files)) {
+	if (include_untracked) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
@@ -1252,20 +1263,15 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 			     0);
 
 	memset(&ps, 0, sizeof(ps));
-	strbuf_addstr(&stash_msg_buf, stash_msg);
-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
-			      NULL, 0);
+	if (!check_changes_tracked_files(ps))
+		return 0;
 
-	if (!ret)
+	strbuf_addstr(&stash_msg_buf, stash_msg);
+	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	strbuf_release(&stash_msg_buf);
-
-	/*
-	 * ret can be 1 if there were no changes. In this case, we should
-	 * not error out.
-	 */
-	return ret < 0;
+	return ret;
 }
 
 static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
@@ -1275,6 +1281,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 	struct stash_info info;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
 
 	if (patch_mode && keep_index == -1)
 		keep_index = 1;
@@ -1309,7 +1316,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		goto done;
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		if (!quiet)
 			printf_ln(_("No local changes to save"));
 		goto done;
-- 
2.20.1.441.g764a526393

