Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2DF2079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966372AbcKLCY7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:59 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33634 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938607AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so3163978pgd.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLVfVTot224HnAQGnDjd4p7ZSHvSZm3T/zV6AmMTVIg=;
        b=cnIDxwNGZFsgy4sLcmqum69jOZQAPW9/iOwreumzCTJb+u52tU5T1FzKTmjdJzeFFC
         DO4Ljr06ewFL12oubXW7P8nmUjTkU4Qjfj8Lt5mQsPeYCOfDvjCChfVdcQ7n5iGv/2pt
         2vJoqsjspY94QpBsGuLNexZnbYaReteBPjkOtpsaME2uhSmoK2s2mocs3n36PTIQV5NP
         /CfMJvCuCYjb0NxXpgj9OzUgA8dEJEZ5tk0JsXcyzipfwFaaFWxzcin29tGkJwk1hEqt
         IT0gA2H2crx+IAnL4YfGxlDDDFvYf+2Cpoey9C9HqoyxxCHJpBsnujTwkt/z157yCJjv
         jLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLVfVTot224HnAQGnDjd4p7ZSHvSZm3T/zV6AmMTVIg=;
        b=f7xhZn92G0qQXzW3Lt0mZ0rmRJOwUuQll6q7ftE2/o/a7ggVZZxLnMpueIWMZDQV5U
         kVdnKqurwB698fIFQkMh86aLocUwZuLYdtG/BUppx4BEfg+E8zb8alZBX9nOfFbEfgwm
         iN0Q4gbkAPs5WpoTE0uIiWxDuPVqYMby3B6ddTywLYiMZlnRFMwY0ZkJ7bQ86DxcAGSk
         FUC4M4udQasgy5JmiKavtV9peXV2chOzVXAHt6dprgM/hPQ2pb7iqA4HFjM3nYB+2sX2
         /hfQRGONdyvVmAOgC5JmkbIPblu0LowEHxfkUdqfkVZujj8KkZ5c6Wat7hDVISkDuRPT
         DNRA==
X-Gm-Message-State: ABUngvdCF6X3m3OrGUbCFURrgPT6rfL9rF9IlZxHhezqBJycdVghihq9YyovNxmzgEtQRw==
X-Received: by 10.98.223.25 with SMTP id u25mr12892244pfg.96.1478917470395;
        Fri, 11 Nov 2016 18:24:30 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id dw3sm9192101pad.29.2016.11.11.18.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:24:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/11] worktree move: refuse to move worktrees with submodules
Date:   Sat, 12 Nov 2016 09:23:36 +0700
Message-Id: <20161112022337.13317-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules contains .git files with relative paths. After a worktree
move, these files need to be updated or they may point to nowhere.

This is a bandage patch to make sure "worktree move" don't break
people's worktrees by accident. When .git file update code is in
place, this validate_no_submodules() could be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 307019c..11be345 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -523,6 +523,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = {0};
+	int i, found_submodules = 0;
+
+	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
+		for (i = 0; i < istate.cache_nr; i++) {
+			struct cache_entry *ce = istate.cache[i];
+
+			if (S_ISGITLINK(ce->ce_mode)) {
+				found_submodules = 1;
+				break;
+			}
+		}
+	}
+	discard_index(&istate);
+
+	if (found_submodules)
+		die(_("This working tree contains submodules and cannot be moved yet"));
+}
+
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -562,6 +583,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	validate_no_submodules(wt);
+
 	if (is_directory(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
-- 
2.8.2.524.g6ff3d78

