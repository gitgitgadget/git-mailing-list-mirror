Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC60C33CA1
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D24206DA
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMXJyAKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUWUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUWUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so3240076wrt.6
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oCa1UKZozp2r7iMnBdi8J69hzu+2k+Oplcwfdq+fCFs=;
        b=aMXJyAKLmV1J5msB26LvX3k3px4SRc6bOlt5ycl+F6ovkG5A6A+mXb3QMUD41IwoqC
         7J8Lq/UwwYyacFcv1UU5PdJqiFUlXDbXul1lvQkq10B4MkLZqgSXBjVNX4C5jdNePQi6
         rE7qTl+nfzgAoFeZcEDW/NO7qIzEc1F2c22PMG3sXv4z1DC4n/ZZnTUjCUxT6ouHDka1
         tX0GW11HRCl7AVKW9rwADZ9ORKrl+RBErFrptBNtm3MmJuLWsO7T83nZxV4DLbdqbg1G
         3S/yWQBEgwY93aOQIgDDrhZgFEhSsZXDJqvNSC6MlqpsER/T/NOcHn1F/dnwlAXSlzW6
         eJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oCa1UKZozp2r7iMnBdi8J69hzu+2k+Oplcwfdq+fCFs=;
        b=JxrM8jFOjD1wPnsQoMNlRaJbEVwEWmwpp3mc6e2p54ZfKos7S0OOskzNHrjERLOvsN
         CPr0WW2Of5jW0h60Tqya8xpnTz1LNpOW4q4EOhuWm+mRMKOHQR1Sw2CZYlS6vkvqGc90
         2RgljWeLTQY1VnaeJptOM19CQ8Rnl4WGuIHT7c+bOwZioaDzygESwoAIeN9il7qlhl1D
         Izmx5F+afo2076RlM4cJWUoQc1OY9GoUSUm1DpC0tTmmAwAjVfFIAefS2rkIytjnKlpx
         Cld+uHEr4vEWoWI18VjelvBdWBQcTk7AKJ0uuI7vMLnU0N1PtRb8H439poiqKhEAxZag
         7MFw==
X-Gm-Message-State: APjAAAXhxCGidtCFaQFsgvUzCPmxafWuCBaE2ehmzhmIwJVXTonZgFT1
        UjpXpLl/hDvbrFNd6ucjZyMhSTCy
X-Google-Smtp-Source: APXvYqy1aqAPklwQ7DLXWRWlh6yMejypT7g+XoQOgWYCwKWDVN8S9woFKIWrK1Jp7IH4prqd/aQIVg==
X-Received: by 2002:a5d:574d:: with SMTP id q13mr14780541wrw.263.1574374832508;
        Thu, 21 Nov 2019 14:20:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u203sm1182830wme.34.2019.11.21.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:32 -0800 (PST)
Message-Id: <36f845cb7ee21443e7f20517968982222e775a6a.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:23 +0000
Subject: [PATCH 08/11] tests: disable fsmonitor in submodule tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature struggles with submodules. Disable the
GIT_TEST_FSMONITOR environment variable before running tests with
a lot of submodule interactions.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t4060-diff-submodule-option-diff-format.sh | 3 +++
 t/t5526-fetch-submodules.sh                  | 2 ++
 t/t7402-submodule-rebase.sh                  | 3 +++
 t/t7406-submodule-update.sh                  | 2 ++
 t/t7506-status-submodule.sh                  | 3 +++
 t/t7508-status.sh                            | 3 +++
 6 files changed, 16 insertions(+)

diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 9dcb69df5c..017417790e 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -15,6 +15,9 @@ This test tries to verify the sanity of --submodule=diff option of git diff.
 # Tested non-UTF-8 encoding
 test_encoding="ISO8859-1"
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 # String "added" in German (translated with Google Translate), encoded in UTF-8,
 # used in sample commit log messages in add_file() function below.
 added=$(printf "hinzugef\303\274gt")
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 63205dfdf9..fb346bff05 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # Copyright (c) 2010, Jens Lehmann
 
+GIT_TEST_FSMONITOR=""
+
 test_description='Recursive "git fetch" for submodules'
 
 . ./test-lib.sh
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..c78e9009cf 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -7,6 +7,9 @@ test_description='Test rebasing, stashing, etc. with submodules'
 
 . ./test-lib.sh
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 test_expect_success setup '
 
 	echo file > file &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c973278300..8d93aaef5f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -11,6 +11,8 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 
 . ./test-lib.sh
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
 
 compare_head()
 {
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 08629a6e70..1a716f2c2a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -4,6 +4,9 @@ test_description='git status for submodule'
 
 . ./test-lib.sh
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 test_create_repo_with_commit () {
 	test_create_repo "$1" &&
 	(
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 4e676cdce8..bf0487632d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -846,6 +846,9 @@ test_expect_success 'status refreshes the index' '
 	test_cmp expect output
 '
 
+# fsmonitor does not work well with submodules
+GIT_TEST_FSMONITOR=""
+
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
-- 
gitgitgadget

