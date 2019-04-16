Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2ECA20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfDPJgm (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36089 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbfDPJgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so10124433pfn.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVjU6r29pDbupTY7CdDKciCqM+l3iwaWNxGJE9kexEU=;
        b=a6CXfe74QC9rI/8VSsxq1euhMmmPm3CEIW/LZujMGvhXT7HfQfJYj/+uE0rWxMoUSO
         lvEJKNNM52KhbgL32k4fCqSOVxM1WowKCn/cH8VN5aG1FaMpxcWRgrgbJUX+18ua/X5z
         RuGmYx9uaNBZ4hGT+4WhKEfcRHJfoLNKEFkaCv/elvwdDp96nsoFrHYNy77x9QvcAN6h
         /sKR8h3Vpy3GmUFcyDVtBvRYxjVY9wdSwNEDtNJm0pGuMpoZh0wG7lXv/OoJy/3Qi2Cp
         25P5pP2wkko4Ea8DuYbOtvW/Oc1h5V/ZxDMNQIo/pQx10JH023qGKW4d257VoslM8GEi
         ceZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVjU6r29pDbupTY7CdDKciCqM+l3iwaWNxGJE9kexEU=;
        b=EwJULrq/DnkdeX1XmKaCJ2c063z9xN+7lipCMHRcMkPV+I259JQEBmVkC36BXw8/2B
         mrmmOwHgfAE10ysUmm/OxkykDg4PcodQ995LR7oOVx/qVWtXDMobPisuMQCN2h4aFw4M
         iL2rvPC7Gxi8xk8meZjJte4ZXR2ul2kX1WPV/D9MtAnTDrxbB/6941dmQSGihzJsS02L
         z/6S2S/IqkcHbNmJNmJFbWMbTTRDLNatzGZf7dEVU1dcpGd2e/BBWrKQ9JCGOogTz5Gb
         ghEszSYzIcr+/uvZuSN0802wBPBXgww7apWtrQpLOIly+sVS2ayC5fk4SfWxfyAj4I7q
         fG/A==
X-Gm-Message-State: APjAAAV8A3jXqT7o/npJQ2E1Ws1pgPx1michaTSV0p97Pf4i/wbjgTUS
        U0LsAk8sCM/rJ5ixMoSILXrh/tEn
X-Google-Smtp-Source: APXvYqwWZWmKIYK1JH4v8uYjTqdVMd/3PFZgte/HWBk7sh5CeiSS+G9RZydYch0RFvEEzl7thT1cGw==
X-Received: by 2002:a63:e915:: with SMTP id i21mr75255675pgh.297.1555407398962;
        Tue, 16 Apr 2019 02:36:38 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id j62sm57760302pfg.6.2019.04.16.02.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 21/34] sha1-name.c: add repo_interpret_branch_name()
Date:   Tue, 16 Apr 2019 16:33:28 +0700
Message-Id: <20190416093341.17079-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7d9512ac44..49c62d5254 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1390,7 +1390,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 	return 1;
 }
 
-static int reinterpret(const char *name, int namelen, int len,
+static int reinterpret(struct repository *r,
+		       const char *name, int namelen, int len,
 		       struct strbuf *buf, unsigned allowed)
 {
 	/* we have extra data, which might need further processing */
@@ -1399,7 +1400,7 @@ static int reinterpret(const char *name, int namelen, int len,
 	int ret;
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = interpret_branch_name(buf->buf, buf->len, &tmp, allowed);
+	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, allowed);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1482,20 +1483,18 @@ int repo_interpret_branch_name(struct repository *r,
 	const char *start;
 	int len;
 
-	if (r != the_repository)
-		BUG("interpret_branch_name() does not really use 'r' yet");
 	if (!namelen)
 		namelen = strlen(name);
 
 	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(the_repository, name, namelen, buf);
+		len = interpret_nth_prior_checkout(r, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
 			if (len == namelen)
 				return len; /* consumed all */
 			else
-				return reinterpret(name, namelen, len, buf, allowed);
+				return reinterpret(r, name, namelen, len, buf, allowed);
 		}
 	}
 
@@ -1506,17 +1505,17 @@ int repo_interpret_branch_name(struct repository *r,
 		if (!allowed || (allowed & INTERPRET_BRANCH_HEAD)) {
 			len = interpret_empty_at(name, namelen, at - name, buf);
 			if (len > 0)
-				return reinterpret(name, namelen, len, buf,
+				return reinterpret(r, name, namelen, len, buf,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.682.g30d2204636

