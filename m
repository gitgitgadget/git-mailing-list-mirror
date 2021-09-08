Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2991C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3CA61153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbhIHJum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348506AbhIHJug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2803C06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1037214wml.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yt8R3/UWqtUM7CQB1VKV8KNf4gJG872khhd+8FEB2U8=;
        b=W+6HefLHdnaBbRc3gKkmuOUWdzpRPB5sYyaZMtEHJUxyOUL0UP5PNEDcO3BLPU+D2X
         uucuAedvPVbpKQRvyvs2f07KL2/WmOAd7qcX263G+xKjmVpBec5KStjuXjxsITicrzKw
         76DywAy+n5kOwhOwBmwbtU2pG3UY2gbgQJuIbcXKvwcXC/dG87xACQoO12bRIV8zxF8c
         68VaEpBGILyJfiE8zQKNDuYXg/ggEY1MkQjvUnlIT4fHE8kS7Gy55m2Pv22/0qxYwWf8
         BtCxr89+GI2FDd53FzEAVCriP4TZOYM1CstG1xx4NDLAq3ZPO9sYEUZ2Kq1rCs7nUAew
         RIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yt8R3/UWqtUM7CQB1VKV8KNf4gJG872khhd+8FEB2U8=;
        b=O3R7Ibg6jRaGBqCw9SnfzNyjtlJp947Pt9v9vuELD6onCIqaBxciWdBATXcDNz19gt
         rk/Q1cKoxBxaE7+4BMveax8vIAeuEdyPKFyZeo2vDq6nL0i6fXfoIYcw6c08Xcx3VcRx
         eRn3hbpivxoDkD6l/wUmR1391jVB/0DIacaUcuWMdQPFCxg8JoYKnotFGJWs1PBpnxp6
         fztoLJcmrWiFwVZFofnJimSy+yoBnighP3V++EXWdIjseK/EIPDERT93K1IJclY9NV8Q
         ToXvQzu530XsZ3r5+CMEVVlO5JWuH8IQYNTbTV8iDVJnd9kpWq8Xkanett7oUQtUGtiI
         VPVg==
X-Gm-Message-State: AOAM533R3tgkXNzWBtwByPhBDrpHbKTdeVTB6PlKKOtqX4xsoZQfkdrn
        Zs9kXbBxjv1NLpk+8S6uvn5oxc/XORM=
X-Google-Smtp-Source: ABdhPJzYTLVU98/Dy4QLeJc5A+R4Y1/QRFeCQGFAFX4ywklJot3pAd23/l5k9Vm9BNzfIUnFBOX0Zg==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr45653wmc.180.1631094567434;
        Wed, 08 Sep 2021 02:49:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm1512368wmi.34.2021.09.08.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:27 -0700 (PDT)
Message-Id: <87d7e9bf2d4537ddbdec8c8fa67190e81a426312.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:17 +0000
Subject: [PATCH 06/11] t3407: strengthen rebase --abort tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The existing tests only check that HEAD points to the correct
commit after aborting, they do not check that the original branch
is checked out.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 624d2ee3fa4..72cf391156d 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -19,6 +19,13 @@ test_expect_success setup '
 	test_commit "merge should fail on this, too" a e pre-rebase
 '
 
+# Check that HEAD is equal to "pre-rebase" and the current branch is
+# "to-rebase"
+check_head() {
+	test_cmp_rev HEAD pre-rebase &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
+}
+
 testrebase() {
 	type=$1
 	state_dir=$2
@@ -29,7 +36,7 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
@@ -41,7 +48,7 @@ testrebase() {
 		test_must_fail git rebase --skip &&
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
@@ -56,7 +63,7 @@ testrebase() {
 		test_must_fail git rebase --continue &&
 		! test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
-- 
gitgitgadget

