Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FE41F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJQH3S (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:18 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:47914 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:18 -0400
Received: by mail-io1-f74.google.com with SMTP id c21-v6so23225276ioi.14
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kf7dkkDmp9teoinVZKskkWrxffP1vLtclk6rRR7i+F4=;
        b=sVp41HCKOlY3AvPnep5YKmTWsL50zWcFB1DW6Z9jp08T7RjAUD8me4OiHMpUPyrObm
         jTyGN7BMRplGQMCke78iIjKI/L0MWxGgJYiaJkUgF0ly9Fdm+049z/fbt+O2MHuVHDhE
         70JsmcLJnXodf3Ql648k7Aps3uwIEvVtAuIqqi4T1xo0xpFJUSEEW0f+YeCM3gcjrrdn
         eeaoforwcnNriT7pa3u4PKoz/10iY5b8rYRoF3hRLt4YQ/pkgyJ0IcN+bNcfYeKTzCau
         5Ay66BR92ivTaj5Xe96ybWyomWkQFCVdwMjolwvHRElUa8oyq6FkAJaDWROXqXEm6RpP
         4L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kf7dkkDmp9teoinVZKskkWrxffP1vLtclk6rRR7i+F4=;
        b=gYDu4sHvhOwNUOUS8zepzcloderE9/f80EqOY/6lGWAmga2+QjsU4TOlQcTXLcippV
         hCgTuqs+b9yKSSI9fp2ZKQ1vziX/npk5bo27AeTJViOl3LD+SClMBsA9BVdOcE5/h6p8
         3DyTd+o1YtUx4k8YenCgH3sI3TVkU2qlxZk+boUDDpWDEjbGbDLXSwQsxsnVEZA2dX+W
         dq8qlYWfAozRGdruCSNbW8KNkpvV77dETORzpP9HXA/yM00PFgKzviGQAqbwQNwVMz4n
         2nhzzKByCBkqqDVZPVCOqrOZXKyNhc9gALWqrHqGK1XIDqMbTuk9FS1uwQWjfI6tYU0n
         3ubg==
X-Gm-Message-State: ABuFfohCIRErE7WRXEJRLPNzSsDCv+LlQ+aVQCusysYHBH/0CA3MDhWs
        kWydKuPSkLpkXZU27i3+4XU5OXSvCPAAbIiJAy8oZf7RqJ61boJkqbt59TmeywYecOqyMhX5MAV
        oguYbFoXLVLlJ8arwBQxC7M63IjbQcK5GkRCor0V/hFbMenDE+1DnG845l5qs
X-Google-Smtp-Source: ACcGV63M9jqzZkM2es6cxQxjQV9X3WfKVMSI6h5UW+CE8dIGpwKtZa6jatfGBlHlao/j96FoR7ZZEqT+cRnd
X-Received: by 2002:a24:2153:: with SMTP id e80-v6mr18770229ita.1.1539732992549;
 Tue, 16 Oct 2018 16:36:32 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:47 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-17-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 16/19] commit: prepare logmsg_reencode to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h                                |  8 ++++++++
 contrib/coccinelle/the_repository.cocci |  9 +++++++++
 pretty.c                                | 13 +++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index f3ef497723..b69a4b140d 100644
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
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 516f19ffee..f5b42cfc62 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
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
index 98cf5228f9..26e44472bb 100644
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
2.19.0

