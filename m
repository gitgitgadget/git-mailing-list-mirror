Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330B820A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbeLOAKZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:25 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56428 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbeLOAKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:24 -0500
Received: by mail-pl1-f202.google.com with SMTP id x7so4675688pll.23
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h4PuIsap4vNJg9HdWbZgjsl2Pvo6Cq3jLdfZG5g5qD4=;
        b=ik18bD3ZV4q3m7eeOenDPIVIvV+hq012yDJ5dI5P9/OeGZLkxIhVsSVN3ZDTcTIzdl
         8O6iw3+9hrLetCFQ53YOwMYH9BirtRdrW0ikJy7WsC3Tq9XyRD/nOqyQu5WLRMduquLH
         jO4mUEknOGS6CK4Fep8baVlnN7EK3iBxwM7WzcJcat20ZUzWcsfd1yL2S5NzzTk5onOS
         aT9cjIkQBhvfY1CfU9O2OfGc+vDer/xmIRnydG7bPk4fpC6hV4AlXDVqohHYkevzThTb
         N3XZkgsrsHyzAnTwBzdtp9BF2XWoPa1/JCOC19pSy7/QHNqTXASvTq81sQCHWv9GmZWB
         T8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h4PuIsap4vNJg9HdWbZgjsl2Pvo6Cq3jLdfZG5g5qD4=;
        b=NJ+eNIS7wMPqYbhX5vRQxSbMFm2NgYMZUeW41pW7NtnOO619dDKKeKsZWmL7Y/Z17O
         nBuLO6cKUSHm+6rbgOsrOgLdZtWngk0GrFTd4IedanfB/5vQSG0NJJp/WAbx6STaTW/K
         bV+W1RzeUrde6pGgNQojxePqvIx+2X4GJDJ5tRgXqKhxAPX2KBjGBdWtxTjRZ1ku0hrN
         iuXKCc+dWgoz+6+kFJbQvD2og26gqzESRxbyFeJOSKZLtixZjxECpVB12QEoH2/uyyeU
         3xaNB/ODhup3T2ouMTvq9PQ7EWfrSLpYiJYKjoEShtjcqtCZU6b6VaV0kqNXRg7Ia2u2
         nQMA==
X-Gm-Message-State: AA+aEWb+E/EWT1B643hZH5Y2ZDHBt3yrfbuW10BZw+UaoS4+xQqRuBdR
        N8Y2u5+QCuKT/TkNg6hN2aXSVXNwn+jMqeW7rl3SoruGTXHnipRerVhZUwXd6lttD1bdf+28/4t
        /8Rq/Cj009DvBSm9EMucAivt4oiU3ouwVC/Z4Yd2+NuU7XQ6riD0lG616BDqt
X-Google-Smtp-Source: AFSGD/VQZ2Hr9yf0xP6qhEhs2w4T03Ez3pEO8u9G4woAJ9pKZ9RSpYM3hMM/Bsct7+jiaXZ6gaSGarl8cocT
X-Received: by 2002:a17:902:6103:: with SMTP id t3mr2242159plj.117.1544832623655;
 Fri, 14 Dec 2018 16:10:23 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:35 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-17-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 16/23] commit: prepare logmsg_reencode to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h                                        |  8 ++++++++
 contrib/coccinelle/the_repository.pending.cocci |  9 +++++++++
 pretty.c                                        | 13 +++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index 57375e3239..2e6b799b26 100644
--- a/commit.h
+++ b/commit.h
@@ -180,6 +180,14 @@ extern int has_non_ascii(const char *text);
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
+const char *repo_logmsg_reencode(struct repository *r,
+				 const struct commit *commit,
+				 char **commit_encoding,
+				 const char *output_encoding);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define logmsg_reencode(c, enc, out) repo_logmsg_reencode(the_repository, c, enc, out)
+#endif
+
 extern const char *skip_blank_lines(const char *msg);
 
 /** Removes the first commit from a list sorted by date, and adds all
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 516f19ffee..f5b42cfc62 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -123,3 +123,12 @@ expression F;
 - unuse_commit_buffer(
 + repo_unuse_commit_buffer(the_repository,
   E, F);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- logmsg_reencode(
++ repo_logmsg_reencode(the_repository,
+  E, F, G);
diff --git a/pretty.c b/pretty.c
index 8ca29e9281..b359b68750 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,14 +595,15 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-const char *logmsg_reencode(const struct commit *commit,
-			    char **commit_encoding,
-			    const char *output_encoding)
+const char *repo_logmsg_reencode(struct repository *r,
+				 const struct commit *commit,
+				 char **commit_encoding,
+				 const char *output_encoding)
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	const char *msg = get_commit_buffer(commit, NULL);
+	const char *msg = repo_get_commit_buffer(r, commit, NULL);
 	char *out;
 
 	if (!output_encoding || !*output_encoding) {
@@ -630,7 +631,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
+		if (msg == get_cached_commit_buffer(r, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
@@ -644,7 +645,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 */
 		out = reencode_string(msg, output_encoding, use_encoding);
 		if (out)
-			unuse_commit_buffer(commit, msg);
+			repo_unuse_commit_buffer(r, commit, msg);
 	}
 
 	/*
-- 
2.20.0.405.gbc1bbc6f85-goog

