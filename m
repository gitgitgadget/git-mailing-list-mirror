From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/11] parse-options.h: add macros for '--contains' option
Date: Sun, 14 Jun 2015 01:48:24 +0530
Message-ID: <1434226706-3764-9-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rtY-0003Vr-M5
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbbFMUTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:19:08 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36630 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbbFMUTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:19:04 -0400
Received: by pabqy3 with SMTP id qy3so40972786pab.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EU7jJJHONmgY9Dz0iJ9iekvKSVkBNa8uo6qOxDv8vIE=;
        b=bYBHi3CVqarY5opn8QR24kClbljYrqf6tBqq7qEk0ewopReN+h1djeXfyF4vm3NOWF
         P/7RTJHnrWeBVQnp/TBg/F59zRcVBBwQkLA03q2aBscVoiwEuyAOraT/jmE3nbRL93j9
         GtXOxUQ5q5Tj+FLtno8WkD7NL4OaSDENoetE4WeqGaozxJALO0ud99r7yRC4ZQvglAMd
         hDosvmH+jF0ppmWKyP9ByRd14+m78a6IZZlZNE0qd5yscyjdk5TbJ4Jo8gQoK5I5BI0k
         eOmP2wtLkFSmafh0F4AFo69bjw8Sx0iyJXGUG9tHlVep3EaywFH0szee//igzYZtxFDG
         pScA==
X-Received: by 10.70.56.4 with SMTP id w4mr34648438pdp.148.1434226743141;
        Sat, 13 Jun 2015 13:19:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nw8sm7471590pdb.30.2015.06.13.13.19.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 13:19:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271584>

Add a macro for using the '--contains' option in parse-options.h
also include an optional '--with' option macro which performs the
same action as '--contains'.

Make tag.c use this new macro

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
index 8542d9c..d76e907 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -243,5 +243,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
+#define _OPT_CONTAINS_OR_WITH(name, variable, help) \
+	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
+	  PARSE_OPT_LASTARG_DEFAULT, \
+	  parse_opt_commit_object_name, (intptr_t) "HEAD" \
+	}
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
+#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
 
 #endif
-- 
2.4.3.435.g2403634.dirty
