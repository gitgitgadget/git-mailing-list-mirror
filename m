Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C01AC2D0D5
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2C3206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO46SBV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfLXTzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33363 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLXTzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so18677196edq.0
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cVdPlPILZi1d/pQbIp22+mGbtwH6yjwXLa5cYI0NUSM=;
        b=dO46SBV/d7BUSXYHzTuVQu3TYCy6p6Y7JfRK5DUkmDT0Iujue3WvlRlnTif51gtOzd
         rmee7n23F17hSNz++6lcRWSKUaSYkZihRehRuJSLszYqmB9sfj/PD5ugVr08BgsMuaIq
         mEeHnOKbeqgp0Vxd+gz0tcFxb5R/qgeYd0IM+MJ+1Ix6Ui2iudGXL+bH3XJVpMkngJlg
         gjjJoZiCF7AfjsYnqDTOOIHNmaSjMjoiFZQzhfak+FPthlAXnpmQZtj+BuXayXutTwiO
         D5tDnfagcKlxDaj7+ACIuf+AFNSvPJLBGFRiX8E7Lec/tzWzOjw+gMvyIRzokN7k2cyq
         EgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cVdPlPILZi1d/pQbIp22+mGbtwH6yjwXLa5cYI0NUSM=;
        b=YaoZzurGUjn7G1KdNmN9OaxFsGx6c4L1RChM+rvSsTxbi4Zvgyw/K11PgbcgY1oqiw
         5G/rPeaiP+TIYjOckEHLIFL/9fAtQKdSgdaldlWuBmDjgTu0AQEkinhq+tNibs9Gvevd
         fkuG586yQZ5j8vjw3k+ncW/S1yvq5NynVSZlveN/hPCjo7rNlO5oy/vu4qI8SWeWg7YG
         qPXe/B4SmZPbMGYYlPY9jlBFwLo0VUUz6OALM0ThjQVC1JMMWUK4/7UQhb5bdpL4Q9iq
         48JUmHEAq4W9ynxHs0+ZYGLZSwvhpfF6rVIrFHTjpp+FPZGH0tCDIaUJR4Q2SPm/8i1b
         p+JA==
X-Gm-Message-State: APjAAAXlbeCEyUKcNrvXdiu/ejJ9BOUiVGjpDANWiURqi7xzO4GPQu53
        evVly8XC+3jiVyT445YQ/5X9+NtV
X-Google-Smtp-Source: APXvYqyt9/i8Dos1V+rcdG/r5lxzJEFSsV5P4ZweBu/a1XqLEIuwbULaC6+jMqSiFlnZVgeVupFeUg==
X-Received: by 2002:a17:906:948e:: with SMTP id t14mr39618528ejx.123.1577217308214;
        Tue, 24 Dec 2019 11:55:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm1654298ejl.5.2019.12.24.11.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:07 -0800 (PST)
Message-Id: <7c3f2e07f3d388730f2a2ba48c70ad1590a91d99.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:53 +0000
Subject: [PATCH v3 09/15] rebase: move incompatibility checks between backend
 options a bit earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7027e34567..d2b99e9908 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1906,6 +1906,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
+	if (options.git_am_opts.argc) {
+		/* all am options except -q are compatible only with --am */
+		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
+			if (strcmp(options.git_am_opts.argv[i], "-q"))
+				break;
+
+		if (is_interactive(&options) && i >= 0)
+			die(_("cannot combine am options with either "
+			      "interactive or merge options"));
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1936,17 +1947,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (reschedule_failed_exec >= 0)
 		options.reschedule_failed_exec = reschedule_failed_exec;
 
-	if (options.git_am_opts.argc) {
-		/* all am options except -q are compatible only with --am */
-		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.argv[i], "-q"))
-				break;
-
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
-	}
-
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
-- 
gitgitgadget

