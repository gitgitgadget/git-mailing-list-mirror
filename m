Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C8320A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeLOAJ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:09:56 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:35017 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:09:56 -0500
Received: by mail-oi1-f201.google.com with SMTP id p128so3508057oib.2
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DACWlUeY+RZA0wRcFkTx1UDCPhv018/kT5+4RWS8SlI=;
        b=iSeOf4GFvr7A/+3yaAJ6ZbqWQGNbrWSNVVUuMxdEAnwGiJtw/ovWQf2lywvWCBMbU5
         +OZ2YDTJTJjswPh4PujQSgTMVS79xyszgFxXNnQdGtmge24YzRSRxIwnMGZ88CnbGq2n
         sKCPRYmw4RcP7X0P/JCK3BtHzPi1LMFiJohnYIjY8w3jmAfkSKre5hadG/DuVq5g6SC4
         DAmgjyCaZWJ4Vg4wNonUfZt43UpnyK2ZGTXCLcSnXzK2pGe3nFrVSbxjoKDB5wICPF5r
         Jw6nuBmGBzFiY6hlzNcfUajJYKpmaYonvDHlTn2D87K44gPEsT/QcmFeOej+3rJ8rvY9
         yFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DACWlUeY+RZA0wRcFkTx1UDCPhv018/kT5+4RWS8SlI=;
        b=VazPuo5+Ei1hnkraKJ3YmX7B66hcNHi7ttmLPIjho/4R5KGbQNPQeaulo/CI5+aOon
         GNR0imtJzozCryEV/c/2/vJBk6peX0bhV7DPBmD8evTgrD4QuRgIi+Euai82arf8fwXJ
         ZptqSBTsMhTbB2SSC0DB/glawEE9biDj8oNchHgis3tq+ZDVIHT59v+ZJ9vQdFkRnE9A
         MEZ2iRwxsB0Eqr1Fv/V4y8IZEQHxKzlE3eenxeYhsTsfWS3bT63+p4/PPo0OqGqg4vXR
         zjoCeCS2dchXgkPbs1yQ+UOB1pSSJZj6sZohgnahp1jCjKHHyHL4sQebpbJlhuvZA9zf
         bUkA==
X-Gm-Message-State: AA+aEWZfT6V2dLce+QKqrXJKANpxyzo2SI2Z25o5NNlejy3tl/Et8tO1
        IF+8/oTl/kiR62jnYSeQlBJ26L64LfBQdz4ix3n/GYIQ8v1oKK9aaGvDn2vEGRf5dcpmgAgrVIm
        BMLQOGOkxTzD7sqi2Jo+RC+cfAd9TQPGLHZDoqczJEatR+3rGOtAHyer3c/7x
X-Google-Smtp-Source: AFSGD/Wlh/pOZK6fp0bxwveogV1kYkE8K23E7umT0Zk7EAlA9woeWRLto574aJH4d/vIrqoEoCZMNfvHNdP0
X-Received: by 2002:aca:3341:: with SMTP id z62mr4171825oiz.32.1544832594985;
 Fri, 14 Dec 2018 16:09:54 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:23 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-5-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 04/23] object-store: prepare read_object_file to deal with any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As read_object_file is a widely used function (which is also regularly used
in new code in flight between master..pu), changing its signature is painful
is hard, as other series in flight rely on the original signature. It would
burden the maintainer if we'd just change the signature.

Introduce repo_read_object_file which takes the repository argument, and
hide the original read_object_file as a macro behind
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, similar to
e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)

Add a coccinelle patch to convert existing callers, but do not apply
the resulting patch to keep the diff of this patch small.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 12 ++++++++++++
 object-store.h                                  | 10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.pending.cocci

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
new file mode 100644
index 0000000000..a7ac9e0c46
--- /dev/null
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -0,0 +1,12 @@
+// This file is used for the ongoing refactoring of
+// bringing the index or repository struct in all of
+// our code base.
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- read_object_file(
++ repo_read_object_file(the_repository,
+  E, F, G)
diff --git a/object-store.h b/object-store.h
index 3d98a682b2..00a64622e6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -165,10 +165,16 @@ extern void *read_object_file_extended(struct repository *r,
 				       const struct object_id *oid,
 				       enum object_type *type,
 				       unsigned long *size, int lookup_replace);
-static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+static inline void *repo_read_object_file(struct repository *r,
+					  const struct object_id *oid,
+					  enum object_type *type,
+					  unsigned long *size)
 {
-	return read_object_file_extended(the_repository, oid, type, size, 1);
+	return read_object_file_extended(r, oid, type, size, 1);
 }
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
+#endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-- 
2.20.0.405.gbc1bbc6f85-goog

