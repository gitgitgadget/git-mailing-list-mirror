Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D5C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6732120BED
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VADRsFC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgCSOA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:56 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43219 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCSOA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:56 -0400
Received: by mail-pf1-f169.google.com with SMTP id f206so1474498pfa.10
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqptoaUnN/UoX4vfWkvi5uegCaJ6856xTvW857QZx0w=;
        b=VADRsFC2PHxV7zCCzwfp9T3Op9CqiypeOmr+7Lk3AEdQ2AycYfM8lcBBQIufsFyKbQ
         iTXcyH3D6ObYlUMroXClOfNJhqW+SUjH+VfXfF6o62h/Clc6IT8aQngHXmZoISGqYAwz
         kV9cbB3JiZJSRSMnKjqLoclHK1wDx2XzgZqtYmpDoMeLKuqY95DH9WXSOqu0+Hud2mdA
         ZE/FykuSdSpLzELlhlzHUAZO293pglSPn52c8fiIqgHF6MTci/CDcxz3EOf/bRE5n6DG
         rYIziP57mTYo3Q5ERJ2YLCYVzyBDIZXmTXnkgTBpYn82Pe4AVB3OF+bO7hysik13RA36
         kZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqptoaUnN/UoX4vfWkvi5uegCaJ6856xTvW857QZx0w=;
        b=OTnlwbXqoqvC1f4uyFKW8NT2ccmsfSzrukLIZiiMeCtEB6xph1BwItwOi4iI0EcH8i
         yR6jJXRYkbq0u4yl4CQoKN6a9v2sQlp2S3pGnInPOBS8vC3nqyv/1rX+xu4SnYLLvlBX
         CTSYf54HdB2Kw8B7RFOuxiZwbC6aJHPK2dzu5ZiHfQVo1yg0wdVGNgN5q7k1JYjKurQ6
         Fb+h5rQTkTRKSu2TeP8ud0iskDlWc3cWJU2qjnQNKpGTtY2qPuyiod/RRrVU/DOs0p1p
         jCdOezTpa6RADdzwpcwFpzLBigVP8E/gBogB/SIIcPkt9taCWW2woahyJHZKmiMLuFPn
         1fHw==
X-Gm-Message-State: ANhLgQ2AaDEL0tIV4XU2TBcJHc3bsph0eKYNUmXNPM1yu77ejHHKGNUg
        GJ7PNs8J/vxTNnH4RI3M9vsXKPzh
X-Google-Smtp-Source: ADFU+vt454j2goxuvfKfvyh7q3+I0AMfVsxNul8TCymeRaga42d6PtPXRRVdbrm+jYrf2obC3QiO5Q==
X-Received: by 2002:a62:e803:: with SMTP id c3mr4155435pfi.31.1584626453551;
        Thu, 19 Mar 2020 07:00:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:52 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 5/6] t7063: use POSIX find(1) syntax
Date:   Thu, 19 Mar 2020 21:00:06 +0700
Message-Id: <215801b02aceeed1e0f6313679c567a914ad5dd8.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
update feature, 2016-08-03), we started to use ls as a trick to update
directory's mtime.

However, `-ls` flag isn't required by POSIX's find(1), and
busybox(1) doesn't implement it.

Use an equivalence `-exec ls -dils {} +` instead.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..c2731d445a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
 export GIT_FORCE_UNTRACKED_CACHE
 
 sync_mtime () {
-	find . -type d -ls >/dev/null
+	find . -type d -exec ls -dils {} + >/dev/null
 }
 
 avoid_racy() {
-- 
2.26.0.rc2.234.g969ad452ca

