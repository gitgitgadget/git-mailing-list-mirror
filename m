From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/3] Rename --pretty=changelog to --pretty=gnucl, and fix a
 bug
Date: Wed, 28 Feb 2007 02:58:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 02:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HME5o-0004mQ-E1
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 02:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXB1B6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 20:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbXB1B6q
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 20:58:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:38971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750985AbXB1B6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 20:58:45 -0500
Received: (qmail invoked by alias); 28 Feb 2007 01:58:44 -0000
X-Provags-ID: V01U2FsdGVkX18z+KpTw4IzbC5CAYW9W1Fa2ylSZJoOgjTzoa2d1x
	onhQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40873>


It was pointed out that this format is rather specific. So, rename it
to "gnucl".

Also fix a bug where it would crash with an empty commit message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/pretty-formats.txt |   10 ++++++++++
 commit.c                         |    2 +-
 diff.c                           |    2 ++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2fe6c31..f9ce4fb 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -77,6 +77,16 @@ displayed in full, regardless of whether --abbrev or
 true parent commits, without taking grafts nor history
 simplification into account.
 
+	* 'gnucl'
++
+--------------------------------------------------------------
+2007-02-22  Simon Josefsson <simon@josefsson.org>
+
+    * link-warning.h, gl/getaddrinfo.c, gl/gnulib.mk,
+         gl/string_.h, lgl/m4/unistd_h.m4: Update.
+--------------------------------------------------------------
+
+
 	* 'format:'
 +
 The 'format:' format allows you to specify which information
diff --git a/commit.c b/commit.c
index 64ddb56..abd84a8 100644
--- a/commit.c
+++ b/commit.c
@@ -38,7 +38,7 @@ struct cmt_fmt_map {
 	{ "fuller",	5,	CMIT_FMT_FULLER },
 	{ "oneline",	1,	CMIT_FMT_ONELINE },
 	{ "format:",	7,	CMIT_FMT_USERFORMAT},
-	{ "changelog",	9,	CMIT_FMT_CHANGELOG}
+	{ "gnucl",	1,	CMIT_FMT_CHANGELOG}
 };
 
 static char *user_format;
diff --git a/diff.c b/diff.c
index aed5388..f2d162f 100644
--- a/diff.c
+++ b/diff.c
@@ -1892,6 +1892,8 @@ static void run_changelog(struct diff_filepair *p, struct diff_options *o,
 static void finalize_changelog(struct diff_options *options,
 		struct changelog_t *changelog)
 {
+	if (!options->stat_sep)
+		return;
 	changelog->offset = print_wrapped_text(": ", -changelog->offset,
 		CHANGELOG_TAB_SIZE + 2, CHANGELOG_WIDTH);
 	changelog->offset = print_wrapped_text(options->stat_sep,
-- 
1.5.0.2.778.g534f-dirty
