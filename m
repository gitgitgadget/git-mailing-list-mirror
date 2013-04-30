From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 8/8] sha1_file: do write objects even if found in ODB_EXTALT database
Date: Tue, 30 Apr 2013 10:42:52 +0700
Message-ID: <1367293372-1958-9-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:43:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1TT-0006UT-6c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868Ab3D3DnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:43:22 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:37275 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796Ab3D3DnV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:43:21 -0400
Received: by mail-pb0-f51.google.com with SMTP id rq13so50105pbb.24
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tYigN8a/BS+OhZLhNrRxmVN7238jLht0I5A1yzG+zCg=;
        b=ACenGukLlY/Gw3OArY6rkSy4nLaDvwjty0HrctwF0HfwX77nyqt8p2to8Z+98MBclJ
         NSJp6dgu9cIpItjxM/5vP2NFgSZ1QrwVAfEtVJHw4rEUuKKa3Axx7I6qqCN6AwT8mqGq
         Sf1sy3/PMFxltNhJOzWlb2mmkU+GiEcgAxmpJNn3yKIBZNIsM4BCkCE7q0flQwK3sl4Y
         GvYJ+F7EMPOQTGdCKRarsG7CwRDZAB+3NCb/hOHeRw6boOFMNN8Ajkos/lhjLeQr1YDD
         fpQ12l0fgXwZLISJIhQAsjPfWcEQMCfSj/c7KmqUGZsZ3NpxMtfdpZr+dcpYlu6UnIUg
         Efmg==
X-Received: by 10.68.202.104 with SMTP id kh8mr73341148pbc.74.1367293400808;
        Mon, 29 Apr 2013 20:43:20 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id li15sm28643066pab.2.2013.04.29.20.43.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:43:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:44:09 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222902>

Those in ODB_EXTALT are temporary and will be gone soon. Make a
permanent copy for safety.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index b8f2afe..ce3698a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2880,7 +2880,7 @@ int write_sha1_file(const void *buf, unsigned lon=
g len, const char *type, unsign
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (has_sha1_file_proper(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
--=20
1.8.2.83.gc99314b
