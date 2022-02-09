Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFF8C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiBIClG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbiBIBd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 20:33:58 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BDCC061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 17:33:58 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id b5so644341qtq.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 17:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wStj/ummu2DQ07xNGCVlAb1xEFi0L4dzEUuc14YjDEQ=;
        b=i4H2YHbhrB4VpLEhVfna0jbBZGqTMVaZyQqrPlKmCcBB5AUp6x7Lyd3fMUAd2TJHzc
         +UZ8Ng/ZUSMWyW+WFifk043poHkKPXFeUC6cYtxKgHjKu8boZT/fXmVMdKPWLXeUvhBj
         vGDPIGxSOdhIw/pfZZma3ys2aI9YDXiUn7vqJ8Ybmv66dTi2TmNf5pOYMNRBmlPDDF6b
         vx2VjL4ElF3yqfRdiqqPdd9qSMcW570vTqF3Z6WOxfqHbMJKsYD9HiEyJsJbQNRvB1z0
         kN2xlkGjIF0wLWo0Ml0HKk3wqOl40ffoYc1jzpTnY0kD9kmLl6blRrLrMyF4CFCNLECx
         hDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wStj/ummu2DQ07xNGCVlAb1xEFi0L4dzEUuc14YjDEQ=;
        b=vaxXDsKkIqMK3jPGwg8w6q8mCi3Np/gyf9pMfUFamvOMBPdrfB4z1C52wVzYlVFU0l
         X/cdfvn5RT1oRgBa26n+h7vOxvs8dV2dxurxTqBBN/kOefmjDWyKpwMU2jTS8MXcOdn+
         4ULPnrsEG1SoZj0S+c13bRA356tPhuILRX1hWLwrHmC8H4xuN/+reFIeq/f3R1MPA+Vc
         qm8GMUXIyQcHYXpri0a9ykJmmpWD/PscezIVJDW+uIuOEcC6xPMUVnRrUcm7IzwegxF7
         8R8be6B5o/ctvco6XpVGaveKfhWsnW3xUtwsTwgISh2qkM4uPr/iuh19yfELZAXeWwFy
         juqg==
X-Gm-Message-State: AOAM530Tb0wVN55q8uX3mX2m3QKePgC+hC8EhfNh50kR2FF5tIf+/+il
        7e7S8rnUPcEncfGr7sgBwGpoeRNtd2lokZhX
X-Google-Smtp-Source: ABdhPJzTMkylqkaKMTwWuxmBx8jJCjSjB4yqZJfoZnZH35F1RMriyRz8amwENTX7w7hVorZqoszNGA==
X-Received: by 2002:a05:622a:1189:: with SMTP id m9mr4906896qtk.573.1644370436809;
        Tue, 08 Feb 2022 17:33:56 -0800 (PST)
Received: from abe733c6e288 ([50.234.189.46])
        by smtp.gmail.com with ESMTPSA id v22sm8199164qta.60.2022.02.08.17.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Feb 2022 17:33:56 -0800 (PST)
Date:   Wed, 9 Feb 2022 01:33:54 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
Subject: [PATCH 1/1] xdiff: provide indirection to git functions
Message-ID: <20220209013354.GB7@abe733c6e288>
References: <20220209012951.GA7@abe733c6e288>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209012951.GA7@abe733c6e288>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide an indirection layer into the git-specific functionality and
utilities in `git-xdiff.h`, prefixing those types and functions with
`xdl_` (and `XDL_` for macros).  This allows other projects that use
git's xdiff implementation to keep up-to-date; they can now take all the
files _except_ `git-xdiff.h`, which they have customized for their own
environment.

Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
---
 xdiff/git-xdiff.h | 14 ++++++++++++++
 xdiff/xdiff.h     |  8 +++-----
 xdiff/xdiffi.c    | 20 ++++++++++----------
 xdiff/xinclude.h  |  2 +-
 4 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 xdiff/git-xdiff.h

diff --git a/xdiff/git-xdiff.h b/xdiff/git-xdiff.h
new file mode 100644
index 0000000000..5d47576551
--- /dev/null
+++ b/xdiff/git-xdiff.h
@@ -0,0 +1,14 @@
+#ifndef GIT_XDIFF_H
+#define GIT_XDIFF_H
+
+#define xdl_malloc(x) xmalloc(x)
+#define xdl_free(ptr) free(ptr)
+#define xdl_realloc(ptr,x) xrealloc(ptr,x)
+
+#define xdl_regex_t regex_t
+#define xdl_regmatch_t regmatch_t
+#define xdl_regexec_buf(p, b, s, n, m, f) regexec_buf(p, b, s, n, m, f)
+
+#define XDL_BUG(msg) BUG(msg)
+
+#endif
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 72e25a9ffa..fb47f63fbf 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -27,6 +27,8 @@
 extern "C" {
 #endif /* #ifdef __cplusplus */
 
+#include "git-xdiff.h"
+
 /* xpparm_t.flags */
 #define XDF_NEED_MINIMAL (1 << 0)
 
@@ -82,7 +84,7 @@ typedef struct s_xpparam {
 	unsigned long flags;
 
 	/* -I<regex> */
-	regex_t **ignore_regex;
+	xdl_regex_t **ignore_regex;
 	size_t ignore_regex_nr;
 
 	/* See Documentation/diff-options.txt. */
@@ -119,10 +121,6 @@ typedef struct s_bdiffparam {
 } bdiffparam_t;
 
 
-#define xdl_malloc(x) xmalloc(x)
-#define xdl_free(ptr) free(ptr)
-#define xdl_realloc(ptr,x) xrealloc(ptr,x)
-
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
 long xdl_mmfile_size(mmfile_t *mmf);
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 69689fab24..af31b7f4b3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -832,7 +832,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			/* Shift the group backward as much as possible: */
 			while (!group_slide_up(xdf, &g))
 				if (group_previous(xdfo, &go))
-					BUG("group sync broken sliding up");
+					XDL_BUG("group sync broken sliding up");
 
 			/*
 			 * This is this highest that this group can be shifted.
@@ -848,7 +848,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				if (group_slide_down(xdf, &g))
 					break;
 				if (group_next(xdfo, &go))
-					BUG("group sync broken sliding down");
+					XDL_BUG("group sync broken sliding down");
 
 				if (go.end > go.start)
 					end_matching_other = g.end;
@@ -873,9 +873,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 */
 			while (go.end == go.start) {
 				if (group_slide_up(xdf, &g))
-					BUG("match disappeared");
+					XDL_BUG("match disappeared");
 				if (group_previous(xdfo, &go))
-					BUG("group sync broken sliding to match");
+					XDL_BUG("group sync broken sliding to match");
 			}
 		} else if (flags & XDF_INDENT_HEURISTIC) {
 			/*
@@ -916,9 +916,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 			while (g.end > best_shift) {
 				if (group_slide_up(xdf, &g))
-					BUG("best shift unreached");
+					XDL_BUG("best shift unreached");
 				if (group_previous(xdfo, &go))
-					BUG("group sync broken sliding to blank line");
+					XDL_BUG("group sync broken sliding to blank line");
 			}
 		}
 
@@ -927,11 +927,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if (group_next(xdf, &g))
 			break;
 		if (group_next(xdfo, &go))
-			BUG("group sync broken moving to next group");
+			XDL_BUG("group sync broken moving to next group");
 	}
 
 	if (!group_next(xdfo, &go))
-		BUG("group sync broken at end of file");
+		XDL_BUG("group sync broken at end of file");
 
 	return 0;
 }
@@ -1011,11 +1011,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 }
 
 static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
-	regmatch_t regmatch;
+	xdl_regmatch_t regmatch;
 	int i;
 
 	for (i = 0; i < xpp->ignore_regex_nr; i++)
-		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
+		if (!xdl_regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
 				 &regmatch, 0))
 			return 1;
 
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index a4285ac0eb..bf66dc0a87 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -24,6 +24,7 @@
 #define XINCLUDE_H
 
 #include "git-compat-util.h"
+#include "git-xdiff.h"
 #include "xmacros.h"
 #include "xdiff.h"
 #include "xtypes.h"
@@ -32,5 +33,4 @@
 #include "xdiffi.h"
 #include "xemit.h"
 
-
 #endif /* #if !defined(XINCLUDE_H) */
-- 
2.35.0

