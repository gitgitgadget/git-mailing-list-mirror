From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 10/18] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn-fri?=  =?UTF-8?Q?endly?=
Date: Mon, 19 Jan 2015 16:51:08 +0100
Organization: gmx
Message-ID: <ab7482bf5661aa8ab23dd65bcd6f8bc037db50ed.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjg-0006Dy-6V
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbbASP7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2015 10:59:23 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbASP7W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:22 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFp8OR026368;
	Mon, 19 Jan 2015 16:51:08 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFp8Im026367;
	Mon, 19 Jan 2015 16:51:08 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262617>

When fsck_tag() identifies a problem with the commit, it should try
to make it possible to continue checking the commit object, in case the
user wants to demote the detected errors to mere warnings.

Just like fsck_commit(), there are certain problems that could hide oth=
er
issues with the same tag object. For example, if the 'type' line is not
encountered in the correct position, the 'tag' line =E2=80=93 if there =
is any =E2=80=93
would not be handled at all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index ed0a669..b8cbbfb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -614,7 +614,8 @@ static int fsck_tag_buffer(struct tag *tag, const c=
har *data,
 	}
 	if (get_sha1_hex(buffer, sha1) || buffer[40] !=3D '\n') {
 		ret =3D report(options, &tag->object, FSCK_MSG_INVALID_OBJECT_SHA1, =
"invalid 'object' line format - bad sha1");
-		goto done;
+		if (ret)
+			goto done;
 	}
 	buffer +=3D 41;
=20
--=20
2.0.0.rc3.9669.g840d1f9
