Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31481FD09
	for <e@80x24.org>; Sun, 28 May 2017 16:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdE1Q5e (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 12:57:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35913 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdE1Q5c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 12:57:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id h64so4057424pge.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xgvmQApkzbwVHoqdGrc3mUDcdMFSu2qRxGsbkKekoz0=;
        b=eikdVnsIcpZoCJuKcE0ZIV3lx4nkDDh26I48wgoNVwrb56/q4GxhYWmcc0pJm6yAI4
         g6vBjcIJE6xG6WEzE87DwFucqb5eA3zTGp5OYmig20JoimYpjSpUeBqTjfIyLZT3u2NG
         x9POGL13UrEFNyWXWAhVB9VbOeO5Yn93Kyy5HIMQvLvwskUw5OC5+OokJc1E6Cv5D4mD
         knphcnWKlh8IcfQHi9D1r+8L+DM186ZKI33HzIM/1xmNj+Ldkqbf2OQvrcydaIAyGY08
         8ENbUQFBF3b29Jp2AxStxI/UQrcJl6ANkyipSqzC0o22NTYPT1eWDw6LDZ/rouzj4PGA
         wvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xgvmQApkzbwVHoqdGrc3mUDcdMFSu2qRxGsbkKekoz0=;
        b=ovEsJ7qK+7LnSMPumxsCjlkdAOQl6PNq4DkUu/IsiKkHH3kTlfxF0CqGBN+qMiu5bA
         Rl++kimBG3GZPU3AAQM1Ar61YZqSNtUWVBLXEDbLPQq4rCD/k/aR+DAmP48pon2d8yjN
         h+1Ke1bxZCpf3EKKPjEOuLQ5UR1qHIqyibwPN7l4qQQKiZHQ9NyASg/iUjBuVYZ1XeHQ
         NVL0oHhCqZ4P5Mli+ymGSGWDOslzDzj6YSmFS8uBceVn2k7E1TgPMW5QDNtiMk/1yrmo
         tWV8kZ/EgyY3dIKbZWmRUG4IjV8nfmUBLOBJ69mDdZ6TAKf5bh2C0Qc2k2ZP4Ss5cxs+
         bgtg==
X-Gm-Message-State: AODbwcBPysVRntkGZto4HC3AcYt5eOkqI3YFT5J5OC+ISX5MAt6qV97a
        sU+AWIe+gdQgGBoN
X-Received: by 10.84.178.129 with SMTP id z1mr25088633plb.171.1495990651941;
        Sun, 28 May 2017 09:57:31 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id w67sm12511824pfi.2.2017.05.28.09.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 09:57:31 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 3/4] close the index lock when not writing the new index
Date:   Sun, 28 May 2017 09:56:41 -0700
Message-Id: <20170528165642.14699-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170528165642.14699-1-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/add.c     | 3 ++-
 builtin/mv.c      | 8 +++++---
 builtin/rm.c      | 3 ++-
 merge-recursive.c | 8 +++++---
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9f53f020d0..6b04eb2c71 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -461,7 +461,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
-	}
+	} else
+		rollback_lock_file(&lock_file);
 
 	return exit_status;
 }
diff --git a/builtin/mv.c b/builtin/mv.c
index 61d20037ad..ccf21de17f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -293,9 +293,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (gitmodules_modified)
 		stage_updated_gitmodules();
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die(_("Unable to write new index file"));
+	if (active_cache_changed) {
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+			die(_("Unable to write new index file"));
+	} else
+		rollback_lock_file(&lock_file);
 
 	return 0;
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index fb79dcab18..4c7a91888b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -389,7 +389,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
-	}
+	} else
+		rollback_lock_file(&lock_file);
 
 	return 0;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 62decd51cc..db841c0d38 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2145,9 +2145,11 @@ int merge_recursive_generic(struct merge_options *o,
 	if (clean < 0)
 		return clean;
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
-		return err(o, _("Unable to write index."));
+	if (active_cache_changed) {
+		if (write_locked_index(&the_index, lock, COMMIT_LOCK))
+			return err(o, _("Unable to write index."));
+	} else
+		rollback_lock_file(lock);
 
 	return clean ? 0 : 1;
 }
-- 
2.13.0

