Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE06820A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeLOAJ6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:09:58 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53484 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:09:58 -0500
Received: by mail-qk1-f202.google.com with SMTP id s19so6717102qke.20
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CzvlT4WIhEJRVP8hCQ0KaOrI064jrf7Cp8CR30bm7jo=;
        b=TLJSCblKAR04X6ObJ27uBjaFz4a2y3oZdLfpHRIpC+1dEW8IdH0MKZiR3aLvREq9zb
         IDmzdYmZNl7NPCvC78bLuy6Ibq3E5gDHCQk5DqLQ/94YzrRYz695+oHQ1ySZJRK86va5
         01RIigVWOHNwTg7yI7jeEfh0+kq02VPRGVAP8jR4wDuZ01IKwKy0R4ZlFA7vJ352pKn+
         ENHtGfzfIFxYVmeVRBgaEFgzJmVuhU/e2kJZpvIPkNF1tdsYEZEPVsu2LnU6tjzjz0sC
         BhmIVFMBqm5WxIBVWpGk9M9p+qdvx7bJOuG+LAGEHsWJuGLcg6cZokQh/xmSfV3sOoqx
         4tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CzvlT4WIhEJRVP8hCQ0KaOrI064jrf7Cp8CR30bm7jo=;
        b=feN25+NjTC3IVi7BFfkG9Hj7gzHGlDvt/lH5nf5nwz99p6hNgpx88WgqRVtbYzKXsz
         nEHhiRMNLon1zQgW1NZzV6j6zpTWTKZOv0Y8IGpSWWC7AekBmAwWZqfkxO2j7NYIgyw4
         /JyHwXgD7cpRtk4JkET/BpuTo3CYJlp0ar/4nehGHkckH7vIFUIS+btuImM3V1U0tsZd
         5nsV2JvHXmv8rKwBi6AcqSu2dDtHtGXQ8aDXEYifMFjGhDy6t2I1u//mUz39ArvH23xz
         +FIHv2JIpDf2gooT4h4sEiJTXnc5oZEnKl9PNfpXMdLYMaKfkbl7yveFblJfTko8F8UB
         /kGw==
X-Gm-Message-State: AA+aEWZ81CkHyYCzpUWhePjoqRyHRvXdrPWqvT9jrDHYQP52Nh0WbJSK
        /X+93iuyBpIPnd3FDc8FN8AM2Bt6s6BnsZSRpyyg71WtvrUUsWnN6VT1AZNEnlTapDcHjoDf82T
        3GP4rrQa1epTYYxXFgnSnJ6q++FlNVaHF/rRDXVezdRER7tsdcbjYA0chLYVY
X-Google-Smtp-Source: AFSGD/USM6LxI4vJWOA4o6VTuXzGXU5V3DbczwdxXjT73ZcVwv94tWv889Q/Hi+PzE9PCCecWjW8bPpETSbw
X-Received: by 2002:a0c:9357:: with SMTP id e23mr4872800qve.55.1544832597277;
 Fri, 14 Dec 2018 16:09:57 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:24 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 05/23] object-store: prepare has_{sha1, object}_file to handle
 any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .../coccinelle/the_repository.pending.cocci   | 30 +++++++++++++++++++
 object-store.h                                | 22 ++++++++++----
 sha1-file.c                                   | 15 ++++++----
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index a7ac9e0c46..46f3a1b23a 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -10,3 +10,33 @@ expression G;
 - read_object_file(
 + repo_read_object_file(the_repository,
   E, F, G)
+
+@@
+expression E;
+@@
+- has_sha1_file(
++ repo_has_sha1_file(the_repository,
+  E)
+
+@@
+expression E;
+expression F;
+@@
+- has_sha1_file_with_flags(
++ repo_has_sha1_file_with_flags(the_repository,
+  E)
+
+@@
+expression E;
+@@
+- has_object_file(
++ repo_has_object_file(the_repository,
+  E)
+
+@@
+expression E;
+expression F;
+@@
+- has_object_file_with_flags(
++ repo_has_object_file_with_flags(the_repository,
+  E)
diff --git a/object-store.h b/object-store.h
index 00a64622e6..2b5e6ff1ed 100644
--- a/object-store.h
+++ b/object-store.h
@@ -212,15 +212,27 @@ int read_loose_object(const char *path,
  * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
  * nonzero flags to also set other flags.
  */
-extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
-static inline int has_sha1_file(const unsigned char *sha1)
+int repo_has_sha1_file_with_flags(struct repository *r,
+				  const unsigned char *sha1, int flags);
+static inline int repo_has_sha1_file(struct repository *r,
+				     const unsigned char *sha1)
 {
-	return has_sha1_file_with_flags(sha1, 0);
+	return repo_has_sha1_file_with_flags(r, sha1, 0);
 }
 
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define has_sha1_file_with_flags(sha1, flags) repo_has_sha1_file_with_flags(the_repository, sha1, flags)
+#define has_sha1_file(sha1) repo_has_sha1_file(the_repository, sha1)
+#endif
+
 /* Same as the above, except for struct object_id. */
-extern int has_object_file(const struct object_id *oid);
-extern int has_object_file_with_flags(const struct object_id *oid, int flags);
+int repo_has_object_file(struct repository *r, const struct object_id *oid);
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define has_object_file(oid) repo_has_object_file(the_repository, oid)
+#define has_object_file_with_flags(oid, flags) repo_has_object_file_with_flags(the_repository, oid, flags)
+#endif
 
 /*
  * Return true iff an alternate object database has a loose object
diff --git a/sha1-file.c b/sha1-file.c
index c5b704aec5..e77273ccfd 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1768,24 +1768,27 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	return ret;
 }
 
-int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
+int repo_has_sha1_file_with_flags(struct repository *r,
+				  const unsigned char *sha1, int flags)
 {
 	struct object_id oid;
 	if (!startup_info->have_repository)
 		return 0;
 	hashcpy(oid.hash, sha1);
-	return oid_object_info_extended(the_repository, &oid, NULL,
+	return oid_object_info_extended(r, &oid, NULL,
 					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
-int has_object_file(const struct object_id *oid)
+int repo_has_object_file(struct repository *r,
+			 const struct object_id *oid)
 {
-	return has_sha1_file(oid->hash);
+	return repo_has_sha1_file(r, oid->hash);
 }
 
-int has_object_file_with_flags(const struct object_id *oid, int flags)
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags)
 {
-	return has_sha1_file_with_flags(oid->hash, flags);
+	return repo_has_sha1_file_with_flags(r, oid->hash, flags);
 }
 
 static void check_tree(const void *buf, size_t size)
-- 
2.20.0.405.gbc1bbc6f85-goog

