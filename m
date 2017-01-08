Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3D01FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934075AbdAHJkn (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:40:43 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33871 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934184AbdAHJk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 04:40:27 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so1441771pfb.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 01:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQ+eFyCaV1Md1dAhajF0EQaPOQKIgQc8B3Be8fLnIlA=;
        b=dyqD48iwQNsdklLoFiRGvKXJhgIsFg4PoOuKVfvbdRcuJb3bi1U6qDrwlbRt3NSUvb
         ec51H84nB5d5El6e5RWNcnax3PV0Kok3IhSljNR9WS6hjznJWw/i4Gm1fkwI5IN1VWw+
         2+3EjatmfzWsvkxljLpdNsmXmLWzZ+y8JvsJ7xI2dUUH8pAv53Bg3g6J0W/ZCXOkz5RV
         p7ThJWGhFo78nYJ0g6/TsJ7rApY/AVer65Tjvx3HIw5iD0yfVA/R8LUV4WYa1j5OZSkD
         WnqoUzp/VVOPC45Z7eU5AUKbI2pWjXgy3HZB2R1VaByjKNXC8NhEeJTcgdqUyChHLGCr
         CNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQ+eFyCaV1Md1dAhajF0EQaPOQKIgQc8B3Be8fLnIlA=;
        b=oT8KXjUuHnN1NcUE/NwNmp3vd5UolRJg8uMLGIT/YeHaBTkvPoMja8aX+M07IZh34l
         hFf70TWVcAUjueQ9RH9NhQfMgVXQX/yVwshGk4428b5ZE+tZQKK2e0O1vD2pERLi0FAs
         HJjUv1iR4b6CBZyGT9G3fexHRyJQalzrDLdOKwZMJFcX+0okSq4MirX7PcK++p6NLHlj
         q810vEQGwEGZ4vGcSsXV2E8YshWP32zD9tbGLfs2lOf5jne4ZVwSH+nJ2++5jcYMnBBf
         Hi0LwON199kfP98yhmUck48iRJFrm2l06ybN+1k0hyWs7e/8sAtI7JShzDgN8fdrZvLO
         HOvg==
X-Gm-Message-State: AIkVDXI3xNj/EcfgokdWIpFyD7cq7rODc1WFPUIxIs46bzjzytEWhFh5GeFGaff6MJN2Uw==
X-Received: by 10.99.120.203 with SMTP id t194mr1137239pgc.55.1483868426424;
        Sun, 08 Jan 2017 01:40:26 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id a24sm170808054pfh.57.2017.01.08.01.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 01:40:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 16:40:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/6] worktree.c: add validate_worktree()
Date:   Sun,  8 Jan 2017 16:39:58 +0700
Message-Id: <20170108094003.637-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170108094003.637-1-pclouds@gmail.com>
References: <20170108094003.637-1-pclouds@gmail.com>
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

