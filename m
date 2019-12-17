Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECBC2D0C8
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C492082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBVA2IWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfLQMBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39147 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfLQMBp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so5564581pga.6
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+ozZ1TvuyuN0T8hy81nZYO8hv7bNr46wsla2AG8SvEg=;
        b=aBVA2IWhHrkbAwaUlbgTohCd5+NujVrTbZSkioSmXSshFk2nY4dj6j1STfZdGTJQFn
         kYhEZu9ISxGFuaWSanbq7LjgxmTT0ulCI9/nLKmL75ZMrXHzkmEnU5IUtoprmdyDtd9e
         JzQ9ptNzvBAMdDVTSKPw3nkgP51sc/0QjgYIRQiXdX5g87spK5a+pycRxr0r9lmHwBDJ
         D88xli3G37kX29XdVoqMgK/HPfCbcirtVDWTHMY7gBKrRYfo4rskTLhsAIQJSz5w7JU+
         MSwrqgFJXJZ/o7aMKTth0B0+2yJBfM4LnLc8mtvyiLD8/iRCoDxKHAcFQZsojeCM9LPl
         gtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ozZ1TvuyuN0T8hy81nZYO8hv7bNr46wsla2AG8SvEg=;
        b=EtBs/Re6WWm6bM+mD6pxugnQPE1/6eB8eybZWnnhUgYPt4fTKz8tX2vTdlowwaDknl
         TY/BJNlxs0NBuyGoQRS+mkj8ES3/NG3EFD9Ug36z7f34CXspDMwL7V9rt/5Bxi5N/wT6
         SiHQ4x/ZEezs0DKvPB58NLTuGfaG1+A0wTeto7xqXE6q6nYzJDykm+KUXSYg9XOZD3Ic
         mkomH2yHftZQDHseX+QaaZFR531SvKuLGQKcdS5CgoMghndj2n3ITHW6xXkdin7RKA3X
         k9R5ei+Dv2b/RnYoIpuxfA5pssE7OHjZASemdYS0fHdCrjzTya/Gqd9ysdIr/PNUp9z3
         b6rA==
X-Gm-Message-State: APjAAAX+8nA0+/KIrBsVE2gS/2s6R7PbcRZP+L8dTVNICi7aliGpaqN+
        enhMKT2J8bxbyIZO74x6sADCL4ap
X-Google-Smtp-Source: APXvYqyTgWAbiXnS5RIiTxLcz/uDl/gKwoJ9Cp0EQ1taXheSzyq6SfPpfvWaIevAclR1sy6DjxJdvQ==
X-Received: by 2002:aa7:90c4:: with SMTP id k4mr22179728pfk.216.1576584104844;
        Tue, 17 Dec 2019 04:01:44 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:44 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 02/15] t/lib-git-p4: use test_path_is_missing()
Date:   Tue, 17 Dec 2019 04:01:27 -0800
Message-Id: <3d64837af1bc2af972ae1415502bbbde26ee3784.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, cleanup_git() would use `test_must_fail test -d` to ensure
that the directory is removed. However, test_must_fail should only be
used for git commands. Use test_path_is_missing() instead to check that
the directory has been removed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 547b9f88e1..5aff2abe8b 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -175,7 +175,7 @@ stop_and_cleanup_p4d () {
 
 cleanup_git () {
 	retry_until_success rm -r "$git"
-	test_must_fail test -d "$git" &&
+	test_path_is_missing "$git" &&
 	retry_until_success mkdir "$git"
 }
 
-- 
2.24.0.627.geba02921db

