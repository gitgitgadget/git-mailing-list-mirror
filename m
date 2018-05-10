Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C2E1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965559AbeEJOTj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36486 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbeEJOTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id t129-v6so3239849lff.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3bHYgGF85V2gmGJN3VwpI5q52r9SUfyWApnPWZnQKc=;
        b=S5L3uFkRmigy8UgDxa/46IjGvU0Nb19VbfOz7gYxHTofALjbBWius3MOMvHdYfAgmm
         HALpubLnGkZDRMkm/lMUbzz5sIz7bTvCx71rO/Pbnxrg3ONAWZjhKo9xc5a6xqjR6uvo
         L+0reqhCkXXFEbpoiRm7/4h3ersbxSFEejHqyq3MsQtgRwBRPbPaTWmPE5RKR5NGXgjC
         Cyw5YqgN4FXTX16BaRH7L03c+es3jaWC5bw14eQvsga6NyHI+EIjYr9v30RuspvAKyAV
         9KoHmNnozJKIJYKh43DgpwHVoTlAmyagtn9rIHHta2P3EVCI1v4f+8TRfU0hMpZV7orZ
         d5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3bHYgGF85V2gmGJN3VwpI5q52r9SUfyWApnPWZnQKc=;
        b=E8Fd7V4Hue0E+Wi+7/c3dWWt9/ribGuf82n4q3Pwjh5AWNN8HzhRzAOJB3GC/+28tF
         FIVFByPOsUtJwDWmkOv85FnTlqatoN7Cv/h/+UWIRzIxlFcCBI9F3Q+Hlre4B2KVDcle
         k/I1nT2CJHJUOxfO/qit97yHDjKCzfA/2vvXG6fvHnA3B3ULf0IGL2IvwyISEEKAP8u6
         oQYGcf6yO1bVWVsVBEAnsKnG5+4TgH21qHriw+fnnyYaHNb9pZQyDJtaKdJC/AIel0Ak
         zwGVI0XNJGMs1Pjswkl0p6xG5ldWisgY70kErzes5P3mkNMwqOnV+Qrt9tjqD96gu3Z3
         HIgQ==
X-Gm-Message-State: ALKqPwfBP6aHCsgjEEFKIDXtNCPGlx5f83jFuMD66XIU3GeW2uOuWZv5
        zMViMRzy72hFoB22z0yknTRt2g==
X-Google-Smtp-Source: AB8JxZqWgSIWwHyMA96RpdpSGw3q/l5N8ti6CBe778M7t5qPOs5mOfnaCChXUIV/+23too5wzCyA0w==
X-Received: by 2002:a2e:99cf:: with SMTP id l15-v6mr1400495ljj.148.1525961974436;
        Thu, 10 May 2018 07:19:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/9] fsck: factor out msg_id_info[] lazy initialization code
Date:   Thu, 10 May 2018 16:19:21 +0200
Message-Id: <20180510141927.23590-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This array will be used by some other function than parse_msg_id() in
the following commit. Factor out this prep code so it could be called
from that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fsck.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fsck.c b/fsck.c
index 9218c2a643..f2534abd44 100644
--- a/fsck.c
+++ b/fsck.c
@@ -84,26 +84,32 @@ static struct {
 };
 #undef MSG_ID
 
-static int parse_msg_id(const char *text)
+static void prepare_msg_ids(void)
 {
 	int i;
 
-	if (!msg_id_info[0].downcased) {
-		/* convert id_string to lower case, without underscores. */
-		for (i = 0; i < FSCK_MSG_MAX; i++) {
-			const char *p = msg_id_info[i].id_string;
-			int len = strlen(p);
-			char *q = xmalloc(len);
-
-			msg_id_info[i].downcased = q;
-			while (*p)
-				if (*p == '_')
-					p++;
-				else
-					*(q)++ = tolower(*(p)++);
-			*q = '\0';
-		}
+	/* convert id_string to lower case, without underscores. */
+	for (i = 0; i < FSCK_MSG_MAX; i++) {
+		const char *p = msg_id_info[i].id_string;
+		int len = strlen(p);
+		char *q = xmalloc(len);
+
+		msg_id_info[i].downcased = q;
+		while (*p)
+			if (*p == '_')
+				p++;
+			else
+				*(q)++ = tolower(*(p)++);
+		*q = '\0';
 	}
+}
+
+static int parse_msg_id(const char *text)
+{
+	int i;
+
+	if (!msg_id_info[0].downcased)
+		prepare_msg_ids();
 
 	for (i = 0; i < FSCK_MSG_MAX; i++)
 		if (!strcmp(text, msg_id_info[i].downcased))
-- 
2.17.0.705.g3525833791

