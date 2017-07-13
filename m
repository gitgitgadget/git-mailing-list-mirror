Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB4F202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 00:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdGMAod (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 20:44:33 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35926 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdGMAob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 20:44:31 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so20720625pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=epHYp0/ayBKnBQl2OIkSkvLpnHukIPoj6wnb2bA2hoM=;
        b=k3aHQP9KosbnJxDs1u6IeoeN44pLGgwT1S+NZq65937Tew9+vVseGvtkAFGE4KH0K6
         EpVyG+Lh3kcAj2XNO6DBMX3Jd+dPGu9LG0d54TMDGTVkn3TgcyPQ/1yRrEhj+dNchc74
         mYvFBeclJFhFudI/RP4UOF5zCsiuNYyXt3l0jCawOb9VKuINVegHc6CK2hU1WtGX3DGK
         7ly5TPY8Ew+ps20K9UyfkuIMtCKA7VmOSeVrvHSuazXudlTMieiqmpX8QsKpcz3dMkxY
         Aj9E0QCsgSgpswD7DS7HnTJi7AtzDSq2cfjSeJmMB6hJ4hnFmvRC96o21omawvKoDKsW
         Eg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=epHYp0/ayBKnBQl2OIkSkvLpnHukIPoj6wnb2bA2hoM=;
        b=CFfvDSodUsjv7jARo1wbRKBBt9rzkxPPMtZQf6fpy9qNG1b7dyFHGxXHU2X6mainnQ
         5PCl//nqDbxOv2kE2Pe0dQb8ce9cQKlJBp9N1Wvr1xRzUrnkBoqNBZ7aJCqYCuNDz9Pc
         e23UYqonLjA948zdEkSeg8XQPcFfgjb7DxjhPlf5/IT7+6pg1lj2pAZtZ6zT7WmffMcz
         ykbpV43ypI0kCJQNhZbI/eTrJez8LaxmvpGUgwfCy87iEtHy4nEjrKoCoYLNZ/a9lkiQ
         mnxL82xeScGop32TSPVuBrZZ7/RpUyTNFAI6mBKuAsO4C6gXpIduBAiAWiPfAinS4zfb
         agcA==
X-Gm-Message-State: AIVw112unOptG2nN6pxQBld96Ky2qXXU6hDS4D5wqx6DhrYJrZmyFy4o
        uNnty2feDWbAH4AeoAaj1g==
X-Received: by 10.101.72.207 with SMTP id o15mr6601128pgs.73.1499906670196;
        Wed, 12 Jul 2017 17:44:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:68de:f6b3:e0e6:2d13])
        by smtp.gmail.com with ESMTPSA id s15sm6463517pgo.48.2017.07.12.17.44.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 17:44:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
Date:   Wed, 12 Jul 2017 17:44:15 -0700
Message-Id: <20170713004415.5051-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.3.650.g5ebc568d5d
In-Reply-To: <20170713004415.5051-1-sbeller@google.com>
References: <20170713004415.5051-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  9 +++++----
 tag.c                | 10 +++++-----
 tag.h                |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 01154ea8dc..b25bf8daa2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -111,7 +111,7 @@ static int verify_tag(const char *name, const char *ref,
 	if (fmt_pretty)
 		flags = GPG_VERIFY_OMIT_STATUS;
 
-	if (gpg_verify_tag(oid->hash, name, flags))
+	if (gpg_verify_tag(oid, name, flags))
 		return -1;
 
 	if (fmt_pretty)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f9a5f7535a..ed8329340f 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -56,20 +56,21 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	}
 
 	while (i < argc) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name = argv[i++];
-		if (get_sha1(name, sha1)) {
+
+		if (get_oid(name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
 
-		if (gpg_verify_tag(sha1, name, flags)) {
+		if (gpg_verify_tag(&oid, name, flags)) {
 			had_error = 1;
 			continue;
 		}
 
 		if (fmt_pretty)
-			pretty_print_ref(name, sha1, fmt_pretty);
+			pretty_print_ref(name, oid.hash, fmt_pretty);
 	}
 	return had_error;
 }
diff --git a/tag.c b/tag.c
index 47f60ae151..7e10acfb6e 100644
--- a/tag.c
+++ b/tag.c
@@ -33,7 +33,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
+int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 		unsigned flags)
 {
 	enum object_type type;
@@ -41,20 +41,20 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
 	unsigned long size;
 	int ret;
 
-	type = sha1_object_info(sha1, NULL);
+	type = sha1_object_info(oid->hash, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
 				name_to_report :
-				find_unique_abbrev(sha1, DEFAULT_ABBREV),
+				find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
 				typename(type));
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
 				name_to_report ?
 				name_to_report :
-				find_unique_abbrev(sha1, DEFAULT_ABBREV));
+				find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
diff --git a/tag.h b/tag.h
index fdfcb4a84a..d469534e82 100644
--- a/tag.h
+++ b/tag.h
@@ -17,7 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern int gpg_verify_tag(const unsigned char *sha1,
+extern int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.13.3.650.g5ebc568d5d

