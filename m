From: Jeff King <peff@peff.net>
Subject: [PATCH v4 15/23] repack: stop using magic number for ARRAY_SIZE(exts)
Date: Sat, 21 Dec 2013 09:00:19 -0500
Message-ID: <20131221140019.GO21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6W-0005cG-9l
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab3LUOAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:48493 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUOAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:21 -0500
Received: (qmail 7503 invoked by uid 102); 21 Dec 2013 14:00:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:20 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:19 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239608>

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
1.8.5.1.399.g900e7cd
