From: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
Subject: [RFC/PATCH] tag: display original sha1 of deleted/overwritten tag
Date: Thu, 10 Dec 2009 13:34:56 +0100
Message-ID: <1260448496-527-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jari.aalto@cante.net,
	=?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 13:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIiL4-0007SW-Gr
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 13:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbZLJMl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 07:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758524AbZLJMl1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 07:41:27 -0500
Received: from mail.icell.hu ([80.99.238.252]:54962 "EHLO mail.icell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934415AbZLJMlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 07:41:09 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2009 07:41:08 EST
Received: from source.ifleet (unknown [10.1.1.250])
	by mail.icell.hu (Postfix) with ESMTP id 3CA9684;
	Thu, 10 Dec 2009 13:37:29 +0100 (CET)
Received: from fuge by source.ifleet with local (Exim 4.69)
	(envelope-from <zoltan.fuzesi@icell.hu>)
	id 1NIiEZ-0000Ak-4A; Thu, 10 Dec 2009 13:35:03 +0100
X-Mailer: git-send-email 1.6.6.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135020>

It makes possible to undo accidental tag deletion and overwriting.

Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
---
This patch was created in response to this feature request:
http://article.gmane.org/gmane.comp.version-control.git/135016
I named it "RFC" because of the overwriting part.

 builtin-tag.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index c479018..8dca364 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -140,7 +140,7 @@ static int delete_tag(const char *name, const char =
*ref,
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
-	printf("Deleted tag '%s'\n", name);
+	printf("Deleted tag '%s' %s\n", name, sha1_to_hex(sha1));
 	return 0;
 }
=20
@@ -479,6 +479,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		die("%s: cannot lock the ref", ref);
 	if (write_ref_sha1(lock, object, NULL) < 0)
 		die("%s: cannot update the ref", ref);
+	else if (force && hashcmp(object, prev))
+		printf("Overwritten tag '%s' (%s)\n", ref, sha1_to_hex(prev));
=20
 	strbuf_release(&buf);
 	return 0;
--=20
1.6.6.rc2
