From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 2/4] cat-file: make the options mutually exclusive
Date: Sun,  3 May 2015 20:00:00 +0530
Message-ID: <1430663402-26717-2-git-send-email-karthik.188@gmail.com>
References: <55463094.9040204@gmail.com>
 <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 16:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Youuc-0005tp-4x
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 16:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbbECOaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 10:30:25 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35599 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbECOaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 10:30:24 -0400
Received: by pabtp1 with SMTP id tp1so138399849pab.2
        for <git@vger.kernel.org>; Sun, 03 May 2015 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpeT1jze5Fmb7WZ072f3HH23JdwBKojjPotWw0HznLo=;
        b=wpcEEQARsxP0N1urpkIuE7rX2jhQDsFmT7Gw74GGun3iO0O9X4tPh4NRhE6Fy4gxoW
         hFl4IA9NGDENAuIiApSWaPBzyzrZKzR4InoPNFPGecvccXa8taDLKEZGhKdyNi6gZLoE
         Ca5KYwlibPK6qHFsddbbtEK2NNuoIjy0PLzEvYFA9wx5ZBskAAwL83zKTFreWodAqjjt
         agGHkGD6oNBHC6pQTpS/TK1CL/lpTJTlGCNiOw60ZvhbsFXwWm/LAeQWDSG29Ms9xHlN
         ToOWkUiMsJjjUXuDDsmteUDzfFRo0qz/M8fMszmVI/MvqK1fOJoeUVpNocgn7Qi1p9iz
         RmNg==
X-Received: by 10.70.103.10 with SMTP id fs10mr34084317pdb.141.1430663423748;
        Sun, 03 May 2015 07:30:23 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id xt9sm10097262pbc.14.2015.05.03.07.30.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 May 2015 07:30:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.250.gfbd73bd
In-Reply-To: <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268264>

We only parse the options if 2 or 3 arguments are specified.
Update 'struct option options[]' to use OPT_CMDMODE rather than
OPT_SET_INT to allow only one mutually exclusive option and avoid the
need for checking number of arguments. This was written by Junio C Hamano,
tested by me.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df99df4..53b5376 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -362,12 +362,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
-		OPT_SET_INT('t', NULL, &opt, N_("show object type"), 't'),
-		OPT_SET_INT('s', NULL, &opt, N_("show object size"), 's'),
-		OPT_SET_INT('e', NULL, &opt,
+		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
+		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
+		OPT_CMDMODE('e', NULL, &opt,
 			    N_("exit with zero when there's no error"), 'e'),
-		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
-		OPT_SET_INT(0, "textconv", &opt,
+		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
+		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
@@ -380,9 +380,6 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc != 3 && argc != 2)
-		usage_with_options(cat_file_usage, options);
-
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
-- 
2.4.0.rc1.250.gfbd73bd
