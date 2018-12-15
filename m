Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89ADB20A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeLOAJv (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:09:51 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:46067 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:09:51 -0500
Received: by mail-io1-f73.google.com with SMTP id r65so6078401iod.12
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ef6cfstK31cHUl53R4s1NhtgQjSryFwo/flJmAvUnnk=;
        b=aTPPzKT1InQradWsGi4DiNoYfpxUGeQvuQNi5ZXWZcvKCrVXG1/a2jLlzbFMU5x3Rl
         fxRg7JR4BVB3bS2OTze9xl0S08uRTBQlRe7GAJu1F2dYB932cbZN4eGM5hWS+QsjNH/M
         q+D9xIdLNjPGy2Qe7RSD1RFwZYEFF/Zhp9AW9A5+2eEbcWdD1wD4RYmMU/cWnzKIbP7R
         5ga/Egn0WXLpOPOcj03EqY9x8uWMtsccW8X0rV/fAKFdgDoT/bbIWd8F2sxYP5BPimtM
         U/Lq7trvIkhTj48zRxZyvpo2milsgTg1d6RKyL2fTF3ePIIe/+VirjthYaAhTRkC3xru
         CNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ef6cfstK31cHUl53R4s1NhtgQjSryFwo/flJmAvUnnk=;
        b=hfcXRR2iCqRzXq0f5bH8XbQ1axLixnyZ/WtrZ8T3Bttbr4DNZlIfYud4yKxNDyXcCY
         7oh99RFtHxtxqXGVaKaP71olgkv3lo52crriw1drtglEUkJR2qevvJrVtmhgOU3jLMV3
         L2pqPzignbNSlNeihJQ1SDpjad1XBbyyeWC/NjJ+jWCB+H/AwTwxgvYEbJRXPYzc7vYU
         liTqHsPYfqE6X2CnkusUaFJEcTa9B0iLgH3zSP8BLeZd04rGNXNYGL6Xcn2xsN/+09zW
         cIQngKn7qUDyjaubEiwJMtUQsIpu13IY32tPaxhT7sEqkf6JEIth2i60ZSAPXdVEjah8
         5ZyA==
X-Gm-Message-State: AA+aEWZYBt6TTQtn5jD4boNxXAGHd8hQpm1Sa9pduK/6wCaJ1BcbPi90
        OpNHfCTpXg3uHhlE2wAQdQBDJ+PiGKah1gHbvz/PHhDeEBKW0aZPzoBQzWCpBApplaCGnUa/9NQ
        5s/tnDKRMGh7USkDQ3SYnA9wwUfIutAyqq41g3EwtUC7hueXcNlQLOwBsGipI
X-Google-Smtp-Source: AFSGD/VQjVKVpO83g9PsS/qNlUzZCe7WOPVkXszxR6tSbRKB/2WXga6Q/qhDwOD0nPtLNclMUgfsZ9GbJsUa
X-Received: by 2002:a24:6852:: with SMTP id v79mr4485569itb.29.1544832590058;
 Fri, 14 Dec 2018 16:09:50 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:21 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 02/23] packfile: allow has_packed_and_bad to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
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
2.20.0.405.gbc1bbc6f85-goog

