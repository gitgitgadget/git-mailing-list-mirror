Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71EBD1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 20:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeGGUoT (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 16:44:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42914 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeGGUoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 16:44:16 -0400
Received: by mail-yb0-f193.google.com with SMTP id c10-v6so4104909ybf.9
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JsHu2HZ+/8vMukSIsGTKiPgA2z+1uDVSh0N1YR9TzlQ=;
        b=iVocNjFMi+zcwV9+RqxxkO1WdxdzatrDY42Sk2s/L4iPD/8fZCbKsO3O26xqF1nht6
         rm34YQU8xKDIDU/k90J42cYL0MVR3M75Z/92ANtwA+BV+icF/wClldQzWTkVue5Y0m0m
         EZE161vjlSvvI68yt/Tg1g7qCG2psTYBdsAes286g87fZFOWPDXSO21uACMDuW8PA74p
         qgC3KGuUAxnAPxCp/4kFgkPOBoYDVWcaDLOmwFv3hLJqWj4eJQI6Sz8HnoCL4tFZl7wW
         jlRSWPv33sokAw68IsWCLoQmJ2w7BeaWFpKPcK49dCicezLAGTNsV+pUbPGgmyrofwjW
         xjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JsHu2HZ+/8vMukSIsGTKiPgA2z+1uDVSh0N1YR9TzlQ=;
        b=jY7gGiGkrVKrhEDmnD9z/fb7e4s8C/Fplmlo4wOusps94rxTKAFV+38kChjaebrGlk
         tHVp9/pIrTLRBd0cy2ymBaaXB1l6yyJk1/zIAOv+57sXfuiDTjH8FzYv47R0Z8kkQNDr
         EHIMCHzpRZPRVtBhAYKJoY5mNsTGY7MBplTicZQl5IKZ8AIY7pfrE6RAvFR9H8HFsTlY
         l1W8MvENyozEaPq0VUA+PfrpyfsGZ75A6iNTB3J9sBYKOzDtMzyDXJ15kIcEk3KSCLUY
         maQ/kInBiBYzOQAPkNiawvYz6SUV1sOtNfJ/pNM3AUDyoNFqg/FlwCwK6SpGb/+Z4c1K
         lVtA==
X-Gm-Message-State: APt69E3Eb8XR2+yQTP9epyWU0HIZyXADgq1mQNxu8nKdqJQ060aw26SR
        HcVxN2DlIa/Ry8+xFNsSs+5SEw==
X-Google-Smtp-Source: AAOMgpftUo2csRQufvfvlqg7FxeMnhXPPpWpqtzPJ6n4L5qb395VLwI/HpvlgNjoMFry8LVG4JnEGg==
X-Received: by 2002:a25:8ca:: with SMTP id 193-v6mr1402182ybi.72.1530996255696;
        Sat, 07 Jul 2018 13:44:15 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4535058ywd.21.2018.07.07.13.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 13:44:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] t7405: verify 'merge --abort' works after submodule/path conflicts
Date:   Sat,  7 Jul 2018 13:44:04 -0700
Message-Id: <20180707204404.7208-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.134.gafc206209.dirty
In-Reply-To: <20180707204404.7208-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7405-submodule-merge.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 6cb51c966..9f71a4859 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -335,6 +335,19 @@ test_expect_failure 'file/submodule conflict' '
 	)
 '
 
+test_expect_success 'file/submodule conflict; merge --abort works afterward' '
+	test_when_finished "git -C file-submodule reset --hard" &&
+	(
+		cd file-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B^0 >out 2>err &&
+
+		test_path_is_file .git/MERGE_HEAD &&
+		git merge --abort
+	)
+'
+
 # Directory/submodule conflict
 #   Commit O: <empty>
 #   Commit A: path (submodule), with sole tracked file named 'world'
@@ -422,7 +435,20 @@ test_expect_failure 'directory/submodule conflict; should not treat submodule fi
 		# merge from starting; we should not be writing to such paths
 		# anyway.
 		test_i18ngrep ! "refusing to lose untracked file at" err
+	)
+'
+
+test_expect_failure 'directory/submodule conflict; merge --abort works afterward' '
+	test_when_finished "git -C directory-submodule/path reset --hard" &&
+	test_when_finished "git -C directory-submodule reset --hard" &&
+	(
+		cd directory-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B2^0 >out 2>err &&
 
+		test_path_is_file .git/MERGE_HEAD &&
+		git merge --abort
 	)
 '
 
-- 
2.18.0.134.gafc206209.dirty

