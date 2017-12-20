Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8791F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756232AbdLTWRm (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:17:42 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:37385 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755715AbdLTWRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:17:37 -0500
Received: by mail-it0-f66.google.com with SMTP id d137so8603588itc.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gv57sPYRvD6vcI4cRiXxSoZgKhAyf4moJ6t+xcu4+JU=;
        b=CiBdKAOs0sZ6pBTKK4OXm+VeDfygET1qDxMtGyLamFqOpYQyZepf8z10iETIehewbX
         gpo7FSjxXjS7cl91TJfQJ+WmRp0ZiQ4eWu6v3EYBvMos5rU3nCZ4z1pF+6mT1ac7tvTG
         FXNT+uWaX/4mM+rmuInTxHRG5dFWtjoKRblvQMhHQyTEKvLgL4dnM08buR6Hq8ZAMS7r
         a6es1RJfVifMVCAj1n0ness8edSZIlYZ3VwOogN2fwNz3t9/HLiNbV9FHjNn94gg/bD9
         9Gu2xqHu2wzDYwgFaN03DENPW360wHqFVjk6FoII99hiEeCRzFSYGMpvJvctMtxGORZc
         3GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gv57sPYRvD6vcI4cRiXxSoZgKhAyf4moJ6t+xcu4+JU=;
        b=EKkkLKZa3JR6Iiw61x7nlET4Z8YgID3A6JKINj6bkohSUzctJVL8NlB5OgvpieFjti
         wF/qS1gJmMKvUEi8jLK5efJ+tzXNPCJlMGTzLvNh/J0qyAk1DrP5eX7MbnzEagl598F5
         KEhozoYXn98Ikywt02eSkxE674Zvrm70qGb1xGCtcUscGIbg2/h7ZWUF+xyqSeVHN3ky
         EzYhBEWyrW5hcKm5g1BlCZwYox02gVzGhutGl5fjd5BENGJa01kGksmIGapNeKc8pJRQ
         ZQZyIUUEmcgJUQ9naF3tPEAJkkmwzBIZDZ3sIc8R963j4msbddGUj84A9NN5YOgJKu+N
         e6nQ==
X-Gm-Message-State: AKGB3mLfZB5SYPocWgdggzlveio8G5Ofav14i4HVr3nbwTIXLI4UMFZI
        3Bbj8TZEadFVhc1KTzrCIOff9Q==
X-Google-Smtp-Source: ACJfBoulJ3RCd96xSVz3mMTNTySNULzyXiQ6NX60wAPC66wKtLj9kILG11Gr3LHkL1MSqhq82t3BGg==
X-Received: by 10.36.123.134 with SMTP id q128mr10378257itc.80.1513808255399;
        Wed, 20 Dec 2017 14:17:35 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i27sm2522947iod.29.2017.12.20.14.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 14:17:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] submodule: submodule_move_head omits old argument in forced case
Date:   Wed, 20 Dec 2017 14:17:25 -0800
Message-Id: <20171220221725.129162-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171220221725.129162-1-sbeller@google.com>
References: <20171220221725.129162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using hard reset or forced checkout with the option to recurse into
submodules, the submodules need to be reset, too.

It turns out that we need to omit the duplicate old argument to read-tree
in all forced cases to omit the 2 way merge and use the more assertive
behavior of reading the specific new tree into the index and updating
the working tree.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index fa25888783..db0f7ac51e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1653,7 +1653,9 @@ int submodule_move_head(const char *path,
 	else
 		argv_array_push(&cp.args, "-m");
 
-	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
+		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+
 	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
 
 	if (run_command(&cp)) {
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb0173ea87..380ef4b4ae 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1015,4 +1015,15 @@ test_submodule_forced_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
+
+	test_expect_success "$command: changed submodule worktree is reset" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			rm sub1/file1 &&
+			$command HEAD &&
+			test_path_is_file sub1/file1
+		)
+	'
 }
-- 
2.15.1.620.gb9897f4670-goog

