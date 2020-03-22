Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA17C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A920767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHB4s95y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCVA4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36460 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgCVA4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:14 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so4282517pjb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL9BNjfEZAraw2UiRF6h6Zn4dRDUOJp7sSHnN15fLNo=;
        b=MHB4s95yokbvyf+bbfYE8a5w0bCS47oZJ+NDO7dtz9KF8nd4ybYecSu7HVzKVbWPnP
         RNQVi+aKQAdwEI8CO/ZW+ce5QFPrxA6fUrqrcO0sNuz3j2+6iPUjuoNSGIGkUgCmrnlD
         WGBJ+qhl/UhrzqXrVSuA7SVYEpkhIvp07WoEKtcYTZC5cB3OWpXRf/GEMIRvxmUY4zXa
         7VwAVM2MGMGnwUFjppv7MYrYUP0e1LATSbZDf9rQleRlHtnYfUZPc4T8QZd+hjoqR5nf
         Jy0M8OfliVmc8i8RY9nALOURT/SQ9fB/par8AztLSbXTJiJnCZG12QLW8ZBz9rn5gq5Z
         f2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL9BNjfEZAraw2UiRF6h6Zn4dRDUOJp7sSHnN15fLNo=;
        b=bX2VeleP20cEVG3AcVlyC+c1XNnSL8C+tApkhx5fEYwG2/396uLrSWKeDBwNobxqiC
         11Szxlhzkvb4pNwAxki7v9lPSG3LhEdS4dr48+/43ifFHKN0WctUn3elofFcAkvZRM1X
         rws9vQiwCCRAaVW9haehTyeg6So4Z7bAxt2S98shB2RLkGPIGFiHCK1gMqr/pm7Ey6nb
         UYYO7zMpHZs1sWdexNs/4DTkwZODnJuy4xMu/RmUhVFOlrmtlzQSq6U+lcIEz+H57z5w
         YM24eEHh93cqjwMn9kh53c1DaQkiz0kIcftwKwjGmiq4Wxft/NHetsRfsG1JAWO3SYgN
         jfmg==
X-Gm-Message-State: ANhLgQ0r6SKdQlTnlITzdXMxXXrRjuqDw1rvbPbS9YPdvJCDCol0BpvV
        5f9RXMasocK8LAFVjSRvuXmetw0+
X-Google-Smtp-Source: ADFU+vuT0WtE1tR4S6l4ExMUceOx/wB2efeRTxEnODNwtTpij+thAMwClCVhgYjopCX6xk1qoQk2iA==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr2738533pjo.170.1584838573190;
        Sat, 21 Mar 2020 17:56:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:12 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 5/6] t7063: use POSIX find(1) syntax
Date:   Sun, 22 Mar 2020 07:55:18 +0700
Message-Id: <1993b28a12cca8f35b89811ee7fea59c280931f3.1584838133.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838133.git.congdanhqx@gmail.com>
References: <cover.1584838133.git.congdanhqx@gmail.com>
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
2.26.0.rc2.310.g2932bb562d

