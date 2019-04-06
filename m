Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3493020248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDFLgm (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33565 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so4508650pgh.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLC/zHqD4nZfCBSwlO+lsrWxWfpYZdPdK2PMT6BBWgM=;
        b=j4t1fIvdCfWk+JPvFqDMmwIzSnT8uUEj+yK1j05wPk9JgX/Oa3vCFjvgxreqtTu+dB
         rBR9q2CGP+Kdlk11yfK9cnkxnctz4xSS2GQhrtlqg7e01iD2chcVxsvcH7ZoDFxixmCe
         vXhFEdGCaNWcAUT5du+ADj/6BIW5FYxyr9SGHZCNldCkdGTnfquRMnx6a2iZ9VjzBxpj
         PWrh4IJqZOsjrJpftuPZNoMsXPH9wYA/iplUH9k6Aau/Cilxyw7yhTUtashGr2QrduU1
         vaAWgGZyIV/RTNe6PhyUxRqvoT/lp+jq5g8JAysogDX6RVwUEagb/N+3gS8Df3cidTKa
         mBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLC/zHqD4nZfCBSwlO+lsrWxWfpYZdPdK2PMT6BBWgM=;
        b=dOhcIzFDqgRR8Mo4g1fSm24SbxTcxOISRSxccZH/oH1QXCycDKXJo8d9KteYleUpl1
         YQ9J8j03902GrbyH6gIU0XZ8mhK3ojwLQK4ctMvhizKpIt7vQFNb0cgcBxzUy+UJrb/o
         605rwV3rSHJGCZDUGf8ZW0wRk1exdeKsciLF+6ka1Nn9sF++pMKOqv0d8D6ijzyfZoRD
         gcI4F//iXzlhTOBRiFqvQ0PVkAAyQuDlyjJ6gBa6r9FjBOC+AR2Qjwz96FALBs5e/4N4
         yFqzLn/bVeAQrVQV5C+yFQpqNb0m5yfHr1YG6ZbzqQDuEO7upqPcuyIESFYOC+ODA3Z0
         0QjQ==
X-Gm-Message-State: APjAAAUP33LmeKcRnf6Z4cYCCKjUIWfupp68NqX8uHin4K5qrc1PJzr0
        bqrLqOpbO94yZgiTr+qaq7o=
X-Google-Smtp-Source: APXvYqwepT/t/D8MmPjqbtt7RTVspjTGj9QnsMxKsCNktVTopzxGTi9vPQ6ZDgM9N3UTx8z7HsxevA==
X-Received: by 2002:a62:1647:: with SMTP id 68mr18121808pfw.113.1554550601492;
        Sat, 06 Apr 2019 04:36:41 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id j19sm4186775pfr.155.2019.04.06.04.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 16/33] sha1-name.c: add repo_for_each_abbrev()
Date:   Sat,  6 Apr 2019 18:34:36 +0700
Message-Id: <20190406113453.5149-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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

