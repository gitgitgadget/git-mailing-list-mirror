Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FFEEB560
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjIHRm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjIHRmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:42:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16BC1FC9
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:42:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso284185466b.0
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694194939; x=1694799739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjVfJvqfr/Pfckjht5zG6LB+Gb/+oPAp4uSbVKVao7k=;
        b=R6TeoI+avL22nBvT3s5GXjE9dzmVMEUV8Y68B0lR+BGCE8D9atTQ7K1R3y8/oeCOV4
         s/GijIcBoB0ef73KQTQ1RamXwX0HERkZjaiDFjc6HYHLCn1KSUkvGHOD47Mo/rwei6ma
         E5TxPu17q642W6LqAystgiFydPKXBoEXZyQ64TuGybcxXjEtZkLt9RF8kMN+6Q5saxRe
         9xVvSgfYzNFonu3V6GqHuEWnbJWf6A356DKX/u8Jxgauujvmltip3fvImF/UUn/uUE+S
         XqiWLHw3sAq0JSoEjldUywcAty6DbtJrE0/2iAupOPbfbJq75o5MNygv+29tbfg+dJ8N
         EK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694194939; x=1694799739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjVfJvqfr/Pfckjht5zG6LB+Gb/+oPAp4uSbVKVao7k=;
        b=JweJExYMX/g0Tk9A7eilemZPX2Ve78dlQhPPjXCE4RL0tZWwevIa+IYLdioYDkcQSa
         BMmK3lWcJtKEwXtSbqShVjL9Vg5OZcMEUgCnF5kYjPm2DcnVqntcek4KsRwDShPs33Z3
         H1qXbiPU91b2cAdUC+1yN5p7eUmxqY+jQpXNCRN4ahSPeq+yde2jn0r4zmjeSQ46p0PG
         QvdeNdnkQGYKtd1PsmSPJLRXDkulcm0jB+FejgeMd8oto/97sDGn3tS4EQBhJlYBZkM9
         wZZGd/zyEhy7rsBO7uaBK2J21+n/QAAaIb4OcR3M95srtR9fss+oMe4vMA2fOtGpKv+s
         hE2g==
X-Gm-Message-State: AOJu0Yzl6VIG+FDril7hMc2m5fv327pLb288bHVDrDgImMay1Z/tVJLb
        POrC6H+ojr77oPiXeJqipwJrQb0XWGaxDbz/
X-Google-Smtp-Source: AGHT+IFham03nQxTs3xxW4kZNc9AZEO2tvzLr+AX8apCIDFO3FSJUKhLYylO9jMfp24tyDSDPzKikQ==
X-Received: by 2002:a17:906:7499:b0:9a5:d657:47e5 with SMTP id e25-20020a170906749900b009a5d65747e5mr2187752ejl.49.1694194938816;
        Fri, 08 Sep 2023 10:42:18 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56f:c000:b99d:247a:bd05:7cda])
        by smtp.gmail.com with ESMTPSA id rl9-20020a170907216900b0099cbe71f3b5sm1311184ejb.0.2023.09.08.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 10:42:18 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] revision: add `--ignore-missing-links` user option
Date:   Fri,  8 Sep 2023 19:42:07 +0200
Message-ID: <20230908174208.249184-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision backend is used by multiple porcelain commands such as
git-rev-list(1) and git-log(1). The backend currently supports ignoring
missing links by setting the `ignore_missing_links` bit. This allows the
revision walk to skip any objects links which are missing.

Currently there is no way to use git-rev-list(1) to traverse the objects
of the main object directory (GIT_OBJECT_DIRECTORY) and print the
boundary objects when moving from the main object directory to the
alternate object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES).

By exposing this new flag `--ignore-missing-links`, users can set the
required env variables (GIT_OBJECT_DIRECTORY and
GIT_ALTERNATE_OBJECT_DIRECTORIES) along with the `--boundary` flag to
find the boundary objects between object directories.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/rev-list-options.txt |  5 ++++
 revision.c                         |  2 ++
 t/t6022-rev-list-alternates.sh     | 43 ++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 t/t6022-rev-list-alternates.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a4a0cb93b2..a0b48db8a8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -227,6 +227,11 @@ explicitly.
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
 
+--ignore-missing-links::
+	When an object points to another object that is missing, pretend as if the
+	link did not exist. These missing links are not written to stdout unless
+	the --boundary flag is passed.
+
 ifndef::git-rev-list[]
 --bisect::
 	Pretend as if the bad bisection ref `refs/bisect/bad`
diff --git a/revision.c b/revision.c
index 2f4c53ea20..cbfcbf6e28 100644
--- a/revision.c
+++ b/revision.c
@@ -2595,6 +2595,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	} else if (!strcmp(arg, "--ignore-missing-links")) {
+		revs->ignore_missing_links = 1;
 	} else if (opt && opt->allow_exclude_promisor_objects &&
 		   !strcmp(arg, "--exclude-promisor-objects")) {
 		if (fetch_if_missing)
diff --git a/t/t6022-rev-list-alternates.sh b/t/t6022-rev-list-alternates.sh
new file mode 100755
index 0000000000..626ebb2dce
--- /dev/null
+++ b/t/t6022-rev-list-alternates.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='handling of alternates in rev-list'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# We create 5 commits and move them to the alt directory and
+# create 5 more commits which will stay in the main odb.
+test_expect_success 'create repository and alternate directory' '
+	git init main &&
+	test_commit_bulk -C main 5 &&
+	mkdir alt &&
+	mv main/.git/objects/* alt &&
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_commit_bulk --start=6 -C main 5
+'
+
+# When the alternate odb is provided, all commits are listed.
+test_expect_success 'rev-list passes with alternate object directory' '
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_stdout_line_count = 10 git -C main rev-list HEAD
+'
+
+# When the alternate odb is not provided, rev-list fails since the 5th commit's
+# parent is not present in the main odb.
+test_expect_success 'rev-list fails without alternate object directory' '
+	test_must_fail git -C main rev-list HEAD
+'
+
+# With `--ignore-missing-links`, we stop the traversal when we encounter a
+# missing link.
+test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
+	test_stdout_line_count = 5 git -C main rev-list --ignore-missing-links HEAD
+'
+
+# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
+# commits.
+test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
+	git -C main rev-list --ignore-missing-links --boundary HEAD >list-output &&
+	test_stdout_line_count = 6 cat list-output &&
+	test_stdout_line_count = 1 cat list-output | grep "^-"
+'
+
+test_done
-- 
2.41.0

