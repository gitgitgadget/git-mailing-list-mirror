Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C601F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeB1BGV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34681 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeB1BGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:19 -0500
Received: by mail-pg0-f65.google.com with SMTP id m19so321089pgn.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G18cMQeHQl3RdrzH/Tool/bMxOlcd/9hHrkNU50wmCk=;
        b=fJYQBtL2QVczyO8/qHq9nINoifDOrEtnnfUI6/Bt0GJRsCSx6baVWAZdGX7/+wz2sX
         5qhUfvaTGbBBNTVETicNwevAK9Q7n3eEo6cKVyoaHrS/pIkm5xWie1T2/xcMGYt9O7rh
         UPdm8HHY3KELOe2DNCNTChiZnlzxueJpR4vxcAuUiDnxUB/E81kCra4EWbuJDCmZgptf
         aqHIL4RnUb5QelZPKcGW4gj0CffRbtakFL7Fk1owJrtfE4jAvre671l80tIeK3np8fuC
         7KwXKpTc3LBYNYJi2/ZqxHK4Oakey8UliDGLImw50SRvXSNMInKcE905fEsmz96LS3Fj
         +SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G18cMQeHQl3RdrzH/Tool/bMxOlcd/9hHrkNU50wmCk=;
        b=QembTkPx5D5lj5LixI5HLYvPKb5euDeWJk1aJsXgKoNUwhV3eSqKRUE4tc8VXGgBU0
         Ba2cpBcdBd7nKttmH6jUeJLmm7BGo2augDuQj6MwQGvlYZSqD3se6i+Qnz94j15DMAU4
         7kjLQyDGBCo/bcusiyDCPr7XuTiH4mLbsLCi8jOJhxGsTh8bnPNdeE7Mviqx9I441whZ
         W38NBRDYME9K5FCeeYThlcTJ/oD5zXtac4IjZMPDDHBAaXNJPJe/+iRvKXnncP556tDn
         WQ/Vq0JEEINhkaLU9eV4rZj+J8zgQLCnziEEf7rMzvL8wTc5XfiiNpuQTJaicmx3QMmd
         kFkg==
X-Gm-Message-State: APf1xPAD4FEzu7NpeDYjaycsPUIStihMUqsv/US+G1YIa04EvB8IXgPY
        i7rCggGkwAJ4Gzju+62zIkJ7i04mb2c=
X-Google-Smtp-Source: AH8x226Pk6XLZkDgsg0VeEymbtfQeveml+e4uRtIhofa8GqRdE/+t7iEAPv1HaaHhiwtyBxLEq8/fw==
X-Received: by 10.99.124.14 with SMTP id x14mr12754354pgc.290.1519779977974;
        Tue, 27 Feb 2018 17:06:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a6sm513269pfi.22.2018.02.27.17.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/11] packfile: allow install_packed_git to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:06:00 -0800
Message-Id: <20180228010608.215505-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This conversion was done without the #define trick used in the earlier
series refactoring to have better repository access, because this function
is easy to review, as it only has one caller and all lines but the first
two are converted.

We must not convert 'pack_open_fds' to be a repository specific variable,
as it is used to monitor resource usage of the machine that Git executes
on.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fast-import.c | 2 +-
 http.c        | 2 +-
 packfile.c    | 8 ++++----
 packfile.h    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1685fe59a20..67550584da4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1038,7 +1038,7 @@ static void end_packfile(void)
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		install_packed_git(new_p);
+		install_packed_git(the_repository, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/http.c b/http.c
index afe2707e86b..f3c2302f84b 100644
--- a/http.c
+++ b/http.c
@@ -2134,7 +2134,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
-	install_packed_git(p);
+	install_packed_git(the_repository, p);
 	free(tmp_idx);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index 5ccce419354..1c24b02cc84 100644
--- a/packfile.c
+++ b/packfile.c
@@ -680,13 +680,13 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git(struct packed_git *pack)
+void install_packed_git(struct repository *r, struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = the_repository->objects.packed_git;
-	the_repository->objects.packed_git = pack;
+	pack->next = r->objects.packed_git;
+	r->objects.packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -782,7 +782,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
+				install_packed_git(the_repository, p);
 		}
 
 		if (!report_garbage)
diff --git a/packfile.h b/packfile.h
index 6a2c57045ca..cc3bf67ab50 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,7 +36,7 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
+extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
-- 
2.16.2.395.g2e18187dfd-goog

