Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B6920248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDCLfw (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40958 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so8024675pfc.7
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szpMHP8EhvpaCOO0W8tVbc6AFYjGROhwwjWwnfbVc9o=;
        b=DBsjsY/gD8mkVNuv9pXhCUdijz0ZrJAbebRnBzuhTRF86TTEp8wP9g54SpwJOvRT7w
         h9/Jn2jFIpCEqS3Kk5uh4tVx5z7PtlfCijn6FVl5+Bc9154+ATRlb6y5/5i09mlMH5LB
         6K5eabEDfmpuVIqmVb1tU9LJjury/qS+DFaVkeXKfN/jUHKNLEOVw0hkte7B3ECVocq0
         cgpY8DkbEw8sderbYZRUEworDcDW1fYz8Xf4x8fXnU8jwXCh5aDph0PR4Fs4s0lbZn5F
         4MPbzH7um3gvrE59Cb8cELZezixkPc0YroNzvb+yZEiomBfy1/BhUEmL4132U+3ris//
         4+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szpMHP8EhvpaCOO0W8tVbc6AFYjGROhwwjWwnfbVc9o=;
        b=uM4q9xtYGkh5nFeEte03fZYg/EWJxHoWec6J4akMwcUYnounY8YTDMaNCWAqumVSwa
         HkZSK6NVjz425x54Fr3CFSKXmHToTGzAfu0Qz+mRbxaCCUCJ454LI8Ztxhvb2kPRWyL5
         pEv2+yeWvmpQK0HLYPan7vstvDaweobk4/7dTj2DWIpF9uU1EJ50v/Ueh0uyUhPjwpfj
         fiDohOuRQWH0CpczO69v8wXHK/fanh1PIdPcUy6sVpBTSGUFoWWlFr/Mojzx+N+5AgL9
         kKY5PPXPqWib2HiRNOBBv/sCryTwV3a13TJOTbJmtnhAUqrU0g9xA8lDC8NKVrTMGLq6
         zmqQ==
X-Gm-Message-State: APjAAAWKHXsQTXOSm8PfYLSToekdoQlauTRWYwggyT3+1YeS8/oxLKSt
        A3Mx7einPqZ7sxUHN/9EQBk=
X-Google-Smtp-Source: APXvYqwioMhrj1km6XSJ1fsCbKYVsdORYz07NpF9m0p2g4OZSN6eaDHeewLsVVlCdoSShYTdKH/KAg==
X-Received: by 2002:a63:1f61:: with SMTP id q33mr72053526pgm.325.1554291351457;
        Wed, 03 Apr 2019 04:35:51 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id t22sm19222215pgu.45.2019.04.03.04.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 08/32] refs.c: add repo_dwim_log()
Date:   Wed,  3 Apr 2019 18:34:33 +0700
Message-Id: <20190403113457.20399-9-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

