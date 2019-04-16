Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B3220248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfDPJfP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so10088239pfj.13
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0KSxw1KtPpsseqHTdVQUBkaWA4zNa42hKXoI5rmvNw=;
        b=rE88KEUgHQYOdVpmPwllV2jNexR1qP63LqbbColGd6ZXqvrTiUHIRYKXy35Pi6vvFX
         B0vsuY9Fi+TusZ0RzvkySnrTwLNaIpd1CyWLSHJfP4QoWkn9OoDMFqkNG3jlWnxAWJFW
         hOOYnzulsGL5GWJUtqrXHZ5F3dYzGirnz6TZEBre3ihOLXuXb6xiVYe4ZCot8EKXWL8h
         kaLIb2ykGl9cqvQPMsxZfXrnWxUSQG2D2qcV0TaGxVg6hrhSca3xzLPg5nWrWEHEurwW
         YF7oBG6z+H0AV4g5UEpFt3eEGfU5pJXjZC1Yj/q76kIqmust/QPK4RiM47jjUIK+x7cO
         +oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0KSxw1KtPpsseqHTdVQUBkaWA4zNa42hKXoI5rmvNw=;
        b=rwHY6lO5FeX1oefrYvOWelU498NcoQN5qkg1DSS0SLswwsLxbuCWM1VjgPSb1KOPfK
         +xYQ1swGPyulN7LIXPH8bpjATqgo0sqtnEWJRsq6n/89PoeEnYyHwg9ztMyiq3ABHH1e
         Kdss3NEeercXIr2I2WLcCiKt/72IRnc6TeYX2J6I8WgQj1Nv+Md7rPNgX1sgpSTYXQ4u
         HwwAwqhqf53wD3O7FZ3/gtMi4SKpuhGwaJGfakGyVMWyBcDIPMo/HCSVB0aWZsB0od8k
         f2HCtl4KMdJLlGs3tmC4kB+kw/trtRaQYKQoBTTSySizZMsaZFHb7+qBDH8Y0Wt6ixhs
         fgqg==
X-Gm-Message-State: APjAAAV+sYPzYxTbx2rGxthWKgFW8iORXutxcSFtrIm2GtAZ8RRJ0CHl
        lHlRPln3vN+WonFenz93QhM=
X-Google-Smtp-Source: APXvYqw6BMRUiQwhIU0o0eMO+FPXmhsAaNwxVS0Sn+0PBPIQx8LFdo4alqAUu3dfBHnRQgPiNQR98g==
X-Received: by 2002:a62:1194:: with SMTP id 20mr670010pfr.224.1555407314945;
        Tue, 16 Apr 2019 02:35:14 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id l74sm91345262pfi.174.2019.04.16.02.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 08/34] refs.c: add repo_dwim_ref()
Date:   Tue, 16 Apr 2019 16:33:15 +0700
Message-Id: <20190416093341.17079-9-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

