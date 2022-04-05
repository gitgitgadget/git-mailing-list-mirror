Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE2FC433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiDEFW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDEFWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4152636
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b13so11130462pfv.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZfEZIociS2yIjQZ+sSOCvFX8pmkYasQu1B5aSLLwZI=;
        b=SGRloEWldblO7pNpbMxqQA6/gcX45rNKb5Wkh3gWSX/WSNbZfaGqRIr+UH9L5cwxiu
         3t0Km+vTHj9S8vfZZRptlyrnu2KrrIVd7SLu8INov25+bQXb/WHIDErzcUZXVig5vVk7
         /moTMWqNo9ULPO9tguRxa++gblJ9gU+KD/Yk3rOrsFeLTlJVlCDdjwaqHvErvV0d4ubt
         lAmyEI87Gd7KFAFrg3h5PGBOkq1zj96NO5jR3SmgJ4JFgc37n/G0K/jiQV4TsosOp7iD
         QG4XRJFGdrYkt877Ah99024dfFnhjzYT+yIp95+YZJjetWyybhtJ8wqRW2fD29kL5PdN
         I70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZfEZIociS2yIjQZ+sSOCvFX8pmkYasQu1B5aSLLwZI=;
        b=C1Qmc3//nQx7ZvpvZUECToRl4oJsUL8OWQ1iBn82XLUz9GPeegQBKWwW3GTV6ks3MB
         2HqkjV7l5FsJ+O6WZI7Jd7y/U6xfPnqY2DnjugIlBtFkl6Hw8z+9owC4s/DBeOhVBQ2J
         mNWLATIwu+sz1LF2h61Qjx1XK7BrkvC5XFAzmY/QPHB3AdDZ1qLLCQWllp2Vq2qw487n
         2vLHj8H9kM/XX5cYfoyeZUat7ZdhG8sWiy6DsI/o6WM4o6UCnWJsVT73y8ouyqzZD1zs
         7+mvkqP4VPUK6CKGsFKxbkQ4nNfxr1xrQczYWYxXAQX4UpK9t7cQafFOX0NUH02ExHrF
         4lvA==
X-Gm-Message-State: AOAM530bDZZqLuirAbjP78H6i7fjewwmw95r1X7nkcFVRBR0SPEt9BAS
        NwqkOzJWJz6cVRnEwBjGdKI=
X-Google-Smtp-Source: ABdhPJyJiKbjV15HwNYBlY7Qn+FUa7550v7JG/s42N5ao4azSwblA+JkxtL/QmANq3yreNhA3ypGSQ==
X-Received: by 2002:a63:5317:0:b0:399:58e9:882b with SMTP id h23-20020a635317000000b0039958e9882bmr1451243pgb.306.1649136026030;
        Mon, 04 Apr 2022 22:20:26 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:25 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 02/12] bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
Date:   Mon,  4 Apr 2022 22:20:08 -0700
Message-Id: <20220405052018.11247-3-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Make it clearer in the naming and documentation of the plug_bulk_checkin
and unplug_bulk_checkin APIs that they can be thought of as
a "transaction" to optimize operations on the object database. These
transactions may be nested so that subsystems like the cache-tree
writing code can optimize their operations without caring whether the
top-level code has a transaction active.

Add a flush_odb_transaction API that will be used in update-index to
make objects visible even if a transaction is active. The flush call may
also be useful in future cases if we hold a transaction active around
calling hooks.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/add.c  |  4 ++--
 bulk-checkin.c | 25 +++++++++++++++++--------
 bulk-checkin.h | 24 ++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3ffb86a4338..9bf37ceae8e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -670,7 +670,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	plug_bulk_checkin();
+	begin_odb_transaction();
 
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
@@ -682,7 +682,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
-	unplug_bulk_checkin();
+	end_odb_transaction();
 
 finish:
 	if (write_locked_index(&the_index, &lock_file,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 88d72178b2c..0fb032c7b69 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,7 +10,7 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static int bulk_checkin_plugged;
+static int odb_transaction_nesting;
 
 static struct bulk_checkin_packfile {
 	char *pack_tmp_name;
@@ -280,20 +280,29 @@ int index_bulk_checkin(struct object_id *oid,
 {
 	int status = deflate_to_pack(&bulk_checkin_packfile, oid, fd, size, type,
 				     path, flags);
-	if (!bulk_checkin_plugged)
+	if (!odb_transaction_nesting)
 		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
 	return status;
 }
 
-void plug_bulk_checkin(void)
+void begin_odb_transaction(void)
 {
-	assert(!bulk_checkin_plugged);
-	bulk_checkin_plugged = 1;
+	odb_transaction_nesting += 1;
 }
 
-void unplug_bulk_checkin(void)
+void flush_odb_transaction(void)
 {
-	assert(bulk_checkin_plugged);
-	bulk_checkin_plugged = 0;
 	flush_bulk_checkin_packfile(&bulk_checkin_packfile);
 }
+
+void end_odb_transaction(void)
+{
+	odb_transaction_nesting -= 1;
+	if (odb_transaction_nesting < 0)
+		BUG("Unbalanced ODB transaction nesting");
+
+	if (odb_transaction_nesting)
+		return;
+
+	flush_odb_transaction();
+}
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b26f3dc3b74..ee0832989a8 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -10,7 +10,27 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags);
 
-void plug_bulk_checkin(void);
-void unplug_bulk_checkin(void);
+/*
+ * Tell the object database to optimize for adding
+ * multiple objects. end_odb_transaction must be called
+ * to make new objects visible. Transactions can be nested,
+ * and objects are only visible after the outermost transaction
+ * is complete or the transaction is flushed.
+ */
+void begin_odb_transaction(void);
+
+/*
+ * Make any objects that are currently part of a pending object
+ * database transaction visible. It is valid to call this function
+ * even if no transaction is active.
+ */
+void flush_odb_transaction(void);
+
+/*
+ * Tell the object database to make any objects from the
+ * current transaction visible if this is the final nested
+ * transaction.
+ */
+void end_odb_transaction(void);
 
 #endif
-- 
2.34.1.78.g86e39b8f8d

