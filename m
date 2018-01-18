Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399EC1F404
	for <e@80x24.org>; Thu, 18 Jan 2018 09:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeARJu5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 04:50:57 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43390 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbeARJux (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 04:50:53 -0500
Received: by mail-pg0-f65.google.com with SMTP id n17so6091400pgf.10
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 01:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekeRnRsehDtIrniXfa0QLrD/vhmRJ3Vrdxalx9ZRg/A=;
        b=eRv/9ssJrBm/+o3a2J18wU21IZZNnm8ewHv7Kreis7x5XzME3TOeLhjjZkM7q2RZnU
         UFI43aGkldvceRq5xjF+HSd+/tFjVLEngGjrs8vLb0tY27yx46czRn1QDAns0wYFzjFo
         iBHQ3KaOGXhWiYhmgMD5RyT1yNk9/wh8bzIaHFZtKHppQOpGBrDVPI4XhnXnNGrUINkW
         nOnVbnAeImjrqAWaWKCFJGeMnMQUoRic5EQI8JsxKhgfMwrO9mr0cPxlIJ5MFnSgp7br
         ztz00SrVsu7Kiqj8gs7G34mebJjvrGHrh2lmhr3Ay/YPJhljvUn42XRr26aC4gu13nnL
         Tv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekeRnRsehDtIrniXfa0QLrD/vhmRJ3Vrdxalx9ZRg/A=;
        b=AqeN/pJXKiqPfGW1vzNj3ayfqf8cCiPmtevQUMrgXLt6U3bQXtTUChuJT8U2PMhKNE
         Cp83bECwErWmst5Pep5qHkieuuwud8DCv/PezDOaTCN4amDt2UV4F/y0TC/jJSq3KSqg
         gt/9IpqxAMUsGJk5rPBh89MrLyV8jALw1QYP8+6ZRBc8JNH6JxrzK/EC+TqUZnS5xvW3
         f7Qgd6KvEfwNBqGVHrGq+dWlev+iS8N29f3oDuACkRswZzDE9XMqvIaWfTTjFFUI9Fs1
         Ce003BWCRTlCbubX7cNsu6UI+25YoIdbVNbIhNksKsxtetKThK6MLNbZ52HXTMQLV4EY
         cpvQ==
X-Gm-Message-State: AKGB3mJeuW1LRp4sBpRTvaYNZzSemoBMCmfw1rnOpQqhqD5PgaBSKxvW
        Z32bYhVq3aUyuVd6QHmtEf1SGQ==
X-Google-Smtp-Source: ACJfBouJiCEXXyqhfaGD2Erah6/J471DG9Eqx3BkN6MTynCgbbmAWOBbk1HpT8hZmJQTRBcO5AIXCA==
X-Received: by 10.99.112.70 with SMTP id a6mr27248983pgn.152.1516269053037;
        Thu, 18 Jan 2018 01:50:53 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id x21sm12464589pfi.174.2018.01.18.01.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 01:50:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 16:50:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] dir.c: print correct errno when opendir() fails
Date:   Thu, 18 Jan 2018 16:50:36 +0700
Message-Id: <20180118095036.29422-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The call invalidate_directory() between opendir() and warning_errno() in
theory could make some system calls and change errno. Prevent that by
warning immediately after opendir().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This is on top of nd/fix-untracked-cache-invalidation which is now on
 'next'. Sorry I waited too long to send the replacement and it's now
 too late.

 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index dd1e50c328..55736d3e2a 100644
--- a/dir.c
+++ b/dir.c
@@ -1795,14 +1795,14 @@ static int open_cached_dir(struct cached_dir *cdir,
 		return 0;
 	c_path = path->len ? path->buf : ".";
 	cdir->fdir = opendir(c_path);
+	if (!cdir->fdir)
+		warning_errno(_("could not open directory '%s'"), c_path);
 	if (dir->untracked) {
 		invalidate_directory(dir->untracked, untracked);
 		dir->untracked->dir_opened++;
 	}
-	if (!cdir->fdir) {
-		warning_errno(_("could not open directory '%s'"), c_path);
+	if (!cdir->fdir)
 		return -1;
-	}
 	return 0;
 }
 
-- 
2.15.1.600.g899a5f85c6

