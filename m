Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50F420248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfDPJgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42590 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so10065331plb.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgsSnv4q0t/+jt+qmRhtwXSPK1oIQTebVJtB6niflsw=;
        b=iH4l8U4LAJcwV6oNcPoO9pNLMTZgRNWPzHg0uezLTebzlfWA693xhzIfByMbB0lc8z
         DsFTBP7eMlQjSsoorTBwy3eGYTUt37WPOSl0Y6JtXqpLr31c3UJ8DCFwWnThZfYEaMs5
         5mx/6sXxIZlIwFiIy5e62xftSBgIH2I8Aai6ru7fgJv2TI/Xzz1wXw4MhscVI1yMleta
         AsWqlBeCONrsxCRmmG8enDtV6FJpazOw1EU0OChrbKdhSIg/Pb0tLoCbdyIcF1O3T7hj
         29xUlfzhKAnjL9TWFOcHR+ywCdIiYKDEkqMG2oxAfMoEQoJbmPL3wjh9NKImH/b2J2O7
         oPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgsSnv4q0t/+jt+qmRhtwXSPK1oIQTebVJtB6niflsw=;
        b=O1ye7gwOekKfJUwDrUpLXFSOilM2lf7zV0aQe/6w5UYx2ZL4sct5DqtQWdsy+q293K
         kuM+ZT/VzTUl/mcg/v9bwgsOagn1Mh4EIt79gqaFuuU5gHDgGsM1AkGyKlh+ZEiuPT7L
         LvUxHgtfgtlJRP2qeWriTOLSJwtzZFy1mdrXMNrP4kkMtjfWMvwNiejH7Q83uzjW+KtA
         KKObWPLhNNFc6hd4JyaTC02ZsX/FpeSh/QGXGcae5NCqDvBY79HdI4AhEeXgXH9MgHet
         EyaDlW/FGBVXvwdM0s8BqXY8HyUigkjBTmLhxt+KctCPGdtZWDDd1uQj2SqbIGy7Q+z5
         oiyA==
X-Gm-Message-State: APjAAAVm/YfQhwGyTWXqogA9fBxEmukreaPSubpR1gI55bSeKKchBgAQ
        RTcE9o94KdXQSeclCvZSmvk=
X-Google-Smtp-Source: APXvYqxVLKPhHyRkpC/DGRxxuk3Dp4Ca7UGLFKj19igFKn8GR3ZEb/Tg73RXyLVPVqy+hQUYPu6nEA==
X-Received: by 2002:a17:902:2a:: with SMTP id 39mr40703435pla.64.1555407368908;
        Tue, 16 Apr 2019 02:36:08 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id a6sm72160409pfn.181.2019.04.16.02.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 17/34] sha1-name.c: add repo_for_each_abbrev()
Date:   Tue, 16 Apr 2019 16:33:24 +0700
Message-Id: <20190416093341.17079-18-pclouds@gmail.com>
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
 cache.h     | 3 ++-
 sha1-name.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 4f8ebb0a67..0cb95c0d4f 100644
--- a/cache.h
+++ b/cache.h
@@ -1392,7 +1392,8 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 				struct object_context *oc);
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
-extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
+int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
+#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
 
 extern int set_disambiguate_hint_config(const char *var, const char *value);
 
diff --git a/sha1-name.c b/sha1-name.c
index a75992eb54..cdcf84b826 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -493,13 +493,14 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	return status;
 }
 
-int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
+int repo_for_each_abbrev(struct repository *r, const char *prefix,
+			 each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(the_repository, prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(r, prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-- 
2.21.0.682.g30d2204636

