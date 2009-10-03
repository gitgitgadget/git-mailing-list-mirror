From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 3/6] Allow zlib to read a pack buffer longer than the actual data
Date: Sat,  3 Oct 2009 20:09:58 +0200
Message-ID: <1254593401-18801-4-git-send-email-herve@itaapy.com>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com>
 <1254593401-18801-2-git-send-email-herve@itaapy.com>
 <1254593401-18801-3-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu96d-0004eY-EG
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbZJCSJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbZJCSJb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:09:31 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54141 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756695AbZJCSJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:09:30 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 5EF114B0130;
	Sat,  3 Oct 2009 20:08:47 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 289944B0177;
	Sat,  3 Oct 2009 20:08:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1254593401-18801-3-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129492>

As we don't know where the compressed data end, only the size of the
uncompressed data.

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index 3cfc932..89ee1f2 100644
--- a/src/odb.c
+++ b/src/odb.c
@@ -432,7 +432,7 @@ static int inflate_buffer(void *in, size_t inlen, v=
oid *out, size_t outlen)
=20
 	inflateEnd(&zs);
=20
-	if ((status !=3D Z_STREAM_END) || (zs.avail_in !=3D 0))
+	if (status !=3D Z_STREAM_END)
 		return GIT_ERROR;
=20
 	if (zs.total_out !=3D outlen)
--=20
1.6.4.4
