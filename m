Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E63C35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCFB20828
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWK50XbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgBXJKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:00 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41545 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgBXJJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:59 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so4890777ywc.8
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 01:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ULdO9o2/eahToGb/73glhTnwAFb3IpEjKHGZeffytQ=;
        b=IWK50XbMJe8XtMpYeRiixP7S0cJCtGJmADliNVOTso0uKt0CuvJ1BMmGBBYum5H8YK
         dR9qoeQpquP5t6UUci9RGP+kw0AF/s4fn/RaCsAWicFxIqgcp79AtSePwOcq2Gg6fIDg
         O/KmD4fgGziMEoOZn4VjFoBXEwdFxnOt3bHs2BSpPIlMTQIfD20wK8IDpwPYPYDIUYAy
         HMaCrFxq9h7FhVHZA2E6NVdxrM+fzX5S+Yv7ayCGIaHcQxaFO2S8SmSM6rZs7voKgw1E
         oNRaVkxaASxwRbXsgsD2kDTkZWti7gfJFpcC1pSKl8cqMSAamHCjPaSA4r9UAEsChugG
         /+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9ULdO9o2/eahToGb/73glhTnwAFb3IpEjKHGZeffytQ=;
        b=Vd46cosREqN9iaqcpc0dKh9Gyge/8jPIpzxxuRUl9o21G1V+MfRj+WHqrq6tEbYV/J
         /HmRXbPXO6KNa9teoNvRu5mW6QUxMDIoJMLcPeCYVj3njvu+WbD6VzDCgG4RupfTFSwy
         cMR4QUKOb/A2i6FTfAmgtw7220X2TesDu3tkHPfDuZdiuM1q9UokhUuR4RurGMIo8h7U
         Y9j2KpzDBZ3B7GcYFuudAuQDaGlfWKYcelVq7khfxtJN6MCldTLJ9ONkiyi/VUOPJxhG
         62y1yfWOSWTSb5k/j/K8N+N+YHJ+zS2moMxEMHhzq5FVUhlL9gf1ojA0zLoWxFT629h1
         YhnQ==
X-Gm-Message-State: APjAAAUKTrqh9jJTRRFDhHQhQJr55m/GJO7vfT2erPNFxmSHUr9mqsEq
        YJiSQ4TxBfZNGUAj/5R4516ZHgjc
X-Google-Smtp-Source: APXvYqyMd0iVICJ/SB9uWRZ6rcyxwdeYt4yrLgz1u+uRnj35V6K71iEAzHtgVXOc0QGFT5TPOu5i/A==
X-Received: by 2002:a81:5056:: with SMTP id e83mr38656229ywb.414.1582535397287;
        Mon, 24 Feb 2020 01:09:57 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g29sm5045988ywk.31.2020.02.24.01.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 01:09:56 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cameron Gunnin <cameron.gunnin@synopsys.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] worktree: add utility to find worktree by pathname
Date:   Mon, 24 Feb 2020 04:08:47 -0500
Message-Id: <20200224090848.54321-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <20200224090848.54321-1-sunshine@sunshineco.com>
References: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
 <20200224090848.54321-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find_worktree() employs heuristics to match user provided input -- which
may be a pathname or some sort of shorthand -- with an actual worktree.
Although this convenience allows a user to identify a worktree with
minimal typing, the black-box nature of these heuristics makes it
potentially difficult for callers which already know the exact path of a
worktree to be confident that the correct worktree will be returned for
any specific pathname (particularly a relative one), especially as the
heuristics are enhanced and updated.

Therefore, add a companion function, find_worktree_by_path(), which
deterministically identifies a worktree strictly by pathname with no
interpretation and no magic matching.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 worktree.c | 16 ++++++++++------
 worktree.h |  6 ++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/worktree.c b/worktree.c
index 5b4793caa3..43c6685d4e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -215,7 +215,6 @@ struct worktree *find_worktree(struct worktree **list,
 			       const char *arg)
 {
 	struct worktree *wt;
-	char *path;
 	char *to_free = NULL;
 
 	if ((wt = find_worktree_by_suffix(list, arg)))
@@ -223,11 +222,17 @@ struct worktree *find_worktree(struct worktree **list,
 
 	if (prefix)
 		arg = to_free = prefix_filename(prefix, arg);
-	path = real_pathdup(arg, 0);
-	if (!path) {
-		free(to_free);
+	wt = find_worktree_by_path(list, arg);
+	free(to_free);
+	return wt;
+}
+
+struct worktree *find_worktree_by_path(struct worktree **list, const char *p)
+{
+	char *path = real_pathdup(p, 0);
+
+	if (!path)
 		return NULL;
-	}
 	for (; *list; list++) {
 		const char *wt_path = real_path_if_valid((*list)->path);
 
@@ -235,7 +240,6 @@ struct worktree *find_worktree(struct worktree **list,
 			break;
 	}
 	free(path);
-	free(to_free);
 	return *list;
 }
 
diff --git a/worktree.h b/worktree.h
index b8a851b92b..d242a6e71c 100644
--- a/worktree.h
+++ b/worktree.h
@@ -61,6 +61,12 @@ struct worktree *find_worktree(struct worktree **list,
 			       const char *prefix,
 			       const char *arg);
 
+/*
+ * Return the worktree corresponding to `path`, or NULL if no such worktree
+ * exists.
+ */
+struct worktree *find_worktree_by_path(struct worktree **, const char *path);
+
 /*
  * Return true if the given worktree is the main one.
  */
-- 
2.25.1.526.gf05a752211

