Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262DAC63777
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 03:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C7C20DD4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 03:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKWDZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 22:25:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42705 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWDZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 22:25:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id z188so4351245qke.9
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 19:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PtckimI99yN29YM9Ui7QCOMr7l3blyuqv4Hrud2reE=;
        b=E8QXVUy7D7I1zBdaRrdWfud4m9EWb1a1YL3xh2SZNiqg4mRG80xZxpu3cpb0GzFby5
         k/SWw+kEy45yt5UCU1ZZAyc5yGrroARu3To4nhrNnKOe5xXgGtBGsp/enRDEjAcoKuRn
         XgEKg0nh6WdE06nem761jyaoXwuL89U971iKeGi0ZTSyjdXz3BCUpNPkccVsYf3shZpm
         P1dvD4ANHYIYZusnaws0jwxOwacgSrc2CHuiO+Vcylyn1wprz8t8xEUp1C+UOTcqtcz6
         yYtaU5i+wlcr6NGRKM9Wa2Pcns/xkA0FJm66t5CjkxV4zPxuvKmpSVaOoUC9CK3kIHEN
         IEIA==
X-Gm-Message-State: AOAM530bJ6D+KVr69FBySUlpWqhfdoXvll/Bp8YPghfcPch9X8k5kMb5
        bcWKb94V1f26tRXxe0IVlszBz6XgF+EuCKtt
X-Google-Smtp-Source: ABdhPJy3aBKxdprKYukKVPr4yv763QZd3PwgnE89x+cj/JKhhO8+Zh+8QuF1/SkuUWQEIDexDNCe3A==
X-Received: by 2002:a37:87c2:: with SMTP id j185mr6029949qkd.210.1606101910851;
        Sun, 22 Nov 2020 19:25:10 -0800 (PST)
Received: from crimescene.lan (pool-100-16-98-84.bltmmd.fios.verizon.net. [100.16.98.84])
        by smtp.gmail.com with ESMTPSA id c6sm8906341qkg.54.2020.11.22.19.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:25:10 -0800 (PST)
From:   nate@roosteregg.cc
To:     git@vger.kernel.org
Cc:     Nate Avers <nate@roosteregg.cc>
Subject: [PATCH 2/2] t3301: test proper exit response to no-value notes.displayRef.
Date:   Sun, 22 Nov 2020 22:23:42 -0500
Message-Id: <20201123032342.24566-3-nate@roosteregg.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123032342.24566-1-nate@roosteregg.cc>
References: <20201123032342.24566-1-nate@roosteregg.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nate Avers <nate@roosteregg.cc>

Signed-off-by: Nate Avers <nate@roosteregg.cc>
---
 t/t3301-notes.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 8f43303007..ca60faf480 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -672,6 +672,11 @@ test_expect_success 'notes.displayRef respects order' '
 	test_cmp expect-both-reversed actual
 '
 
+test_expect_success 'notes.displayRef with no value handled gracefully' '
+	test_must_fail git -c notes.displayRef log -0 --notes &&
+	test_must_fail git -c notes.displayRef diff-tree --notes HEAD
+'
+
 test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
 	GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
 		git log -2 >actual &&
-- 
2.27.0

