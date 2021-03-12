Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFDFC433E9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CD564F71
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhCLWsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhCLWsU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:48:20 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F721C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:20 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id by2so5071986qvb.11
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuNUDaKcKhHhkaHDqTZ+FOp5Z3Q+j2cjfVlmgT9kqzI=;
        b=kVHPR0H5Een6nOSX0EXY4wvVX8C7WECmLiN168++Ejm+LM1MZhOA1vrvoEyqRFjs1s
         /z06IgsmJV7OMeOHAoKMGyivu3Ch+0z46hw5T1Oo30Z/7A4yDnZndTenygW1ePSU0Plw
         6+TAwPx0vtv5X1cn1rrhfh1SD9/2yu9QWoa+LElkxKfZk5ep2S7KSrhex3Vp2bqLDEHO
         6FawkZVKUGSWYt/QXxFDGsDi3aS/IpbLgtLcDDwyJpxD5ROPmnnWQZHBpBckSEVy0ig8
         XuUfxNDMa7hAFYzCZ4HObQ3XmxbgB7NOcgnhKvylDDiHqgXzI1ybAEAFdPhtLS0lyiWj
         e9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuNUDaKcKhHhkaHDqTZ+FOp5Z3Q+j2cjfVlmgT9kqzI=;
        b=R2Lg2IH6OqIptWzjl8J+4/upfBjWtL/yEzQQzCwgWCpW5NoKFBEtIncizZRoP9RdMI
         lmsY+3PGEFnT2OQEVOd9u1yvXeOUst606f2/vAbHAW8qubx7RTG4dysEgoAnhogUzdPf
         oR9Ox3193RkkVNZGUJqD9+LpymtcZOLTmmJe3TDfo1lNIp5rs5BmWfPmXOyD0RHxp2UB
         VcW82f6mCv2R7JD9IRXkSqgHIXQXJESQymle0sqNK64uR3nusYakbVaVguYqR+W8fDgA
         yiMubYT88OugpRZ0QFMEJa08zsaln3NtPSraFzXtkS70LPcQArsisfdqPtDFliA7jkdI
         OOfg==
X-Gm-Message-State: AOAM530J0nSVIclYAWbmns3xcaYR6Y2VNLi8A19rjd6PPJ3zSMdrEUNw
        dhA+QVR+Gb/eEUudW9cbKh0Oq4T0LaF75A==
X-Google-Smtp-Source: ABdhPJxO/H7GfBU1DrhYFBMt8CfMqi2ykR/G5+8PW5Q8++CrYabu0pHP8d5Z3xppPgR0m7NdqY6FJw==
X-Received: by 2002:a0c:e90d:: with SMTP id a13mr14481307qvo.36.1615589299122;
        Fri, 12 Mar 2021 14:48:19 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j1sm4870400qti.55.2021.03.12.14.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:48:18 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH v3 5/7] refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
Date:   Fri, 12 Mar 2021 19:48:00 -0300
Message-Id: <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
References: <cover.1615588108.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refresh_index() optionally takes a seen[] array to mark the pathspec
items that had matches in the index. This is used by `git add --refresh`
to find out if there was any pathspec without matches, and display an
error accordingly.

In the following patch, `git add` will also learn to warn about
pathspecs that match no eligible path for updating, but do match sparse
entries. For that, we will need a seen[] array marked exclusively with
matches from dense entries. To avoid having to call ce_path_match()
again for these entries after refresh_index() returns, add a flag that
implements this restriction inside the function itself.

Note that refresh_index() does not update sparse entries, regardless of
passing the flag or not. The flag only controls whether matches with
these entries should appear in the seen[] array.

While we are here, also realign the REFRESH_* flags and convert the hex
values to the more natural bit shift format, which makes it easier to
spot holes.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 cache.h      | 15 ++++++++-------
 read-cache.c |  5 ++++-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 6fda8091f1..0b6074d49e 100644
--- a/cache.h
+++ b/cache.h
@@ -879,13 +879,14 @@ int match_stat_data_racy(const struct index_state *istate,
 
 void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
 
-#define REFRESH_REALLY		0x0001	/* ignore_valid */
-#define REFRESH_UNMERGED	0x0002	/* allow unmerged */
-#define REFRESH_QUIET		0x0004	/* be quiet about it */
-#define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
-#define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
-#define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
-#define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
+#define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
+#define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
+#define REFRESH_QUIET                    (1 << 2) /* be quiet about it */
+#define REFRESH_IGNORE_MISSING           (1 << 3) /* ignore non-existent */
+#define REFRESH_IGNORE_SUBMODULES        (1 << 4) /* ignore submodules */
+#define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
+#define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
+#define REFRESH_DONT_MARK_SPARSE_MATCHES (1 << 7) /* don't mark sparse entries' matches on seen[] */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 /*
  * Refresh the index and write it to disk.
diff --git a/read-cache.c b/read-cache.c
index 1e9a50c6c7..0bf7c64eff 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1514,6 +1514,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
+	int no_sparse_on_seen = (flags & REFRESH_DONT_MARK_SPARSE_MATCHES) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = (CE_MATCH_REFRESH |
@@ -1552,12 +1553,14 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		int filtered = 0;
 		int t2_did_lstat = 0;
 		int t2_did_scan = 0;
+		char *cur_seen;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
+		cur_seen = no_sparse_on_seen && ce_skip_worktree(ce) ? NULL : seen;
+		if (pathspec && !ce_path_match(istate, ce, pathspec, cur_seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
-- 
2.30.1

