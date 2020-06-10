Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A166C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A81820760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWyr+mCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFJGb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFJGb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:31:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D2C03E96F
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:31:57 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so890991iob.12
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPtcdgftzoBqPW91YoLmZSnHgjxijrfF1mPTpDpKyk0=;
        b=IWyr+mCU2W9F0zEpgVo/K+lZwiT0j+kopa1XPjNBqsy1VaY4kMeP3SW+CopxqrXxNX
         pL51LhP9ybXbAIrj87+t79opTGAg01nUcRT6lCugIPMTX3bNqFqDH73wbzx8kNJmtyIZ
         42qMSNz/lchqlKIPgg/MfWjHg4GPyTKZouNYKnWTASNn5FWDbx8c1BC4hOBNIdoCUOb8
         JF6dGRy3OMzTHAd9g8S+jjKOLfrDhDBomHFvlWHUc1DX1Xpw0YqUc8HqqCYlA38taIm3
         MPa7B+QQFwNqxUlTbg9Fa/xjTFoIlFDR+1L8pWo7cGiBSC6kEa3t51KrthCYwS/jBLdA
         gzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XPtcdgftzoBqPW91YoLmZSnHgjxijrfF1mPTpDpKyk0=;
        b=pEPM+WTnyufqBHoyTeVMDPwFFBuYXY1h2Epn8O/D684mDXl5WM8Zx50TO2oxwIw1tr
         Qrv0qgslTKyOWO/286FOTkoDAUg/Nn+uVC0MKowjclSWl4wKHrCR1ExKVbkX22paP7t0
         8cRGb4DhMkFlI2FCo1NmfKygWE/scl2jqgxOv60tVTRh68LdcHoI7d1VUDAM6KCxjwGr
         qGIDpiU6sVO4f4KyslTdvo4SPcT5vU59yFI2i0HjobpgcEfZfhW/kFwJVerMmrD3E4Cs
         9vAovuOR8oaDR5cfDk65fBTi9+PJ3q6tNpUvDDlR3Uul5DJpvbY45kw0BNPMqPilMeb6
         QYbA==
X-Gm-Message-State: AOAM530FX2sfTPXbF0XNh2ux9fZhOqgSfDIZTf8oY52wBG1gqsdWaCiQ
        R/rEIhkQzezBc3M0HCPUMiIaCklZno0=
X-Google-Smtp-Source: ABdhPJwbsUEbcWXj8pbs07zx1gOWGhcJMznQxUM4RuULrAbSfHd/U5wu1RDkNmG/FEOh4t5EN79jtw==
X-Received: by 2002:a6b:6414:: with SMTP id t20mr1832316iog.101.1591770716014;
        Tue, 09 Jun 2020 23:31:56 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.31.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:31:55 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/7] worktree: factor out repeated string literal
Date:   Wed, 10 Jun 2020 02:30:43 -0400
Message-Id: <20200610063049.74666-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200610063049.74666-1-sunshine@sunshineco.com>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For each worktree removed by "git worktree prune", it reports the reason
for the removal. All reasons share the common prefix "Removing
worktrees/%s:". As new removal reasons are added, this prefix needs to
be duplicated, which is error-prone and potentially cumbersome.
Therefore, factor out the common prefix.

Although this change seems to increase the "sentence lego quotient", it
should be reasonably safe, as the reason for removal is a distinct
clause, not strictly related to the prefix. Moreover, the "worktrees" in
"Removing worktrees/%s:" is a path literal which ought not be localized,
so by factoring it out, we can more easily avoid exposing that path
fragment to translators.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d99db35668..9b15f19fc5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -76,19 +76,19 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	ssize_t read_result;
 
 	if (!is_directory(git_path("worktrees/%s", id))) {
-		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
+		strbuf_addstr(reason, _("not a valid directory"));
 		return 1;
 	}
 	if (file_exists(git_path("worktrees/%s/locked", id)))
 		return 0;
 	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
-		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not exist"), id);
+		strbuf_addstr(reason, _("gitdir file does not exist"));
 		return 1;
 	}
 	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
 		return 1;
 	}
 	len = xsize_t(st.st_size);
@@ -96,8 +96,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 
 	read_result = read_in_full(fd, path, len);
 	if (read_result < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
 		close(fd);
 		free(path);
 		return 1;
@@ -106,15 +106,15 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 
 	if (read_result != len) {
 		strbuf_addf(reason,
-			    _("Removing worktrees/%s: short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
-			    id, (uintmax_t)len, (uintmax_t)read_result);
+			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
+			    (uintmax_t)len, (uintmax_t)read_result);
 		free(path);
 		return 1;
 	}
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
-		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"), id);
+		strbuf_addstr(reason, _("invalid gitdir file"));
 		free(path);
 		return 1;
 	}
@@ -123,7 +123,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 		free(path);
 		if (stat(git_path("worktrees/%s/index", id), &st) ||
 		    st.st_mtime <= expire) {
-			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
+			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
 			return 1;
 		} else {
 			return 0;
@@ -147,7 +147,8 @@ static void prune_worktrees(void)
 		if (!prune_worktree(d->d_name, &reason))
 			continue;
 		if (show_only || verbose)
-			printf("%s\n", reason.buf);
+			printf_ln(_("Removing %s/%s: %s"),
+				  "worktrees", d->d_name, reason.buf);
 		if (show_only)
 			continue;
 		delete_git_dir(d->d_name);
-- 
2.27.0.90.gabb59f83a2

