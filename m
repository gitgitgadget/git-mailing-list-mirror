Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A50C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiCUHfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiCUHfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C319192B4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s11so14669596pfu.13
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MErRpfnVkg7CEB9VOLwBllqQC8cdkdTVDeLq8PZFpns=;
        b=B5E3RaayK18lRoLnS3BW40+olOj8y3+CxOjK+A4KDU3zkFuAyNhYJqmwF/YVKvK560
         OhPCe0ZXrBItiyxqk2WQxLWd/vOY1Uje0BdP4mujUOD0DiRHV31ipH8vjWarzwYIhUMa
         uvfVvGRI1RGvU11ZiDTOXWvQpf/hTUAzxKSVbwv4MpHpX4XTEvJuKFUKjO2LUhwFLJG6
         13E33qsI9ZBJ6K1lNx59yZjjoJZOesuoaAbA+6BF6aiwmIIhYorcmdQI0/LCweUXNFJD
         +hi7WPqsXAPxdY59iI7DJwbYfGRd1oNXtqSNJ5R9SnOYhnV8KyxnbnYVH2lw4ryjyDJD
         d2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MErRpfnVkg7CEB9VOLwBllqQC8cdkdTVDeLq8PZFpns=;
        b=zu+6wS35GZX2QGHPI8+zP24QAJL5oIyNnhPTTKQsxUktqN8LF0hTR3TruMWZgAFlIG
         VERFqrsj1hnUig90PDSmcN9Xubg1LT1EnqZeazShcXR5cOgSrVt+VBvwhhn5QnjsFlug
         e3A3hR+8y3JFZRfPVhL+xlDbPkxsIDk43JYQDCVeSZ+lGeuX5lW6oajgCAnmQVd1VbOS
         rF8DEatv28pmvcd8HbTWUJ1v7ctkFQURlf+jrzeYsnn4jD+XIZKNahJFkaoFzhtDpCOp
         Os5XXTm6reS8Z3Rhqvu48fOgi3LehFpphzRiPNegBdNLkcL104XCnHb/hVlr2usKuj2C
         ib+g==
X-Gm-Message-State: AOAM5328KFoW1ckQrQ1tF5R6wtuXxaUTA+Vk+hq9TwCzJ+ehQno8fuYB
        BvugHmX42ASYksMXqll27Xo=
X-Google-Smtp-Source: ABdhPJyuNrqpGYt/uFkkBQSeHCITeHOOHkPbnshvi6/moCimQiunYOmiu764KRd0Q/0Ayk8uqLonwg==
X-Received: by 2002:a63:f10c:0:b0:382:623b:3bb9 with SMTP id f12-20020a63f10c000000b00382623b3bb9mr5977964pgi.97.1647848059706;
        Mon, 21 Mar 2022 00:34:19 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 14/16] ls-tree: detect and error on --name-only --name-status
Date:   Mon, 21 Mar 2022 15:33:28 +0800
Message-Id: <89402a851806aabfcde6ebcbcb2bc16826d7ed4e.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The --name-only and --name-status options are synonyms, but let's
detect and error if both are provided.

In addition let's add explicit --format tests for the combination of
these various options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c       | 11 ++++++++++-
 t/t3103-ls-tree-misc.sh | 15 +++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1aa65cc87f..a271941540 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -52,6 +52,7 @@ static const  char * const ls_tree_usage[] = {
 static enum ls_tree_cmdmode {
 	MODE_LONG = 1,
 	MODE_NAME_ONLY,
+	MODE_NAME_STATUS,
 	MODE_OBJECT_ONLY,
 } cmdmode;
 
@@ -301,7 +302,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
-			    MODE_NAME_ONLY),
+			    MODE_NAME_STATUS),
 		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
@@ -327,6 +328,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		ls_tree_prefix = prefix = NULL;
 		chomp_prefix = 0;
 	}
+	/*
+	 * We wanted to detect conflicts between --name-only and
+	 * --name-status, but once we're done with that subsequent
+	 * code should only need to check the primary name.
+	 */
+	if (cmdmode == MODE_NAME_STATUS)
+		cmdmode = MODE_NAME_ONLY;
+
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d979c0df5d..7454ebbb00 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -24,15 +24,18 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 '
 
 for opts in \
-	"--name-only --long" \
-	"--name-status --long" \
-	"--name-only --object-only" \
+	"--long --name-only" \
+	"--name-only --name-status" \
 	"--name-status --object-only" \
-	"--object-only --long" \
-	"--object-only --format"
+	"--object-only --long" 
 do
 	test_expect_success "usage: incompatible options: $opts" '
 		test_expect_code 129 git ls-tree $opts $tree
-    '
+	'
+
+	one_opt=$(echo "$opts" | cut -d' '  -f1)
+	test_expect_success "usage: incompatible options: $one_opt and --format" '
+		test_expect_code 129 git ls-tree $one_opt --format=fmt $tree
+	'
 done
 test_done
-- 
2.34.1.406.g2e0e55130e

