Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187E520248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDCLgw (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so7889336plb.12
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5XiUNgZOyJMfbfBOhs6OmmQ4I37YwDc4n2auyrKfdQ=;
        b=uUGvAydiVd7AzBn0SKA6Y30lWY9qdQB4Cn6VV+/msTtktZnhG1e0/+3y/iIAdmdo/p
         3JUJ2Pep6l60LVtHnxbeF7/5ROjCgJVAh/PjAbXRKnoZUFrA3xcyRmwOqtW7bRy+jPl4
         ZHgXbd/Jiv7PJJ70syHE+yi675WfbnS/VPtCzPoBg7a5NH4q/RGA1Q3ZCHkY4l0OmX6l
         eniA/Du+4NMEw+y5PVQM/y3RHMdIZIWtlTOpcrPPCTKHSbIhG1HCPdPcxd+6DcvIFmxK
         8lPJe6F7uuQS3qtqc162SdHpFq+TEPx3HSg2Px+jDNWvhXsOYj5c7hStVd1YP2pfskS7
         XSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5XiUNgZOyJMfbfBOhs6OmmQ4I37YwDc4n2auyrKfdQ=;
        b=mmVi2XdL8Pn9HoAn17wKynYbvZv5HjthiA8twNeqCdgAf13NU1mTuHv+kwNqw4aiRC
         CVm26DF+3HlaF3BoZH18wutIWm4ecNsRsRIfJ2NJ29MGbVJPkbfZSdweMZ2EZb9G1/PH
         NLNeNxCYhEmVe3F74lRXeqEgtdXcW88oST74vvRUmAxC7SMDDEfIoMP9221Akgr3M9lw
         yMOhygOoVJ6Sv0Db9d6eg7YzlzRqWUa+fjcUEZpZpO0pQmXyU0z9sSINlvydJYT9V8JU
         c3nvizTrm5LcYb9KEPrs4jnit4OT4MOv3ShWsa8nAk1g4aPQePG8OWab+kV4mmG89/7T
         k5eg==
X-Gm-Message-State: APjAAAV2pyyzb+Gin97VKlkI0C/kX94Um2B6VbdSALP43qRlusvfxYaM
        5HUiaTb0Jw8JQfOGDDyUXR8=
X-Google-Smtp-Source: APXvYqxi/41bTq6X9gznHiE2khI+uFQ41a5JZBbGAVyzWPTC/7/habZEeuZb5hZtPLzFNLo9KSNyuQ==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr18513490plo.283.1554291411231;
        Wed, 03 Apr 2019 04:36:51 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id r87sm15084038pfa.71.2019.04.03.04.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 19/32] sha1-name.c: add repo_interpret_branch_name()
Date:   Wed,  3 Apr 2019 18:34:44 +0700
Message-Id: <20190403113457.20399-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

