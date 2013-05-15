From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 v4] make color.ui default to 'auto'
Date: Wed, 15 May 2013 19:00:56 +0200
Message-ID: <1368637256-22622-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq61ykfang.fsf@grenoble-inp.fr>
 <1368637256-22622-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 15 19:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucf54-0002Jh-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab3EORBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:01:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41775 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759389Ab3EORBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:01:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4FH1BBx009760
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 19:01:11 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Ucf4j-0000Jm-Fk; Wed, 15 May 2013 19:01:13 +0200
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Ucf4j-0005td-Ax; Wed, 15 May 2013 19:01:13 +0200
X-Mailer: git-send-email 1.8.3.rc1.315.g4602f33
In-Reply-To: <1368637256-22622-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 15 May 2013 19:01:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FH1BBx009760
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1369242076.56909@5itVEFJcaVWsDAITQA8xWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224424>

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
---
Adapted after PATCH 1/2, and commit message updated.

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
index 171bad7..4010c43 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -347,7 +347,7 @@ static int get_colorbool(int print)
 
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
1.8.3.rc1.315.g4602f33
