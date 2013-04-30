From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/8] mktag: refuse to write tags referring to external objects
Date: Tue, 30 Apr 2013 10:42:51 +0700
Message-ID: <1367293372-1958-8-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1TN-0006PO-9j
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854Ab3D3DnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:43:15 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:59485 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796Ab3D3DnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:43:14 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so107567pad.20
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xcP5ipFlYTpcygmq8mkXow/Fl8UaKWCtaZQN+YqPnk0=;
        b=WvF6OKdHqB9JxcY9zVC+4pjdLS62ognd8dArBUy0L/8issb0N2Qq2y4brwphHX0Ysg
         w3WTnYnYH6p8xYRe9egH7D1ycAOBp6kpnKnu0n0NqJrtmK78Lc7vYn/jqrC/70zn4Pee
         ubDsx1bbPwDnWSc3k8FdPUGU+ts7i8Xd7VGjdMuHlcpbpULiSGIO1r3cdD2LQ3GdZaqV
         lyJTafsHTiOkFzZsoLykWCLDJulb86S69NhU9OO9RH55xsO1hyOLhS05bHJ+kpmEM/xJ
         ktpxxCjH0Fmx8l9LGzMptmd//Sddsgq1nk0hWRpdl/1ivV34USM83PhBOMal1CMS1ROE
         763A==
X-Received: by 10.66.8.69 with SMTP id p5mr49295055paa.57.1367293394066;
        Mon, 29 Apr 2013 20:43:14 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id kr7sm28572621pab.23.2013.04.29.20.43.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:43:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:44:03 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222901>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mktag.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..2284280 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -23,7 +23,10 @@ static int verify_object(const unsigned char *sha1, =
const char *expected_type)
 	int ret =3D -1;
 	enum object_type type;
 	unsigned long size;
-	void *buffer =3D read_sha1_file(sha1, &type, &size);
+	void *buffer =3D read_sha1_file_extended(sha1,
+					       ODB_CACHED | ODB_LOCAL | ODB_ALT,
+					       &type, &size,
+					       READ_SHA1_FILE_REPLACE);
 	const unsigned char *repl =3D lookup_replace_object(sha1);
=20
 	if (buffer) {
--=20
1.8.2.83.gc99314b
