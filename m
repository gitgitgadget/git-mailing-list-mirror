From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 2/8] Avoid writing to buffer in add_excludes_from_file_1()
Date: Tue, 11 Aug 2009 22:44:00 +0700
Message-ID: <1250005446-12047-3-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatWq-0006wH-Tb
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbZHKPo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZHKPo0
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbZHKPoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:25 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kyFbfg9Ha3ViGreNgK2kLEWmsAxnym0VCRMladjsaJo=;
        b=Lm4c9gipLIGwnyndV3dYy0QU4RWmhPkvfKgKnv9mWIb+U/eVP4XEzNHNKc+Gfqb0Rd
         oDJVu+ZmP/SaZVU/Xd9mpJ2zgn6WWJWRctdqbM5kUU/eTzBXrLVQBVcO30IzC20JTKww
         cWZcR7mBCz7SHy5VLjLWAVn5Zbpv13hT3sMa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CraZgQZJkremd/+0fAQFEQr1jTdhC8/pJJZk0sc5d55y/eRGkE3hAUCHPiAvpfwde9
         PBWFbUfrePjgfSmo8dhyKlh1q/Vyp/75FOIS46APUAtzNYxaCNCKb+DOr1Gqw4VOO5kZ
         CDHN+VagYIy6aCRUvtexPxLhrGLaUSSc2MScE=
Received: by 10.140.143.12 with SMTP id q12mr1979347rvd.115.1250005466354;
        Tue, 11 Aug 2009 08:44:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id f42sm32816048rvb.15.2009.08.11.08.44.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:20 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125577>

In the next patch, the buffer that is being used within
add_excludes_from_file_1() comes from another function and does not
have extra space to put \n at the end.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.6.3.GIT
