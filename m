Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00917C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiHIMKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiHIMJy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136324BE7
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p8so11113384plq.13
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9fad2qurKeXw5sLEpwY3Y82BlmeQT41QuC73U++aYY=;
        b=N505Yzun+2SR2GJXrcT9pXC5HWFrzpg+ysu5T33BMZnNucAD29AdIO28BR6SjYUBWK
         voXBz+sfvtQYkxMbAi7o6jgZRI+JRbzJsKs7l8sc9Qj3HJ6qKA2ZfZeKd+zTlNU31P+j
         2egcmt6Ts3mdhE8zCrULSYBtDA4zjaLe+W9g3SiAOV0tdNYYyRIK2ZGSCGsJ0Rz96yRL
         AJFnxyHdyxupAWvUdYxml26n4jtTXbX17OIm+3Z1DRxBmYF7joiLRZzGxX24SryDijGG
         KCd7f2MdYw3whwHJcoytcYr6fPzMFPmBI7ue/yEQllcrfveMt1HutXdN6YGN8QPLw9hb
         QhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9fad2qurKeXw5sLEpwY3Y82BlmeQT41QuC73U++aYY=;
        b=vo8cZEdftKTDFWosmsAo12A0JeTWVm4Q9eSs6Li+CcHVdcBSFZ4Pu5kH0uU7ElVJrt
         Sgyd1FX13SBU6ZuuZcTJMp5WpGa5yDQeYXpk+3prmdD+GsIvLfTNBZlvMAcN0z+We93W
         hguNqbX8XV6D7RHf3p/7pprf1okHRzD767kV3w+Q9/J/vyEo5Mii3DUQHJ3E69nEKogo
         JESj8zOgEir4U6HdrEvrG7hHgJpdv9m+2W+ZIoEJwdZdNXlTKHwlQOlAX78hXk+cphtu
         Zu+yRdaK/+ucg69XPC21eI/BOd/KiGu8EugXAa3vZu9dFEy7t0YMvhe1xnhUrf/X8oeC
         q/PQ==
X-Gm-Message-State: ACgBeo1IXLgyBmfsXEXUsaL7yQ/enZHvTPcstdQdickU1sPWvljeAqrT
        AsXzsSsf5Hu3Zwmrox/bGqTZMk/MnnEJCA==
X-Google-Smtp-Source: AA6agR6LlpYMamQQ5qJfKxd4vEutIZKD5JzdqIAtGPn7GVHH6LlhvpkkXWYmrgqCYbeop8+6vhU6Tg==
X-Received: by 2002:a17:90b:380d:b0:1f5:2c6d:7de8 with SMTP id mq13-20020a17090b380d00b001f52c6d7de8mr33866239pjb.18.1660046986365;
        Tue, 09 Aug 2022 05:09:46 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:46 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 8/9] advice.h: add advise_on_moving_dirty_path()
Date:   Tue,  9 Aug 2022 20:09:09 +0800
Message-Id: <20220809120910.2021413-9-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an advice.

When the user use `git mv --sparse <dirty-path> <destination>`, Git
will warn the user to use `git add --sparse <paths>` then use
`git sparse-checkout reapply` to apply the sparsity rules.

Add a few lines to previous "move dirty path" tests so we can test
this new advice is working.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 advice.c                      | 19 +++++++++++++++++++
 advice.h                      |  1 +
 builtin/mv.c                  |  3 +++
 t/t7002-mv-sparse-checkout.sh | 24 +++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 6fda9edbc2..fd18968943 100644
--- a/advice.c
+++ b/advice.c
@@ -261,3 +261,22 @@ void detach_advice(const char *new_name)
 
 	fprintf(stderr, fmt, new_name);
 }
+
+void advise_on_moving_dirty_path(struct string_list *pathspec_list)
+{
+	struct string_list_item *item;
+
+	if (!pathspec_list->nr)
+		return;
+
+	fprintf(stderr, _("The following paths have been moved outside the\n"
+			  "sparse-checkout definition but are not sparse due to local\n"
+			  "modifications.\n"));
+	for_each_string_list_item(item, pathspec_list)
+		fprintf(stderr, "%s\n", item->string);
+
+	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
+			  _("To correct the sparsity of these paths, do the following:\n"
+			    "* Use \"git add --sparse <paths>\" to update the index\n"
+			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
+}
diff --git a/advice.h b/advice.h
index 7ddc6cbc1a..07e0f76833 100644
--- a/advice.h
+++ b/advice.h
@@ -74,5 +74,6 @@ void NORETURN die_conclude_merge(void);
 void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
+void advise_on_moving_dirty_path(struct string_list *pathspec_list);
 
 #endif /* ADVICE_H */
diff --git a/builtin/mv.c b/builtin/mv.c
index 32e7ac4896..a396a030c7 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -530,6 +530,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	strbuf_release(&a_src_dir);
 	free(src_dir);
 
+	if (dirty_paths.nr)
+		advise_on_moving_dirty_path(&dirty_paths);
+
 	if (gitmodules_modified)
 		stage_updated_gitmodules(&the_index);
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index df8c0fa572..5e5eb70e7a 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -28,12 +28,25 @@ test_expect_success 'setup' "
 	updated in the index:
 	EOF
 
-	cat >sparse_hint <<-EOF
+	cat >sparse_hint <<-EOF &&
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
 	hint: Disable this message with \"git config advice.updateSparsePath false\"
 	EOF
+
+	cat >dirty_error_header <<-EOF &&
+	The following paths have been moved outside the
+	sparse-checkout definition but are not sparse due to local
+	modifications.
+	EOF
+
+	cat >dirty_hint <<-EOF
+	hint: To correct the sparsity of these paths, do the following:
+	hint: * Use \"git add --sparse <paths>\" to update the index
+	hint: * Use \"git sparse-checkout reapply\" to apply the sparsity rules
+	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	EOF
 "
 
 test_expect_success 'mv refuses to move sparse-to-sparse' '
@@ -431,6 +444,10 @@ test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	test_cmp expect stderr &&
 
 	git mv --sparse sub/d folder1 2>stderr &&
+	cat dirty_error_header >expect &&
+	echo "folder1/d" >>expect &&
+	cat dirty_hint >>expect &&
+	test_cmp expect stderr &&
 
 	test_path_is_missing sub/d &&
 	test_path_is_file folder1/d &&
@@ -478,6 +495,11 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_cmp expect stderr &&
 
 	git mv --sparse sub/dir folder1 2>stderr &&
+	cat dirty_error_header >expect &&
+	echo "folder1/dir/e2" >>expect &&
+	echo "folder1/dir/e3" >>expect &&
+	cat dirty_hint >>expect &&
+	test_cmp expect stderr &&
 
 	test_path_is_missing sub/dir &&
 	test_path_is_missing folder1/dir/e &&
-- 
2.37.0

