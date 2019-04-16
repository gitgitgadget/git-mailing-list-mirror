Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CA620248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfDPJg3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34731 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so10070925pgq.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=792oefmhbdLjQAr3XkKYiXStA0mFKhfa/xqCUGWZ4Ow=;
        b=mPzX837z7oZ4z9ykPhQq/PQtIlxhPrZ+/cnKsWPUHpPwt7s1baT0CDlxHwyl1VjOGi
         KOGxbbboXlt5yLO5CMJ7/mQKwN0oqz5XQ4+i3yLaurGP0Oztub5GmujETbYn6HT/D7GB
         u7JfvDnPNjPpUdwlTxhv18iu5Ooh3IPa6UEqR5O/6Llho4sjX1DsioY/Exlv41aT7snR
         3Ctth2aq0MeW/yyq0CFjTi7BXSlY1fUWP2zU2QDv6IeX5nCogzF4DaZdLjzMyRRvD0dL
         Ecq+W93GnHRBALtb/0RWBQw1gCJHtY2JIYgKjtjhxh5GOqeKpr5ySKdsul45v8+XNI/y
         sE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=792oefmhbdLjQAr3XkKYiXStA0mFKhfa/xqCUGWZ4Ow=;
        b=GoUqJmompeyt8WmbR76YMzN51saOT/3FtmzhdgjhpqLC93d8xv/bzl3NyFDKdPyee9
         EcuZwuhilnztrW+QYhMpTRL+0pd1QaGkOJLj2xptEtvM1F6dDSgPMmBp3fNGx+hroPNX
         aXsJvoDFcY36cXep7mnImHF0uwvfSnDaTyxqaHp4mHTjUmisoz1/QKR4Do7nhh7fEZVn
         NHXkckQOl/KEoZuSQlMfANlSJCafK6hycGz/PM03CTzgzHZBKQe2HJgGcMKFhoLVygpE
         XLmRunr0PIyDQLSdwm1DuE/KFScWtFXWb3nIeB+JB7mPlgVJLpDX4/wO9nujpCHA4xpK
         Umzw==
X-Gm-Message-State: APjAAAUU/GEdMi3+MmzrrKclmmfhR9rKnpy1dBaPOsVOM8Cv4meo/+9X
        aZwC1BbGiRswdEv8OTpbrq4=
X-Google-Smtp-Source: APXvYqwOuq7nQUjVwOUVvkMQHXWyFdH+Zxu0C7G7iS8uLQ1UEXI1hb30TeMni352poWhZ0SvGm5aPA==
X-Received: by 2002:a63:f115:: with SMTP id f21mr70116692pgi.65.1555407388029;
        Tue, 16 Apr 2019 02:36:28 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id 6sm46625018pft.64.2019.04.16.02.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 19/34] sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
Date:   Tue, 16 Apr 2019 16:33:26 +0700
Message-Id: <20190416093341.17079-20-pclouds@gmail.com>
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
 sha1-name.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 2643b75b54..af8bf5b351 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -771,7 +771,7 @@ static inline int push_mark(const char *string, int len)
 }
 
 static enum get_oid_result get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
-static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
+static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
 static int get_oid_basic(const char *str, int len, struct object_id *oid,
 			  unsigned int flags)
@@ -835,7 +835,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
+		if (interpret_nth_prior_checkout(the_repository, str, len, &buf) > 0) {
 			detached = (buf.len == the_hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
@@ -1288,7 +1288,8 @@ static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
  */
-static int interpret_nth_prior_checkout(const char *name, int namelen,
+static int interpret_nth_prior_checkout(struct repository *r,
+					const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
@@ -1312,12 +1313,14 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 	cb.remaining = nth;
 	strbuf_init(&cb.buf, 20);
 
-	retval = 0;
-	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
+	retval = refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
+			"HEAD", grab_nth_branch_switch, &cb);
+	if (0 < retval) {
 		strbuf_reset(buf);
 		strbuf_addbuf(buf, &cb.buf);
 		retval = brace - name + 1;
-	}
+	} else
+		retval = 0;
 
 	strbuf_release(&cb.buf);
 	return retval;
@@ -1484,7 +1487,7 @@ int repo_interpret_branch_name(struct repository *r,
 		namelen = strlen(name);
 
 	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(name, namelen, buf);
+		len = interpret_nth_prior_checkout(the_repository, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
-- 
2.21.0.682.g30d2204636

