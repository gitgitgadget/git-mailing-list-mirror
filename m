From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] fsck: return error code when verify_pack() goes wrong
Date: Mon,  7 Nov 2011 09:59:23 +0700
Message-ID: <1320634766-24511-2-git-send-email-pclouds@gmail.com>
References: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 04:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNFSK-00082B-5h
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 04:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab1KGDA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 22:00:59 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50093 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1KGDA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 22:00:59 -0500
Received: by qao25 with SMTP id 25so281160qao.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 19:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BZ0r3VRpGja4L/D89BHDgjJaWc51efz7yi1+e9dOtbE=;
        b=LcWT7HFgkk49siMJ//cLsp+KZjfZqE5eCdDTpD1ILZUS6Zs8kP7We3XRwhHH3UfnVz
         d0GNbvzhs9/ZOpGU6NhmV2dZjm7Bw4hj/iXCa3LR6irCOZ2WWeJp+SN54538gQ2VFT97
         xGmhRBC1mEU8Yuenzh/hZ5UJtpYvXAm8c6lPg=
Received: by 10.50.94.229 with SMTP id df5mr39188830igb.27.1320634858162;
        Sun, 06 Nov 2011 19:00:58 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.230.110])
        by mx.google.com with ESMTPS id t5sm32557155pbb.13.2011.11.06.19.00.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 19:00:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Nov 2011 09:59:37 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184940>


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
