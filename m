From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 14/26] Do not try to read $GIT_DIR/info/attributes if there is no repository
Date: Tue, 16 Feb 2010 23:05:05 +0700
Message-ID: <1266336317-607-15-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ5H-0005aD-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166Ab0BPQP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:15:29 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:61942 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757151Ab0BPQP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:15:27 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2010 11:15:12 EST
Received: by mail-yw0-f197.google.com with SMTP id 35so4824679ywh.21
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7VnkADQqZt12o/DPNnBCFd3qXl26HhS669fF+I+9l4I=;
        b=iP6AnH0Vbjaowml2TOq1gVgYpA4pHwRAoKH0OyrNrs9XEHRUbCCJwFHM12vD1/mMUz
         PYDn7UBzQBC0Q4EDCsC5r6ewIC9miI04//fJ2yX2L4znlTUuMi+2OEbKCIZjpvxxZ1R1
         2nl1+DiBBJGmYPzuT0lDbPh/AUNzkhRQeCAn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HmY4pe818o0r5FdPPKTEEVDw6ychPzLNrkGuygb/JDjy3PP5JygzJ36P9lagdUxF6J
         dJw1PGwGinTGbGwzq7dfe3QIJW5HIkb0VX2frZE3NkV2lBck5yCUUQHFOd8abJCF5FkI
         XgvGhkeb1Upmp86kXpV6h31LXP1d7kEUWAJFM=
Received: by 10.150.251.10 with SMTP id y10mr8458327ybh.131.1266336570547;
        Tue, 16 Feb 2010 08:09:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 8sm2855981ywg.19.2010.02.16.08.09.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:48 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140119>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index f5346ed..f1362de 100644
--- a/attr.c
+++ b/attr.c
@@ -480,7 +480,10 @@ static void bootstrap_attr_stack(void)
 			debug_push(elem);
 		}
=20
-		elem =3D read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		if (!startup_info || startup_info->have_repository)
+			elem =3D read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		else
+			elem =3D NULL;
 		if (!elem)
 			elem =3D xcalloc(1, sizeof(*elem));
 		elem->origin =3D NULL;
--=20
1.7.0.195.g637a2
