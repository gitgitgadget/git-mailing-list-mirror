From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 10/19] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn-fri?=
 =?UTF-8?Q?endly?=
Date: Thu, 18 Jun 2015 22:09:08 +0200
Organization: gmx
Message-ID: <dc0aa536c928cb038e66859b7918106b18395aaf.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g89-0003nn-JE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbbFRUJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 16:09:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:57655 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072AbbFRUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:09:13 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LzoSt-1Z0dzb2uXb-014y8t; Thu, 18 Jun 2015 22:09:08
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Qjtt2bJJnP4WZbe2iMo/KlxkYMwnoFC/2G5pRIbQUWCMLbSgK2c
 nfFiiMM4rkr6D4TbucOeP8qe5gS4XopOz8y2pGE+szEmuFAo4RudyXE5zRIbOB64CTNlS5g
 ZbgEAM+xMSOGP3g1AV2IsRoqmalL6FAbeG8Aoqxj35Oa+4Axb4aYrjD+U4uuz6zfbXsRjEg
 v23uJ9K1lQmsi8ksOiQEA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272053>

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
index 856221d..bd4bfc2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -640,7 +640,8 @@ static int fsck_tag_buffer(struct tag *tag, const c=
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
2.3.1.windows.1.9.g8c01ab4
