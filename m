Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA0220248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfDPJf0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46841 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so10030196pll.13
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdT4xFz+irPOEmQPKlD6f536lXBUMNQ6Vo6NmwoQVSw=;
        b=bCpjl03gaTR/s6UMB3VVoboMse3C5nhsx0HkPOTGn89dM7Rel8GRPcnWw6psnTmgAA
         xflNxxXU5G64grqWgPIIibtC4rnajetKn02R0HXIYD97pG56zC4m3PsrPTwkae5/It8o
         seO/lDueFJ0ZjOJkiZWMvvpd3IEGd6tGgXQm6rMYrSO4ZxTy/zllAaWgTUDMEv9yg9Dh
         gRbJTk2s3Oj9phqL95BmiDV3cvD5S1/wcn6fGI/06fdXomDrHXRBBVXGGxBXDHXTKe2b
         GBlYYO84Vg5PiZXAFTUjaRoHG5p0mbQqFsuwCNlxFx7kyVoveqsX5JYXKdIcswjPEJZB
         rNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdT4xFz+irPOEmQPKlD6f536lXBUMNQ6Vo6NmwoQVSw=;
        b=o2fPEUYzeWHAadz7x/F4ERhSPbLGJ7H6rz15HgoWa2qhw2nC3Fs3AVdHoQh7xWOFno
         c1euOaujLhOOO6IjtIYFs5yv+tUK/4I1WRNg8b6d1m7466nNdR+A3HsYNgdcNe57PyGd
         diSO7Te0XcI2mEMdIqqfl8DCfQjuH81dI3VhTF2jsVeZgJh9KvVNaiNflQBF3Rwcmc/P
         w0XFiFPYmw0/fmI6oHJv1O++uk/M4O2F0Yp0juOT+v8bn+uks/18dBAjBGPtxZ9g/kG5
         XhoAl9u3fzIunXk/PfahsQnQkwpvmg9rpdl7m9vfj6nPjqY+ENkARjIfodfWa9s/Fkqw
         eP7Q==
X-Gm-Message-State: APjAAAWshyewfAV71V7NuCWjKeA9ddel/xH4ZdQDB6GV/RSWrcjoo/7Q
        PXD8cbQs7g/N0axgbXiUmPs=
X-Google-Smtp-Source: APXvYqw+FAI2iQX1Pfc6gUZUbR1BJR+yE7Agoy4/Us9qHRvl1C1Iz6jRZL7x/cOi9nMTDnn3Hjc2oA==
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11mr16423236plk.266.1555407325185;
        Tue, 16 Apr 2019 02:35:25 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id f7sm86557702pga.56.2019.04.16.02.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 10/34] refs.c: remove the_repo from read_ref_at()
Date:   Tue, 16 Apr 2019 16:33:17 +0700
Message-Id: <20190416093341.17079-11-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

