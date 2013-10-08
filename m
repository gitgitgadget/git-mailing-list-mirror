From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] send-pack: don't send a thin pack when the server doesn't support it
Date: Tue,  8 Oct 2013 10:44:44 +0200
Message-ID: <1381221884-27048-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 10:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTT17-0000vb-6n
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 10:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab3JHIvl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Oct 2013 04:51:41 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:58595 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab3JHIvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 04:51:38 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2013 04:51:38 EDT
Received: from cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id 89315805FA
	for <git@vger.kernel.org>; Tue,  8 Oct 2013 10:44:45 +0200 (CEST)
Received: (nullmailer pid 27086 invoked by uid 1000);
	Tue, 08 Oct 2013 08:44:44 -0000
X-Mailer: git-send-email 1.8.4.561.g1c3d45d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235766>

Not every server out there supports fixing thin packs, so let's send
them a full pack.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

It's not always possible to support thin packs (sometimes there isn't
even an object database to grab bases out of). And in any case git
shouldn't create thin packs if the server hasn't said it knows how to
fix them, as per the point of the extension.

 send-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 7d172ef..7b88ac8 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -205,6 +205,8 @@ int send_pack(struct send_pack_args *args,
 		quiet_supported =3D 1;
 	if (server_supports("agent"))
 		agent_supported =3D 1;
+	if (!server_supports("thin-pack"))
+		args->use_thin_pack =3D 0;
=20
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing=
=2E\n"
--=20
1.8.4.561.g1c3d45d
