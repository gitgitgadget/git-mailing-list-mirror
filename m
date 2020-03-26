Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05065C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24D820772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbUc8K1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZEh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37843 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZEh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so2179303pfe.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igWZKJLHsdQCZWYAe97MD1rG+bYewy+UxY4h6xDz/cs=;
        b=FbUc8K1Tq5jA7N4Ik1IG7V7oCUbUhgyeT9lVE46ehDf7+PxqsCixwdadb9nXdnDezx
         iHMgalDdRNhy80iFVN/p1b2ZHwc99XYOOamc11ZP2w2sT0y8IHsZ7GBVTJ+uIE6tOaAb
         X3RAc4os1aURmgbxUtgj02v9IOPWTTnlUpDTHgLlYSLLw44ac3s9pGvy7oHeZHdmhojV
         9NnKxjbatGB/rv/If3erh4a+XNHXihqhuUEWhNjJQv3V3BvjgChU+LJ6N1HAUQzVKS+i
         T/CZ6HdJu7CBRZHj87pgbHitsoTGnmH0Y/H7s8NZs4Cd2rP3ScniIHRzdYi4SDfXxfV0
         vo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igWZKJLHsdQCZWYAe97MD1rG+bYewy+UxY4h6xDz/cs=;
        b=LGJGd/FR8XIrB5GjzpibTJ2DzGwdVLzrl3sKs6nQBgTiVH989LW28zkN8i5pzXC6mO
         Km5fbPkDC/jLMbs3TKEH36sjo1//zUKTFGnyb0OZxiIyFN3IFtJoa0/V+QMgaI7GrYen
         KzCeOJ9uJBguapR5pg4FXD6+wRuNgD+NRbDdUnzsarn1i4j/qgbGwMvD/eywcXR91NoQ
         CEh3bmKWYAxq9ZSjswBsrggN6xFv+IAC9hFHRveNLGdMbmJYeuLOpupjSg1cVR7+uwkL
         OZjsESIWNRUGYRrGuaZ1Pq/3JutCALM0pn+eHordPQFEL5OmA0SRRdUAZm3DNu6wAjBM
         dkHA==
X-Gm-Message-State: ANhLgQ3xcIw6raW5jHsmFddYPyIoRX0Sk+U3YnXzQP/LFCxfvUqMycaX
        whHIbF99DK3lNAK2zwpgZXPurhGg
X-Google-Smtp-Source: ADFU+vu0D2lpSxF7FmhEVgCDkiuNolBF4RKhWf7m0Yli0DLxUzwvAMKezRKAYOj6SmblZTY8fS8k5w==
X-Received: by 2002:a62:144c:: with SMTP id 73mr6979018pfu.265.1585197475740;
        Wed, 25 Mar 2020 21:37:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:55 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 5/8] t5616: use rev-parse instead to get HEAD's object_id
Date:   Thu, 26 Mar 2020 11:37:35 +0700
Message-Id: <c6f7498d934e79f751cbdfdea62571e6012a3cbf.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only HEAD's object_id is necessary, rev-list is an overkill.

Despite POSIX requires grep(1) treat single pattern with <newline>
as multiple patterns.
busybox's grep(1) (as of v1.31.1) haven't implemented it yet.

Use rev-parse to simplify the test and avoid busybox unimplemented
features.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 77bb91e976..09e640cae4 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	git -C srv.bare rev-list HEAD >headhash &&
+	git -C srv.bare rev-parse --verify HEAD >headhash &&
 	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
 	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
 '
-- 
2.26.0.rc2.357.g1e1ba0441d

