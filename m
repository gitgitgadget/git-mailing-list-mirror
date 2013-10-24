From: Jeff King <peff@peff.net>
Subject: [PATCH 14/19] repack: stop using magic number for ARRAY_SIZE(exts)
Date: Thu, 24 Oct 2013 14:06:54 -0400
Message-ID: <20131024180654.GN24180@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 20:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPJF-0008Vx-Il
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 20:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab3JXSG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 14:06:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:54900 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754747Ab3JXSG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 14:06:56 -0400
Received: (qmail 980 invoked by uid 102); 24 Oct 2013 18:06:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 13:06:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 14:06:54 -0400
Content-Disposition: inline
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236601>

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
