Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB141F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBFA0N (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:26:13 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44248 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeBFA0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:26:11 -0500
Received: by mail-pg0-f65.google.com with SMTP id r1so162983pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jy7xluoFJ6E9V/v/4lRU1jdNNeduKbrSkJKTpa6P/o0=;
        b=cj7mGBvd2L11A8PLYrqyA6n1deu+goGg3sPkksEYtsHt+AfDY7aqEftD3ufSgOBRF7
         vGSVD0ifHQWdtSs/QpIGjHf5H6RwH/ROOqQfdat2aCMyBcsPGhYhoTzus69klx9LzMso
         1n+Lluz3/B5FyHvzvk2aNDgArHsAsB9AiBVmVf4DMmAJ0QZAIvJNOP/FEitPtNZJD7Wb
         vAyCALU8Zv8nrCEWDk9h3khsoSFf3/yLVrgrDxZECcIYCGtqQTkqgPiP4znRoW1w4JTY
         mSivgGzBIRvak/gZeh/KiSeVgFxUNCbLUviONdLsohT7vG7KZ4l3QloIejkd97q319Fc
         3vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jy7xluoFJ6E9V/v/4lRU1jdNNeduKbrSkJKTpa6P/o0=;
        b=fJ+I+r9/0QDdF0MUHPWmLk1uwjOlWcvZ1vlQyOg/7fL4z+y6B1Redm4xfme5PmCdmy
         qPstgP3FylHfsLn5xQZ7SKu5kQIbqaiLFsfdwiVI3aOqD3On7GQ9qKjvyXY7gQkI2uDT
         iDo+MkVuOngFWEaa/J8Zc/Vu5FOQ8xYA8vgejvGU/Eldsx5As+6LzFTBBZ9DInlyGVFr
         JeAqsbcQszgFfs++loi11P2oCUGMia5l/uLdPjKd8gWW0bn9A1eZDBlYNda1zlKoWveA
         iEDos95YDDs1GTqwIaJL+Ix+RNba9e9KYB8A1WiSHGcf9dc5rke3XcR30F5Ckmq3Bz9O
         mmBQ==
X-Gm-Message-State: APf1xPAEAUUPeM+zNkcltVqF5jjicYAK11gFw9Kjh3Be+yWzRbhcXEYB
        ZnTQcijkG+VAwyrLooAvctTQCfzkW8I=
X-Google-Smtp-Source: AH8x227AyZ4xmQ/yEi73WapRV/IHqC4nqjwbK+/77qbMKTvhCKDK2MPMtqoa7AgskCsjJK4p7KcO1w==
X-Received: by 10.101.100.69 with SMTP id s5mr442720pgv.413.1517876770665;
        Mon, 05 Feb 2018 16:26:10 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t21sm19613167pfe.122.2018.02.05.16.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:26:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 151/194] cache: convert get_graft_file to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:06 -0800
Message-Id: <20180206001749.218943-53-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h       | 2 +-
 commit.c      | 2 +-
 environment.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index ee01daf130..a74a10fe1f 100644
--- a/cache.h
+++ b/cache.h
@@ -489,7 +489,7 @@ extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
-extern char *get_graft_file(void);
+extern char *get_graft_file(struct repository *r);
 extern int set_git_dir(const char *path);
 extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
diff --git a/commit.c b/commit.c
index a5e570f057..32eda5f7c9 100644
--- a/commit.c
+++ b/commit.c
@@ -205,7 +205,7 @@ static void prepare_commit_graft_the_repository(void)
 
 	if (commit_graft_prepared)
 		return;
-	graft_file = get_graft_file();
+	graft_file = get_graft_file(the_repository);
 	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow();
diff --git a/environment.c b/environment.c
index 249516cf6b..972ade61d8 100644
--- a/environment.c
+++ b/environment.c
@@ -287,11 +287,11 @@ char *get_index_file(void)
 	return the_repository->index_file;
 }
 
-char *get_graft_file(void)
+char *get_graft_file(struct repository *r)
 {
-	if (!the_repository->graft_file)
+	if (!r->graft_file)
 		BUG("git environment hasn't been setup");
-	return the_repository->graft_file;
+	return r->graft_file;
 }
 
 int set_git_dir(const char *path)
-- 
2.15.1.433.g936d1b9894.dirty

