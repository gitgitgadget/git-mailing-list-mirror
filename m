Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2824720380
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDCLf6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37846 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so3831298pgc.4
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaAroo8H6l5o6UF7G2ggzqIjs+ycGdPBE3mfbGzd8Qc=;
        b=VFk8cx1ZrhHh7VDn8V1fnKDdtTDSA6oVoXBY7OYH5cyQblqipr1qgZA8HwPaJusLC5
         NZhdmtCfC59PHy3Wx8DyJKT/EY+W/B0W2zHpqCZE6Bq/zNkt0apWCAsqdC5O7iogEKA0
         azytjXDUTjbJ+5h5nkCg6+laiRnDglG0nsMTXtOYpHH+TNaG+YbG5ceZ0V94clDLE+A0
         waGpl3hJ5WBEwHOfFEhL7Ez4JBZ4NSlOJ4FZYprkSltLHQaCvUv01NcPNE4R60pqsas9
         srPn/+catrR7sl5/pLiEkOqSmSX9F7xjb6h8xOmk7lO8F6+ihvNjTPALoU+pDPL4zQ+2
         UXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaAroo8H6l5o6UF7G2ggzqIjs+ycGdPBE3mfbGzd8Qc=;
        b=EaGLoLkbWlv1zb9mJZzV51h96bIfEdm/SBli9S3k7TDQMY4NngD6+wDgjdTXY8Gmm/
         TkajRrcK7pweZje4WeJQMVgsqT+VB9rpNzioR4km79BMnLdaV0GjZG+T4nGU085eO/nx
         1wp7aYIkrR7O8MvyeKCrOEO0u/oBjYYxZh0bJbX5l1+p/JImHKawNf65PjHUBvL2PNMw
         0LdvNv/kSHCGeJIWpqgtYBYcCaukPw/+pWGSnrVJ88wpwTlfFGBpIlmAujuuFx6xYXaz
         0iUCjxGg8eAg+lhCfyDi3TimF5CYO11cn3L3gzZtZnRpSqu8E8WMHoDBYglBR6jhHADn
         m73Q==
X-Gm-Message-State: APjAAAVR0OKtd7gx29kfVH4gjegzIOSe4geDFrYNc3yQNL418zwFXMyc
        MafHmgG2nAIfVWxkAQsGEfw=
X-Google-Smtp-Source: APXvYqz+Nk/SJWpNjXHIQsQPqvUC1Eflq3LcYcYGrTGJ6fAkao++anN9bP9NDomljep3dO0YsMuVIw==
X-Received: by 2002:a63:3185:: with SMTP id x127mr72136869pgx.299.1554291357209;
        Wed, 03 Apr 2019 04:35:57 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id i13sm19354706pgq.17.2019.04.03.04.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:56 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 09/32] refs.c: remove the_repo from read_ref_at()
Date:   Wed,  3 Apr 2019 18:34:34 +0700
Message-Id: <20190403113457.20399-10-pclouds@gmail.com>
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
 builtin/show-branch.c | 6 ++++--
 refs.c                | 7 ++++---
 refs.h                | 3 ++-
 sha1-name.c           | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 934e514944..082daeac32 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -753,7 +753,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				timestamp_t at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, flags, at, -1, &oid, NULL,
+				read_ref_at(get_main_ref_store(the_repository),
+					    ref, flags, at, -1, &oid, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -765,7 +766,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			timestamp_t timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg,
+			if (read_ref_at(get_main_ref_store(the_repository),
+					ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
diff --git a/refs.c b/refs.c
index edea001446..92d1f6dbdd 100644
--- a/refs.c
+++ b/refs.c
@@ -967,7 +967,8 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
+int read_ref_at(struct ref_store *refs, const char *refname,
+		unsigned int flags, timestamp_t at_time, int cnt,
 		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
@@ -983,7 +984,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
-	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
+	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
 		if (flags & GET_OID_QUIETLY)
@@ -994,7 +995,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	if (cb.found_it)
 		return 0;
 
-	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
+	refs_for_each_reflog_ent(refs, refname, read_ref_at_ent_oldest, &cb);
 
 	return 1;
 }
diff --git a/refs.h b/refs.h
index 859dffe691..8f9cbf8a93 100644
--- a/refs.h
+++ b/refs.h
@@ -388,7 +388,8 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
 int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
-int read_ref_at(const char *refname, unsigned int flags,
+int read_ref_at(struct ref_store *refs,
+		const char *refname, unsigned int flags,
 		timestamp_t at_time, int cnt,
 		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
diff --git a/sha1-name.c b/sha1-name.c
index d535bb82f7..15a1107998 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -849,7 +849,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
+		if (read_ref_at(get_main_ref_store(the_repository),
+				real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
-- 
2.21.0.479.g47ac719cd3

