Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B80C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiCAA1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiCAA1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:27:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927C4DF7A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g205-20020a2552d6000000b0061e1843b8edso11933389ybb.18
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9IfPvEnls/l8y37Sp5+hkKQqd6JZhFtkI6UPflCUu6E=;
        b=CLKpYKhOxdeja1QuMIwy2tIutfZxHgHW2uXc9Z1GlBPLWJfupSMUiPb7B1T3ZUooXi
         nGO31wRNaar5LhuJ8TP2vEPOspiJPzWH76/Q8hORB6reH7xa7o7toD/KUeIzOIV1ktgo
         Yix6s3mdvNm5th5D5gbGG9EIDxo+cCaAmU0F9jIIGhrhH0/n023qBt4tWlOdsXaGfXm5
         wNozBS5dhCYRtShIlNOstK0YTmK8rCyyTNY8xuA3sgihbBc1juU1bjxKqCutyWOkPQku
         SUMlEkGo/2R0cO/ZezQ9/zgea8lRidLMpg8iQXeuV5gEz7VTpQk/qG+9tl4cDxKLInhm
         zjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9IfPvEnls/l8y37Sp5+hkKQqd6JZhFtkI6UPflCUu6E=;
        b=40/qGWmnQqxfHsv8gqvdVMEUxU0I5WiuhdfUxq+Y9ddqlCN15vpHKhoH3NW4TvMJ8T
         30T/2ch4B9HouHkeAW3KYc9IkNU5KxTdsalnk8c0l6b57k7a0FU6xm9oozl3jTJ27ykM
         SDw493Cmbv6VPKktnI6a93Dqi7jgp7nlZFTXU0ufcUGF1FC7FCtIdnD65kbvQvHYYd8N
         WEmWbzGb/n306abGF7W75r9w/79XYey1Ikj5uoai2tC2gAGj+2vXhNg2J3vk1IyKi/jM
         yCbE1bKRvTd5H81hBESgPtaVxLs/ph1zEakeAcQA7/mR94werJ7VIR5sswdyrgwc1Dqe
         nU+g==
X-Gm-Message-State: AOAM531OmiPB8YGsW7svrFtLY3qYr4kTH5irAiFLiYOYb7WyR9v84ukP
        e5CavWdWyOcA4I9CdAdqNXQFJ2y1y1r9yNL5y5eEJi0BJjLMlBiqbQrDiRUchkXzmDxmFGcmYJu
        R5L/KOgQdgh34aoNpRxAvnCElPfSNstk+UpBKMHPkd3xBSogohmbsRzdW6nUpSbFRR0Pb9DCyhg
        ==
X-Google-Smtp-Source: ABdhPJyQ1z82WzxcoU//OuBQmxOj+Roo/H6s0EZ2TwMDJ8EY0t3+pl3kTo4DfS9bzL7/VuG60jkVfPTDVn0PHDNw7lA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:3f0e:8f7:9f8d:6e8c])
 (user=emilyshaffer job=sendgmr) by 2002:a0d:f105:0:b0:2d1:1f59:80fc with SMTP
 id a5-20020a0df105000000b002d11f5980fcmr21648551ywf.77.1646094393692; Mon, 28
 Feb 2022 16:26:33 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:26:11 -0800
In-Reply-To: <20220301002613.1459916-1-emilyshaffer@google.com>
Message-Id: <20220301002613.1459916-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com> <20220301002613.1459916-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v8 1/3] t7400-submodule-basic: modernize inspect() helper
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the inspect() helper in the submodule-basic test suite was
written, 'git -C <dir>' was added. By using -C, we no longer need a
reference to the base directory for the test. This simplifies callsites,
and will make the addition of other arguments in later patches more
readable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7400-submodule-basic.sh | 40 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e7cec2e457..40cf8d89aa 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -107,23 +107,15 @@ test_expect_success 'setup - repository to add submodules to' '
 # generates, which will expand symbolic links.
 submodurl=$(pwd -P)
 
-listbranches() {
-	git for-each-ref --format='%(refname)' 'refs/heads/*'
-}
-
 inspect() {
-	dir=$1 &&
-	dotdot="${2:-..}" &&
-
-	(
-		cd "$dir" &&
-		listbranches >"$dotdot/heads" &&
-		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
-		git rev-parse HEAD >"$dotdot/head-sha1" &&
-		git update-index --refresh &&
-		git diff-files --exit-code &&
-		git clean -n -d -x >"$dotdot/untracked"
-	)
+	sub_dir=$1 &&
+
+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
+	git -C "$sub_dir" update-index --refresh &&
+	git -C "$sub_dir" diff-files --exit-code &&
+	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
 test_expect_success 'submodule add' '
@@ -146,7 +138,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
+	inspect addtest/submod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -248,7 +240,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch ../.. &&
+	inspect addtest/submod-branch &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -264,7 +256,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz ../../.. &&
+	inspect addtest/dotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -280,7 +272,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	inspect addtest/dotslashdotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -296,7 +288,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	inspect addtest/slashslashsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -312,7 +304,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod ../.. &&
+	inspect addtest/realsubmod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -328,7 +320,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 ../.. &&
+	inspect addtest/realsubmod2 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -359,7 +351,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 ../.. &&
+	inspect addtest/realsubmod3 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
-- 
2.35.1.574.g5d30c73bfb-goog

