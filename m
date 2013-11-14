From: Jeff King <peff@peff.net>
Subject: [PATCH v3 15/21] repack: turn exts array into array-of-struct
Date: Thu, 14 Nov 2013 07:46:01 -0500
Message-ID: <20131114124600.GO10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:46:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwJF-0001UV-8O
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab3KNMqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:46:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:39144 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753818Ab3KNMqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:46:02 -0500
Received: (qmail 11636 invoked by uid 102); 14 Nov 2013 12:46:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:46:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:46:01 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237839>

This is slightly more verbose, but will let us annotate the
extensions with further options in future commits.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2e88975..a176de2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -115,7 +115,12 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
-	const char *exts[] = {".pack", ".idx"};
+	struct {
+		const char *name;
+	} exts[] = {
+		{".pack"},
+		{".idx"},
+	};
 	struct child_process cmd;
 	struct string_list_item *item;
 	struct argv_array cmd_args = ARGV_ARRAY_INIT;
@@ -261,14 +266,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
 			fname = mkpathdup("%s/%s%s", packdir,
-						item->string, exts[ext]);
+						item->string, exts[ext].name);
 			if (!file_exists(fname)) {
 				free(fname);
 				continue;
 			}
 
 			fname_old = mkpath("%s/old-%s%s", packdir,
-						item->string, exts[ext]);
+						item->string, exts[ext].name);
 			if (file_exists(fname_old))
 				if (unlink(fname_old))
 					failed = 1;
@@ -319,9 +324,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			char *fname, *fname_old;
 			struct stat statbuffer;
 			fname = mkpathdup("%s/pack-%s%s",
-					packdir, item->string, exts[ext]);
+					packdir, item->string, exts[ext].name);
 			fname_old = mkpathdup("%s-%s%s",
-					packtmp, item->string, exts[ext]);
+					packtmp, item->string, exts[ext].name);
 			if (!stat(fname_old, &statbuffer)) {
 				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 				chmod(fname_old, statbuffer.st_mode);
@@ -340,7 +345,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			fname = mkpath("%s/old-pack-%s%s",
 					packdir,
 					item->string,
-					exts[ext]);
+					exts[ext].name);
 			if (remove_path(fname))
 				warning(_("removing '%s' failed"), fname);
 		}
-- 
1.8.5.rc0.443.g2df7f3f
