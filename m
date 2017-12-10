Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81ED11F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdLJVUi (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:20:38 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44220 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdLJVUf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:20:35 -0500
Received: by mail-wr0-f193.google.com with SMTP id l22so15614116wrc.11
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxAo5xrt9F6CXzGWMaDmW+hTMh3nRKKSDfB+haBjwhg=;
        b=uaNJCFK9MIHeivdzUAr+nwofuv8PX3md80jGivZc01MCvq4/cPUDbDOSVQlb+aHvCV
         XYyvSqrZl6iyL/JahXiEw4Pizn5F0tNW7DWyT+m9+Oz/8yBPYCrt3WJ9Ar7z8MU3e/10
         qH/7lQsq0fFeoqUGeUYJZ2AsUnfVMXYGRIVpEUHG6mr7fXcdr/9NOxJh/AUUFA/uHWKm
         OiqmmnZcyaIem7lVRFM1X9RiziKkXuCtudFLfyO8GkEZZBlwJ71fyLshnS5ZEE+lvHlN
         6moy8k9ltDDhsC9C+fSMQKwV7N86ze/yiFs8/nZ6hQZYFnWHU/YjslrD2rkYDdamwy7r
         Q7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RxAo5xrt9F6CXzGWMaDmW+hTMh3nRKKSDfB+haBjwhg=;
        b=aMb1MbyZ4sbAjOS961B8jypXtkyk+224N3jI7q68H4HDL0L9wXBuhOOgU21+pCxz/x
         ioEBKEjQ1sXkEcdVJcrAKsTnAmODBSLHae1YM3q3vG2IVs82OD7jzyj803zEFHqKtVVe
         KzFuxnBvb6zSlA5W4HhiBmRHwfEoA75/E6rMh6aPPabAAdeyAtSjQWC025CktJwjxPLp
         9dcRYns4HFdaFyMlalttGTW/2LzGd6PS5GkBMOLCmcO2ctRFUxd6kDFQanJYCK2cFmNa
         trxBQ+StK3q6aKr2GF+EXkyDbdeGkHUCmH+OOE2j1LkZXQPGsD9/EaasatCahfTD/ER2
         528w==
X-Gm-Message-State: AJaThX56gvVHAO5tNM6NsCWOny1tKM+ZJDWQD09CGf1Zh0PuiQB+/g5C
        dzCi473I7fsw6BhfZoG+CsSdoDcY
X-Google-Smtp-Source: AGs4zMYrEsUntJmPvzwnlexcGtRN/O0LJWUA6e6vrCPgMTxVjVE0fBppHGp74YOITi2ZQDWzbV3qmg==
X-Received: by 10.223.161.158 with SMTP id u30mr33754711wru.200.1512940834105;
        Sun, 10 Dec 2017 13:20:34 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v23sm7045274wmh.30.2017.12.10.13.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Dec 2017 13:20:33 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] repository: fix repo_read_index with submodules
Date:   Sun, 10 Dec 2017 21:22:00 +0000
Message-Id: <20171210212202.28231-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103
In-Reply-To: <20171210212202.28231-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

repo_read_index calls read_index_from, which takes an path argument for
the location of the index file.  For the split index however it relies
on the current working directory to construct the path using git_path.

repo_read_index calls read_index_from with the full path for the index
file, however it doesn't change the cwd, so when split index mode is
turned on, read_index_from can't find the file for the split index.

For example t3007-ls-files-recurse-submodules.sh was broken with
GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
broken in a similar manner, probably by introducing struct repository
there, although I didn't track down the exact commit for that.

Fix this by introducing a new read_index_for_repo function, which knows
about the correct paths for the submodules.

The alternative would have been to make the callers pass in the base
path for the split index, however that ended up being more complicated,
and I think we want to converge towards using struct repository for
things like these anyway.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h      |  1 +
 read-cache.c | 19 +++++++++++++++++--
 repository.c |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index cb5db7bf83..d42bea1ef7 100644
--- a/cache.h
+++ b/cache.h
@@ -614,6 +614,7 @@ extern int read_index_preload(struct index_state *, const struct pathspec *paths
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path);
+extern int read_index_for_repo(const struct repository *);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..4d5c4ad79b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,6 +20,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "fsmonitor.h"
+#include "repository.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1871,7 +1872,8 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
 	free(shared_index);
 }
 
-int read_index_from(struct index_state *istate, const char *path)
+static int do_read_index_from(struct index_state *istate, const char *path,
+			      const struct repository *repo)
 {
 	struct split_index *split_index;
 	int ret;
@@ -1896,7 +1898,10 @@ int read_index_from(struct index_state *istate, const char *path)
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
 	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
-	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	if (repo)
+		base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
+	else
+		base_path = git_path("sharedindex.%s", base_sha1_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
@@ -1909,6 +1914,16 @@ int read_index_from(struct index_state *istate, const char *path)
 	return ret;
 }
 
+int read_index_for_repo(const struct repository *repo)
+{
+	return do_read_index_from(repo->index, repo->index_file, repo);
+}
+
+int read_index_from(struct index_state *istate, const char *path)
+{
+	return do_read_index_from(istate, path, NULL);
+}
+
 int is_index_unborn(struct index_state *istate)
 {
 	return (!istate->cache_nr && !istate->timestamp.sec);
diff --git a/repository.c b/repository.c
index bb2fae5446..928b1f553d 100644
--- a/repository.c
+++ b/repository.c
@@ -229,5 +229,5 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
-	return read_index_from(repo->index, repo->index_file);
+	return read_index_for_repo(repo);
 }
-- 
2.15.1.504.g5279b80103

