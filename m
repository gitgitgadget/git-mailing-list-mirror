Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949CC43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABD820874
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="IgZsSrWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgIUIP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIUIP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 04:15:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08FC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:15:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so11192914wmd.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Uvr6qyYq9yoXnjdXRAPCTm0BqsB9PqakzghFuFix3E=;
        b=IgZsSrWEGtxPNGUQd5HXC6qL05Y1WDODnGJe+dR7g2YTrzRKiGmZUipFOJsmM3WzLy
         U7kGRAptTR8nlYCv9vVNeBJEkci/YPc6OXvv0QCxYXZRZv8rs3V7TfveV0WwbxCsdVoq
         hOjJaK2mXCNStNyIcCnkhcqhrPn3V6azfQRHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Uvr6qyYq9yoXnjdXRAPCTm0BqsB9PqakzghFuFix3E=;
        b=A6SOZ6IJrXvRhKL0jeNoyDc1Nwjn5RkhfeDx1CzzrKbWjfctIiokjmW9AfbvuTu0qq
         ljAj/k7cvDUwraZvJXtcGGVRFrSCe2LTFGj1WYlXzkQdTZr/pD9HcVlEMcVgyYGvBLWJ
         tagoV7AV4cllLGACroYv7KZpIphd3alZbGLgfjWZbz81RauyL2vUXRQ2nD9srV2dyjx7
         li4PD8FkBMd/ZZJusSlHW4Vz0Di47KRKoMSWRU04xnjdmyiUT5jhFjfcXBy+N1xOdM4Y
         FPUNc6aHMOnub/6H8luOR7eeJDokDRq0JC2cwxHIxnjcxbp4dyA6mGaM27gzGQhKPj3L
         +wiA==
X-Gm-Message-State: AOAM530SWhFWNlVI4HZO2P2rXypQWmEViMBQIjHS0h/obYAcJjJyysl1
        9AQ82aDrEiJfu2sCF7oN+7n+WC/6CBzT4A==
X-Google-Smtp-Source: ABdhPJwwDsnN7RYa40rKsOKqujhDwnuDuylM0wqOxqV77hxdwrtUyQpiluTIcNCFjbWpuLYrjTymWQ==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr28216125wmm.2.1600676155656;
        Mon, 21 Sep 2020 01:15:55 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id u17sm21108187wri.45.2020.09.21.01.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:15:55 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     kartic Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/1] Test case for checkout of added/deleted submodules in clones
Date:   Mon, 21 Sep 2020 09:15:37 +0100
Message-Id: <20200921081537.15300-2-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
In-Reply-To: <20200921081537.15300-1-luke@diamand.org>
References: <20200921081537.15300-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test case for various cases of deleted submodules:

1. Clone a repo where an `old` submodule has been removed in HEAD.
Try to checkout a revision from before `old` was deleted.

This can fail in a rather ugly way depending on how the `git checkout`
and `git submodule` commands are used.

2. Clone a repo where a `new` submodule has been added. Try to
checkout a revision from before `new` was added.

This can leave `new` lying around in some circumstances, and not in
others, in a way which is confusing (at least to me).

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t5619-submodules-missing.sh | 104 ++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 t/t5619-submodules-missing.sh

diff --git a/t/t5619-submodules-missing.sh b/t/t5619-submodules-missing.sh
new file mode 100755
index 0000000000..d7878c52fc
--- /dev/null
+++ b/t/t5619-submodules-missing.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='Clone a repo containing submodules. Sync to a revision where the submodule is missing or added'
+
+. ./test-lib.sh
+
+pwd=$(pwd)
+
+# Setup a super project with a submodule called `old`, which gets deleted, and
+# a submodule `new` which is added later on.
+
+test_expect_success 'setup' '
+	mkdir super old new &&
+	git -C old init &&
+	test_commit -C old commit_old &&
+	(cd super &&
+		git init . &&
+		git submodule add ../old old &&
+		git commit -m "adding submodule old" &&
+		test_commit commit2 &&
+		git tag OLD &&
+		test_path_is_file old/commit_old.t &&
+		git rm old &&
+		git commit -m "Remove old submodule" &&
+		test_commit commit3
+	) &&
+	git -C new init &&
+	test_commit -C new commit_new &&
+	(cd super &&
+		git tag BEFORE_NEW &&
+		git submodule add ../new new &&
+		git commit -m "adding submodule new" &&
+		test_commit commit4
+	)
+'
+
+# Checkout the OLD tag inside the original repo. This works fine since all of
+# the submodules are present in .git/modules.
+test_expect_success 'checkout old inside original repo' '
+	(cd super &&
+		git config advice.detachedHead false &&
+		git tag LATEST &&
+		git checkout --recurse-submodules OLD &&
+		git submodule update --checkout --remote --force &&
+		test_path_is_file old/commit_old.t &&
+		test_path_is_missing new/commit_new.t &&
+		git checkout --recurse-submodules LATEST &&
+		test_path_is_file new/commit_new.t
+	)
+'
+
+# Clone the repo, and then checkout the OLD tag inside the clone.
+# The `old` submodule does not get updated. Instead we get:
+#
+# fatal: not a git repository: ../.git/modules/old
+# fatal: could not reset submodule index
+#
+# That's because `old` is missing from .git/modules since it
+# was not cloned originally and `checkout` does not know how to
+# fetch the remote submodules, whereas `submodule update --remote` does.
+
+test_expect_failure 'checkout old with --recurse-submodules' '
+	test_when_finished "rm -fr super-clone" &&
+	git clone --recurse-submodules super super-clone &&
+	(cd super-clone &&
+		git config advice.detachedHead false &&
+		test_path_is_file commit3.t &&
+		test_path_is_file commit2.t &&
+		test_path_is_missing old &&
+		test_path_is_file new/commit_new.t &&
+		git checkout --recurse-submodules OLD &&
+		git submodule update --checkout --remote --force &&
+		test_path_is_file commit2.t &&
+		test_path_is_missing commit3.t &&
+		test_path_is_dir old &&
+		test_path_is_file old/commit_old.t
+	)
+'
+
+# As above, but this time, instead of using "checkout --recurse-submodules" we just
+# use "checkout" to avoid the missing submodule error.
+#
+# The checkout of `old` now works fine, but instead `new` is left lying
+# around with seemingly no way to clean it up. Even a later invocation of
+# `git checkout --recurse-submodules` does not get rid of it.
+
+test_expect_failure 'checkout old without --recurse-submodules' '
+	test_when_finished "rm -fr super-clone" &&
+	git clone --recurse-submodules super super-clone &&
+	(cd super-clone &&
+		git config advice.detachedHead false &&
+		test_path_is_file new/commit_new.t &&
+		git checkout OLD &&
+		git submodule update --checkout --remote --force &&
+		git checkout --recurse-submodules OLD &&
+		test_path_is_file commit2.t &&
+		test_path_is_missing commit3.t &&
+		test_path_is_dir old &&
+		test_path_is_file old/commit_old.t &&
+		test_path_is_missing new/commit_new.t
+	)
+'
+
+test_done
-- 
2.28.0.762.g324f61785e

