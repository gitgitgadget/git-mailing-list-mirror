From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 10/19] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn-fri?=
 =?UTF-8?Q?endly?=
Date: Fri, 19 Jun 2015 15:34:14 +0200
Organization: gmx
Message-ID: <851b7fdb435c193abf0e20d0f0e171849e302aff.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:34:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wR4-0000BK-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbbFSNeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 09:34:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:54721 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbbFSNeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:34:16 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQu9K-1ZY5PN1h3G-00UKeT; Fri, 19 Jun 2015 15:34:15
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:i6P4ZEUDYoWPw9aocIO1wU8EFcXxARoZyWJryBOL0aDSE8chsLv
 dNsasXgx5CgcGsadU6skXI9JL172b2cGqHTGLY+wzavs7AMzEm2rLogYcYFQdORARIqVGpc
 8ncqbNrHsWo0MHcUwVMcIfcAMojrnUWLX5g/3qaCHLeAaJAATu/Bz0Fy4OtwtK4e8Qm3y/b
 W/ys7S5n4Vxiv6i9zB33g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2zpAVk1IaMI=:6+oeq8/NkVVrx0viuK5jQe
 HW9Yxx9ScTrnnC/Y8wzCMDMMp4uhjLDC68CJxByvxrSl5uAlGCJTERpn9Zl/ob3r4Q+juby75
 2rN1bZpA4+GufrCDPrsSOw8qGShS+kAnYP/YlqvUKBIENSd762H+qWZGc0vI/ejTSg43tKfu6
 kHqeUeyRUT+8UNJnvmiwesYQIMXRj0GOu7g948T8Z24H78VZPGPRGA5nK2ChX8TEHqXWcGTog
 GDn6u8eITbrNbslp//3rgXYS0v8mqq5GrsvHwwVhLPaQIu95QeUYTeZ1djBwJLPKPOFHc/Bjy
 L2c9vIz3ri6BFZYJTFlzDJhdE+4QZGosJe6XuULTakovH2XwqF8cNQpIWEy+J5B4eSTfWCfyM
 1KblAmE2jLgQLRc3BDcCltbUv8V+9LOsiHzFOKzK0GDE1nluVTFbsatSQJshqY5yAQryJqkbQ
 IUiC/YwvDw8mxKwyj9EtAtJttyRok06AthzWlBAEOh7lwaUdvSArdNaD9OaPuyW6aHBrTznRK
 Mqd1I5g7lFqjMhwlkbIOJOuGJjjfhIbIEyo6UKUYAUyEeu4spMgUSehqASLQ+BN9UsrVmB9Nw
 YI6WnqU4oJ/CeAFO7z/4kf4DotypH/C0n7a+HBZomeh13xwtxOiG0K/aqYKWuI6uauv5ysrx2
 vjfC3rWpD9H09APE2cDDUoyun1BOBvv1IDSdSO7ZsMwZhKUXTH+PwPH6EZtq1qi2nfjY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272144>

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
index 0cfa4d0..21e3052 100644
--- a/fsck.c
+++ b/fsck.c
@@ -640,7 +640,8 @@ static int fsck_tag_buffer(struct tag *tag, const c=
har *data,
 	}
 	if (get_sha1_hex(buffer, sha1) || buffer[40] !=3D '\n') {
 		ret =3D report(options, &tag->object, FSCK_MSG_BAD_OBJECT_SHA1, "inv=
alid 'object' line format - bad sha1");
-		goto done;
+		if (ret)
+			goto done;
 	}
 	buffer +=3D 41;
=20
--=20
2.3.1.windows.1.9.g8c01ab4
