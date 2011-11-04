From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] fsck: return error code when verify_pack() goes wrong
Date: Fri,  4 Nov 2011 22:47:47 +0700
Message-ID: <1320421670-518-2-git-send-email-pclouds@gmail.com>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 16:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMM1I-000386-W5
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 16:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab1KDPtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 11:49:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab1KDPtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 11:49:24 -0400
Received: by mail-iy0-f174.google.com with SMTP id e36so2682080iag.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BZ0r3VRpGja4L/D89BHDgjJaWc51efz7yi1+e9dOtbE=;
        b=f8tH4Oqzz2HCtQRSgx8iMjhGqIFMnqImyDsMJCZ6qkUOyDM7DHCQeRgmAXmT0yF8MV
         xn8rvjpLWOtOpLIPcJygcNlGFro1BoyTKH5whWtR1kkh4YNGw2yUIOcQ2M63kr1Yon9Q
         GIlDTu0PSXdrM1MPUd4LeeH7xHlXfojnOoGzs=
Received: by 10.42.108.136 with SMTP id h8mr16576513icp.43.1320421764063;
        Fri, 04 Nov 2011 08:49:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.210.255])
        by mx.google.com with ESMTPS id p16sm22105283ibk.6.2011.11.04.08.49.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 08:49:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 04 Nov 2011 22:47:58 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320421670-518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184778>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index df1a88b..4ead98d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -29,6 +29,7 @@ static int write_lost_and_found;
 static int verbose;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
+#define ERROR_PACK 04
=20
 #ifdef NO_D_INO_IN_DIRENT
 #define SORT_DIRENT 0
@@ -626,7 +627,8 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 		prepare_packed_git();
 		for (p =3D packed_git; p; p =3D p->next)
 			/* verify gives error messages itself */
-			verify_pack(p);
+			if (verify_pack(p))
+				errors_found |=3D ERROR_PACK;
=20
 		for (p =3D packed_git; p; p =3D p->next) {
 			uint32_t j, num;
--=20
1.7.4.74.g639db
