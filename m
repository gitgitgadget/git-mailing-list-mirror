From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 10/19] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn-fri?=
 =?UTF-8?Q?endly?=
Date: Sat, 31 Jan 2015 22:05:56 +0100
Organization: gmx
Message-ID: <eff683e7d1c7bd3b692f20c170615671e1672f84.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfF9-0004iY-Kl
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbbAaVGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2015 16:06:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:50421 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:06:11 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4WuC-1XS49Q47K8-00yiUz; Sat, 31 Jan 2015 22:05:57
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:qSgTO+WZmjnv7SXD6o1GFzn1kUa69RycI24CfrlxTL16kUE3wJ3
 DEaUw3GXFWSrSPFbwyveBdMYU8VQaMnFFCyLOhd58eiNRVflvFW3h1fw6SK4uIufpRKbhuY
 m+MAGOLWF8flMI4dnsoD293Mzg0HzPqSw/b7goa+Xmdllw3vNjBp6aOFlmBRE3Jhsm3qyct
 80C+B9a+1vjDOXGPmhPFg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263220>

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
index b92d8c4..f72e404 100644
--- a/fsck.c
+++ b/fsck.c
@@ -620,7 +620,8 @@ static int fsck_tag_buffer(struct tag *tag, const c=
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
2.2.0.33.gc18b867
