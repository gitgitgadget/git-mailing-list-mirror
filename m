Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F90C07E9A
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DE6138C
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 05:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGDFtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 01:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhGDFs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 01:48:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93155C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 22:46:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h6so7174614plf.11
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KS9A8JrY9wDyD1RZ5HJvdOqjcyjLDsdJ+AW42Y25aZE=;
        b=INKYfQUGV5hMPZZzLOi8OYx8odpq0m1k6CeChJQ6qIzHuiI++7QiYO3PhxAbS3SlkM
         gR6N+yRJEdPANJvIZcJ1vDGmamwZGHpfbjl4qxRQgmG6KJXBNgVjJALTt1SNhC8N81wf
         tGBD1lwr0izch2nSesda8qtjy2pEz2/39SEsWbrJBA9WSq7TOnkodvGV/njCYBySxBzV
         oBlJMiCautyIc2aRLFOFKDLmgq1uWp13/8GKmJxqjv6kmoknDhdI92iKamHLfF/qKT0+
         JhWxJeLCpT60ORaswl2IK+QtgMEIvqd5G7y1Iei7lA/iFokLNFAwES3/+PI7jUFhDDac
         tVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KS9A8JrY9wDyD1RZ5HJvdOqjcyjLDsdJ+AW42Y25aZE=;
        b=gqAy5slZmhUja4mSK01rsBy15NWIjwKev4Je2E6UlFcraQWqFIjTrE2PszLZWITZvg
         SDNiHrAqANTxrHysd2JmUAul6wl5oIojlbLxomS8ViGLIcYFc1KpfiNA9THc2/BgS9we
         3MK+eLpsecXEasPL2t2Djcv3WPd7KGpJxYpXIg0ZG4RclW6BhFAfKXrdplKHaWXmC/vU
         EthXbelkv5Q/B1inHl3DS/wnBPKMcnkSQRiUq0T30Fj0Om+aAlMkK6tYm4BAltqT8cmT
         /rgYDIk0p6/Teujid9BNYd3vHJpS4zEHvxPc4ptLCBzSvOjneU2zuPH9O+WkEQ9rtn0S
         Xl5A==
X-Gm-Message-State: AOAM531hepEof/E352KMshOQPjaYNA4xBT1BOMxnEmgAwrZzdQ9P6ZNl
        0uuEmcYHQQ6KDO9ozqfA4MRL9uCqe78=
X-Google-Smtp-Source: ABdhPJz/Qp/ljSb5QY1Knrve67xHCZCQDpmDbGI+9M53xOap2ytTTWRKJi0fxTJg5D6vk6wJuYpevA==
X-Received: by 2002:a17:90a:ea88:: with SMTP id h8mr8029200pjz.147.1625377584074;
        Sat, 03 Jul 2021 22:46:24 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:ac70:88b3:9959:84e3:df13])
        by smtp.gmail.com with ESMTPSA id i8sm8182379pfo.154.2021.07.03.22.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 22:46:23 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 2/3] t6400: preserve git ls-files exit status code
Date:   Sun,  4 Jul 2021 12:46:11 +0700
Message-Id: <f7a06994cd57d4a8c0f70a0d1e5f48f8ac2e2561.1625362489.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.172.g7674896d58
In-Reply-To: <cover.1625362488.git.congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1625362488.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t6400, we're checking number of files in the index and the working
tree by piping the output of "git ls-files" to "wc -l", thus losing the
exit status code of git.

Let's use the newly introduced test_stdout_line_count in order to check
the exit status code of Git's command.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6400-merge-df.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 38700d29b5..57a67cf362 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -82,13 +82,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_stdout_line_count = 5 git ls-files -s &&
+	test_stdout_line_count = 4 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_stdout_line_count = 0 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_stdout_line_count = 1 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
@@ -103,13 +103,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_must_fail git merge delete &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_stdout_line_count = 5 git ls-files -s &&
+	test_stdout_line_count = 4 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_stdout_line_count = 0 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_stdout_line_count = 1 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
-- 
2.32.0.278.gd42b80f139

