From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] get_sha1_oneline: allow to input commit_list
Date: Sun, 12 Dec 2010 17:56:58 +0700
Message-ID: <1292151419-30678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 11:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRjdK-0008IZ-BF
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 11:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0LLK56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 05:57:58 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:62183 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab0LLK55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 05:57:57 -0500
Received: by pxi20 with SMTP id 20so1413609pxi.10
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 02:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2gVJMNvqRalHY2+sgPvqzU1n6DqYtYL8sHthwSPTZWg=;
        b=blgypiq8xKYxR7SeEQ2tshHtgwmsZhDMHACp1YCMi+2tDYCKdCugfUbaKq83jgJX4o
         maCBcB7G7ADyt2XBpCwR80rFYwKvnmFX+n3v03okU8GTR4bwaLUQnuDO8Br+Ehvw/9zk
         QvSCwwCyQPNrqVT/j0CuNHw8GLEjrmTGPkp0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=pczLc1t0EjeVjfDBkCKzjghdBJsihxoeChBGu75s2CIK3wE3ZvHaLmrlf5CCKPyHyN
         K3ya3rpmB5d/7GRovL27TQMWMKXqyQOeW0s4KzdYdGe5BgjjT1zyeSnSwVSvs+kVJqKI
         ZzBwe4UPWk7KL1m8Zl1/rRhrLMuc9rmZlBrd0=
Received: by 10.142.50.7 with SMTP id x7mr2123628wfx.300.1292151476722;
        Sun, 12 Dec 2010 02:57:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id f5sm7141715wfg.14.2010.12.12.02.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 02:57:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 12 Dec 2010 17:57:01 +0700
X-Mailer: git-send-email 1.7.3.3.476.g893a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163477>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2c3a5fb..c298285 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -690,7 +690,9 @@ static int handle_one_ref(const char *path,
 	return 0;
 }
=20
-static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+static int get_sha1_oneline(const char *prefix,
+			    unsigned char *sha1,
+			    struct commit_list *original_list)
 {
 	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
 	int retval =3D -1;
@@ -706,7 +708,12 @@ static int get_sha1_oneline(const char *prefix, un=
signed char *sha1)
 	if (regcomp(&regex, prefix, REG_EXTENDED))
 		die("Invalid search pattern: %s", prefix);
=20
-	for_each_ref(handle_one_ref, &list);
+	for (l =3D original_list; l; l =3D l->next) {
+		commit_list_insert(l->item, &list);
+		l->item->object.flags |=3D ONELINE_SEEN;
+	}
+	if (!list)
+		for_each_ref(handle_one_ref, &list);
 	for (l =3D list; l; l =3D l->next)
 		commit_list_insert(l->item, &backup);
 	while (list) {
@@ -1090,7 +1097,7 @@ int get_sha1_with_context_1(const char *name, uns=
igned char *sha1,
 		int pos;
 		if (namelen > 2 && name[1] =3D=3D '/')
 			/* don't need mode for commit */
-			return get_sha1_oneline(name + 2, sha1);
+			return get_sha1_oneline(name + 2, sha1, NULL);
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
 		    name[1] < '0' || '3' < name[1])
--=20
1.7.3.3.476.g893a9
