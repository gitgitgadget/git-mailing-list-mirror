Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CCB1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfBQKKk (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44691 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so6983970pgk.11
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PriUNGoNRPHBymzG2Iuyg44flPEY7XWWD3rRa38acg=;
        b=lJIlOsKBP0eKX+hLxoksDNww9hcuV3gsVRu4kxyu5pbE0o5uV6msEYGyPV4ecR8svd
         ubBlmEV1S6Cj3gktbAYKow01KH57qRWAA/IG1JDsWIBlHj17QtdnVyhHP+IN3lr2JtRT
         awwoSWGc/+0JIYMQbNSNfjiScwLBh/n9j82QhTL3tYN1QgIKoOXf3orRGSTLZlO3X1Ft
         e1pbyutwtVhVNp3X8TypUnxxzVGE7QZ86RLDnH7pacryZGy8JWBERc8BQCFxmExQPMby
         ltJBLSZ4SVcptCsvi5jHD1s+hzzypnFI52TL6XCnx8a9EI2TgKb/dOrt2RpT3uWikNu3
         iyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PriUNGoNRPHBymzG2Iuyg44flPEY7XWWD3rRa38acg=;
        b=XUvAcgC9kbooUrGRT6YwUjPtNponib54qeLdRouyzwQhGF7HvnOau2hl/rZ7DIl9RD
         7Xxk828nk/xgPUKy46BgmIFA2zHeZvYIh+733xEQmw/ru9MSP6A5mMvWZ2tvWW0S2Mex
         j+lR4UDQA8k2sCm6Ctc7Pk59wGa7ZC9+yx8+8MB2uJnMMPgIdb3qKh7HmnO5vtZz+p87
         6U94mwAsVKhFtA9B+YoOcN5WioHXY6X2vYiGMC4NEALNsYbgE6ZFumbsjSXv17JACnjy
         6PnHkCx7hZRcPiGopJp6ySzwlRXebu7/Uz9oc8s64f+8jD1nc0bMBlMKl6s7wZfNf02z
         kgfw==
X-Gm-Message-State: AHQUAubXtQk4uU1KSiRc3xl182gNwkzsGFjnZfpYPRqRYCMmVUH9kfmv
        R0R19zYYe/9CtOcG1mxDx0kqCHuz
X-Google-Smtp-Source: AHgI3Ibq9mP04y+5NUDjfl36GqxdhCUzlBmc47pSkgWvGOQLTopDipmtTqyzyKl3Z7+FiLDHghMaWA==
X-Received: by 2002:a62:68c5:: with SMTP id d188mr19014881pfc.194.1550398238442;
        Sun, 17 Feb 2019 02:10:38 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y21sm16900660pfi.150.2019.02.17.02.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/31] sha1-name.c: add repo_interpret_branch_name()
Date:   Sun, 17 Feb 2019 17:09:00 +0700
Message-Id: <20190217100913.4127-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
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
2.21.0.rc0.328.g0e39304f8d

