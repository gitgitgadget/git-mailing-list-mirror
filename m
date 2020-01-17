Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A9EC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDB72082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae2k63Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAQMXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:23:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34804 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 07:23:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so22538995wrr.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 04:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kbk4kbULXKzW/XSbMq7bhvTq3G7+MGylCb6dgnTZw4o=;
        b=Ae2k63QrB9h9APZXNg02c8hDbnuThZ6+AHhSuN5Yu4vvWCVWdfsxL4lsuwB1Nq+6ev
         XUcpWrPd0hTChiqRGSLEVDGX+y7DX96J9mlPxrIuHpmPbK536WxBlvVwTPgE1FSjTFTm
         fDVbHdc9j05ny4ovglIJ9hMp+jU/z0opEK0B2mmyfbOx56qGI3jJ+pXYuxu/h4zW7SsM
         dHi1VdwzFlAfE+vrZMM3Zt7dnAUJEJSlC+P3vmEIHJvjPW2y+Y2eS0UTta7Om6F99z9G
         kE7mnLZ5p7ZBB95QFCQ3PZNuHF2QewOPpPmbPgDLRfrQAaUlbOpGrDJ+IRkcAspFgZF6
         iJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kbk4kbULXKzW/XSbMq7bhvTq3G7+MGylCb6dgnTZw4o=;
        b=ffRMDvAUiBujHSyqAsGdK1jcQX4L7xZlQA4r26ZSXh1u/ydXBiJAApmNCmEk80T9yA
         qth8wMff8zq9ncWufA+g6yHDeNLWZaRcW8aIDP8RXnu+GXTxeDOqJUIfOmsCKpLB8Zsr
         wsBCG4j4KHh9RaTbui24bkseSvVe8LDM+85OtA98FnYs2GBFXcVn+xMqiwcMB24buzH+
         OKgZ1gIGNYjoJ4+AuJy74PtDv/PaerjEwOTRd6Cmp+inZwndXMvsGSMGPq44cWiunUw1
         QmDwz1zkOs+RaxqMpYdLCtzF7BLcZ8vBpJTeCr3tQshtc0PB3ykfM71HtDlDc7AZkL3T
         ULEQ==
X-Gm-Message-State: APjAAAV+4G3ztiJXcb5in+y2jczg1gYqeW+voFtEpdqVHsye+Qd91hzp
        K3HJQwy8vzzR7Ubkf1XiQSbcFl9l
X-Google-Smtp-Source: APXvYqyzn8idP2l0gj7x3y66Wf8yeze6UKC2EP8MC6MBBKO/QFINnMDPBkkfE6zw9Ts6oVK+oNM6rQ==
X-Received: by 2002:adf:f606:: with SMTP id t6mr1248605wrp.85.1579263813239;
        Fri, 17 Jan 2020 04:23:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm32400311wrv.39.2020.01.17.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:23:32 -0800 (PST)
Message-Id: <5060ce3d64419369b2912c395a880fb49a0a3137.1579263809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.git.1579263809.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 12:23:27 +0000
Subject: [PATCH 2/4] t2405: use git -C and test_commit -C instead of subshells
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The subshells used in the setup phase of this test are unnecessary.

Remove them by using 'git -C' and 'test_commit -C'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t2405-worktree-submodule.sh | 40 +++++++++++------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index f2eee328cc..b9040c30d4 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -6,32 +6,16 @@ test_description='Combination of submodules and multiple worktrees'
 
 base_path=$(pwd -P)
 
-test_expect_success 'setup: make origin'  '
-	mkdir -p origin/sub &&
-	(
-		cd origin/sub && git init &&
-		echo file1 >file1 &&
-		git add file1 &&
-		git commit -m file1
-	) &&
-	mkdir -p origin/main &&
-	(
-		cd origin/main && git init &&
-		git submodule add ../sub &&
-		git commit -m "add sub"
-	) &&
-	(
-		cd origin/sub &&
-		echo file1updated >file1 &&
-		git add file1 &&
-		git commit -m "file1 updated"
-	) &&
+test_expect_success 'setup: create origin repos'  '
+	git init origin/sub &&
+	test_commit -C origin/sub file1 &&
+	git init origin/main &&
+	git -C origin/main submodule add ../sub &&
+	git -C origin/main commit -m "add sub" &&
+	test_commit -C origin/sub "file1-updated" file1 file1updated &&
 	git -C origin/main/sub pull &&
-	(
-		cd origin/main &&
-		git add sub &&
-		git commit -m "sub updated"
-	)
+	git -C origin/main add sub &&
+	git -C origin/main commit -m "sub updated"
 '
 
 test_expect_success 'setup: clone' '
@@ -49,7 +33,7 @@ test_expect_success 'checkout main' '
 
 test_expect_failure 'can see submodule diffs just after checkout' '
 	git -C default_checkout/main diff --submodule master"^!" >out &&
-	grep "file1 updated" out
+	grep "file1-updated" out
 '
 
 test_expect_success 'checkout main and initialize independent clones' '
@@ -60,7 +44,7 @@ test_expect_success 'checkout main and initialize independent clones' '
 
 test_expect_success 'can see submodule diffs after independent cloning' '
 	git -C fully_cloned_submodule/main diff --submodule master"^!" >out &&
-	grep "file1 updated" out
+	grep "file1-updated" out
 '
 
 test_expect_success 'checkout sub manually' '
@@ -71,7 +55,7 @@ test_expect_success 'checkout sub manually' '
 
 test_expect_success 'can see submodule diffs after manual checkout of linked submodule' '
 	git -C linked_submodule/main diff --submodule master"^!" >out &&
-	grep "file1 updated" out
+	grep "file1-updated" out
 '
 
 test_done
-- 
gitgitgadget

