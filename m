From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pathspec: reserve some letters after a colon pathspec
Date: Wed, 23 Mar 2011 22:32:33 +0700
Message-ID: <1300894353-19386-1-git-send-email-pclouds@gmail.com>
References: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:32:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Q3J-0004VZ-Ep
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112Ab1CWPcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 11:32:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043Ab1CWPcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:32:47 -0400
Received: by iwn34 with SMTP id 34so8675558iwn.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0M57bzMhEbVRqQP+fGHurNTRBZTIHics57RIv+wkK1I=;
        b=jJhgiDfl3i5nVbCdx3f4qR9w/AV/syBqSVrXoLFiI/RdOMS3tk7yME/7WK7bq4UrGo
         QBaClKLbWnu41L55PDIReAt6+4sFCRcibT+X+a8cmidIpcKkVGLPWmi9T5stm2bpvKx+
         EE7nU5/1hm8cfgje43gLffkvyj1vnuCPzXNOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XoixInZRyvJPpZE/ler4fl5IFaCdT6mvOQfsv/ewRI/kb9uZSqjvoSi27NX30XHySL
         PNemwlRN0v04tBi2+UW3p6jLeh/SgxMIKN2EMhUA0QFtEKxVf7v02+aK4QIeioSmpLsp
         DoDDG9XIHiiTpxEtvnQH6D/1C6btnHLBgzyYE=
Received: by 10.43.70.193 with SMTP id yh1mr5930508icb.129.1300894365926;
        Wed, 23 Mar 2011 08:32:45 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id vr5sm3146941icb.0.2011.03.23.08.32.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 08:32:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Mar 2011 22:32:34 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169842>

Pathspec ':something' means 'something' at top directory. Limit it a
bit so that ':<non-alnum>something' can be reserved for future
extensions. ':\<non-alnum>something' can be used to achieve
':something' before this patch.

All non-alphanumeric chars on the en_US keyboard, except \ and ., are
currently reserved.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is the better, non-whitespace-damaged version. While I mark
 colon_pathspec_type() static, you can export it to use in git-attr.c

 setup.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 3bbb01a..684abb5 100644
--- a/setup.c
+++ b/setup.c
@@ -123,6 +123,27 @@ void verify_non_filename(const char *prefix, const=
 char *arg)
 	    "Use '--' to separate filenames from revisions", arg);
 }
=20
+static int colon_pathspec_type(const char **pathspec)
+{
+	const char *reserved =3D "~`!@#$%^&*()-_=3D+[{]}|;:'\",<>/?";
+	const char *s =3D *pathspec;
+	int ret;
+
+	if (*s++ !=3D ':')
+		return -1;
+	if (*s =3D=3D '\\') {
+		s++;
+		ret =3D 0;
+	}
+	else if (*s && strchr(reserved, *s))
+		ret =3D -1;
+	else
+		ret =3D 0;
+
+	*pathspec =3D s;
+	return ret;
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry =3D *pathspec;
@@ -145,8 +166,14 @@ const char **get_pathspec(const char *prefix, cons=
t char **pathspec)
 	prefixlen =3D prefix ? strlen(prefix) : 0;
 	while (*src) {
 		const char *p;
-		if ((*src)[0] =3D=3D ':')
-			p =3D prefix_path(NULL, 0, (*src)+1);
+
+		if ((*src)[0] =3D=3D ':') {
+			const char **s =3D src;
+			if (colon_pathspec_type(s) !=3D 0)
+				die("Pathspec syntax ':%c' is not supported. %s"
+				    "Quote it for literally match.", (*s)[0], *s);
+			p =3D prefix_path(NULL, 0, *s);
+		}
 		else
 			p =3D prefix_path(prefix, prefixlen, *src);
 		*(dst++) =3D p;
--=20
1.7.4.74.g639db
