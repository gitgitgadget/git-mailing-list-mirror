Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559ED20248
	for <e@80x24.org>; Tue, 26 Feb 2019 05:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfBZFS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 00:18:29 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43857 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfBZFSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:25 -0500
Received: by mail-qk1-f175.google.com with SMTP id f196so6856258qke.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86wUssbtwenoScENzMPC3Yc0ZwSX1nx/hz6/nOehjQY=;
        b=fMvyPLiGS/AHWDhnLtCBPvQnDS/SFmR/hJuK65o0kUQsXbvn7Av/GeH+U5EK2jhieB
         5nF8yQMW9nwup2tBuOU/6bC2v4mBckXQiWD6OsugNtCQfmRYeZrQgb0YKSY8JBnbuccL
         /2qssS3Ia2ALPqk51lBnNnWjdKcX7htcmLHZL92ot2dXq+Ai49+f4lsHaIMo6bCJjvsN
         llHjg0dDWAqArjbzuquD8pCF79YgTWowmhnmcOggUHRJ95FaNGzniKWh8QutNeWGLCRq
         8cdl0rFcboEMf5pVzDOUqcOlgRGMWxq8C6zLzXUzSnmmv3OF1t1TcYLldsV9hZEfd0LX
         lkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86wUssbtwenoScENzMPC3Yc0ZwSX1nx/hz6/nOehjQY=;
        b=tIKXVJrUHQTgsUzNqKp2ZYvsY6pRHcfJkEg2pnhPdMwVnNh0ZznoFSt0ibeh4BQPTG
         GaNY6wjyrgh8wmplOxgNGtpzDeiWGlbhCOBbDh9aT+VbHWmQPzugXu8BRaXwRAoeeYzL
         Xq4K4OhqyznIzObKRiUG34tYDo9G53I7DgsoyaERrmZ5TeRslswfuYO8newHOY7+Oojt
         +7MezUisuhhh7ThznC4ecG5LNtLjCYX3vc3+fYOBQdBhMe3uvhZa1t36wdC3lgx8rJur
         gKNLe/LlrhIfcNIOOFi9awXnG2k7JpYtb6GT6HXvomKl61RlMWITne97ZEAvMR3YHKFv
         FZyQ==
X-Gm-Message-State: AHQUAubgSNR9BXdSnqnKk6UnxveBhsPLv7JqZ6yrxfAL1MoIKSnQ0ZRM
        A9occ4MQsi/6Idw/oaXNs7hqIP0AQzA=
X-Google-Smtp-Source: AHgI3IaaT8OGMbUQSs09r+RWxVHQHNtRzqKL0HRZM0xq7r0Za8R6LEF2ZpI7HykxG9I2ifJOLVdpcQ==
X-Received: by 2002:a37:d150:: with SMTP id s77mr15881483qki.334.1551158304414;
        Mon, 25 Feb 2019 21:18:24 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id k39sm7698738qtb.37.2019.02.25.21.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:18:23 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [WIP RFC PATCH v2 4/5] clone: extract function from copy_or_link_directory
Date:   Tue, 26 Feb 2019 02:18:03 -0300
Message-Id: <20190226051804.10631-5-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help removing
copy_or_link_directory's explicit recursion, which will be done in a
following patch. Also makes code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index cae069f03b..fd580fa98d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,24 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	fclose(in);
 }
 
+static void mkdir_if_missing(const char *pathname, mode_t mode)
+{
+	/*
+	 * Create a dir at pathname unless there's already one.
+	 */
+	struct stat st;
+
+	if (mkdir(pathname, mode)) {
+		if (errno != EEXIST)
+			die_errno(_("failed to create directory '%s'"),
+				  pathname);
+		else if (stat(pathname, &st))
+			die_errno(_("failed to stat '%s'"), pathname);
+		else if (!S_ISDIR(st.st_mode))
+			die(_("%s exists and is not a directory"), pathname);
+	}
+}
+
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
 {
@@ -404,14 +422,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
-		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
-		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
-	}
+	mkdir_if_missing(dest->buf, 0777);
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
-- 
2.20.1

