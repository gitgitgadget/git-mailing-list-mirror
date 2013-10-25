From: Jeff King <peff@peff.net>
Subject: [PATCH v2 06/19] sha1_file: export `git_open_noatime`
Date: Fri, 25 Oct 2013 02:03:23 -0400
Message-ID: <20131025060322.GD23098@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 08:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaUm-0006Ed-Ff
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab3JYGD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:03:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:55293 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751183Ab3JYGDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:03:25 -0400
Received: (qmail 3353 invoked by uid 102); 25 Oct 2013 06:03:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:03:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:03:23 -0400
Content-Disposition: inline
In-Reply-To: <20131025055521.GD11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236668>

From: Vicent Marti <tanoku@gmail.com>

The `git_open_noatime` helper can be of general interest for other
consumers of git's different on-disk formats.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 1 +
 sha1_file.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 5e3fc72..f2e5aa7 100644
--- a/cache.h
+++ b/cache.h
@@ -780,6 +780,7 @@ extern int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern int git_open_noatime(const char *name);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
diff --git a/sha1_file.c b/sha1_file.c
index f80bbe4..4714bd8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -239,8 +239,6 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-static int git_open_noatime(const char *name);
-
 /*
  * Prepare alternate object database registry.
  *
@@ -1357,7 +1355,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-static int git_open_noatime(const char *name)
+int git_open_noatime(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME;
 
-- 
1.8.4.1.898.g8bf8a41.dirty
