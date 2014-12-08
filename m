From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 10/18] Make fsck_tag() warn-friendly
Date: Mon, 8 Dec 2014 17:15:06 +0100 (CET)
Message-ID: <1654f9b634e4e21191c92199563dc42faf2e3d40.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-110140437-1418055306=:13845"
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0y2-0006EY-2l
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbaLHQPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:59173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbaLHQPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:12 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0M1iGk-1Xiwqm45ms-00tlPv;
 Mon, 08 Dec 2014 17:15:07 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:xNMW9c72bqL5mWJva3sOGRDH/lrpd1L4Uzt/CeJwm8Qx3lIBXLq
 /ZDG/eyRUibxmiP0MTuNFDnN4lMzI742MZ6glLnvWmpxkQk+vU0wcR9jzfTufug5ba5xWmq
 MBc/RIQMvUkYjmWEzjErMf2VfPvARD8Jy8/sTIJ6bhojq78M/PqLYuducJs6sMUV/+5Jtgd
 FEP5yahR/7GGsyQ0wOIuA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261062>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-110140437-1418055306=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

When fsck_tag() identifies a problem with the commit, it should try
to make it possible to continue checking the commit object, in case the
user wants to demote the detected errors to mere warnings.

Just like fsck_commit(), there are certain problems that could hide other
issues with the same tag object. For example, if the 'type' line is not
encountered in the correct position, the 'tag' line =E2=80=93 if there is a=
ny =E2=80=93
would not be handled at all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 21ff35b..c1e7a85 100644
--- a/fsck.c
+++ b/fsck.c
@@ -604,7 +604,8 @@ static int fsck_tag_buffer(struct tag *tag, const char =
*data,
 =09}
 =09if (get_sha1_hex(buffer, sha1) || buffer[40] !=3D '\n') {
 =09=09ret =3D report(options, &tag->object, FSCK_MSG_INVALID_OBJECT_SHA1, =
"invalid 'object' line format - bad sha1");
-=09=09goto done;
+=09=09if (ret)
+=09=09=09goto done;
 =09}
 =09buffer +=3D 41;
=20
--=20
2.0.0.rc3.9669.g840d1f9

--1784107012-110140437-1418055306=:13845--
