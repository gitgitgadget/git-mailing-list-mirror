Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB5C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62566610C9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbhIGNiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344390AbhIGNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394DC0613CF
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e26so6882645wmk.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VbH/83jrdvsUB3nQiP13PUf4tK2Z3NCD9+NJRlFhS2Y=;
        b=RiPMVl/8BJ9BjqloJiw1H75atPXMEznihaobJpZExl3/h8NnZM/lYdtP3Mc7zLsCDh
         UUx+q/0GpyFLB/RvwJZFR7KbXMczOhnukpu6Cs+xCaOF717vKqy8uVzf3/JT37zSCZqs
         aVT0EmETxyWo8vjSzm8x8z3O0blZ0f87aRheEvFPbYYnZRmEVTdX6ZBPMEDZwrGpJyHp
         o1tz3XdWHoigihI9D/HRDuj/nVJVyg33p4JCH5WJQj2xE94StTff4t8wxqO63twOg54m
         maiqukd0oRSHKPFMk9x5gU8EFFe/tbgyH6SIo2Nm6s0yV3TZFUFwmb6f1wup9kW0npYr
         x2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VbH/83jrdvsUB3nQiP13PUf4tK2Z3NCD9+NJRlFhS2Y=;
        b=XF5Z/TmjG5xXjWo/r9LWAnkiCVJsavBkxzarkBt38qLB86U87NesuPFdHpaGttPlqM
         1YrgqYatR+K75e7XmxXClEa6u3ZPq7j564tL/dRgYc/TUPejMNHPfhX+BicHHkpKjPKN
         mdx8oFYGmQ9vypqkXp5VzdliUBBWcShA7NQsCKXhKA8Hqg4FuCDZ4LYdHHm1vHCDvw3Y
         miy+ohTdonWDnY/Z8UpwNT6TNK0Pxdpc8vsM0u2GBnShU9n1zPM56YYAfCzKf/26Tw//
         BVvVvf4IXJevZUFppr/fgYW+uRfsafZZp9dXL0+nUS9/W7JsulWR/wwddGU7K0HMx4+7
         CDDg==
X-Gm-Message-State: AOAM530ql4LY5zt8V1b6NoJ/lgZPszKCz5/ugQWaLbEmnTy3EuS9f6wj
        wcBRr9/JTDJsiP//y8OMzgWNtnFMCYY=
X-Google-Smtp-Source: ABdhPJzD85Od1z2B7CmAsqNAN03w2oUnmUbDafb+N7B1Y9zJg7t0pH7N0wl4jai5MabmS7Hce/8HlQ==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr3952491wmq.154.1631021812136;
        Tue, 07 Sep 2021 06:36:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm11841135wrg.50.2021.09.07.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:51 -0700 (PDT)
Message-Id: <52093fce57c7ef91b6d730f50d6b7ffa6cadc03f.1631021808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:45 +0000
Subject: [PATCH v3 4/7] t1400: use test-helper ref-store to inspect reflog
 contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1400-update-ref.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4506cd435b0..8ced98e0fe8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -10,6 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 Z=$ZERO_OID
+TAB='	'
 
 m=refs/heads/main
 n_dir=refs/heads/gu
@@ -318,11 +319,12 @@ test_expect_success 'symref empty directory removal' '
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
-$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
 EOF
 test_expect_success "verifying $m's log (logged by touch)" '
-	test_when_finished "rm -rf .git/$m .git/logs expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m > actual &&
+	test_cmp actual expect
 '
 
 test_expect_success "create $m (logged by config)" '
@@ -347,11 +349,12 @@ test_expect_success "set $m (logged by config)" '
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
-$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000$TAB
 EOF
 test_expect_success "verifying $m's log (logged by config)" '
-	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m > actual &&
+	test_cmp actual expect
 '
 
 test_expect_success 'set up for querying the reflog' '
@@ -467,7 +470,8 @@ $h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	co
 $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
 EOF
 test_expect_success 'git commit logged updates' '
-	test_cmp expect .git/logs/$m
+	test-tool ref-store main for-each-reflog-ent $m >actual &&
+	test_cmp expect actual
 '
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
-- 
gitgitgadget

