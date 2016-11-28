Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80FC1FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbcK1JoQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36234 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbcK1JoO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id x23so12689608pgx.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQ+eFyCaV1Md1dAhajF0EQaPOQKIgQc8B3Be8fLnIlA=;
        b=D62rIauoZfdqgOmtOH1wyeVHkIVfVYuH6Y3XdsXl81fHlI5OjH7HDaKRKevUSAWUfT
         TnQUUEokkWJGXwtWHyMO5yUxqH9dLC4S8uHS5k6bO18lDnJrQ1L53dX59b95AFW9kLY7
         1o6oE25ftQcThben2wThnBEEGONGZEhVJl2QzV7Gks52k673RPPzLLOCQLZnqJYdnNqo
         x3HpqZeI6MDhVoTmcswarlh3yQ0PdwuTXc/ODRpKwsT7/33FceKaEF4clZaVsfIbFO+f
         WLwNUG+GNvi/YZqnOEqmG7zCjEGNrNL0CClEV3PPSb6ozabJQP/CjHhaDF3VMvm3wuPd
         OTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQ+eFyCaV1Md1dAhajF0EQaPOQKIgQc8B3Be8fLnIlA=;
        b=W78sWrsRVrLQlnNgBce/xCz3T7PfDXnjIUSGabUgVIGXahZK2BrWXtjZ3l3CYIG7YQ
         a7zKfhP2WA7hOh/48ExH2JhZFtdlEvDtY2nwNAAjHXyVJe9uopZJX2nOd0w2+LEmgHv8
         s8BO1xwign+A2ap3+8ZpBqpyRNIqxi8ehabbwJbxEOHO7pnXum+kw0tKEmFyK/UrbR/j
         gUJUQf/v+qkv5cF3u8G2axx412/urdfqOWxBT16AyIS+5Dl8cicPGFP9tLK4OBhF5UIT
         MZZUEzdsMDpcjFwrjXODsY41bTbv/vVAppJOpxmJesSjZ/iNR6liNPt2zd/x5YQBkG6N
         rp6g==
X-Gm-Message-State: AKaTC015nmwX1DEFEJFGyCCTTZ5E9XkgI2Fn5RJdINVtFK8yK+XQwvXbDJxwOUxAEDVL2w==
X-Received: by 10.84.172.131 with SMTP id n3mr46565812plb.5.1480326253641;
        Mon, 28 Nov 2016 01:44:13 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id 16sm85775430pfy.4.2016.11.28.01.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:44:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:44:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/11] worktree.c: add validate_worktree()
Date:   Mon, 28 Nov 2016 16:43:14 +0700
Message-Id: <20161128094319.16176-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree. For example, if a worktree is moved manually, the
worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
incorrect and we should not move that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  5 +++++
 2 files changed, 68 insertions(+)

diff --git a/worktree.c b/worktree.c
index eb61212..929072a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -291,6 +291,69 @@ const char *is_worktree_locked(struct worktree *wt)
 	return wt->lock_reason;
 }
 
+static int report(int quiet, const char *fmt, ...)
+{
+	va_list params;
+
+	if (quiet)
+		return -1;
+
+	va_start(params, fmt);
+	vfprintf(stderr, fmt, params);
+	fputc('\n', stderr);
+	va_end(params);
+	return -1;
+}
+
+int validate_worktree(const struct worktree *wt, int quiet)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *path;
+	int err;
+
+	if (is_main_worktree(wt)) {
+		/*
+		 * Main worktree using .git file to point to the
+		 * repository would make it impossible to know where
+		 * the actual worktree is if this function is executed
+		 * from another worktree. No .git file support for now.
+		 */
+		strbuf_addf(&sb, "%s/.git", wt->path);
+		if (!is_directory(sb.buf)) {
+			strbuf_release(&sb);
+			return report(quiet, _("'%s/.git' at main worktree is not the repository directory"),
+				      wt->path);
+		}
+		return 0;
+	}
+
+	/*
+	 * Make sure "gitdir" file points to a real .git file and that
+	 * file points back here.
+	 */
+	if (!is_absolute_path(wt->path))
+		return report(quiet, _("'%s' file does not contain absolute path to the worktree location"),
+			      git_common_path("worktrees/%s/gitdir", wt->id));
+
+	strbuf_addf(&sb, "%s/.git", wt->path);
+	if (!file_exists(sb.buf)) {
+		strbuf_release(&sb);
+		return report(quiet, _("'%s/.git' does not exist"), wt->path);
+	}
+
+	path = read_gitfile_gently(sb.buf, &err);
+	strbuf_release(&sb);
+	if (!path)
+		return report(quiet, _("'%s/.git' is not a .git file, error code %d"),
+			      wt->path, err);
+
+	if (fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id))))
+		return report(quiet, _("'%s' does not point back to"),
+			      wt->path, git_common_path("worktrees/%s", wt->id));
+
+	return 0;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index d59ce1f..4433db2 100644
--- a/worktree.h
+++ b/worktree.h
@@ -52,6 +52,11 @@ extern int is_main_worktree(const struct worktree *wt);
  */
 extern const char *is_worktree_locked(struct worktree *wt);
 
+/*
+ * Return zero if the worktree is in good condition.
+ */
+extern int validate_worktree(const struct worktree *wt, int quiet);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.8.2.524.g6ff3d78

