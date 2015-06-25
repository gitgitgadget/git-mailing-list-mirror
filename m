From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 09/11] parse-options.h: add macros for '--contains' option
Date: Thu, 25 Jun 2015 14:27:11 +0530
Message-ID: <1435222633-32007-9-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 10:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82yz-0000p8-VW
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbbFYI6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:58:01 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34827 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbFYI55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:57:57 -0400
Received: by pactm7 with SMTP id tm7so46105530pac.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ft0vYmuq7zejCFYEh0HyHMOJWcHNep7LTFZ+SXAhKSI=;
        b=mjmVadXLbW42iwMUjSt6C61oD5Uxtz3pUpkFLI4VOmTy7exfZBMUg0wpezSwd2uzCV
         +UHHwq0JxuMq0WDvNtj0Mw5T1xaRKsZWzJhZVKvVWBazAE2b92BOBp+2FHE4hqR5Bt2e
         ahIj0E+nezGkm5YjhNSRAthjmX+nhq0K5ECBxmQs2R6zXzlDRYZFG2nYu+qjcCKXrK7E
         0i2RPXqrSCI8eW7RE36sr+cxo6rjD0z9N/YGUC2C8cSKY9fW8Lqw+ceH7+TBjjeipM7z
         k7PnG44pjVloLdvFgzDAgFzm0OWsZvFvwZ6aupmJ0AMShTau+4C4GjkmoPgYka2nYHMT
         3bnA==
X-Received: by 10.68.201.132 with SMTP id ka4mr52655052pbc.30.1435222677105;
        Thu, 25 Jun 2015 01:57:57 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id wa4sm29391000pab.17.2015.06.25.01.57.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 01:57:56 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272650>

Add a macro for using the '--contains' option in parse-options.h
also include an optional '--with' option macro which performs the
same action as '--contains'.

Make tag.c and branch.c use this new macro.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 14 ++------------
 builtin/tag.c    | 14 ++------------
 parse-options.h  |  7 +++++++
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a008b0d..b04e341 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -824,18 +824,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
 			REF_REMOTE_BRANCH),
-		{
-			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
-			N_("print only branches that contain the commit"),
-			PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_commits, (intptr_t)"HEAD",
-		},
-		{
-			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
-			N_("print only branches that contain the commit"),
-			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_commits, (intptr_t) "HEAD",
-		},
+		OPT_CONTAINS(&with_commit, N_("print only branches that contain the commit")),
+		OPT_WITH(&with_commit, N_("print only branches that contain the commit")),
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
diff --git a/builtin/tag.c b/builtin/tag.c
index 7af45a0..767162e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -595,23 +595,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
+		OPT_CONTAINS(&with_commit, N_("print only tags that contain the commit")),
+		OPT_WITH(&with_commit, N_("print only tags that contain the commit")),
 		{
 			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
 		{
-			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
-			N_("print only tags that contain the commit"),
-			PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_commits, (intptr_t)"HEAD",
-		},
-		{
-			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
-			N_("print only tags that contain the commit"),
-			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_commits, (intptr_t)"HEAD",
-		},
-		{
 			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
diff --git a/parse-options.h b/parse-options.h
index 2ffd857..627423f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -243,5 +243,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
+#define _OPT_CONTAINS_OR_WITH(name, variable, help, flag)		      \
+	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
+	  PARSE_OPT_LASTARG_DEFAULT | flag, \
+	  parse_opt_commits, (intptr_t) "HEAD" \
+	}
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
+#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN)
 
 #endif
-- 
2.4.4
