Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF75C6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 17:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCPRPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCPRPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 13:15:17 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F6E049
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:15:16 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id e12-20020a4ada0c000000b0052cdbbdc803so349314oou.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678986915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NJ0nSplYU/aH4j0iYZ4h6RSkhSmh60ZsvyNsNsmOTk=;
        b=QIkF9OeQ9wqVxri+n61W2n9KK/YznamrfQpbC+Q8rlsPcnUTlsePeqiOohCj/Fo6rI
         Ht1bL/tsKV50ZLrExjjP/sohgAy0y0mOMa96Pwj/KTYji6zbszI896fvRe5BT9DZxJyM
         DLmKdiN0Em2Jb5TWuJY5TmH/vInOOCq2n19au2QUfbLSeX2EQuVXZYUY4beeOv3wg5u6
         hg7Qumc7JrTptCxWvj21/YYD5clds2AFdKDIiJFJ6TzBDh7SdKVzQqnqjIU1l863Y9b2
         ICsMOPZElRFF0v0w26DqEe6KPbsBw2TJ91yJKbusMgKcoIGgBurw0J9DtfGQPQdyH9Os
         H+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678986915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NJ0nSplYU/aH4j0iYZ4h6RSkhSmh60ZsvyNsNsmOTk=;
        b=b2AZn6kfhTy1wcNDyCO0XfW/RCLxwNJKNJTaFMyL8QAHyJT8/Kgw3yU92Uvx2rCniY
         V4STqHHuKGKTKXYoK4FcCL1r69xJB8dP6obEjaQo8VdZfrA5n71v/gXWmlqre9B499XS
         TiRbtQjQeObNUx2OHBk4iPMG771x83mRWSmI9RIUlVNVpd/f4w9gEaVLLS13Q6VTFQap
         p9uQAa9+JuAJb2v9CQqrNFOkp8OjkHo3LDzPQkH5o3+WrWGjkWBlsyiKJgbJKZ873YMO
         UF/yzoKCh/svXXYexUqMkZb6UbN2ofAZpnSfl4dzwMhu1hQTY1+saRgnJQjQiGTwqNP8
         Ayog==
X-Gm-Message-State: AO0yUKVdoe+7qTubQkJxf7UQFfl5Gz8oDdwc5Y8/FcVBxfqyO5JjTnbg
        qT7GSedKPL46PfgEKMit8OXPes+NIK0=
X-Google-Smtp-Source: AK7set9DNuS12rqIMUZB3xz8x1XzCk1I9fc35aFkiy5OUdJgcxB/gbicRhtsqSjDsEDU+FeYYEK8EA==
X-Received: by 2002:a4a:95c6:0:b0:525:129c:6165 with SMTP id p6-20020a4a95c6000000b00525129c6165mr20651391ooi.6.1678986915698;
        Thu, 16 Mar 2023 10:15:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6481000000b00690e783b729sm37687otl.52.2023.03.16.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:15:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] object-name: fix quiet @{u} parsing
Date:   Thu, 16 Mar 2023 11:15:14 -0600
Message-Id: <20230316171514.23741-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently `git rev-parse --quiet @{u}` is not actually quiet when
upstream isn't configured:

  fatal: no upstream configured for branch 'foo'

Make it so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 object-name.c                 | 5 +++--
 t/t1507-rev-parse-upstream.sh | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e..d9f3a176d8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -898,6 +898,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
+	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
@@ -952,11 +953,11 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, 0);
+		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, !fatal);
 	else if (reflog_len)
 		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
 	else
-		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, 0);
+		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, !fatal);
 
 	if (!refs_found)
 		return -1;
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index c34714ffe3..549eb315a9 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -183,6 +183,11 @@ test_expect_success '@{u} error message when no upstream' '
 	test_cmp expect actual
 '
 
+test_expect_success '@{u} silent error when no upstream' '
+	test_must_fail git rev-parse --verify --quiet @{u} 2>actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'branch@{u} error message with misspelt branch' '
 	cat >expect <<-EOF &&
 	fatal: no such branch: ${SQ}no-such-branch${SQ}
-- 
2.39.2.13.g1fb56cf030

