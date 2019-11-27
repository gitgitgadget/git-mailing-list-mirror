Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8586CC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45520674
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1fIKBIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfK0PNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38599 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0PNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so10570065pgl.5
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pJOomD/OGzubWwTYaYcOOj/gx5u5i0oyvQjWMcZg1I=;
        b=E1fIKBIAGffiU5hx/POU42I2fLVbF1VTiLhECjbElXpZpCHsNAOVFddmAzWJGG+88Z
         SDhQuFApuWqaUWM+/VM7eke32ZVfjrAGEfZbCX25df8wJv31PH3SjiMHbwNeJDoSGhXd
         D82KMXiuY1UDn/gi2rZDQwSoHpKyHkN+dIrRkyuFwKrD4cWclGMlP1OX1NYzr3Mzaird
         bZTu7ZZcag0B+rPKtzby31f8Z9EIw/CDQSNlZ7eVettCiWJKWaCSRQHYUVRZbpSn+Is0
         JoJGP8xRH96GizLXYpbPqOBaH+saJzRNs3qtLPhEKsBl9IJMClIJ3+FeArY16Rr3Ih27
         Z5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pJOomD/OGzubWwTYaYcOOj/gx5u5i0oyvQjWMcZg1I=;
        b=MJ5DA7mWgw+yCr25tIPwI6ty9ithlQfozWlzTYPoLb/ZF/u4hn1loiSryAgQhs7yY9
         2n2oPLBYYsutAgHd2DiCuKig+vN02KWzK5Jyk+ZzJnaqqTESlOrcZ6PkKpniyZMqX6Xn
         w/p8FMXGLnhn9TGK2w/9EyoaYxmdxj89kN7dmpobZp4sJGr/YKewogddhMhTTXMEeap8
         ZBzZU5DfePS82QIEdL22YFhbd15VW2ZjuIHkNQQRAOxvkz2qKDX3HtoWlsCDnkMkJQG5
         9bQ6N40WmYSK5YqbBfs/ICWdifRA+x9BGB4p/o5ddjZBHu6dOncAGQud+tVB3XldZn6M
         r4Lw==
X-Gm-Message-State: APjAAAWP1XzUNzC0Bzo+sNbRHJMnEpEdIoyOxbbqnUEGBGgoG1IEJ0cv
        p3sGLL8UdVL/bFa+WWHYkf3vk2DM
X-Google-Smtp-Source: APXvYqzo0UU3SIUvPog6LkCnMNi7BaLH47AHsvdqASD1hEeXOitlBoXqQZqu6J8oX5Wul+lM+8/aaw==
X-Received: by 2002:aa7:8e15:: with SMTP id c21mr48230470pfr.122.1574867625791;
        Wed, 27 Nov 2019 07:13:45 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g192sm16883674pgc.3.2019.11.27.07.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:13:45 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 4/5] archive-zip: use reentrant localtime_r(3)
Date:   Wed, 27 Nov 2019 22:13:20 +0700
Message-Id: <f6fd89dfe12afbfddbdf718cb691025bb1541eef.1574867409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.158.gd77a74f4dd.dirty
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 archive-zip.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4d66b5be6e..8bbd3e5884 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -603,18 +603,18 @@ static void write_zip_trailer(const struct object_id *oid)
 static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 {
 	time_t time;
-	struct tm *t;
+	struct tm tm;
 
 	if (date_overflows(*timestamp))
 		die(_("timestamp too large for this system: %"PRItime),
 		    *timestamp);
 	time = (time_t)*timestamp;
-	t = localtime(&time);
+	localtime_r(&time, &tm);
 	*timestamp = time;
 
-	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
-	            (t->tm_year + 1900 - 1980) * 512;
-	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
+	*dos_date = tm.tm_mday + (tm.tm_mon + 1) * 32 +
+	            (tm.tm_year + 1900 - 1980) * 512;
+	*dos_time = tm.tm_sec / 2 + tm.tm_min * 32 + tm.tm_hour * 2048;
 }
 
 static int archive_zip_config(const char *var, const char *value, void *data)
-- 
2.24.0.158.gd77a74f4dd.dirty

