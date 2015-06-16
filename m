From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 09/11] parse-options.h: add macros for '--contains' option
Date: Tue, 16 Jun 2015 19:50:55 +0530
Message-ID: <1434464457-10749-9-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rpj-00089r-Bd
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388AbbFPO1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:27:19 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35752 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbbFPO1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:27:18 -0400
Received: by pdbnf5 with SMTP id nf5so15658234pdb.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5RpZhlz+dANF05aFekUUFlG6UrQ/Ws4qQGyUulDyqQw=;
        b=byj6p41PjzzNb3ouzGyQ/SjEaVfrrbZs/6vq+2JwbrE/FnaXSt+uIXxV24aWhmr9Ji
         FZ75NiQI0nQ889/qlQLO99/U/CFP9OsPkWW2aYsmPF1VqOaS+wxS9+frmeDV48KJ5/OV
         TfkE2eIXeGPYnicq98eq0x/ryGLfzvct8636o592PGibg/R6/33KEyly73PJAQ6qqz8B
         ySLDseP55DErBYRRD1zsQ6UKLVwO6wbmmcxxNkXGVlAgeQgcCzs/rFEHl8d4kPDdVDU6
         udQ6pNnJ1Uace8P5Bw6EA9TsGtPrxmqhy/fmR9doqcJGy8fpcBQOoPgPw1jxqA/30YMU
         H7Jw==
X-Received: by 10.70.96.65 with SMTP id dq1mr1106071pdb.79.1434464837620;
        Tue, 16 Jun 2015 07:27:17 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.27.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:27:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271764>

Add a macro for using the '--contains' option in parse-options.h
also include an optional '--with' option macro which performs the
same action as '--contains'.

Make tag.c use this new macro.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c   | 14 ++------------
 parse-options.h |  7 +++++++
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 2d6610a..767162e 100644
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
-			parse_opt_commit_object_name, (intptr_t)"HEAD",
-		},
-		{
-			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
-			N_("print only tags that contain the commit"),
-			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_commit_object_name, (intptr_t)"HEAD",
-		},
-		{
 			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
diff --git a/parse-options.h b/parse-options.h
index 8542d9c..2b555ff 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -243,5 +243,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
+#define _OPT_CONTAINS_OR_WITH(name, variable, help, flag)		      \
+	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
+	  PARSE_OPT_LASTARG_DEFAULT | flag, \
+	  parse_opt_commit_object_name, (intptr_t) "HEAD" \
+	}
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
+#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN)
 
 #endif
-- 
2.4.3.436.g722e2ce.dirty
