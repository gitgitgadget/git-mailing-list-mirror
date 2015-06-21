From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 09/19] parse-options.h: add macros for '--contains' option
Date: Mon, 22 Jun 2015 02:18:23 +0530
Message-ID: <1434919705-4884-9-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:49:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mB9-0005fs-4r
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbbFUUtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:49:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34505 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853AbbFUUtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:49:17 -0400
Received: by pabvl15 with SMTP id vl15so73668775pab.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U54SveS8q/qJQHQ1+yejjCrb37dIQRqRj2O8/QEJFUM=;
        b=Y+Iyxpd8vbXsiMGdUb8ZArK69rjQAIpvB7Zdr8RbTKh+i5m170rB7JM+j1C7uAY8zV
         86sBrwudqsIFAkaIYp/VZ0Q8PT21rFiRflAzvMM7tKKVRo3rKTrZkBJkWRgmd8ZmxEe1
         dITCk0myX69o5TJOPAYifCbz8rzO+PhnMEzG80G5H9yxTiy5yxDfBEXudqEZjN6LyNFm
         mML2yX55y09g1J/+NLEurwJ1nciYzPiR2F9g6V4m3HjvtdyK5fFcay6kgnPHn9Pv7sTu
         IskuUMM/DniE9Ffslb58oYHLx5v5R+qHnl6XqHOUXLHrvVJl54fHjT5xL88NTlXjiu/B
         RegQ==
X-Received: by 10.68.238.39 with SMTP id vh7mr39898877pbc.12.1434919756457;
        Sun, 21 Jun 2015 13:49:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.49.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:49:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272295>

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
2.4.3.439.gfea0c2a.dirty
