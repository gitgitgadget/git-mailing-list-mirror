From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/17] fixup! index-pack, pack-objects: allow creating .idx v2 with .pack v4
Date: Sat, 21 Sep 2013 20:57:53 +0700
Message-ID: <1379771883-10278-8-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeo-0000mE-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab3IUNz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:27 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37059 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab3IUNzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:23 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so1463206pbb.6
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HbG4KHfwFWnVqxd3YmyfthdFJgqbmCP+MtGxdJiPaj8=;
        b=vTxA2Djg2k8qK1dP5yZEx8ltEfox5LBZZeJqNw0too09E3K6zq+W/unLeoFWNsiZHf
         FLNDidA/qGhOtsYhC+p1ToMlZQMo5JTXdewy3JTWBeam54TBtEksgnYWxtOfTkN+nPy0
         xGNEO9s69TNYnNWYqvA6af5Ut/mfvNtcfdeEco/MtodiG9lEhwpxLhvH4zYsP19vq3YV
         AobzGBnQOlduScBEhwFEReZyQwIPtLMSMIo2/hQk9qvkEAE6CqPj4tqN1oIBEvNqMdDf
         kjJg0DDUZLnA60FdV5xqtJnMKfrSdsAJ4sDs61ZkmLksL0DYvU/fdQBqZGUj05SkiG6R
         OZOQ==
X-Received: by 10.68.224.199 with SMTP id re7mr647668pbc.183.1379771722566;
        Sat, 21 Sep 2013 06:55:22 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id sy10sm25689997pac.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:45 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235108>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index e98eb8b..ef6ecc8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -605,7 +605,9 @@ static int check_packed_git_idx(const char *path,  =
struct packed_git *p)
 		}
 		p->sha1_table =3D pack_map;
 		p->sha1_table +=3D 12;
-	} else
+	} else if (version =3D=3D 2)
+		p->sha1_table =3D idx_map + 8 + 4 * 256;
+	else
 		p->sha1_table =3D NULL;
=20
 	p->index_version =3D version;
--=20
1.8.2.83.gc99314b
