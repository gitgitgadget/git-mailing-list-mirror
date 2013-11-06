From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/2] send-pack: only send a thin pack if the server supports it
Date: Wed,  6 Nov 2013 16:04:23 +0100
Message-ID: <1383750263-32495-3-git-send-email-cmn@elego.de>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 06 16:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve4eu-0008MY-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 16:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab3KFPEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 10:04:31 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:60583 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756591Ab3KFPE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 10:04:26 -0500
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id A754C81544;
	Wed,  6 Nov 2013 16:04:25 +0100 (CET)
Received: (nullmailer pid 32539 invoked by uid 1000);
	Wed, 06 Nov 2013 15:04:23 -0000
X-Mailer: git-send-email 1.8.4.652.g0d6e0ce
In-Reply-To: <1383750263-32495-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237354>

In combination a the previous patch making receive-pack advertise the
thin-pack capability, this allows git to push to a server in a
constrained environment which is not able to fix thin packs while takin=
g
advantage of the feature for servers which can.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
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
1.8.4.652.g0d6e0ce
