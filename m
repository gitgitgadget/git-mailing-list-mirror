Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD031F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeJaHDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:03:53 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:54662 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeJaHDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:03:53 -0400
Received: by mail-it1-f202.google.com with SMTP id t5so6112145itk.4
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vJly1bdEYz4Ov8RMEYfidWD4NO7Q4BvqJSEKZJG4J7c=;
        b=aR1sAAnNTpeWc2j+U6TMJ1mJ+XB/NTCBwiaSv77xjE8a8Hq8WcUjTFia8pNcbqZ+ld
         Bz2V5M72SEgt268m5m35z65YEQAHJGaqwKBxVUvCXnUUPjjbtUljcUSJpbfTRz7miBSX
         gfEysQgfuNTvYtLUL/7pSMQZgo1dTX/+o9NojXELzK0wlpWS+SgmGPFQ8AuqY0/5D2up
         ZZt+pAaA+Q6sThVzGuu0MsKbE6JSkHF7Xeam/U8r1+8tyBU06RJKw4v/5pNPAKgDE9Vu
         ZgdiJ89NimwbH/WVkIFBrtgFSqbyR/8v+K87LVp27s23k0ZsuMn5ldi8QxdNVL1bEz4D
         l+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vJly1bdEYz4Ov8RMEYfidWD4NO7Q4BvqJSEKZJG4J7c=;
        b=e97YOL7lX6a45ubAcS+GUNdW7G+znMHbV0AhLlkPiZX9uJzgD7u2QzOu+0cZ+SXDBD
         GiZaZGbbEJsHLIxnX0+ZuGYYdSP52ooo+eJZTJV+vkmAtcA1a3Q9heSGjwjtPsR7cxcG
         4uvYGKCuE0TAyxVpHAhpec4GKXzmWdFnZ9fzBpsBtxlL2wUASpjnH0MpwnXubowoCJiO
         uNIU0NARle6/mrB67mTj5O9r9x+bwb63mWItQjLCnu1QfWyBJjIx5SJ64clw/6JLJmMO
         Rb0UpCvmNI4WIvIE5szC1LrR4YZCa+zB0qeR+oqRic/x8HvdaHGrwtxyah6EB9cu9Ltf
         h32w==
X-Gm-Message-State: AGRZ1gKl3wwQFrjTculpiJtW0TOPYqLRRqAPDfzM40/j2UXPzmQW2wzG
        XfO0n+e+ah1kpBN/Yx8kWYPJFDcwMdodvlOKR+ZBvfgDbqY1nPPjtq2kT8KFkpBRUIOXFZcStNF
        MSDRy7UueLvIs5dRLVMf/O1ma6jcX3OC/2cbnOLZgcIwA8lN+iMpMI7+ghxFX
X-Google-Smtp-Source: AJdET5fsFrDvKZorrCJkbyejFQMXHSoC72KZSJ9EaYaIVGoCRfW8i2vTdaVN0LqtkXjdQnQlopcmCx4f2aGH
X-Received: by 2002:a24:2795:: with SMTP id g143-v6mr328620ita.38.1540937318430;
 Tue, 30 Oct 2018 15:08:38 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:56 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 03/24] packfile: allow has_packed_and_bad to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

has_packed_and_bad is not widely used, so just migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c  | 5 +++--
 packfile.h  | 2 +-
 sha1-file.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index f2850a00b5..63f8dc7b98 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1138,12 +1138,13 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 	p->num_bad_objects++;
 }
 
-const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
+const struct packed_git *has_packed_and_bad(struct repository *r,
+					    const unsigned char *sha1)
 {
 	struct packed_git *p;
 	unsigned i;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = r->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (hasheq(sha1,
 				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
diff --git a/packfile.h b/packfile.h
index 6c4037605d..d70c6d9afb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -146,7 +146,7 @@ extern int packed_object_info(struct repository *r,
 			      off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+extern const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
diff --git a/sha1-file.c b/sha1-file.c
index b8ce21cbaf..856e000ee1 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1432,7 +1432,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(repl->hash)) != NULL)
+	if ((p = has_packed_and_bad(the_repository, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
-- 
2.19.1.930.g4563a0d9d0-goog

