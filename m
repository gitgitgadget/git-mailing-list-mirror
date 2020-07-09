Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B719C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C38B206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="vpBzmoht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGICKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGICKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:10:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D19C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:10:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so449604qke.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=654xk1egj2i0Q+BGwN4JKDpSHK8PqcpFa0Zd+ij0mLQ=;
        b=vpBzmohtfcnXUsPPjJ4vofMNGYr7gN0HtPhWDjqA6T/Q/X2GSKOH2G8Fe1+l8JoLp/
         cDcRXbKteEAvHPHkI+rbUV7nIWIQ8xgFHKr2S5TM/rNaxHuJevY7zkFEoXD5NA4L53Ix
         u1m70n1xQtG+DhMhSOvWatLbki04BmeESggEXuIlCsD2KKBgoZQcQ0T4whcs0IURtWY6
         lDLDE/VRUFeVmDzaomDgs59SR4vM+jDPnwwW7mYmpbD6lvrNRhhpOxk1AcJZtiD4PWTX
         0uAcEp0sVQXZkKsX2dPuMA+fosdWL0Y+W8ntIIU2qogYqLhx820YiHyKDth0dp3yR22c
         Tc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=654xk1egj2i0Q+BGwN4JKDpSHK8PqcpFa0Zd+ij0mLQ=;
        b=CC/vXgFz6Rmvel4K6w8MmgD2o2/yc61wYQHQoQDH1XpKhYmbQ/tPGxPDy7eeb6ppDN
         xGCJSHhnUgJhQQOr0MdZ2nEdL5gREG5WnI13zgJYelMpZFymxaePk+3558UEqWs2Ud1a
         3b7o/r7JxviZol5h8qZyksm+ai3aKUicv3EmDFgwMV9XnJ3onmfNv0V+vHghnpnOEKuU
         AM7SLWEyCS0cIernMom12DY0IhzI3dErjGFMM5MFXIrbFHQJQlQF3052yTPk3mJ2SuEE
         LLZkWDuv0qItV/QQjUrAOzErat47HynNSKO026qonJQg0NB4l4Jln6hgQgIGV+d45rc0
         rQTA==
X-Gm-Message-State: AOAM533EwORqGL4VlpuneIPbFZzdJjZB55yqZdJADkqOorg4sv+EOEji
        rp+LYYkEJ3HzlIq8WUKXnB4pxzsQ5iY=
X-Google-Smtp-Source: ABdhPJxlArGT3fX4Uvc8yiyJEa7WMmdaive0tcrVtrbCYewvxvbGS40/kq8kCfJSQdiYU0tzUtTdrw==
X-Received: by 2002:a37:b56:: with SMTP id 83mr57058561qkl.362.1594260647453;
        Wed, 08 Jul 2020 19:10:47 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id d19sm1953658qko.114.2020.07.08.19.10.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:10:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH] entry: check for fstat() errors after checkout
Date:   Wed,  8 Jul 2020 23:10:39 -0300
Message-Id: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 11179eb311 ("entry.c: check if file exists after checkout",
2017-10-05) we started checking the result of the lstat() call done
after writing a file, to avoid writing garbage to the corresponding
cache entry. However, the code skips calling lstat() if it's possible
to use fstat() when it still has the file descriptor open. And when
calling fstat() we don't do the same error checking. To fix that, let
the callers of fstat_output() know when fstat() fails. In this case,
write_entry() will try to use lstat() and properly report an error if
that fails as well.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 00b4903366..449bd32dee 100644
--- a/entry.c
+++ b/entry.c
@@ -113,8 +113,7 @@ static int fstat_output(int fd, const struct checkout *state, struct stat *st)
 	/* use fstat() only when path == ce->name */
 	if (fstat_is_reliable() &&
 	    state->refresh_cache && !state->base_dir_len) {
-		fstat(fd, st);
-		return 1;
+		return !fstat(fd, st);
 	}
 	return 0;
 }
-- 
2.27.0

