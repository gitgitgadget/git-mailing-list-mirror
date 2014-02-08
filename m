From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] dir: warn about trailing spaces in exclude pattern
Date: Sat,  8 Feb 2014 15:10:03 +0700
Message-ID: <1391847004-22810-2-git-send-email-pclouds@gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 09:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC2zZ-0007A0-FO
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 09:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbaBHIKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 03:10:18 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54655 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaBHIKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 03:10:12 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so4076162pdj.22
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 00:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4OwCRiqtkxjQyn2mHjiXOef15i598s9cWA5qe6BebSg=;
        b=hIaEaEPyq7DCwc7dGlczybu2wF4VsetKGmlWChxj7Jld+6Z2Oq1wBkc0YxpA0/v2G2
         T+MthhKm93Bz4sjFCtJsBtoj/SmCKpDJ629e83eYq04ftOhosVOMqA6Xq59g6H5qmQsH
         fOWNi0jSIieaRXORtdzgYIhOkF7kkDs1MHUKkuiIU1mxg9ueWYf0ndsIdPRckTGfs9WR
         rvfCrmD6lWhEh6/ItFyAVpEfX09FV+mc+1Ixq6YhrVttSC7olrrnJAFOjR1PtzuUg3BM
         EqqSU9w9D5Bdb4sCIxPEs5yoZoPMoEKLQOsPuWMgWPCmvFLi/UhMPOhHeXNWfNIK5LaP
         IUpg==
X-Received: by 10.66.221.199 with SMTP id qg7mr13048189pac.88.1391847012152;
        Sat, 08 Feb 2014 00:10:12 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id lh13sm53661641pab.4.2014.02.08.00.10.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 00:10:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 15:10:15 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241826>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/dir.c b/dir.c
index b35b633..9edde44 100644
--- a/dir.c
+++ b/dir.c
@@ -491,6 +491,16 @@ void clear_exclude_list(struct exclude_list *el)
 	el->filebuf =3D NULL;
 }
=20
+static void check_trailing_spaces(const char *fname, char *buf)
+{
+	int len =3D strlen(buf);
+	while (len && buf[len - 1] =3D=3D ' ')
+		len--;
+	if (buf[len] !=3D '\0')
+		warning(_("%s: trailing spaces in '%s'. Please quote them."),
+			fname, buf);
+}
+
 int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
@@ -542,6 +552,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
+				check_trailing_spaces(fname, entry);
 				add_exclude(entry, base, baselen, el, lineno);
 			}
 			lineno++;
--=20
1.8.5.2.240.g8478abd
