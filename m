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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD1C2D0E7
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2920719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLCt9Fal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgCZEiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:38:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36502 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZEh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so2174867pfe.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+z6BdC5bveeBZcRo7RMZhSYRMUrKbaLzmtDUtbC3KI=;
        b=FLCt9FalUuxNdx9BqjGjEI5GQG8A86U2MibrzwlpIgAECZdyzuVebhoPC3PeUTwRQI
         f2TIYdZjX/ZRsjaqpZvIFZNDIgiS3coky9B1BYN/s1ElmBZW2gbesxaz5eov6NOyv4Fa
         pCGlfGX5lX7eCzbZNOoYv32FhuYLZhQJzeAASVg536NvDV8sB6AZR/QuArY6mSczhXUR
         aaWi7l7DILX+zBZRnXGuphvBC+9JA1cb/j76bKV4r2H3W/qMwFiMU+VQA/39vINwiHQr
         GtVRfQGIMcoO6BhrUMl0QN2SgBcaILWot4TCg5G+zPl299weemDh4BNyv4SuMPoUUVpc
         L9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+z6BdC5bveeBZcRo7RMZhSYRMUrKbaLzmtDUtbC3KI=;
        b=kSRyMjXkmmh+s4t/Oy1I4kUUDATrcV0cRGMAAhp1NfmGXxhHJJve1HL70UAO6VbQH4
         VUjRN897qkvg23BQEkMjPLUO2OQQIh6zm4+bHV179u1NPB5mRZiM3fSuylRjskeWZUnT
         pcV3TszI92ip1OXYY9W4dD1gMAz/Xrw6PI8U2SDxUeky1rg5JTEUdgxF2ICHkALt/Z3y
         nu6nYHvCxlNauO9TlKMh3hwD1y1KAfrO57bva3D2000HlvXqU8JJcAjRDb6t7lVnMBh1
         BbBMj9sUEI6l33/YUdoYYrBMfU4ZpLK4BLj+MIiYaqF9LAch+qe/pZx1Un4clp16ZgJ5
         jxYA==
X-Gm-Message-State: ANhLgQ2QFFgi0Tjb1V5iQAlkrJZzA32ni3iCu7Ae2joCLRZ0uYhAQxSY
        u5uX9D7LrPUP+mVTqE2wr/ZCGvQW
X-Google-Smtp-Source: ADFU+vuPoomKePFaV5wmtC+S35sOD7wBJpSb2yrLNpu1HUiMVaa5AS6MZY08T2tAssYIi/fTseYecQ==
X-Received: by 2002:aa7:999e:: with SMTP id k30mr6849256pfh.235.1585197477339;
        Wed, 25 Mar 2020 21:37:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:56 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
Date:   Thu, 26 Mar 2020 11:37:36 +0700
Message-Id: <b3acf4adcfdfd48f0728c5b05913d81b8ee6362f.1585197360.git.congdanhqx@gmail.com>
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

Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
update feature, 2016-08-03), we started to use ls as a trick to update
directory's mtime.

However, `-ls` flag isn't required by POSIX's find(1), and
busybox(1) doesn't implement it.

Use "-exec ls -ld {} +" instead.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..6738497ea7 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
 export GIT_FORCE_UNTRACKED_CACHE
 
 sync_mtime () {
-	find . -type d -ls >/dev/null
+	find . -type d -exec ls -ld {} + >/dev/null
 }
 
 avoid_racy() {
-- 
2.26.0.rc2.357.g1e1ba0441d

