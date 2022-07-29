Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18420C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiG2JGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiG2JGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 05:06:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD41C1B797
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 02:06:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g12so4114236pfb.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9aCyaJ6RdpdLbbUzx1wHprXTKhQ6wuKVHcRAuVpT2U=;
        b=A4sh9HUGoWR68ZZ0Ey1QzzSnqTc0rw1TiRO8gfya5AtnoTVWsDygOM7aYQZxNCNXD2
         XoaHc98uJvYiohpU5VvZUG/exaRD2VNwF3TkGPrN3Gtj6TBIGKc1M+c8yQqiQvu2CVQ9
         OkCmaUsZLAHeQKsRi9DXK6iH3p6ZoLypoEhgB7bjkQ7RgukuwZT9eSgfophNV9UeDYh0
         tvliwvwks1IGVkV6ZB6rQp9Pu6mZY0/GTlkPWyN3gE7xkNAvVRjuX4zJGM0YZ8emNL1K
         0vkapVteqLp3ddZ+z4adVVze/JeCY3/ZOSJsskaIj72Ckp87nhGZTBxXZkt14WQgfctp
         xt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9aCyaJ6RdpdLbbUzx1wHprXTKhQ6wuKVHcRAuVpT2U=;
        b=ujT2+kgsCYb40O/rKa8E/3jjKQlUCjIFjn92+PXgOKoFRt/V6NWxCNOw14Bbns27Et
         uDevUb10ljpxic5GjCfVvIxf3Oj0nX96EoD4a85WuxQDJ+3Up1RwtmGd1PoTfommajiu
         jaGPLk6kPas6PYmBibh4BqmsVduU+S0jGND53zBjBnKpwl6ThSXlu5JSKTdcoGNXYnyl
         LDGLIg9PEu/PjYaIFfQXGQgJcMyB4Hep8wPdEDos129qCJfu68AhZqTFmYY9bp5WWs24
         tfVLT2Wn5ufLsiwcidctdWBNjv2HFBiKtVHtyFPoFVL8+SmfOehFS5ok/OsZc0WADEBY
         eMUQ==
X-Gm-Message-State: AJIora9PyRXHbuLMAG/R9QI0mH7/mAUF+cNsUfHl8fgU/OR0xdUVHP3l
        dB/28aNEgbC91IeGs1/GlN5HP9Sj2XM=
X-Google-Smtp-Source: AGRyM1t8TFXHDjZdAJH4xykFico+dIcry+g4crg5CFJRUNyUDDa2axlKOdVgYugcb+LOBX5L/WmS8A==
X-Received: by 2002:a63:de15:0:b0:41b:99a5:8119 with SMTP id f21-20020a63de15000000b0041b99a58119mr485580pgg.180.1659085573019;
        Fri, 29 Jul 2022 02:06:13 -0700 (PDT)
Received: from localhost.localdomain ([113.173.163.90])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090a4a1300b001f329d1c54bsm1698925pjh.6.2022.07.29.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:06:12 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] merge-file: fix build warning with gcc 4.8.5
Date:   Fri, 29 Jul 2022 16:05:55 +0700
Message-Id: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.37.1.560.gdfb9273964
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mmfs is an array of struct, xmparamt_t's first field is a struct,
mmfs's element and xmparamt_t's first field must be initialised
with {0}.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 This warning is available in master

 builtin/merge-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2ab..607c3d3f9e 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -26,9 +26,9 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
 	const char *names[3] = { 0 };
-	mmfile_t mmfs[3] = { 0 };
+	mmfile_t mmfs[3] = { { 0 } };
 	mmbuffer_t result = { 0 };
-	xmparam_t xmp = { 0 };
+	xmparam_t xmp = { { 0 } };
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	struct option options[] = {
-- 
2.37.1.560.gdfb9273964

