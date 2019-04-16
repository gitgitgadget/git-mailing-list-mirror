Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CE120248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDPJfU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44447 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so10098098pfm.11
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xG1/wqpzevuEv29717i9z54Yu6dpcnCl16aCmBzObCI=;
        b=YYpaUsnnDphZGeH7jIYy4fYhp2R/2DxUxT9EFN8A2/2vvNmtgjYuWg+vX42t5XbgjD
         ODHHuoD1e7v3Rmr+FemJAB6tJaCz3aSTCrDm5Apg/k1kVx3VnCQws//FN/xSvLsZGwvg
         6HF+AndUqiXKUnXRylpgoz/HWxOgjvvrxqXcz7+oyXnYDYmPrN7VUperErKSKQQGOS89
         Xv7Pm8zfA7tTKejpsVLlLEL4p/pdKZXt9Izwqz3lEIUfvcSkCrWEns+I7v9whs9pJS7l
         TI1obCkkcCHfZOjbK212o8GtA6nD39gHti2MKgZvYsuFfSBjivnebY5voFRscx5ZL4Yh
         8ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xG1/wqpzevuEv29717i9z54Yu6dpcnCl16aCmBzObCI=;
        b=sUM05xXV128kH5hOP62APmEsndbnoJ8FxnIWdiMKfPrmzHxZHl6xvwYBu3M/q073Wt
         rh/bTW/BjcM0RU0kcl+C59fwxCMRoc9oNi1JDdivFOo+Vq4YcxPWFyYAf50+2b02dqv1
         66RMIBl4qaWT6cENu4mvxGtKUPgwzM/EERZK3AmWTyYd2vuXavFUKXsDP5qd7LZKrp4y
         3DnefkyOfm5fpNQg/kZqlKLbkSQ/egiWqGnGaTdMkuX7/O2pECkzaL6ii5n75pcBY1us
         0dN14ZY8VJM6hYBtnlHaZEaB5W3sm2TEY2EXlaSydcGtJcrc7ejj8Pm1q38LbR0f6No2
         2igA==
X-Gm-Message-State: APjAAAWdGrIkU9fRHqvBLdM+ifKO0Jm1sQVGd76/7N+RzhEouiAOAPnt
        aJDyQABim7dIHyg4VAOkKgEZNTE/
X-Google-Smtp-Source: APXvYqz8kZS1cZfYI4ilRtu5aZRonNMAkf2qplazzbVB77KDnToyuhBbXLxy+qH6PVoIVKo+YbuIEQ==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr74100887pgd.255.1555407320038;
        Tue, 16 Apr 2019 02:35:20 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id e4sm74084042pgd.32.2019.04.16.02.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 09/34] refs.c: add repo_dwim_log()
Date:   Tue, 16 Apr 2019 16:33:16 +0700
Message-Id: <20190416093341.17079-10-pclouds@gmail.com>
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
 refs.c | 21 +++++++++++++++------
 refs.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index bd0fec5776..edea001446 100644
--- a/refs.c
+++ b/refs.c
@@ -603,9 +603,11 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	return refs_found;
 }
 
-int dwim_log(const char *str, int len, struct object_id *oid, char **log)
+int repo_dwim_log(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **log)
 {
-	char *last_branch = substitute_branch_name(the_repository, &str, &len);
+	struct ref_store *refs = get_main_ref_store(r);
+	char *last_branch = substitute_branch_name(r, &str, &len);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
@@ -617,13 +619,15 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
-					 &hash, NULL);
+		ref = refs_resolve_ref_unsafe(refs, path.buf,
+					      RESOLVE_REF_READING,
+					      &hash, NULL);
 		if (!ref)
 			continue;
-		if (reflog_exists(path.buf))
+		if (refs_reflog_exists(refs, path.buf))
 			it = path.buf;
-		else if (strcmp(ref, path.buf) && reflog_exists(ref))
+		else if (strcmp(ref, path.buf) &&
+			 refs_reflog_exists(refs, ref))
 			it = ref;
 		else
 			continue;
@@ -639,6 +643,11 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 	return logs_found;
 }
 
+int dwim_log(const char *str, int len, struct object_id *oid, char **log)
+{
+	return repo_dwim_log(the_repository, str, len, oid, log);
+}
+
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
diff --git a/refs.h b/refs.h
index fd3dc1d0f4..859dffe691 100644
--- a/refs.h
+++ b/refs.h
@@ -150,6 +150,7 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
-- 
2.21.0.682.g30d2204636

