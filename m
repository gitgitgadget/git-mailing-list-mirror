Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FA820248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDCLfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42278 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so7903327plb.9
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10ZYZz/KCtQq+hTWl+4RRZs4YFEAPYAluyqXGvx5xco=;
        b=I0azJqg+2RC9DmG78QAbQk9P7cs6vpbf6iJqsD9PLDL0bP4kBTRIk8+ED9R0p3NcWF
         xIiqz5jypGgcJrXL9SNTzkRVPk3dX/VNumcRvYo+BKRESOmMPQDvFUXBtoNeO8i3IXMi
         YBGpNPhXXgPll6AXy43EgdaLhrSq0/N0jIasUCFIv/qMHPOOW1IG25hGSjaJiICf2Sh2
         B4nJnYYJevmSk6yCzxvph5zMXFtfReAeGDoXl+YK6CDj9qyukONqPFUGPMj7Csv0J//g
         +V0CouctnwczcXztOZvUZ4JGUFe7kZ2osJgwOZI4qQ9Uht5L8V4XSs9v7txbHL2VlhhA
         OyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10ZYZz/KCtQq+hTWl+4RRZs4YFEAPYAluyqXGvx5xco=;
        b=oTv7hQE1Ufoi5jKVHTfQXRvrFostZ1hkaQqcYI7VjEqtmeYiJMVaWNQXVwxooOnyRW
         ie+OVMzpltgbDjUnppgugFe43bsneudaVW1cvJhH/UMtgkUs321TUe/3UzNGN+clcrWy
         tocR/yG/jY51vUcLDK6ULFTgGwuuRyCXkDF5MwUX4PmEesFbdl4jc9Ahs4x99JI6kvxO
         /tAgG6ve+xjjcFUgbqO66i4vl2WJMW5lILJ6KymQamqoVbJNGnW1bsbi+WBc2ukimLqZ
         tdc6S+82MkEBjniUJdUTd4Suw0RKha5wwkDMX7Kv1micMrcI3XL5n8ndWx60b8qOZAVR
         rGsg==
X-Gm-Message-State: APjAAAVgVyq7jOBioNXQJ+CsZgrqOHPkBm9HgwnXZJgHDQq07AMDxBGw
        mkCrNqLD1R0lcEZhSQie5z4=
X-Google-Smtp-Source: APXvYqxmhNOUw5Bd6L9zJKIdLWXEtOaAWknnp5fx+Ey0dQGElCmMm4KQixO+ox2XMTgg3wniu6oazw==
X-Received: by 2002:a17:902:b715:: with SMTP id d21mr47825420pls.103.1554291346327;
        Wed, 03 Apr 2019 04:35:46 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id h64sm24660324pfj.40.2019.04.03.04.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/32] refs.c: add repo_dwim_ref()
Date:   Wed,  3 Apr 2019 18:34:32 +0700
Message-Id: <20190403113457.20399-8-pclouds@gmail.com>
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
 refs.c | 12 +++++++++---
 refs.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1f5864aa36..bd0fec5776 100644
--- a/refs.c
+++ b/refs.c
@@ -555,14 +555,20 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+int repo_dwim_ref(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **ref)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
+	char *last_branch = substitute_branch_name(r, &str, &len);
+	int   refs_found  = expand_ref(r, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
+int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
+{
+	return repo_dwim_ref(the_repository, str, len, oid, ref);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index b630d5bde7..fd3dc1d0f4 100644
--- a/refs.h
+++ b/refs.h
@@ -149,6 +149,7 @@ struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.479.g47ac719cd3

