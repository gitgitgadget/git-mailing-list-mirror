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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28881C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF0361101
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhHTRXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhHTRXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82612C061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso9594326wmb.2
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDf4NR7irMIBPs6yfFlCt71FkrZC3JHtpdJMSAhYZAI=;
        b=B8cIWgm/brrnLHhkHzvqjDSFmpaL6aUVHNb2v1nsJta5qhNaTYlN2tD6MhAH2nR+ad
         IrayQcswZNRAfx5GYMuBgqiDUQS5c+Hz5IdBZDcEPOl52oWmMGP4cwCgqfzOWZNXU7mh
         OYFp5moHsV8JH/vAhbhUi4tE15xa4akKzivocqPOwSZMMgxfJn8SlURY4PD5444u7End
         7RMSUb3XOFeKL4t9+eeIeyW7YgVdVe42VGKrvuOfwZXfRrDZCfCuuxHdckYZLNX5gw5b
         Q+iNVeqZT5YV+mW8hTXZjOL1lw1MfksPxSIs0kkjiZWxvOfTElykqAFcAcrn0aagB0zK
         /94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDf4NR7irMIBPs6yfFlCt71FkrZC3JHtpdJMSAhYZAI=;
        b=cjCPRKqm+YYV0ZzWB3l6ZAaczpFg6BVHGuqeYQCrM5Zo8cHzKZlTsmHJQTweBEuJVv
         x3FBL9+7Xcyt90RHovj74OWawloOZaejigxmTPDtkYyxMgaKXeoZvOfxVUO7QOXBh05a
         dYaV7axEb774RxRDUHRdlU6K0v5Mtj4TookaphTDO/x4V+sHEUwRbozDwRFCBrgoawH8
         ek9HEmovHnaD/H/Nn/YOKasLFLt/6yv4qoJBvIuiBnd+54sBMGdRCgU8B4rJjOUVYjzH
         3VsrzhKpTRiRPal6U4pDX3XMOdAQvBLQZC0D2e+Ph06t/7c3gnIWjWOHhscT9MHmIDTp
         XPEA==
X-Gm-Message-State: AOAM53232T5HUJKBb0HZuUDh98jRKsk2LaaywEX47qnWTkcm+bqQUwhi
        DeXXobGrBs/taaKdNfiNOg8Jb9VnG2I=
X-Google-Smtp-Source: ABdhPJyaiVHhHzO/M+BOJ2YDbG3v8zg7V+Td6eG7rSdCfLNr3WKC+fvBsBrUyZfvwZgVqh0mjSE72w==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr5041209wmi.174.1629480179118;
        Fri, 20 Aug 2021 10:22:59 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:22:58 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
Date:   Fri, 20 Aug 2021 19:21:43 +0200
Message-Id: <20210820172148.2249-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
References: <20210820172148.2249-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a gap on bisect run test coverage related with error exits.
Add two tests to control these error cases.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1baf4e451..e61b8143fd 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -962,4 +962,15 @@ test_expect_success 'bisect handles annotated tags' '
 	grep "$bad is the first bad commit" output
 '
 
+test_expect_success 'bisect run fails with exit code equals or greater than 128' '
+	write_script test_script.sh <<-\EOF &&
+	exit 128 >/dev/null
+	EOF
+	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt &&
+	write_script test_script.sh <<-\EOF &&
+	exit 255 >/dev/null
+	EOF
+	test_must_fail git bisect run ./test_script.sh >> my_bisect_log.txt
+'
+
 test_done
-- 
2.29.2

