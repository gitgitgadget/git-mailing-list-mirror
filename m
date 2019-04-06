Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FB320248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDFLhx (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34288 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so4506468pgq.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKjJIvSfH8MGf6h4/kuMUZwGHNx2sxD8tRhAQUc8aZA=;
        b=AG4EQQNPni2i/Gv+Bnd13yq/0OeJa8DEYomBhK5j2W+a+LTLoSROWpMXsg5aXrEUxy
         V0U1PyRpjHic6WIdo0v11BWIgG369jq5rZLqa9oOePOUDDpuraJkrbEvCufQjisWfL4Q
         s46zN1oWqRHJIy7EUoy1ziTkz6WD5FKPjPpqcO2H7cYbjOvVJxojCLh8HOzfuYCo6e8N
         4X9xH9/J/eteMYrgb0MdIxrc7zr8k4k1LETosIWCJ6BVwUETOdFt81rpM6RfhOGsvGPX
         cJU8DgQvxwLcosBMWjBuX6VBFeJnQ8DFaV3rx4t0hIT/Rd8Fd3SIHcI5qytrBR9JQCvh
         9hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKjJIvSfH8MGf6h4/kuMUZwGHNx2sxD8tRhAQUc8aZA=;
        b=QT7v4xBwGixc2MtAQiLp20ntTn6PTcGqMUqQCBPPbmDKTOmqsDomTP6gPfQX0dL3hn
         xOYsJhHtW98KDksQU4lf6E018UH936GFwfUelTIlmOdsIGBlKtBIKtclXK2HZZCroKt1
         N3t7Jya0fns6eVINYd8p2+ETJJyZDh1b0A19bVxmQM+l8t9nhI0OId5RUXO4FUtKEeyn
         CS3LBBGKkpieYu3ipiNCHMnrrvu8d9uVmuckpKluKvlcv2t6zH5S75ziXCZW4X8Ntqio
         EmeR8O90AY9F43w9dLt8FswlNX6wMsQ3NZ3wR6WYcIr+C7xwvfuy70lOZeFtjHqQZVj9
         CphA==
X-Gm-Message-State: APjAAAVs7Ud5GLowiHtk0N8W/NIwgRGVKJyp1j/OirOwOuF83x4BU3c+
        PN+ig7/GmszFwU7y4S/5Pe0=
X-Google-Smtp-Source: APXvYqwlot2U9GXKs/wSD6DcJVXQSx40rlvRviXnZ6LA0LyVLYfQB75qXFDeQDh4E/QtrgEUAOr3NA==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr16765729pgn.208.1554550672800;
        Sat, 06 Apr 2019 04:37:52 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id a72sm7891355pge.0.2019.04.06.04.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 29/33] sha1-name.c: add repo_get_oid()
Date:   Sat,  6 Apr 2019 18:34:49 +0700
Message-Id: <20190406113453.5149-30-pclouds@gmail.com>
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
 cache.h     | 3 ++-
 sha1-name.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2149dc4f56..f6e87194d0 100644
--- a/cache.h
+++ b/cache.h
@@ -1380,7 +1380,8 @@ enum get_oid_result {
 		       */
 };
 
-extern int get_oid(const char *str, struct object_id *oid);
+int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index 64a50d1291..953df0d692 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1573,10 +1573,10 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
  * This is like "get_oid_basic()", except it allows "object ID expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_oid(const char *name, struct object_id *oid)
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository, name, 0, oid, &unused);
+	return get_oid_with_context(r, name, 0, oid, &unused);
 }
 
 
-- 
2.21.0.479.g47ac719cd3

