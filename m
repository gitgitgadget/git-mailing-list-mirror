Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C03CC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAE820767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUBFGEih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgDXPMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgDXPMo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:12:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E6C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so4750637pgs.9
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+qYI0xvGQsUgtH1FSRhdvvtYWSwfJVxZgXG2a6BvmI=;
        b=KUBFGEihPH6LnXia/Czr60FLtKgr9QjHpSRIV2y7zREJFVDljFyfRFlwSwf7q8wSzN
         j5hZ0hY57YrR17UGDlHwh+88d8PnBi4QxpyRqo4OvjHLDUaIvckf6vfzUEmSmpT5Ik5c
         oFzaK0gZ7X4gFnyzEM9sYxZUTFDEQDCGTjIomDdf8/Y9E+z2EajnAFxiY6Xz4iB/mo8O
         g8hBkQhyYemt+7OEsXLJBmPbbBHvg8CT5HKSuKHV4FYRw/mMCyBNTwWfNlMLfM/es9Nx
         P9iJ93/WfBX68/KF5khEFg2ff95lnMj2Dr+Z3SoqSO/YUzONkSH/KKHJhR2zUiDqcDQn
         FVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+qYI0xvGQsUgtH1FSRhdvvtYWSwfJVxZgXG2a6BvmI=;
        b=jxCL9tYjAGgttl1Ye1V2u07V0MX3+91YlSC3kPbxn/MhHUz9JWbnKgatvfhA0DBgbU
         szcpcpKeSjZTLxZuEliGViJOCe2osvpnhv1ppyKVSLteDuKwlrrQkKXVaZOHc9dSak+s
         MvEh0Nr0+7BwHVR4XWr0vJLlSF9SIbt687hkOcx/CNuD4y8jK9Y+MetpEsuoqgJRaXQx
         IQcC2F6TtlcygsijL4pdVpNwmMrCe/LR/kjIQTmNZiSVj4DXN/ylNdQyoKiU3VsClFoZ
         riiq5OahVzc6cnwOPN3glMsUP8hNhkoNxDLDJ52UHIMXFLlY5wzx4pLsrcZQjbBePVl5
         kWdg==
X-Gm-Message-State: AGi0PuZaJ+XqtVoOqckkYRPshvs7oCTfuWq05z3V24FB/nnsslIojocU
        gqM7uFnTxhG3Xa7T75GdtdQkwgrF
X-Google-Smtp-Source: APiQypJG8kymck2OrAj7AjKjLIV89s0ciBS50N7YpE/zIWPAoN5P1c2aWtTsiYoQENgZ2VnEAAGmCQ==
X-Received: by 2002:a62:1dd8:: with SMTP id d207mr10360261pfd.3.1587741162987;
        Fri, 24 Apr 2020 08:12:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id f99sm5078429pjg.22.2020.04.24.08.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:12:42 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Date:   Fri, 24 Apr 2020 22:12:31 +0700
Message-Id: <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587740959.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587740959.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somewhere later in the code, we indirectly include alloca.h
which will define alloca again, thus create a warning about
redefinition of a preprocessor.

Include it prior to define alloca in order to not define it again.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 compat/regex/regex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index f3e03a9eab..4bef75a716 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -62,6 +62,7 @@
 #include <stdint.h>
 
 #ifdef GAWK
+#include <alloca.h>
 #undef alloca
 #define alloca alloca_is_bad_you_should_never_use_it
 #endif
-- 
2.26.2.384.g435bf60bd5

