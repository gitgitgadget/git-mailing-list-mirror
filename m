Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CCB91F404
	for <e@80x24.org>; Thu, 28 Dec 2017 00:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbdL1A3G (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 19:29:06 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40624 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdL1A3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 19:29:05 -0500
Received: by mail-pl0-f67.google.com with SMTP id 62so18791340pld.7
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=no6Ys0xnCWlArKV6Urq41WsCefwqLDabKq6YPb3RETY=;
        b=EsAk68Kn9s06AN/lg5Nkb/AGvRrAE9Wt5ZFlzz0WO1smTwWKlYrb/2X/W6pnYH1hXC
         s3X+jCMH3aCLVcI688STvjVCdkWqrqZiL/t+RoJ78kLxkYuWUvFTRKIf5eOR9qRjjfzy
         Ppe6+BJxu79hz/5nbfPNvQCdGRPfvfmxa3czGNYXSH/ux8hZqYSZX3ztYLEafY0pU9Ru
         9V6aZ8uZ+7AftRGSsBrWA7EH6A0KuTbO0K6gZtUa4zGRI0HLJnyGwtPOG6eM7oleY5d2
         gDNJmU1U27P5HmK5gg/tM/Nwc85NoijzVUtlVfDfynYpMIpWAs4ZjIQ/UGm2D1701R9B
         yeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=no6Ys0xnCWlArKV6Urq41WsCefwqLDabKq6YPb3RETY=;
        b=ueZyK9b8eEOQhuMJmZ9SwDDywnMKg+DDVUwBlI6NKs0hi9H6w4D6xKCYJaMfd42L9f
         ibYzCDwzvEc5uRTAZ6PoGN+Ezr8ozX+tnKh1Aaj9S04CZxRHsijuk+x+B2jkiSWg0sVu
         QUBPRDpoxyehbJyDI90zANO1V8LhnOB14YvgDqoQoEyCJPZmDxwiXsMaGw+XLFYKToxH
         R6gvh2384YkZE9vQfbkvFqvac2VDi4uK74No0CQRJwRbOT0VglmNlzahmqZoFQk6hY5G
         cYEh1UuueX9zHouYBHNbcOaNNi97cMBdrIXhsNsP0kkqjsJRijVAWcVSvT9Lf6rR4WT1
         4hXg==
X-Gm-Message-State: AKGB3mKOAo1wMrWFHVvmNXkk9B4zEp9zVu/djTEdvh0WqeEQWLRNwTHg
        kpDf5w5v4gJr8MV8wGXONTP2GA==
X-Google-Smtp-Source: ACJfBoufQgGLydp8iOi+YzYF2W9yvDhVNUvz1av5i2wH/DI86/Ap9oZRtfaXIjLgh656zIW5Ub/T9g==
X-Received: by 10.84.229.5 with SMTP id b5mr30580155plk.405.1514420944845;
        Wed, 27 Dec 2017 16:29:04 -0800 (PST)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id c24sm75351913pfl.2.2017.12.27.16.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 16:29:03 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] dir.c: avoid stat() in valid_cached_dir()
Date:   Thu, 28 Dec 2017 07:28:07 +0700
Message-Id: <20171228002807.22388-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

stat() may follow a symlink and return stat data of the link's target
instead of the link itself. We are concerned about the link itself.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I noticed this while looking at the untracked cache bug [1] but
 because it's not directly related to that bug, I'm submitting it
 separately here.

 [1] https://public-inbox.org/git/CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com/

 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30e..edcb7bb462 100644
--- a/dir.c
+++ b/dir.c
@@ -1809,7 +1809,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 	 */
 	refresh_fsmonitor(istate);
 	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
-		if (stat(path->len ? path->buf : ".", &st)) {
+		if (lstat(path->len ? path->buf : ".", &st)) {
 			invalidate_directory(dir->untracked, untracked);
 			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
 			return 0;
-- 
2.15.0.320.g0453912d77

