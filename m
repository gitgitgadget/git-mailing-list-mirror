Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA26C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4924692
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHM3kvSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgCJNLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34833 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgCJNLf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so15835248wro.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XTU2wfaaH8f7sxDLfC++czLuzfn0gJFeR4c4RRnX2Eg=;
        b=CHM3kvSvmj5/nFQxoB/QEPpXr9YnkyfXizNAavNwyf1ElHmxiAetFcISreghm/AGaq
         imxjzVr21ZB545GuTaT9mPhczmjt362el24yhNrfwFAbvJSkadKwVOBkLkyMiQ8Gs3Jd
         Jn/PbUrXbIvwfOa9NzgOp3ZBh1a5GnZM5ESLJ4ktRvKrHNWUgv/fsW+yahA0z9nSXsud
         g3H9CxP14XN5AX3KEGLr/9pJ4p090Jsmyt3YHveijR9rfSvuNdVGrkqqwYqaIa3luMTX
         +U5m3XMbhyq/NIOq9z5KiMKB91KTykKu7mD1tNsVDRb78oZDOcqGmqMQVKbnZME0wU0L
         V6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XTU2wfaaH8f7sxDLfC++czLuzfn0gJFeR4c4RRnX2Eg=;
        b=MMX3eXNjAmFV3c5s4Jhp7xYD5CMvsCyIClFfoePRAnytV5A/jHFe0M1gZWHb+rUYUe
         bV55vx7l/BUx0j5q/yiNqUCRwxrGagp6tjYe0RX5XQwPr7GtzGssqK3gxQS39s2rfkVy
         8iFr1Zm/Vjo8Zmmax8cv6tYNe2zZ6jhrXjtwCWu4Lu9mMkEoEO1UvHPHnJC3lAjWnXBU
         Xf08D6bTQ4/QpQ/SMrsaz4htH+HFD6hYcjT8Wa0UjsW46Ij4DJdgU5hkTnfm9N31VjGl
         tSpMWZluWHaLwkVxYsOLemiOVxRaIGFBvt2eMJZmoRp/KMmxODo0Ke9AggmG3pIlac9q
         1JAg==
X-Gm-Message-State: ANhLgQ1wEZK6n6NiqGwTbtspzDdZG+C0KRONDas6B4WX9xcmoFMBO1gJ
        YsjucdGz3Oix20qcIFtx0RKGJj9u
X-Google-Smtp-Source: ADFU+vvpTpd/Qn5QJQ3U3WnUcf1VQAtkOnFsiO+VM01zZtP7RFZuw56srvWTZ13ucGsjCrsciPxnKA==
X-Received: by 2002:a5d:69cc:: with SMTP id s12mr14131141wrw.20.1583845891261;
        Tue, 10 Mar 2020 06:11:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm39482879wro.66.2020.03.10.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:11:30 -0700 (PDT)
Message-Id: <41950069a169c68e7e6d93f1a7d80166cb3a4689.1583845884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 13:11:24 +0000
Subject: [PATCH v2 4/4] get_superproject_working_tree(): return strbuf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Together with the previous commits, this commit fully fixes the problem
of using shared buffer for `real_path()` in `get_superproject_working_tree()`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/rev-parse.c |  7 ++++---
 submodule.c         | 17 ++++++++---------
 submodule.h         |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 06ca7175ac7..06056434ed1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -808,9 +808,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
-				const char *superproject = get_superproject_working_tree();
-				if (superproject)
-					puts(superproject);
+				struct strbuf superproject = STRBUF_INIT;
+				if (get_superproject_working_tree(&superproject))
+					puts(superproject.buf);
+				strbuf_release(&superproject);
 				continue;
 			}
 			if (!strcmp(arg, "--show-prefix")) {
diff --git a/submodule.c b/submodule.c
index 215c62580fc..c3aadf3fff8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2168,14 +2168,13 @@ void absorb_git_dir_into_superproject(const char *path,
 	}
 }
 
-const char *get_superproject_working_tree(void)
+int get_superproject_working_tree(struct strbuf *buf)
 {
-	static struct strbuf realpath = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
 	const char *cwd = xgetcwd();
-	const char *ret = NULL;
+	int ret = 0;
 	const char *subpath;
 	int code;
 	ssize_t len;
@@ -2186,10 +2185,10 @@ const char *get_superproject_working_tree(void)
 		 * We might have a superproject, but it is harder
 		 * to determine.
 		 */
-		return NULL;
+		return 0;
 
 	if (!strbuf_realpath(&one_up, "../", 0))
-		return NULL;
+		return 0;
 
 	subpath = relative_path(cwd, one_up.buf, &sb);
 	strbuf_release(&one_up);
@@ -2233,8 +2232,8 @@ const char *get_superproject_working_tree(void)
 		super_wt = xstrdup(cwd);
 		super_wt[cwd_len - super_sub_len] = '\0';
 
-		strbuf_realpath(&realpath, super_wt, 1);
-		ret = realpath.buf;
+		strbuf_realpath(buf, super_wt, 1);
+		ret = 1;
 		free(super_wt);
 	}
 	strbuf_release(&sb);
@@ -2243,10 +2242,10 @@ const char *get_superproject_working_tree(void)
 
 	if (code == 128)
 		/* '../' is not a git repository */
-		return NULL;
+		return 0;
 	if (code == 0 && len == 0)
 		/* There is an unrelated git repository at '../' */
-		return NULL;
+		return 0;
 	if (code)
 		die(_("ls-tree returned unexpected return code %d"), code);
 
diff --git a/submodule.h b/submodule.h
index c81ec1a9b6c..4dad649f942 100644
--- a/submodule.h
+++ b/submodule.h
@@ -152,8 +152,8 @@ void absorb_git_dir_into_superproject(const char *path,
 /*
  * Return the absolute path of the working tree of the superproject, which this
  * project is a submodule of. If this repository is not a submodule of
- * another repository, return NULL.
+ * another repository, return 0.
  */
-const char *get_superproject_working_tree(void);
+int get_superproject_working_tree(struct strbuf *buf);
 
 #endif
-- 
gitgitgadget
