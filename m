Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B6DC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiBQWya (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:54:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBQWya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:54:30 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F7257DF2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:54:12 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id o10so6291353qkg.0
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMsNYcYjY8aTfSo3kb4Eb1ZBQ/bM3gynWf/SasJVlQ0=;
        b=k9d9BXrFtmI5jCxstfUGwClSm5RQN8FtGyndpCf/QHKqYJtIBiTVKXjIEK8Vj8batO
         /aNA398jUANwYARxcFq1l5mqNbEgGUgQXyXyx/N8BtEpKo067xy2V83h0YGwxZqG00zj
         cIW8le3rSdyEbXhwvg8qMGXeFreZfJOKYf27eSRYfZgOirM0UcBG2DZ4tnyzxAwmqnyE
         EmtyG8FlH/FNxTfsm3yZ9vsh3XewWf6KknwDQ8lWVwzw/bpiYESNwyTsG7QCNzcKVlTF
         j6GsUG8Grp7c7Pdq7QLYB1h3+390PySBtEVMfPD67JetCSMAHsytYSqYf+L/g+7jV+RT
         YrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMsNYcYjY8aTfSo3kb4Eb1ZBQ/bM3gynWf/SasJVlQ0=;
        b=J9QlNAWlrAIsEKLcpMYOhth8MtCH3eS6Umfo1rIEfo/2KBRL1Z9l42lFg2QsPPz6Ya
         iNnlddMmUnP/n/wpSKjGj2CXoODMs2Z9JaU9P3XLl3cDzMhmEUgNs7tNE2RBOMKFDuyT
         gcRjdOSONRTRHWFQZTlLIAajPlwGLZYfjyhRaZqrjetdmnhVzRiuIZL2a3WRGiiglC7H
         Sf0vdmfWHql2zEaNl357fYV/IjieX5PrCIDZDEMdJHWgj7hsZ90OcWc/N+wtydCW1F7h
         avwZMZKoYREhameoXS1LVmDg5STjxRoEaNE1vjqYbAdOlvfwpxvrL/gNfmctS39OVyEp
         MWdg==
X-Gm-Message-State: AOAM5317RJiz3jYiuCDJL35eeSwJaCeYZ2nTGV+FC8/QxqrF0qI6i0ur
        WN0NHHviBeEz1OStHCD63aouVzWmIRf85MRT
X-Google-Smtp-Source: ABdhPJz4EMLXYBcJXTuxxGbCzuWeX3Jae5sGdvsNyK4ozIpmSKfzMLZMCqOf7nu5Dtjvwe/IipeXDQ==
X-Received: by 2002:a37:6808:0:b0:46c:e3c1:7247 with SMTP id d8-20020a376808000000b0046ce3c17247mr2893308qkc.770.1645138451167;
        Thu, 17 Feb 2022 14:54:11 -0800 (PST)
Received: from edef91d97c94 ([50.234.189.46])
        by smtp.gmail.com with ESMTPSA id s14sm21638106qkp.79.2022.02.17.14.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Feb 2022 14:54:10 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:54:08 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 1/1] xdiff: provide indirection to git functions
Message-ID: <20220217225408.GB7@edef91d97c94>
References: <20220217225218.GA7@edef91d97c94>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217225218.GA7@edef91d97c94>
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
 xdiff/git-xdiff.h | 16 ++++++++++++++++
 xdiff/xdiff.h     |  8 +++-----
 xdiff/xdiffi.c    | 20 ++++++++++----------
 xdiff/xinclude.h  |  2 +-
 xdiff/xmerge.c    |  4 ++--
 5 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 xdiff/git-xdiff.h

diff --git a/xdiff/git-xdiff.h b/xdiff/git-xdiff.h
new file mode 100644
index 0000000000..664a7c1351
--- /dev/null
+++ b/xdiff/git-xdiff.h
@@ -0,0 +1,16 @@
+#ifndef GIT_XDIFF_H
+#define GIT_XDIFF_H
+
+#include "git-compat-util.h"
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
index a4285ac0eb..75db1d8f35 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -23,7 +23,7 @@
 #if !defined(XINCLUDE_H)
 #define XINCLUDE_H

-#include "git-compat-util.h"
+#include "git-xdiff.h"
 #include "xmacros.h"
 #include "xdiff.h"
 #include "xtypes.h"
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index fff0b594f9..433e2d7415 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -88,7 +88,7 @@ static int xdl_cleanup_merge(xdmerge_t *c)
 		if (c->mode == 0)
 			count++;
 		next_c = c->next;
-		free(c);
+		xdl_free(c);
 	}
 	return count;
 }
@@ -456,7 +456,7 @@ static void xdl_merge_two_conflicts(xdmerge_t *m)
 	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
 	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
 	m->next = next_m->next;
-	free(next_m);
+	xdl_free(next_m);
 }

 /*
--
2.35.1
