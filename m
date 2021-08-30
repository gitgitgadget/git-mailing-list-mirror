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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A65C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C1660E77
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhH3Ots (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhH3Otq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:49:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77574C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so3588119wmk.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7gxx5uuHGSeO97xa3hjgVqyUX5ZZzAI/LQQTQWSrlRw=;
        b=iv49usGRd8tfV9zqBFY+pW3UPiakrE41vTUtPTPbFJgDnoA+mmQuNKevtnbmvYYsIO
         YuWK2iPRNTVW9jANQhWj1XlRM9++ETtUiYFSYOBYs541bhQazM7aDB5Bxw/umkSDCKQs
         hoA39ENE6hZAehuwxVwjSnHL2ffX28TZ2z/05Bk9/+lv4djCLoL/DSpOoAKzrVQg04R4
         cBBGBRXEbhMCuoTRF98a789Kf/m+BV6+xEafOxlJcNKq5jOqfdaWp0o3CgxAu2mA9Y0o
         9H9onYQAXMdFKPyMDUmEFyt4bA/Ar93pjORhEt5e+YGITd/4NP/fbRAGRTboZ/l98H7g
         ocsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7gxx5uuHGSeO97xa3hjgVqyUX5ZZzAI/LQQTQWSrlRw=;
        b=YkdXYOQC7+StsJZ5s+7tgtSpW187GpiW6ibD0DWC/tXkmjTPMfsv9ZmUxYxAsjtKeW
         fCCo4d2k42cGKtC1+6KaH7t9/x+64e5ETYl9yjHDOHOWGcGhO3zy5urP3K+hMKP5qdLF
         SanEXIjKEABYI/9spuUB6fgm/4DqN/qm8SmRDJB849HD5i2wYNLghp8t9+oz7z4mlSTE
         ny7RyPA3NyVoH40FOciNI8nSivh838mzwpycO8D68RcW3K1uNrDowGn7UsshRZaHjUWv
         90cTdvZUYMYcH49iIWR55BW8kfbuo9ku5dkOhejmcItO54ZkVZg/AiNN2ZC3bThg/ger
         zCBg==
X-Gm-Message-State: AOAM530dTY8qF1EytFcN/sQhOevzt4uFx/2Zbn4kPq/HcdoydzMIzh+8
        WbvxyLH4Xzsnc7iJeqQ4k7QjeKiwviw=
X-Google-Smtp-Source: ABdhPJyYWMmgwkw+JvHlHrSqrq6e/moZrE2WUPb+kvDBgPVChx+EStzfzGVzYLgQg5VnRhI4UQNk+Q==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr33474097wmm.16.1630334931137;
        Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20sm4273648wml.37.2021.08.30.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:48:50 -0700 (PDT)
Message-Id: <dab8e115faf35529b086f102662ff86ca57a9748.1630334929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:48:46 +0000
Subject: [PATCH 2/4] t1400: use test-helper ref-store to inspect reflog
 contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 4506cd435b0..de0cf678f8e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -315,14 +315,16 @@ test_expect_success 'symref empty directory removal' '
 	test_path_is_file .git/logs/HEAD
 '
 
+TAB='	'
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

