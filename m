From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 14/86] parse-options: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:07 +0100
Message-ID: <20131109070720.18178.30853.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2f9-0002lM-CC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933292Ab3KIHIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:42 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36296 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933241Ab3KIHI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:26 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 6BA9061;
	Sat,  9 Nov 2013 08:08:25 +0100 (CET)
X-git-sha1: 6b98ec02ffc967bc31628267f737b416adb5ff7e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237484>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 parse-options.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 62e9b1c..4f7fddc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -273,13 +273,13 @@ is_abbreviated:
 			if (options->flags & PARSE_OPT_NONEG)
 				continue;
 			/* negated and abbreviated very much? */
-			if (!prefixcmp("no-", arg)) {
+			if (has_prefix("no-", arg)) {
 				flags |= OPT_UNSET;
 				goto is_abbreviated;
 			}
 			/* negated? */
-			if (prefixcmp(arg, "no-")) {
-				if (!prefixcmp(long_name, "no-")) {
+			if (!has_prefix(arg, "no-")) {
+				if (has_prefix(long_name, "no-")) {
 					long_name += 3;
 					opt_flags |= OPT_UNSET;
 					goto again;
@@ -289,7 +289,7 @@ is_abbreviated:
 			flags |= OPT_UNSET;
 			rest = skip_prefix(arg + 3, long_name);
 			/* abbreviated and negated? */
-			if (!rest && !prefixcmp(long_name, arg + 3))
+			if (!rest && has_prefix(long_name, arg + 3))
 				goto is_abbreviated;
 			if (!rest)
 				continue;
@@ -334,7 +334,7 @@ static void check_typos(const char *arg, const struct option *options)
 	if (strlen(arg) < 3)
 		return;
 
-	if (!prefixcmp(arg, "no-")) {
+	if (has_prefix(arg, "no-")) {
 		error ("did you mean `--%s` (with two dashes ?)", arg);
 		exit(129);
 	}
@@ -342,7 +342,7 @@ static void check_typos(const char *arg, const struct option *options)
 	for (; options->type != OPTION_END; options++) {
 		if (!options->long_name)
 			continue;
-		if (!prefixcmp(options->long_name, arg)) {
+		if (has_prefix(options->long_name, arg)) {
 			error ("did you mean `--%s` (with two dashes ?)", arg);
 			exit(129);
 		}
-- 
1.8.4.1.566.geca833c
