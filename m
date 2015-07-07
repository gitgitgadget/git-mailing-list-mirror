From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 09/11] parse-options.h: add macros for '--contains' option
Date: Tue,  7 Jul 2015 21:36:15 +0530
Message-ID: <1436285177-12279-9-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:08:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVPj-0001w7-OT
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbbGGQHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:53 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36852 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893AbbGGQHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:44 -0400
Received: by pacgz10 with SMTP id gz10so41771226pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7n1chXONj7tNZhodmwJoMR06nsHf8uAp08I1ee27jI=;
        b=dr5wIdF/uwHSp47Tbv7d4XcMaS7BvDuhh+vwQP+hwyzzZRXAlpcjYXmZCq3wHdLWCT
         Qj3UqkT9l0nPXMA4DxgcPMHMkyZHQBfQhsZUouW2PjIm5WE8GemakjSIO0s/XENbxKYU
         7Qijjbm/lDIYb1FjMhSUPtjQ0hmtx/tRatYOEsgxPfMp/MWphhZ6FYudJkrwbrvrfVIU
         ZfPRjS022EUmLGSbN6AXrum1nlRnFlf9Izy+5DWdHMevOTPPTNA8yC8BFCXax88k4fQg
         1vK9ZvsP9+3mtE2HJoXdjKFRti19cqHqrpj2/0RN5NUXn3VoaBPCIxQNRj6fDOgdEqHh
         rhOw==
X-Received: by 10.68.78.36 with SMTP id y4mr10353130pbw.106.1436285263633;
        Tue, 07 Jul 2015 09:07:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.07.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273582>

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
index ae9a0eb..c443cd8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -828,18 +828,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
index 583690c..7ea22b2 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -246,5 +246,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
+#define _OPT_CONTAINS_OR_WITH(name, variable, help, flag) \
+	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
+	  PARSE_OPT_LASTARG_DEFAULT | flag, \
+	  parse_opt_commits, (intptr_t) "HEAD" \
+	}
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
+#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN)
 
 #endif
-- 
2.4.5
