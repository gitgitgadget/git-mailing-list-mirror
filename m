From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: [PATCH 3/6] Allow zlib to read a pack buffer longer than the actual data
Date: Wed, 14 Oct 2009 12:37:46 +0200
Message-ID: <1255516669-26745-3-git-send-email-herve@itaapy.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com>
 <1255516669-26745-2-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 12:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1Qi-0004AO-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbZJNKpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 06:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbZJNKpq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:45:46 -0400
Received: from mailhost-p4-p2.nerim.net ([195.5.209.61]:52479 "EHLO
	smtp-delay1.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756177AbZJNKpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:45:41 -0400
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [62.4.17.103])
	by smtp-delay1.nerim.net (Postfix) with ESMTP id 7DD21B3B28F
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:36:54 +0200 (CEST)
Received: from localhost.localdomain (itaapy-35-170.cnt.nerim.net [213.215.35.170])
	by mallaury.nerim.net (Postfix) with ESMTP id EA4B5A108C
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 12:35:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1255516669-26745-2-git-send-email-herve@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130283>

As we don't know where the compressed data end, only the size of the
uncompressed data.

Signed-off-by: Herv=C3=A9 Cauwelier <herve@itaapy.com>
---
 src/odb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/odb.c b/src/odb.c
index 2b4b016..349747b 100644
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
1.6.5
