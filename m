Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A311C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeKNKOT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:19 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49846 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:19 -0500
Received: by mail-pf1-f202.google.com with SMTP id x62-v6so11728253pfk.16
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=02IgdK8uUOxL7M8ikqLAMdYUjR8Rbj8Lbzj+AnfQFE8=;
        b=g25bxDjys62g5Txy+d5LSFBja3cGzr9PKdtTfRVGEpoREDK9Yo0F5NTw+0Ulhb2ZL3
         jxBx4A5tViNJOQsEWK1KYyX+guyeegPw1VnSJeensUVTxWppSBnBXvY+ICK22dDqs0r9
         2Y0me6W3OMCvomGwtpWeilvydqwLQyIJPfWUrza5doCP9OuqFb4w2kgCvtHXEPkEJYhV
         cgIGEwUf9r0W/qwVjr/9W6jEbCBxXom6iv4bCIo6s03zlxFI29n5gHXuFFOiXKnJP2YR
         +m79viqJ1PQb9MhdqH42qxtq1HJ7/5piHM+GLphMvDn/gf20tKXy5k557cM4/hZsJY94
         68UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=02IgdK8uUOxL7M8ikqLAMdYUjR8Rbj8Lbzj+AnfQFE8=;
        b=TTp83lo6YBrxCIdHQqD1+m/Lr4ELT7G4kjKY1exEPTMCF4HUTxwOvJGmwt0wAiHG4+
         4m11n5N1SNqs/3oJJzVoca0uaMAQctaQYkebvYM6YbBycaX9bmd4N663Zmekk+86J3Oq
         JkXs/lE4055woS6tNhAlqXwRntBLL3DOedA84/dQhOGIl8j7u93pDYthIU6NfmAKVmlg
         vvHvEKV2Ur0wafPmbRhB0ah34/WvpJBSqdBls5azdYKCkGZX2LpcKmncuxl6XkqCBpWD
         bRSNEbb3SkcUMKzF9Buoyc+rGQFL5PDu2arlf9pelnmC89UNpmsVxYQWG0PhqnT5+9k+
         EeZw==
X-Gm-Message-State: AGRZ1gLPPl4rrQAJAI1de5OZmqyU9rxNIy6SFUQ7RMde2tSCTNGz77j8
        AqH8ucU3J6ScKIRmL8kRqjdIg2AkIXo4
X-Google-Smtp-Source: AJdET5c4S0jcbiYOGAHtym/nvBrw904qs8BqFEFDJTkluXvD7GuBKIavClG1ZdT47XPlbB2hMTmiw9sF/ePJ
X-Received: by 2002:a63:608:: with SMTP id 8mr3195156pgg.139.1542154416511;
 Tue, 13 Nov 2018 16:13:36 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:45 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 02/23] packfile: allow has_packed_and_bad to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
index 841b36182f..bc2e0f5043 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1131,12 +1131,13 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
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
index 442625723d..7a62d72231 100644
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
2.19.1.1215.g8438c0b245-goog

