Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D726207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031160AbdDTKLU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33997 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030738AbdDTKLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:19 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so14627212ioi.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQ/6F87gKPSIPur1q5OzJ+BIntsMNhnrx4RAwcbWNmc=;
        b=SlfvtS36xRdmtBtW1wdCOrLzh3E5ffiQOr6KS3qnbB22ZEJi+y0fWw72rWdnoDmt6J
         zOo6OukuJoObJDU9jukuAH+BQmBHy0Z9Y/kAxFNICtaDcPtnxCKej2v88Q18pMGtJk8M
         2/vQa6qV2Qrh15HToMG7XWs60OMQWS/kT1Io5yPyPVSn4T9oYq9w8QRxgjODeyuuNUXS
         Ro5UySXQE3EnCnf9QR/RSF7sdUDX7RmpEUCV97xhMebMVlhXIoHySO1jUYVtfri62xxq
         RQ90MZWV2n5Q/LLId/y8Eg5GbKtrnG0qMlZaNaCQOOvX0yNYYeU0+X4a7mh9Gr2EVUqW
         QoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQ/6F87gKPSIPur1q5OzJ+BIntsMNhnrx4RAwcbWNmc=;
        b=dctOJLVl3Ze3S6PJVrF9wWctsv93aavizBWC6Tb7o5DOmxBrjDsi/7fvNF/xHbiuKR
         nWHhIw9mwc5LjN5g/mPOJbq818u9Q1b/G2cQhFqWu3dBlG/wyDY+FXiyZgyKYA50x6eR
         UOTK5oL03FYZfLvIhlTRufz5q0APJ8gYjxlF8iNrLRCJFesNYklcc4gGRp790Yy1EjeF
         Nxo1PCZB5mq7MI0RwQOwAzpAw3Y+4RxfCqgnglIT5jFY92PUAfnY986sUh6tlDhuzG5c
         AciOG+A1GhyuSv0rQarPZ00DxkmDXcT0AEBqsjLK5LJnvSnq2ksVCNkWetg1vQSeKSLj
         TlNw==
X-Gm-Message-State: AN3rC/7NI1yfBc/UveiJUXvCIlnlFfhjwhMZ3Pd0guoDav7Hxjy/SkNZ
        0ynylPX3TdoG3p/0
X-Received: by 10.99.7.197 with SMTP id 188mr3219996pgh.225.1492683078284;
        Thu, 20 Apr 2017 03:11:18 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id e13sm9555573pfb.30.2017.04.20.03.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/6] worktree.c: add validate_worktree()
Date:   Thu, 20 Apr 2017 17:10:19 +0700
Message-Id: <20170420101024.7593-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
References: <20170420101024.7593-1-pclouds@gmail.com>
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
 worktree.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  5 +++++
 2 files changed, 71 insertions(+)

diff --git a/worktree.c b/worktree.c
index bae787cf8d..40cc031ac9 100644
--- a/worktree.c
+++ b/worktree.c
@@ -294,6 +294,72 @@ const char *is_worktree_locked(struct worktree *wt)
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
+	char *path;
+	int err, ret;
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
+	path = xstrdup_or_null(read_gitfile_gently(sb.buf, &err));
+	strbuf_release(&sb);
+	if (!path)
+		return report(quiet, _("'%s/.git' is not a .git file, error code %d"),
+			      wt->path, err);
+
+	ret = fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id)));
+	free(path);
+
+	if (ret)
+		return report(quiet, _("'%s' does not point back to '%s'"),
+			      wt->path, git_common_path("worktrees/%s", wt->id));
+
+	return 0;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 6bfb985203..33f7405e33 100644
--- a/worktree.h
+++ b/worktree.h
@@ -58,6 +58,11 @@ extern int is_main_worktree(const struct worktree *wt);
 extern const char *is_worktree_locked(struct worktree *wt);
 
 /*
+ * Return zero if the worktree is in good condition.
+ */
+extern int validate_worktree(const struct worktree *wt, int quiet);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
-- 
2.11.0.157.gd943d85

