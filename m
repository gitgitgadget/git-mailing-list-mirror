From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3] make color.ui default to 'auto'
Date: Wed, 15 May 2013 16:24:29 +0200
Message-ID: <1368627869-16539-1-git-send-email-Matthieu.Moy@imag.fr>
References: <51938B90.8040004@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 15 16:25:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uccdl-0005u2-3e
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 16:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089Ab3EOOZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 10:25:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39207 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758970Ab3EOOZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 10:25:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4FEOXPe002061
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 16:24:33 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uccd8-0004tg-R2; Wed, 15 May 2013 16:24:34 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uccd8-0004JQ-N9; Wed, 15 May 2013 16:24:34 +0200
X-Mailer: git-send-email 1.8.3.rc1.314.g2261e40.dirty
In-Reply-To: <51938B90.8040004@gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 15 May 2013 16:24:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FEOXPe002061
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1369232677.8418@Fio2bnC1onzX9VpZgm4U6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224409>

Most users seem to like having colors enabled, and colors can help
beginners to understand the output of some commands (e.g. notice
immediately the boundary between commits in the output of "git log").

Many tutorials tell the users to set color.ui=auto as a very first step.
These tutorials would benefit from skipping this step and starting the
real Git manipulations earlier. Other beginners do not know about
color.ui=auto, and may not discover it by themselves, hence live with
black&white outputs while they may have preferred colors.

A few people (e.g. color-blind) prefer having no colors, but they can
easily set color.ui=never for this (and googling "disable colors in git"
already tells them how to do so).

A transition period with Git emitting a warning when color.ui is unset
would be possible, but the discomfort of having the warning seems
superior to the benefit: users may be surprised by the change, but not
harmed by it.

The default value is changed, and the documentation is reworded to
mention "color.ui=false" first, since the primary use of color.ui after
this change is to disable colors, not to enable it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
v2 crossed Stefano's email with typos. v3 just fixes these typos in
the commit message.

 Documentation/config.txt | 11 ++++++-----
 builtin/config.c         |  2 +-
 color.c                  |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1009bfc..97550be 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -913,11 +913,12 @@ color.ui::
 	as `color.diff` and `color.grep` that control the use of color
 	per command family. Its scope will expand as more commands learn
 	configuration to set a default for the `--color` option.  Set it
-	to `always` if you want all output not intended for machine
-	consumption to use color, to `true` or `auto` if you want such
-	output to use color when written to the terminal, or to `false` or
-	`never` if you prefer Git commands not to use color unless enabled
-	explicitly with some other configuration or the `--color` option.
+	to `false` or `never` if you prefer Git commands not to use
+	color unless enabled explicitly with some other configuration
+	or the `--color` option. Set it to `always` if you want all
+	output not intended for machine consumption to use color, to
+	`true` or `auto` (this is the default since Git 2.0) if you
+	want such output to use color when written to the terminal.
 
 column.ui::
 	Specify whether supported commands should output in columns.
diff --git a/builtin/config.c b/builtin/config.c
index 000d27c..ecfceca 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -316,7 +316,7 @@ static void get_color(const char *def_color)
 
 static int get_colorbool_found;
 static int get_diff_color_found;
-static int get_color_ui_found;
+static int get_color_ui_found = GIT_COLOR_AUTO;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
diff --git a/color.c b/color.c
index e8e2681..f672885 100644
--- a/color.c
+++ b/color.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "color.h"
 
-static int git_use_color_default = 0;
+static int git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
 
 /*
-- 
1.8.3.rc1.314.g2261e40.dirty
