From: Jeff King <peff@peff.net>
Subject: [PATCH v2 14/19] repack: stop using magic number for ARRAY_SIZE(exts)
Date: Fri, 25 Oct 2013 02:04:23 -0400
Message-ID: <20131025060422.GL23098@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 08:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaVg-0006zF-7y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3JYGE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:04:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:55319 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182Ab3JYGEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:04:25 -0400
Received: (qmail 3565 invoked by uid 102); 25 Oct 2013 06:04:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:04:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:04:23 -0400
Content-Disposition: inline
In-Reply-To: <20131025055521.GD11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236675>

We have a static array of extensions, but hardcode the size
of the array in our loops. Let's pull out this magic number,
which will make it easier to change.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..2e88975 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -115,7 +115,7 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
-	const char *exts[2] = {".pack", ".idx"};
+	const char *exts[] = {".pack", ".idx"};
 	struct child_process cmd;
 	struct string_list_item *item;
 	struct argv_array cmd_args = ARGV_ARRAY_INIT;
@@ -258,7 +258,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	 */
 	failed = 0;
 	for_each_string_list_item(item, &names) {
-		for (ext = 0; ext < 2; ext++) {
+		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
 			fname = mkpathdup("%s/%s%s", packdir,
 						item->string, exts[ext]);
@@ -315,7 +315,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	/* Now the ones with the same name are out of the way... */
 	for_each_string_list_item(item, &names) {
-		for (ext = 0; ext < 2; ext++) {
+		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
 			struct stat statbuffer;
 			fname = mkpathdup("%s/pack-%s%s",
@@ -335,7 +335,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
-		for (ext = 0; ext < 2; ext++) {
+		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname;
 			fname = mkpath("%s/old-pack-%s%s",
 					packdir,
-- 
1.8.4.1.898.g8bf8a41.dirty
