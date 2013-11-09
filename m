From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 75/86] builtin/rev-parse: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:08 +0100
Message-ID: <20131109070720.18178.4544.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l0-00014x-Nw
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933472Ab3KIHOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:35 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55699 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932895Ab3KIHOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 5F82079;
	Sat,  9 Nov 2013 08:14:20 +0100 (CET)
X-git-sha1: 9df8f6b8a4e619c19b4f7e14c41698fedff9bb95 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237553>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/rev-parse.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c76b89d..b6c92e0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -508,7 +508,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			continue;
 		}
-		if (!prefixcmp(arg, "-n")) {
+		if (has_prefix(arg, "-n")) {
 			if ((filter & DO_FLAGS) && (filter & DO_REVS))
 				show(arg);
 			continue;
@@ -560,7 +560,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--short") ||
-			    !prefixcmp(arg, "--short=")) {
+			    has_prefix(arg, "--short=")) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
 				abbrev = DEFAULT_ABBREV;
@@ -588,7 +588,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				symbolic = SHOW_SYMBOLIC_FULL;
 				continue;
 			}
-			if (!prefixcmp(arg, "--abbrev-ref") &&
+			if (has_prefix(arg, "--abbrev-ref") &&
 			    (!arg[12] || arg[12] == '=')) {
 				abbrev_ref = 1;
 				abbrev_ref_strict = warn_ambiguous_refs;
@@ -606,7 +606,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
-			if (!prefixcmp(arg, "--disambiguate=")) {
+			if (has_prefix(arg, "--disambiguate=")) {
 				for_each_abbrev(arg + 15, show_abbrev, NULL);
 				continue;
 			}
@@ -615,7 +615,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
-			if (!prefixcmp(arg, "--branches=")) {
+			if (has_prefix(arg, "--branches=")) {
 				for_each_glob_ref_in(show_reference, arg + 11,
 					"refs/heads/", NULL);
 				continue;
@@ -624,7 +624,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_branch_ref(show_reference, NULL);
 				continue;
 			}
-			if (!prefixcmp(arg, "--tags=")) {
+			if (has_prefix(arg, "--tags=")) {
 				for_each_glob_ref_in(show_reference, arg + 7,
 					"refs/tags/", NULL);
 				continue;
@@ -633,11 +633,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
-			if (!prefixcmp(arg, "--glob=")) {
+			if (has_prefix(arg, "--glob=")) {
 				for_each_glob_ref(show_reference, arg + 7, NULL);
 				continue;
 			}
-			if (!prefixcmp(arg, "--remotes=")) {
+			if (has_prefix(arg, "--remotes=")) {
 				for_each_glob_ref_in(show_reference, arg + 10,
 					"refs/remotes/", NULL);
 				continue;
@@ -724,19 +724,19 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						: "false");
 				continue;
 			}
-			if (!prefixcmp(arg, "--since=")) {
+			if (has_prefix(arg, "--since=")) {
 				show_datestring("--max-age=", arg+8);
 				continue;
 			}
-			if (!prefixcmp(arg, "--after=")) {
+			if (has_prefix(arg, "--after=")) {
 				show_datestring("--max-age=", arg+8);
 				continue;
 			}
-			if (!prefixcmp(arg, "--before=")) {
+			if (has_prefix(arg, "--before=")) {
 				show_datestring("--min-age=", arg+9);
 				continue;
 			}
-			if (!prefixcmp(arg, "--until=")) {
+			if (has_prefix(arg, "--until=")) {
 				show_datestring("--min-age=", arg+8);
 				continue;
 			}
-- 
1.8.4.1.566.geca833c
