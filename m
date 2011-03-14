From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/3] make_absolute_path: Don't try to copy a string to itself
Date: Mon, 14 Mar 2011 20:18:36 +0100
Message-ID: <1300130318-11279-2-git-send-email-cmn@elego.de>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 20:33:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDWb-0007Y2-7f
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab1CNTdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 15:33:46 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:45619 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab1CNTdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:33:45 -0400
Received: from bee.lab.cmartin.tk (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id C7BEE46102;
	Mon, 14 Mar 2011 20:19:09 +0100 (CET)
Received: (nullmailer pid 11312 invoked by uid 1000);
	Mon, 14 Mar 2011 19:18:38 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300130318-11279-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169015>

Sometimes (at least in t-0001-init.sh test 12), the return value of
make_absolute_path() is passed to it as an argument, making the first
and second arguments to strlcpy() the same, making the test fail when
run under valgrind.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This patch assumes the path returned by make_absolute_path() is never
longer than PATH_MAX, which I think is a safe assumption.

 abspath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/abspath.c b/abspath.c
index 91ca00f..9149a98 100644
--- a/abspath.c
+++ b/abspath.c
@@ -24,7 +24,7 @@ const char *make_absolute_path(const char *path)
 	char *last_elem =3D NULL;
 	struct stat st;
=20
-	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
+	if (buf !=3D path && strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
 		die ("Too long path: %.*s", 60, path);
=20
 	while (depth--) {
--=20
1.7.4.1
