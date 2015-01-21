From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 10/19] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn-fri?=
 =?UTF-8?Q?endly?=
Date: Wed, 21 Jan 2015 20:25:40 +0100
Organization: gmx
Message-ID: <726432c3b043ab282eecb9c70ac3f15cb7fc91e3.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:25:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0uU-0002en-8i
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbbAUTZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 14:25:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:64040 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbbAUTZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:25:44 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LyWAQ-1XhJ3b0MVS-015nbd; Wed, 21 Jan 2015 20:25:41
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:/79qNRr9e2N5afeKQKxdho3PwVjpThmk9nqntrw4KkRDZODsr1u
 a97tTc0araxb8EeBGGq8MipUaVuu+XjJgXWe5pTpnq7WjiUm+UZt2bYgF0uDMuUNf3HNBCk
 ZNA/zAsZ/dg4tKAYZuERj4JalIGzTQOvIDNqNmzTaUzBp4nm+GUbGlN7rFJdFFGpKWTqFZD
 +1Gxd1NxUqJ5TN7Vq/9Fg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262755>

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
index 3118db1..4adf9ce 100644
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
2.2.0.33.gc18b867
