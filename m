Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BF720248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDCLga (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40991 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so8184741pgs.8
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLC/zHqD4nZfCBSwlO+lsrWxWfpYZdPdK2PMT6BBWgM=;
        b=rXMQ1zaBy0FwMKGyFvk+uVYq94uj2VjaRam+R7zJW/umSc0wgO+nTpdafe5TkJ8Bc/
         9ezTjRoSrGYi1+DNOmbqYruEuIh5SaRiottu3viTRcoIMlM+ttcdwIOiHN/NBupnrsTG
         7GMM0Gc/O0owEBfh0jTBIdfn9sowN8PTm5RSuR19b9mOKemR6W4mp5yQwMdxNoa97C/+
         +NBkpZOrTdFnIM7TPpjOh3vAvzByl7hSdPhLX+0MSzHX8B28Pf+EJv10doZDm64M8u19
         gcUYfYi/nlTpn7+1U8hyU+DmReznXJ2X7U+GSTSIvYHZ37FwvY2U9UTsNJ6rxGPK80sF
         4zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLC/zHqD4nZfCBSwlO+lsrWxWfpYZdPdK2PMT6BBWgM=;
        b=ajfnsPdRrnk17wwHe5VnsSRumqM1UvxY/30wujafQj+lvUsXBD4lXXIHxH6p0Fn4Yr
         Dl2etXOgyifURTTrGarqN0fp3znnKYHPWuk3hYy9+VLSHukeq+fFuFR7ReTciWEK1vUp
         gFmUuKaE173sidsIUtrGSv69xbGRmNOjumAXnm/0TX30dL9slFnnmzBCNdGHgyf8ntWB
         Kur7IPfF1eSIio3Duxy/IWEtn+fsGyDw+pSgNMyDOHtJOcSb2GhBMI/Cu1X7NBy7FBWo
         z+9u/IhVa3wU4yCwIh4j3jIgTEopeIQHlxJzaa5iThm9Bbp+wydtrDo9tAXz5Ir8drxh
         umyg==
X-Gm-Message-State: APjAAAW6EDAe5zGLFbBorQt5cnkPtUQr62QQE+vnSUygTNoI38SgOhFp
        iSA088gNryYL8X2cYRUN4Bw3GMeT
X-Google-Smtp-Source: APXvYqxkJd0m3fTco7/AfMlzttJfziNH1LrGFY1luS6u7a2aSnqehR3jxkhFMLDmOgiy2x+nDk4n+w==
X-Received: by 2002:aa7:8453:: with SMTP id r19mr47326397pfn.44.1554291389682;
        Wed, 03 Apr 2019 04:36:29 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id k17sm20371759pfk.166.2019.04.03.04.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 15/32] sha1-name.c: add repo_for_each_abbrev()
Date:   Wed,  3 Apr 2019 18:34:40 +0700
Message-Id: <20190403113457.20399-16-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

