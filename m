Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9040120248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfDPJhU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35621 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfDPJhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so10076608pgf.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPqzv1444yrjMrDhPL+txtZC21OIjNCqHratO1l6F+4=;
        b=ANjUnfr7ud+NwB8emCHlXrTJo8R0Fw8Py+yZoI+sFjhYDq0js7NV+Rg+RTrjHtUVHs
         0bN1tdgkcbhl/L/wh7x0MyoYhZ9FYr0gN7DwxbtlI+vnBnf3tm9DV1zW0kCjPbmuQyrq
         zaCCJqyZvMYRyBIhGmD0WE+DJU/01hMTZVdDkEYIRUc/ZjW9JR1uwEv6hKvahaZLMSup
         AyAocgsAuAXcLlbOeBWNSdTrOmVhxkVq/ewMFhOGgwva0RWc+o9tg3Cj1YUxphHsdnJT
         nRuAoNoFyes5PeNVGvfG22TEswSB/wwYHSHa4Fo0mC+BcL3s9Bwz/hUfqLIgsjVnS/Sn
         pe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPqzv1444yrjMrDhPL+txtZC21OIjNCqHratO1l6F+4=;
        b=mdfbENfY6Fok+zHhanrlZCKSFwN+X4mRiAz9Yx2vFVSuSzDuGv22vO48T8VRoGsASB
         Dxv1nztKuaBz306NLBVR6rlwNwuEYc1/GoV31xR1ewdbSgNFldg2g/873SnSqdD0pm0J
         ZKfY2SR+Ul4njzu7aivrmViMfMGLg79g0zyuSwvJo3sKNUqttr6YEhWVrN8nM8fFc5/k
         voKhVKx+Ld+2dokGxKm1CaBJl9xmLSBm3uhR3TRPpQa6cH6y4w3r712NlH/Sjc+TSHLm
         nLTTcTA+gKuM8/OecBt1N4Tr/umEhL7g40AhaYg/ox4UYPqjlI2UuCpAvjebVE1xK4pp
         It/A==
X-Gm-Message-State: APjAAAWk1wJ72uvvIiFs74437xfu/+wKjVGdQvN5pq7jcN9/meS/BVz+
        J47nDqVu1jk24Qwr5yoVrtixwS7j
X-Google-Smtp-Source: APXvYqyuGL9HVmeTZrz6/S6CM3B3k9Si5dtk+Ji0eSiBG9qgBpkyQph0ULpwMtswOH8wwXR6H2Pnpg==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr21242795pfv.10.1555407438596;
        Tue, 16 Apr 2019 02:37:18 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id j4sm28175830pgi.71.2019.04.16.02.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 27/34] sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Date:   Tue, 16 Apr 2019 16:33:34 +0700
Message-Id: <20190416093341.17079-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

