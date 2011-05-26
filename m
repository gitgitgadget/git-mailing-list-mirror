From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] remove tests of always-false condition
Date: Thu, 26 May 2011 15:58:16 +0200
Message-ID: <87zkm95zt3.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 15:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPb53-0001Yx-G5
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607Ab1EZN6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 09:58:24 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51939 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540Ab1EZN6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 09:58:23 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id B64FE940210
	for <git@vger.kernel.org>; Thu, 26 May 2011 15:58:17 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 78AB06026C; Thu, 26 May 2011 15:58:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174510>


* fsck.c (fsck_error_function): Don't test obj->sha1 == 0.
It can never be true, since that sha1 member is an array.
* transport.c (set_upstreams): Likewise for ref->new_sha1.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
Fix some coverity-spotted nits.
Relative to "next".

 fsck.c      |    2 +-
 transport.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6f266c1..60bd4bb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -349,7 +349,7 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...)
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;

-	strbuf_addf(&sb, "object %s:", obj->sha1?sha1_to_hex(obj->sha1):"(null)");
+	strbuf_addf(&sb, "object %s:", sha1_to_hex(obj->sha1));

 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
diff --git a/transport.c b/transport.c
index 1a3998e..c9c8056 100644
--- a/transport.c
+++ b/transport.c
@@ -156,7 +156,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 			continue;
 		if (!ref->peer_ref)
 			continue;
-		if (!ref->new_sha1 || is_null_sha1(ref->new_sha1))
+		if (is_null_sha1(ref->new_sha1))
 			continue;

 		/* Follow symbolic refs (mainly for HEAD). */
--
1.7.5.2.660.g9f46c
