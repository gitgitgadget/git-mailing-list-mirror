From: Jeff King <peff@peff.net>
Subject: [PATCH v3 14/21] repack: stop using magic number for ARRAY_SIZE(exts)
Date: Thu, 14 Nov 2013 07:45:54 -0500
Message-ID: <20131114124554.GN10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwJ6-0001LZ-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab3KNMp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:45:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:39141 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753602Ab3KNMp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:45:56 -0500
Received: (qmail 11619 invoked by uid 102); 14 Nov 2013 12:45:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:45:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:45:54 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237838>

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
1.8.5.rc0.443.g2df7f3f
