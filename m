Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CFF1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 03:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeGKD70 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 23:59:26 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39999 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeGKD70 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 23:59:26 -0400
Received: by mail-yb0-f196.google.com with SMTP id y11-v6so9486423ybm.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 20:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6k9ZB3qs6XT1ovJYzsWHqBpQ+1OlqguWBjCmbk0Z4Mw=;
        b=slgs84cuBzYRhPtxSTTbxo8t4aEJ2ml7Yo+j8j9ZUe8dO2YGxvKWM09cJqL3UkRLGj
         +EXNQUbsRgZZ1LGpB8E4AmA6uQ+iNQJBKUT50na7atMX9sWODL2np3M6lYWAWh/bwqX0
         xD/bYxXR6pvn5gGBGRmG3MMT9xTQ/V4Qf4xj4u34Vd+Vs7rHO2DQ0phzTugs+Y/dM3i5
         JNqWClhmnT+6a7/CO0CEShfpqKIUMuRvBBPmeEN7Q1//uMG/ea+OBDitP9teNhmh8ftG
         ETPuCg4nvVnGpSs1DJBOtaTYrl9py/bI5dg107YjTRR1hdNbhXSPSMAtjnu3NnhuWiew
         n6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6k9ZB3qs6XT1ovJYzsWHqBpQ+1OlqguWBjCmbk0Z4Mw=;
        b=IcW1PUicvQ8j6TfSf8vJGPPDA7InMn6SZ2qkJiqYIDav7Tbnav/0DFp/WNQJboaDeX
         3nG9mE8+r3VZlDcVwFhSU20sU0L2rWI5O1wh6CTMjyMMnYPCBz0gcCnyxRapg6l2ExZe
         cJUh4g3zkB5FYbc3nc8xx0Tq9/aEKOjX9+KI9kxdHJUsScpoxBpRlh7qyEChCYsekuaY
         IV9qmB3xzPUGnp76hpUINNvPNxhH68Hc76kYdjRR0giFI8lv9b1Um2k8Gxkbb2vH9hya
         ZjpyBjrXeyczVAlC1JXll5qPUXj+G7M2dOdRfoeeR0p6N7EEm68YI657xB/oqeiKeb1m
         +2vQ==
X-Gm-Message-State: APt69E0vug9a3RaiODGRdhTVzxpCv9vD31yLKZnXt8bHTprRgGCgpUPn
        OTJBvR6rjMTTJ2LI6IwnfHM=
X-Google-Smtp-Source: AAOMgpfkVlfP5Zy6agFl1GTLwKhoYRtMj9iUTewOvvNmpxf016vMUHfsmWBxNoKFbss5cFBLNf2ZIQ==
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr13874811ybp.76.1531281430277;
        Tue, 10 Jul 2018 20:57:10 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id a62-v6sm1938699ywf.79.2018.07.10.20.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 20:57:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/3] t7405: verify 'merge --abort' works after submodule/path conflicts
Date:   Tue, 10 Jul 2018 20:56:59 -0700
Message-Id: <20180711035659.27352-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180711035659.27352-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
 <20180711035659.27352-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7405-submodule-merge.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 45d1779d2..7855bd864 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -333,6 +333,19 @@ test_expect_failure 'file/submodule conflict' '
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
@@ -417,7 +430,25 @@ test_expect_failure 'directory/submodule conflict; should not treat submodule fi
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
 
+		git checkout A^0 &&
+		test_must_fail git merge B2^0 &&
+		test_path_is_file .git/MERGE_HEAD &&
+
+		# merge --abort should succeed, should clear .git/MERGE_HEAD,
+		# and should not leave behind any conflicted files
+		git merge --abort &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
 	)
 '
 
-- 
2.18.0.132.g6e63b23f4

