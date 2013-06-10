From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] make color.ui default to 'auto'
Date: Mon, 10 Jun 2013 16:26:09 +0200
Message-ID: <1370874369-30248-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1370874369-30248-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 10 16:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um33B-0005pg-G1
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab3FJO0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:26:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59536 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3FJO0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:26:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEQCFg022569
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:26:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Um32z-0001zq-Tj; Mon, 10 Jun 2013 16:26:13 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Um32z-0007tK-JG; Mon, 10 Jun 2013 16:26:13 +0200
X-Mailer: git-send-email 1.8.3.rc3.8.g5e49f30
In-Reply-To: <1370874369-30248-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 16:26:12 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227288>

Most users seem to like having colors enabled, and colors can help
beginners to understand the output of some commands (e.g. notice
immediately the boundary between commits in the output of "git log").

Many tutorials tell the users to set color.ui=auto as a very first step,
which tend to indicate that color.ui=none is not the recommanded value,
hence should not be the default.

These tutorials would benefit from skipping this step and starting the
real Git manipulations earlier. Other beginners do not know about
color.ui=auto, and may not discover it by themselves, hence live with
black&white outputs while they may have preferred colors.

A few people (e.g. color-blind) prefer having no colors, but they can
easily set color.ui=never for this (and googling "disable colors in git"
already tells them how to do so), but this needs not occupy space in
beginner-oriented documentations.

A transition period with Git emitting a warning when color.ui is unset
would be possible, but the discomfort of having the warning seems
superior to the benefit: users may be surprised by the change, but not
harmed by it.

The default value is changed, and the documentation is reworded to
mention "color.ui=false" first, since the primary use of color.ui after
this change is to disable colors, not to enable it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
I just changed "Git 2.0" with "Git 1.8.4". I think a default change
deserves a mention of the version in which it changed (I think it's
common for someone to use an old Git version and to read a more recent
documentation online, so this may avoid bad surprises). I'm fine with
dropping "since Git 1.8.4" completely if people think it's better.

 Documentation/config.txt | 11 ++++++-----
 builtin/config.c         |  2 +-
 color.c                  |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e97facc..6570aee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -905,11 +905,12 @@ color.ui::
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
+	`true` or `auto` (this is the default since Git 1.8.4) if you
+	want such output to use color when written to the terminal.
 
 column.ui::
 	Specify whether supported commands should output in columns.
diff --git a/builtin/config.c b/builtin/config.c
index 057bb61..753449f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -342,7 +342,7 @@ static int get_colorbool(int print)
 
 	if (get_colorbool_found < 0)
 		/* default value if none found in config */
-		get_colorbool_found = 0;
+		get_colorbool_found = GIT_COLOR_AUTO;
 
 	get_colorbool_found = want_color(get_colorbool_found);
 
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
1.8.3.rc3.8.g5e49f30
