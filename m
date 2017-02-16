Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586661FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbdBPMEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:04:00 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35773 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbdBPMD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:03:59 -0500
Received: by mail-pg0-f66.google.com with SMTP id y6so760789pgy.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isPrcxPzUeC0ShhM9KASL0CzUtgV8vlZTZDgDJDrMzs=;
        b=Q4PdCc8YeeqyMIdPv9DZmktwdN5D6EQIO5ieQExnyD9QrtMxmCwz7XIw4k4572W2mY
         SMgL7LpP6hJrosBKV4gZHnKSRQ4kkOjvjMKcKb3siYHwdyrxzc5o4QRxjlvv9eVPCdJF
         36ss4x0CGvMk+oy5+bi1bMKiiYy7tFg373SSx6vKbPBtchYpnAALbUEaA8Cd6gFXiZqk
         4FO+Xs2b3omFJUhjWna6Mx11Bt9J3fGqsm0DB7TOixrW0kC91G/qfkLqtK15dQe89G1z
         2sw5CLB3XJW3yn6GtnAsvb1/+dzTRq1C/OQyPIIfB6miq7Kjy2LM8EWqNhoQY1iqQQKY
         t3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isPrcxPzUeC0ShhM9KASL0CzUtgV8vlZTZDgDJDrMzs=;
        b=g+Le/QYZLaxHet1kThGbmC4yDhFv/mmIV3URm2YLwRjk9OvWeAkvq/bLRaZO1HmtFv
         XjyE0s70rshzG+cf0ZkhOCMqB3Y6OkLtk0kzO5KxsIggKX4FTPNw0QldtL36icK1Kq7B
         LmkWxTcAmaL0IzDxouKo5PN/CDRI3IkFBVLJjLAVvvXmCe5e1kmY8yFfmtx5N68tR6vf
         o3aPTedpP5doj9Rqaub3xg1JhdM/J8HPsiJEYXdHXshaOQFQojg/8f1IHR8mL3/jCbDa
         x8QEHtEW7kuPFjYWKG5l1Y6Opu15/lhGMHusGDdQQ1gbutozFOd49Z2gsaYUHzipxIvf
         lKLg==
X-Gm-Message-State: AMke39mwc9mL0tFerOnDit4+vePZRLNGiNjFgTNE5RUw2zw5GJPhF4369wufgI8QmBYmLg==
X-Received: by 10.98.72.88 with SMTP id v85mr2240864pfa.54.1487246638325;
        Thu, 16 Feb 2017 04:03:58 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r16sm13390617pfg.76.2017.02.16.04.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 04:03:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 19:03:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/5] refs.c: add refs_resolve_ref_unsafe()
Date:   Thu, 16 Feb 2017 19:02:59 +0700
Message-Id: <20170216120302.5302-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216120302.5302-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170216120302.5302-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Surprise surprise. This is just rename and introduce
resolve_ref_recursively() to the public.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 9 +++++----
 refs.h               | 6 ++++++
 refs/files-backend.c | 2 +-
 refs/refs-internal.h | 5 -----
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index ba4d9420c..e0e191107 100644
--- a/refs.c
+++ b/refs.c
@@ -1226,7 +1226,7 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_recursively(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
 				    unsigned char *sha1, int *flags)
@@ -1313,8 +1313,9 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_main_ref_store(), refname,
-				       resolve_flags, sha1, flags);
+	return refs_resolve_ref_unsafe(get_main_ref_store(),
+				       refname, resolve_flags,
+				       sha1, flags);
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
@@ -1343,7 +1344,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, sha1, &flags) ||
 	    is_null_sha1(sha1))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index 464cc384a..10c2cfc00 100644
--- a/refs.h
+++ b/refs.h
@@ -568,4 +568,10 @@ struct ref_store *get_submodule_ref_store(const char *submodule);
 struct worktree;
 struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1,
+				    int *flags);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 685ea5c14..f3be620ab 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1276,7 +1276,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_dir_entry(refs, refname.buf,
 							  refname.len, 1));
 		} else {
-			if (!resolve_ref_recursively(&refs->base,
+			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
 						     sha1, &flag)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index cb6882779..6b29dc3b1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -634,11 +634,6 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
-const char *resolve_ref_recursively(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    unsigned char *sha1, int *flags);
-
 static inline int is_per_worktree_ref(const char *refname)
 {
 	return !starts_with(refname, "refs/") ||
-- 
2.11.0.157.gd943d85

