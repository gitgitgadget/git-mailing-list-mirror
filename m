Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA76C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7691360FBF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbhIFQxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhIFQxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 12:53:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB0C061757
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 09:52:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso5457824wmb.2
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VbH/83jrdvsUB3nQiP13PUf4tK2Z3NCD9+NJRlFhS2Y=;
        b=KUooObF74j2MVrlrFId8YwBni+lFXpSXQPik+6HmkmQViIK1NHV0TlYfvgULsbgVJK
         T+Yn0wjc4EVyIxTvrNLYWv8VuPS6jPv6IouKEO+XbPv5wyeTStPHBt+vAhsqAqgPkfHD
         /mkExAjiDEQWz3Q/0k1Z/x/LHN7ABQMluA0KEyY7ShGPgFM4MBO98M9PwHy2VtUS0F/Y
         fmWjbyKADYUr+YfhPVka6ElV1K5yPUdsYZpg8iwMGI3u4rdmJWdoX9S7v5A/QU7WufYa
         DHLD71fUHP13FLzHCTmRSjsryq7UrNtRooArycBx1u7kSKOe+XQ0dzVkVRWW8Tkv5j+R
         LE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VbH/83jrdvsUB3nQiP13PUf4tK2Z3NCD9+NJRlFhS2Y=;
        b=AXnkclCwKLYynax0u4J+r8s+fVtxtYetJSVSEbCWkQY7xTJ/bgcM8B9Qyr0HAOoVE3
         GXEP2+RzNnRSHDdtUxuoQlJ2I7W1fuD7yEbBNNiZJmMQI89mjsyKRs6mwfhIXkH5UaW9
         0gfry2DiloEH3UIBvpPDo4VsuGjB0IJARedCZVj9i+5Gg+2ZdrsMkdCOPBGN3Ngx0Np2
         kfZ6w1dpqo4s2LSfBDMRdXwi7wBGX5uMC7hR/E08nfo8wL8Bq90bphYfm6Yb8iE2Y7z5
         4O0j03zdopVW7GbKvmXDSZiQe4ziE+RqQw2MQz43ZCoKHlpyBKh4GH5dFrMiWCT110nZ
         VY/A==
X-Gm-Message-State: AOAM532MQwCshDhze+53YUfGrZvqyE7yTjOQBbm3Pm/KtP4GSbIxRQI4
        HYgxwejtqm1KYYXG7rX5jwrFkl3cVFY=
X-Google-Smtp-Source: ABdhPJxoJ95m0T8P1y73KLj5HR0t9tC1TkMkd9PUHp0QmIOM8cJgemDeDFBNH6HxrfbrQQPaX5RtqQ==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr36993wmi.147.1630947146039;
        Mon, 06 Sep 2021 09:52:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm8454773wro.83.2021.09.06.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:52:25 -0700 (PDT)
Message-Id: <9ec09cc64cd6f227e96fb9752c23ce3e54e5dd2f.1630947142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 16:52:20 +0000
Subject: [PATCH v2 3/5] t1400: use test-helper ref-store to inspect reflog
 contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

