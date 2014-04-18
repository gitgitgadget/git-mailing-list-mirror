From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] blame: add correct paddings in time_buf for align
Date: Fri, 18 Apr 2014 16:44:25 +0800
Message-ID: <43a3735a164c923acc8e6e2681dfbd727cda63de.1397810231.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 10:44:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb4Pj-0006hN-7B
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 10:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaDRIop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2014 04:44:45 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:35891 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaDRIom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 04:44:42 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so1276419pbb.14
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=mzKv+mlQh64w+yMeJvVLxCTT6vK9G1M8F9S7QNZRV10=;
        b=0M8/LVb+HvxawowxU+pDJFT2dg1/ywjBedyQ+J/UJOlZVipkLZlmt77IryR9r2gUNV
         GxqTLtZr6U47X3gmgzthhhMJDFshBZKrYKGcKyfzXs8o+qtcQnOgNAIVb0HmyitdRw2y
         bXOG4w6ri2kR1qZ+oIWJ0RIvvqHMH7SZbbDkpQKETv9WV488C8zRtKNownD/JRWENb/V
         CUyoDct+wO96G9MIsYH33ENllbpfSudsIAq/yyuHM5blW59+4chJ+ouC4RI40BiFGHFA
         AysLA3RwhKu6anVUgvbCKTjb/0zoN/DBg9NgNT7W9PEo8BTEshSdL+5AefrBE7DTRM+D
         Eptw==
X-Received: by 10.68.221.42 with SMTP id qb10mr20815895pbc.65.1397810681661;
        Fri, 18 Apr 2014 01:44:41 -0700 (PDT)
Received: from localhost.localdomain ([61.233.23.226])
        by mx.google.com with ESMTPSA id te2sm138538105pac.25.2014.04.18.01.44.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Apr 2014 01:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.474.g17b2a16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246464>

When show blame information with relative time, the UTF-8 characters in
`time_str` will break the alignment of columns after the date field.
This is because the `time_buf` padding with spaces should have a
constant display width, not a fixed strlen size.  So we should call
utf8_strwidth() instead of strlen() for calibration.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---

Before applying this patch:

        5817da01 builtin-blame.c   (Pierre Habouzit             6 =E5=B9=
=B4=E5=89=8D                         21) #include "parse-options.h"
        ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 =E5=B9=
=B4=E5=89=8D                         22) #include "utf8.h"
        3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 =E5=B9=
=B4 10 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D            23) #include "us=
erdiff.h"
        25ed3412 builtin/blame.c   (Bo Yang                     1 =E5=B9=
=B4 1 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D             24) #include "li=
ne-range.h"
        58dbfa2e builtin/blame.c   (Eric Sunshine               9 =E4=B8=
=AA=E6=9C=88=E4=B9=8B=E5=89=8D                   25) #include "line-log=
=2Eh"
        cee7f245 builtin-pickaxe.c (Junio C Hamano              8 =E5=B9=
=B4=E5=89=8D                         26)=20

After applying this patch:

        5817da01 builtin-blame.c   (Pierre Habouzit             6 =E5=B9=
=B4=E5=89=8D                           21) #include "parse-options.h"
        ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 =E5=B9=
=B4=E5=89=8D                           22) #include "utf8.h"
        3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 =E5=B9=
=B4 10 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                 23) #includ=
e "userdiff.h"
        25ed3412 builtin/blame.c   (Bo Yang                     1 =E5=B9=
=B4 1 =E4=B8=AA=E6=9C=88=E4=B9=8B=E5=89=8D                  24) #includ=
e "line-range.h"
        58dbfa2e builtin/blame.c   (Eric Sunshine               9 =E4=B8=
=AA=E6=9C=88=E4=B9=8B=E5=89=8D                       25) #include "line=
-log.h"
        cee7f245 builtin-pickaxe.c (Junio C Hamano              8 =E5=B9=
=B4=E5=89=8D                           26)=20

 builtin/blame.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 88cb799..c8f6647 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1564,12 +1564,19 @@ static const char *format_time(unsigned long ti=
me, const char *tz_str,
 	else {
 		const char *time_str;
 		int time_len;
+		int time_col;
 		int tz;
 		tz =3D atoi(tz_str);
 		time_str =3D show_date(time, tz, blame_date_mode);
 		time_len =3D strlen(time_str);
 		memcpy(time_buf, time_str, time_len);
-		memset(time_buf + time_len, ' ', blame_date_width - time_len);
+		/*
+		 * Add space paddings to time_buf to display a fixed width
+		 * string, and use time_col for display width calibration.
+		 */
+		time_col =3D utf8_strwidth(time_str);
+		memset(time_buf + time_len, ' ', blame_date_width - time_col);
+		*(time_buf + time_len + blame_date_width - time_col) =3D 0;
 	}
 	return time_buf;
 }
--=20
1.9.2.474.g17b2a16
