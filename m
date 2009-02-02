From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] parse-options: add new function "usage_msg_opt"
Date: Mon, 2 Feb 2009 06:12:58 +0100
Message-ID: <20090202061258.e044e2b7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Feb 02 06:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTr8t-0005cZ-1X
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 06:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbZBBFNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 00:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbZBBFNN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 00:13:13 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:43081 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbZBBFNM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 00:13:12 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id EF5D34C801D;
	Mon,  2 Feb 2009 06:13:04 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id B775E4C80A3;
	Mon,  2 Feb 2009 06:13:01 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108048>

This function can be used instead of "usage_with_options" when you
want to print an error message before the usage string.

It may be useful because:

if (condition)
	usage_msg_opt("condition is false", usage, opts);

is shorter than:

if (condition) {
	fprintf(stderr, "condition is false\n\n");
	usage_with_options(usage, opts);
}

and may be more consistent.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 parse-options.c |    8 ++++++++
 parse-options.h |    4 ++++
 2 files changed, 12 insertions(+), 0 deletions(-)

	This patch may be generaly useful.

diff --git a/parse-options.c b/parse-options.c
index 4c5d09d..7a5fde8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -449,6 +449,14 @@ void usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void usage_msg_opt(const char *msg,
+		   const char * const *usagestr,
+		   const struct option *options)
+{
+	fprintf(stderr, "%s\n\n", msg);
+	usage_with_options(usagestr, options);
+}
+
 int parse_options_usage(const char * const *usagestr,
 			const struct option *opts)
 {
diff --git a/parse-options.h b/parse-options.h
index 9122905..6061a19 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -113,6 +113,10 @@ extern int parse_options(int argc, const char **argv,
 extern NORETURN void usage_with_options(const char * const *usagestr,
                                         const struct option *options);
 
+extern NORETURN void usage_msg_opt(const char *msg,
+				   const char * const *usagestr,
+				   const struct option *options);
+
 /*----- incremantal advanced APIs -----*/
 
 enum {
-- 
1.6.1.2.353.g99fdd.dirty
