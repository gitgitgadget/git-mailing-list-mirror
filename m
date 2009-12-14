From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/23] Avoid writing to buffer in add_excludes_from_file_1()
Date: Mon, 14 Dec 2009 17:30:53 +0700
Message-ID: <1260786666-8405-11-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FH-0007wL-5w
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbZLNKcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZLNKcr
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:47 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbZLNKco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:44 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TSwTQOFI4otR02Dz0Y984IaYaDPiPQDAJKbx/mjlsoc=;
        b=py9UctRk0yiCPWKS4JSYOua+55BXr3uhJ7eGsrLN964LC7Y3NKMvHW2SInStrRjkhz
         7r2KhAiXlraJ6Abihr8YMPiMs0tApT0+csgFnw0r6DlH0/d4LcMrWsAWz8Y6JLzRt7O8
         lcqTAAFL32Q15O37eKnEoL8FqIxA0tZzLJdmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TBkPSiX2ZvwNc+FREtNfsHsrFzZtzvgUefUNBGqvTaQPCbmKhycFSnauFjaIU/udn0
         lo+VZz1vOntFNMNUc9KvlNgaRm36UEAAb4nqrSwISRXWpcEK/2aHMZu4bifyrd31vRHl
         m4KPvdfq0Iu4oQS+G8dfPW5FAcsmYAtdJ/DO4=
Received: by 10.114.188.17 with SMTP id l17mr3133294waf.135.1260786764001;
        Mon, 14 Dec 2009 02:32:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4904407pzk.3.2009.12.14.02.32.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:02 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135185>

In the next patch, the buffer that is being used within
add_excludes_from_file_1() comes from another function and does not
have extra space to put \n at the end.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index e05b850..1170d64 100644
--- a/dir.c
+++ b/dir.c
@@ -229,10 +229,9 @@ static int add_excludes_from_file_1(const char *fn=
ame,
=20
 	if (buf_p)
 		*buf_p =3D buf;
-	buf[size++] =3D '\n';
 	entry =3D buf;
-	for (i =3D 0; i < size; i++) {
-		if (buf[i] =3D=3D '\n') {
+	for (i =3D 0; i <=3D size; i++) {
+		if (i =3D=3D size || buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
 				add_exclude(entry, base, baselen, which);
--=20
1.6.5.2.216.g9c1ec
