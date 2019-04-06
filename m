Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E8A20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDFLgJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45509 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so4743333pfi.12
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaAroo8H6l5o6UF7G2ggzqIjs+ycGdPBE3mfbGzd8Qc=;
        b=ChqjZWl1C1DR22FhqCRQTUTlRI06atScMYEcppGObCQX3EtaVSsXu8Njbb5pEmPFHV
         /YTa5KUg46OjKDXKDi1ZB3lxIM88RjXtNG2PDZ8/zR7wcZUSC5qlCyhkPgqOtr343Cxh
         Osu1bZoLKJllsMjAN+eFkRP4wdOygNaC05+S0kvmDjLJ5pSgxNocXpWclziV3nMU6KF8
         4Mx9ueFnqvh288/Ju6pXU97H2he157OisyTZQML2P17Y6hqrA2tJId+Kr2OJeqUSEsE0
         +3uRgQjSI/xNJXiqRQuOZcpiPw15cRf6zmS2EayBeEzTgPfsr7EkEBswpjG2Ix/FyWXv
         o80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaAroo8H6l5o6UF7G2ggzqIjs+ycGdPBE3mfbGzd8Qc=;
        b=i1dnfL0j5Omq3jUUHiGVbVtE8p6DDm+00r4c+Aa+SYI4iaqPF4f1fkeulmBv9xQoJi
         7RwmuiRW7Ir3x7FdbNbsSB3NPrOFt0NOh7EEE3ArDXSETASJzOp9fIkw0eVJjqxKTBgy
         pebdTgGYHN8KehsRYFpJLUEnoTvlsOtnZEs41BkZx77WEsgM4cVnqnoO4N/SaCgL8eM6
         iew/K4jtWJ87WPQ9e7VqSWYRitn/jktUWB8k5YR/FmHlQLzyysIWphCdAG+9r/5ab8TM
         gbj+g52VMvelP63kfQK79NsYAzfdny+k5sOpMA1lvgAJ+WnbGlyNaYqwQj5I/B5/W4JC
         e/vg==
X-Gm-Message-State: APjAAAUUq7OVLpDiJhXZswfdsLIkxvqPTYIFNNHcVMeuhE7L+YCyzs2M
        j5S28O8nSokd8Adxzm7oJCjGzsAX
X-Google-Smtp-Source: APXvYqzShfzyPqVnmmY+OCi/Kb18foUhYqOQSMq5c42TKtlWOKeWmXgwsVa6x0YOR3UHV0z5MSw6Bg==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr16553524pgr.403.1554550568526;
        Sat, 06 Apr 2019 04:36:08 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id p189sm18997567pfg.184.2019.04.06.04.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 10/33] refs.c: remove the_repo from read_ref_at()
Date:   Sat,  6 Apr 2019 18:34:30 +0700
Message-Id: <20190406113453.5149-11-pclouds@gmail.com>
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

