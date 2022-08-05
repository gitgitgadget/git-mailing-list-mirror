Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF2C19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiHEDGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiHEDGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:06:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C2AEE38
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:06:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so1577376pgb.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+6w4KbvUR8fvO/OdiGiJz3W8kvsA10zemHwlZRgFrQ=;
        b=kOr8eHAHMbRpKX34oT58TwCcnOaKZCBxLKsbox7IOGsOJboIeCvhIWnk/ClsAg4AUs
         Bi1cbTcOTRTqB1FTnCp9nWzMtmQ4ig5Hb5E7qzwLigz5ogOQCrVecnn+hN6LaGpbab/I
         6kDv8VSizZJUwu+B7naTvNnNiQe/GSccYsalUcv8tmPcpQVAmycuuEe88/2YXDBYTBpB
         GvJZyNp62PxS5ntyvk28jq98oQ20X/nVG0S71v0VO8hnC8imYgqXfLmoEYAiCaXAEvJg
         Jb9iF/P2r2Jh16KOyoI3wirlKOMgV8qA2xm+4mmhM5ahuUvZFjzjUZIwxcbS+BN2joGj
         HMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+6w4KbvUR8fvO/OdiGiJz3W8kvsA10zemHwlZRgFrQ=;
        b=AIY+adLw4dc3KEJqOjR+mL/aey2iU0pQVzJ17dppYAo9dcV6vcfZNd3/50MYXwoyvo
         9jKhG1GbQq8e5XNNIbeiOaNjdPwWwI7yKDQI55SxinA+6HZ07AG9H+mJxP2I/GTExm9R
         eJuoXfOzsp4vGSqhz0MyGVSXw2+IFmpL4i/fMOnYv7s0gqec1osSoiak0DI1H1javXQO
         vSxrxg5xMsuzAg6vKodd6NLE0rKJ4JA4SSABwyJQZuWClglk7HBlQ2PWVYp0cOuZ6+s2
         J1sMYPCMWSpMxiL1/T0PGOAZgcxJ7mvh0usdm7EC+zt+oORa7sdm07hzfhe9DgCU3BXH
         457g==
X-Gm-Message-State: ACgBeo3xL970iTa3gnAGBs4yxbfTToIA9cWNy8KCXG0W8k6+q+m9ZNf9
        7JONta5OZ81QFdzU7fRaBzKdXocZZCIftocJ
X-Google-Smtp-Source: AA6agR5Qh+TqALfkQBIurx5C0DO8ySIcCRovBqOpRQGPghx/D7BypernCJexx2ifnIsj1CtyOJqkYQ==
X-Received: by 2002:a63:3243:0:b0:41c:ea5f:b29d with SMTP id y64-20020a633243000000b0041cea5fb29dmr3300477pgy.433.1659668762338;
        Thu, 04 Aug 2022 20:06:02 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:06:02 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 8/9] advice.h: add advise_on_moving_dirty_path()
Date:   Fri,  5 Aug 2022 11:05:27 +0800
Message-Id: <20220805030528.1535376-9-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
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
index a58387a986..765a1e8eb5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -514,6 +514,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	strbuf_release(&a_src_dir);
 	free(src_dir);
 
+	if (dirty_paths.nr)
+		advise_on_moving_dirty_path(&dirty_paths);
+
 	if (gitmodules_modified)
 		stage_updated_gitmodules(&the_index);
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 23d0c4cec6..f0b32a2f70 100755
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
@@ -355,6 +368,10 @@ test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	test_cmp expect stderr &&
 
 	git mv --sparse sub/d folder1 2>stderr &&
+	cat dirty_error_header >expect &&
+	echo "folder1/d" >>expect &&
+	cat dirty_hint >>expect &&
+	test_cmp expect stderr &&
 
 	test_path_is_missing sub/d &&
 	test_path_is_file folder1/d &&
@@ -402,6 +419,11 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
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

