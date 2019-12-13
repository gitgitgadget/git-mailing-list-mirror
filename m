Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9466AC2D0CD
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DB224658
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyNDoypZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfLMIIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37851 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLMIIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so5618598wru.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VT9oSHUP0RKB+EtGYSHiqIDVovWaaPzNGKQuJobuqtQ=;
        b=qyNDoypZpJxUmLVkzf1c9Z8Y4/1yQr+62F3ETYKXCNQTihSN5OB2szCISqU5WOsaqw
         FPVzVFd7QYqDYtnnYgK364eR8IojRL/VPvTUYqucyImiN70+WgVKDLqExEnv3oF1ZGPH
         bfLCz0tc1meWbn/MedYXiH+jOa/0Tdxuk5kIg3V4/aknf0Pu6zB+EeH9sbdKI6hlfJCG
         lxtfaKauGDGsXQrf51Ou4P64tQjVW5PZq06EF8D5HiHJtAH2Npd5iUltt9FUzyQwXl5X
         fVLmsq8ovTH3gdTu3GXM6iHUSd09BlDr+gWEYdiFFiDpZuq1/iXpZeScb3Ub65C403N3
         Srhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VT9oSHUP0RKB+EtGYSHiqIDVovWaaPzNGKQuJobuqtQ=;
        b=Ylp/PmTeGDlY7IwchWGZ8nt6ZTW3iDrpXBdNOgg+UvMCVVKZ210bUX/Pt7gR2IaL9v
         Usv1BOKsazolT0dliyNU5iRe8kTgCdT8PlcoIObiqqV8gRAql6IkCNfF2hAGsj8fSFxq
         RHJYMst8TP6TBLe6CAYJHQjLaye0Ol186kPm47U6ugB+aKsi5wjEn5m7hGGkCZmZJlFd
         dGfI0a0t5hsWjn31l8XbzosUbPo4St0JLk/6AY+aiswltuUlI3PwzGnSIX2F8eK4l+m6
         QaFaBfw/15WCuWZYvAgsK78CKbI9HPca+m9nOkfrJStX5rBZfKqE9wvG6qjrFUYD3KOW
         zfuw==
X-Gm-Message-State: APjAAAX1kk4cdzyGsVkmpCHBhL/dlswtaYwG87rHvBYtFvJElBJvszoG
        lKcqyEK3r9+pLX3nUnRvOnlJpZpl
X-Google-Smtp-Source: APXvYqzpHZeELeUkBFAcCi2aZit6dL7MzkPuI0xer1bb4iDQFUEVAb3Ed0RZduPVtlWL8Y/xqjg4wA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr11420789wrw.188.1576224498369;
        Fri, 13 Dec 2019 00:08:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm559527wmj.13.2019.12.13.00.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:17 -0800 (PST)
Message-Id: <18c008fbe119036700faf2a82711c2b0f453df6a.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:08:00 +0000
Subject: [PATCH 13/19] strbuf: add a helper function to call the editor "on an
 strbuf"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This helper supports the scenario where Git has a populated `strbuf` and
wants to let the user edit it interactively.

In `git add -p`, we will use this to allow interactive hunk editing: the
diff hunks are already in memory, but we need to write them out to a
file so that an editor can be launched, then read everything back once
the user is done editing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c | 28 ++++++++++++++++++++++++++++
 strbuf.h | 11 +++++++++++
 2 files changed, 39 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index aa48d179a9..f19da55b07 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1125,3 +1125,31 @@ int strbuf_normalize_path(struct strbuf *src)
 	strbuf_release(&dst);
 	return 0;
 }
+
+int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+			      const char *const *env)
+{
+	char *path2 = NULL;
+	int fd, res = 0;
+
+	if (!is_absolute_path(path))
+		path = path2 = xstrdup(git_path("%s", path));
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		res = error_errno(_("could not open '%s' for writing"), path);
+	else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
+		res = error_errno(_("could not write to '%s'"), path);
+		close(fd);
+	} else if (close(fd) < 0)
+		res = error_errno(_("could not close '%s'"), path);
+	else {
+		strbuf_reset(buffer);
+		if (launch_editor(path, buffer, env) < 0)
+			res = error_errno(_("could not edit '%s'"), path);
+		unlink(path);
+	}
+
+	free(path2);
+	return res;
+}
diff --git a/strbuf.h b/strbuf.h
index 84cf969721..bfa66569a4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -621,6 +621,17 @@ int launch_editor(const char *path, struct strbuf *buffer,
 int launch_sequence_editor(const char *path, struct strbuf *buffer,
 			   const char *const *env);
 
+/*
+ * In contrast to `launch_editor()`, this function writes out the contents
+ * of the specified file first, then clears the `buffer`, then launches
+ * the editor and reads back in the file contents into the `buffer`.
+ * Finally, it deletes the temporary file.
+ *
+ * If `path` is relative, it refers to a file in the `.git` directory.
+ */
+int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+			      const char *const *env);
+
 void strbuf_add_lines(struct strbuf *sb,
 		      const char *prefix,
 		      const char *buf,
-- 
gitgitgadget

