Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD2F1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbdB0SIb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:08:31 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35774 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdB0SI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:08:27 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so11365061wrb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhOpjQulJthIYA75CDm/Mz5rmEHP+47Q8amVOHz4Q7M=;
        b=plKIJoTrWLBKcr9NA5SC0O9JYDY7+e/dG0tR94tCZx1pKPFztCddY9uDJTnj3c5cn4
         hG3tlPaSWMxDOWIPkHfHIHri67fzzV5L6dOuZMVmlCKVEo8GmfmAq5PAy6lMxPqxvsGr
         L+T8vJZpEDpl/dWIgDLkrB2xeLK1S9Jf+2XlOdgsYOH6/enDCx7FZhb6awZ3MKevSfpW
         VyXhGEw1o9qk37HX3oGcs8B7RXZCB0g/0bfpoyaJWMyld+1F7Iggm5Ojv1cvO4/pN8pP
         PAQ6CL3JtDTD51a3h8Z5BqrkAQ3Tqv3BtFovrNDnA2g833FhQSwgLq2fJ7juqQz5I5CY
         D83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhOpjQulJthIYA75CDm/Mz5rmEHP+47Q8amVOHz4Q7M=;
        b=oH43qfeSmrIQAtZxfKzAdqcA0/aRVGUzgwSnF0RNWldx4ZxggRjHRoiTdDMECMfbA1
         WdJ1bKhvj52xsEubh6QxMeRivM88aSiADKzPVAcbRgB/LSBqftYRX8ZFldgKoV8W8DZj
         8utQ4LXQK2kha1tDhD2vqfK3p9InAqWViYbLOk9NSQRVV7TLk6+2FTn/C6DlusNxpQNo
         y8g3i6KFay5YKvklRmkEEBnlC9uAwqteMREUSuCOvds9DQENLnP0IWKB3Lz3LxqRTJue
         c+8e42gVDVCaiLDyT8BQbo0D2mdOKPHn/LxjyqmC5jKjYTOjguYjU4ndXBX9u5uf/bvl
         vHZQ==
X-Gm-Message-State: AMke39lMNIrOU6Hq79KNNL0DxnlAr8U1+RQ/OAiGTSVNmr7hggwS0CSrvY+003EqD8rUaQ==
X-Received: by 10.223.154.149 with SMTP id a21mr9955897wrc.145.1488218456189;
        Mon, 27 Feb 2017 10:00:56 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:55 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 14/22] sha1_file: make check_and_freshen_file() non static
Date:   Mon, 27 Feb 2017 19:00:11 +0100
Message-Id: <20170227180019.18666-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a commit soon, so let's make
it available globally.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 3 +++
 sha1_file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 955e80913e..6b25b50aab 100644
--- a/cache.h
+++ b/cache.h
@@ -1229,6 +1229,9 @@ extern int has_pack_index(const unsigned char *sha1);
 
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
+/* Helper to check and "touch" a file */
+extern int check_and_freshen_file(const char *fn, int freshen);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
diff --git a/sha1_file.c b/sha1_file.c
index ec957db5e1..192073ea95 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -593,7 +593,7 @@ static int freshen_file(const char *fn)
  * either does not exist on disk, or has a stale mtime and may be subject to
  * pruning).
  */
-static int check_and_freshen_file(const char *fn, int freshen)
+int check_and_freshen_file(const char *fn, int freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-- 
2.12.0.22.g0672473d40

