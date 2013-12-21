From: Jeff King <peff@peff.net>
Subject: [PATCH v4 06/23] sha1_file: export `git_open_noatime`
Date: Sat, 21 Dec 2013 08:59:47 -0500
Message-ID: <20131221135946.GF21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN5t-0004zF-Ji
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab3LUN7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:59:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:48477 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754669Ab3LUN7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:59:48 -0500
Received: (qmail 7350 invoked by uid 102); 21 Dec 2013 13:59:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:59:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:59:47 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239600>

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
1.8.5.1.399.g900e7cd
