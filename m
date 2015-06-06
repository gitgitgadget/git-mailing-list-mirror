From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 7/9] parse-options.h: add macros for '--contains' option
Date: Sun,  7 Jun 2015 01:34:10 +0530
Message-ID: <1433621052-5588-7-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKj-0002b1-F5
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbbFFUEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:42 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34818 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbbFFUEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:37 -0400
Received: by pacyx8 with SMTP id yx8so32107064pac.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xy4HweC2CsoYk8e73GQBOZWlm20iAUvaFlRvKDafuaA=;
        b=AxPd5Qo7Hq39SoyRuIkYgaPoiqca/VPCh/9/MNoWJyA3q9zP7Cg3tVblaTmXQdVQsB
         dHVHjrd4KJkkae6hrMZZZmzXuZIAmW9WhuN1IQOsONoR1+aEDp0MUcyksrKWnd/LFzgE
         wJH0dPOVEwBpNzmJ4aiOsWxTZ+00zJpGGEiRLwfopzGod0Vg5OQNx9Z/vQuN2eKpCujQ
         +rv03mhlesGV5f4gfvQ03xYX4RZPDmT3MgwC4yX3/DxEqR+GQdZGnRUD5LLrNUzSdwXV
         QjLFBN8QgrKLPSakfwXkbqlZZFt5+jI5rCWaQ9mJqFMbFhvw/kS3pKnQM6ol7Bnv79XY
         xswQ==
X-Received: by 10.68.57.229 with SMTP id l5mr16451731pbq.130.1433621076106;
        Sat, 06 Jun 2015 13:04:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270951>

Add a macro for using the '--contains' option in parse-options.h
also include an optional '--with' option macro which performs the
same action as '--contains'.

Make tag.c use this new macro

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c   | 14 ++------------
 parse-options.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index eda76ba..e16668b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -591,23 +591,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
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
-			parse_opt_with_commit, (intptr_t)"HEAD",
-		},
-		{
-			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
-			N_("print only tags that contain the commit"),
-			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_with_commit, (intptr_t)"HEAD",
-		},
-		{
 			OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_points_at
 		},
diff --git a/parse-options.h b/parse-options.h
index 7bcf0f3..d8389ad 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -254,5 +254,15 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
 	  parse_opt_merge_filter, (intptr_t) "HEAD" \
 	}
+#define OPT_CONTAINS(filter, h) \
+	{ OPTION_CALLBACK, 0, "contains", (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT, \
+	  parse_opt_with_commit, (intptr_t) "HEAD" \
+	}
+#define OPT_WITH(filter, h) \
+	{ OPTION_CALLBACK, 0, "with", (filter), N_("commit"), (h), \
+	  PARSE_OPT_LASTARG_DEFAULT, \
+	  parse_opt_with_commit, (intptr_t) "HEAD" \
+	}
 
 #endif
-- 
2.4.2
