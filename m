Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B930520248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCLhX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33281 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so1521344pgh.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HRwL2T7MODfcXrlBYA8wLAi07ntXHgzSLd7OPKp/jk=;
        b=TAE0l0JSl52773Syvht+Aekoo+10iC/+wqWBK/86seg0T5Ows2N+ab6AJKlGb51+DY
         M3aNzjg0DJLstSvWfIc72J3QkLcwIl8mwvlXYiGRO6MormH0Bl6A6ls/qfOeIfy4MuKe
         lgvfVpFvOlsfRrdDUfbDFYJcIaZXuu1eiZWGg/cMDhRaERChbpnoZljaXwWSRv61yOir
         HRiZf8H42A47z0ofItJPVy78sAXbqYQYlevOMeErY+L6JwLIfJOcNtCWXf9vIgwwlZV3
         bBzKvQwDUpjyU+67mFihnWquJWIpL3bZ8G5zhjFUxSCrihyS3y+/AjryPq94//ebIoE/
         LzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HRwL2T7MODfcXrlBYA8wLAi07ntXHgzSLd7OPKp/jk=;
        b=GTPUuUhDwbgqGisdCR3P6WkDadP65CISJneyje+fwj2BZPklXNkUqtn8y1q1VadMXk
         HqcyJ5nZqnxJKIkC161XD0wtXHSA92EQqxtjvBa4qJtr9Vh/075X8TLBz8vNt9xmKjxT
         pLG2YqqwkB0Vm560KrgT3H1zcjNHyYOTo06TfTBdS+DFbjz8+7j4bgZ2gJNAP32l+jLS
         2vBBnZvzn32l4k+CdznbnGnr+qjQFoYvlem+npOhZfPwOMDogywLMudZZyiMEuta6z3Q
         aLqNULRSyfxTv6SW5ImzBKgHFBAfUhYhgphH4kovW2X1g57HHRu2RwSDodoxOwbUwmFE
         c/YA==
X-Gm-Message-State: APjAAAXmBnk5zAlVS7IKUI6MspQsn4OEmM3Y0GPXZHXVv2vre4EqnqDa
        sFnJOnqLXPjtwVC6t1EUEG4=
X-Google-Smtp-Source: APXvYqzhRXk5hYxBSCcRkdkY1+qW5nAx4uWDrLMqT/gkXWwMu2BZoZ2kB0XNHhFXPBMxJU7tHFyjHg==
X-Received: by 2002:aa7:818a:: with SMTP id g10mr73363686pfi.178.1554291442922;
        Wed, 03 Apr 2019 04:37:22 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id w3sm39941393pfn.179.2019.04.03.04.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 25/32] sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Date:   Wed,  3 Apr 2019 18:34:50 +0700
Message-Id: <20190403113457.20399-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c       | 8 ++++++++
 dir.h       | 4 +++-
 sha1-name.c | 7 ++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index b2cabadf25..e6d97343f4 100644
--- a/dir.c
+++ b/dir.c
@@ -2315,6 +2315,14 @@ int file_exists(const char *f)
 	return lstat(f, &sb) == 0;
 }
 
+int repo_file_exists(struct repository *repo, const char *path)
+{
+	if (repo != the_repository)
+		BUG("do not know how to check file existence in arbitrary repo");
+
+	return file_exists(path);
+}
+
 static int cmp_icase(char a, char b)
 {
 	if (a == b)
diff --git a/dir.h b/dir.h
index e3ec26143d..47c5409ced 100644
--- a/dir.h
+++ b/dir.h
@@ -269,7 +269,9 @@ extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
 extern void clear_directory(struct dir_struct *dir);
-extern int file_exists(const char *);
+
+int repo_file_exists(struct repository *repo, const char *path);
+int file_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
diff --git a/sha1-name.c b/sha1-name.c
index d9050776dd..6caf3f4e3a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1664,11 +1664,12 @@ static void diagnose_invalid_oid_path(const char *prefix,
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(struct index_state *istate,
+static void diagnose_invalid_index_path(struct repository *r,
 					int stage,
 					const char *prefix,
 					const char *filename)
 {
+	struct index_state *istate = r->index;
 	const struct cache_entry *ce;
 	int pos;
 	unsigned namelen = strlen(filename);
@@ -1708,7 +1709,7 @@ static void diagnose_invalid_index_path(struct index_state *istate,
 			    ce_stage(ce), filename);
 	}
 
-	if (file_exists(filename))
+	if (repo_file_exists(r, filename))
 		die("Path '%s' exists on disk, but not in the index.", filename);
 	if (is_missing_file_error(errno))
 		die("Path '%s' does not exist (neither on disk nor in the index).",
@@ -1814,7 +1815,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			pos++;
 		}
 		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(repo->index, stage, prefix, cp);
+			diagnose_invalid_index_path(repo, stage, prefix, cp);
 		free(new_path);
 		return -1;
 	}
-- 
2.21.0.479.g47ac719cd3

