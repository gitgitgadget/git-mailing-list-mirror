From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] repack: s/write_bitmap/&s/ in code
Date: Tue, 10 Jun 2014 16:10:07 -0400
Message-ID: <20140610201007.GC14974@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:10:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSN5-0005ah-D9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbaFJUKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:10:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:41248 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932561AbaFJUKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:10:08 -0400
Received: (qmail 13373 invoked by uid 102); 10 Jun 2014 20:10:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:10:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:10:07 -0400
Content-Disposition: inline
In-Reply-To: <20140610200741.GA11248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251226>

The config name is "writeBitmaps", so the internal variable
missing the plural is unnecessarily confusing to write.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not critical, but after getting it wrong several times while
working on the code, I was inspired to write this.

 builtin/repack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index fab9989..36c1cf9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -10,7 +10,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
-static int write_bitmap = -1;
+static int write_bitmaps = -1;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -29,7 +29,7 @@ static int repack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "pack.writebitmaps")) {
-		write_bitmap = git_config_bool(var, value);
+		write_bitmaps = git_config_bool(var, value);
 		return 0;
 	}
 	return git_default_config(var, value, cb);
@@ -172,7 +172,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL('l', "local", &local,
 				N_("pass --local to git-pack-objects")),
-		OPT_BOOL('b', "write-bitmap-index", &write_bitmap,
+		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
 				N_("write bitmap index")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
@@ -195,7 +195,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				git_repack_usage, 0);
 
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmap > 0;
+		pack_kept_objects = write_bitmaps > 0;
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
@@ -221,9 +221,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd_args, "--no-reuse-delta");
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");
-	if (write_bitmap >= 0)
+	if (write_bitmaps >= 0)
 		argv_array_pushf(&cmd_args, "--%swrite-bitmap-index",
-				 write_bitmap ? "" : "no-");
+				 write_bitmaps ? "" : "no-");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs);
-- 
2.0.0.729.g520999f
