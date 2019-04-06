Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297FF20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDFLgE (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45742 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so4478622pgk.12
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szpMHP8EhvpaCOO0W8tVbc6AFYjGROhwwjWwnfbVc9o=;
        b=no1651ehIlY4odQ8r+Ow/PM8vL19tiLT+/HL79TP5KzKlq7AUL2qKGEbwhQqQgFhRw
         rp9/6VbCkXhLtA0sJeUXVwdJ5FwLCBuabZ/lTfwH3BX6iUW6AxrRetnhTScKvZmQOduu
         3C4myriNSz/jvnv3taFboWbXuyu9hlgfOS9WmI/6Nm/oLohvpGZ7iQ70q0CDKOr34Uv6
         vTDbMVzR1MaFcGYaGDIbTU3wy9R+7gAxXb4Wk906g34v8bV+Zdgz3uSl2fEbQlrP7a/Y
         zLnYDeF2FObXIGrxEoMJzKUzudRBQMkv5LbMni9j5hrj2zSRRFDrSDO0fKmUFmBe389S
         vG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szpMHP8EhvpaCOO0W8tVbc6AFYjGROhwwjWwnfbVc9o=;
        b=GOjroJ8WwOSXD2+COrZN25FOgMFrx1kFT9hHZQm0QH/u+jL2pHRMfcMYdP3GtkDKWi
         FotL7UKZZsLQLcbFwS5Ddwn5gTlWKdmFTPW88yK/xTAGyR8TA87HxCt9V/0iaG651Qo6
         nglKzNWST0yJ/SZmbJDQzBkh7oGay76TxfSCLJ9eYx3cLjSaHbpukJiDzRpALjgtgWtF
         ZvskpDDcMiCILDbx4VKZNIsbKORZGeXLHbWm49q30UXWYEk+bB2TvfUJxzSAqHgR6knN
         RdeUpi1DNjd8JuZxpBnpQGb2YYM3gHU9SnsRZOUMVhDzIZKNUDVpRP+8+8d7s0cfN9y9
         5qAg==
X-Gm-Message-State: APjAAAXBEadu+z12HLXSwazp5P0fZt7kbdDlyBhKtUTmbdefFCgYEPK1
        mroZ+IRbPoYE4NAALUkovhY=
X-Google-Smtp-Source: APXvYqw+4vKuwjPTr14NEw1W/4yOu4VMqbG+Ltx426AiAO1IXhkUKYVWWQYz7dvv1GYtY+OS2ceVvA==
X-Received: by 2002:a65:6149:: with SMTP id o9mr8343652pgv.254.1554550563331;
        Sat, 06 Apr 2019 04:36:03 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id 75sm42503723pfr.55.2019.04.06.04.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 09/33] refs.c: add repo_dwim_log()
Date:   Sat,  6 Apr 2019 18:34:29 +0700
Message-Id: <20190406113453.5149-10-pclouds@gmail.com>
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

