From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/10] test-dump: new test program to examine binary data
Date: Thu, 26 Sep 2013 09:26:40 +0700
Message-ID: <1380162409-18224-2-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1IQ-0002TD-GO
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab3IZC1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:09 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51763 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3IZC1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:07 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so482429pde.24
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZR5Y8bMka2PgxWt8iUBsCqg9hnZUuvsR7ed+yFBYb24=;
        b=lLa5lOqXg9yneUZqLKOvRvUnF0Jkcuw8HAdMsYPUWkNfhjLoaPoUi4rDSdSyYzNkeN
         BtMqlGOgxEXpxPXmEUEPs3Tx8IyO9plJ43TUE7QmJanVOt4fCrKJvM4JmFoZaG1EnkOE
         Qws/OeldcdJKqQh9x9fHm6AnUWWbwNIqGybl3SIp/oSaBFWHhaFrNA4Wiy5o83d+TzOk
         u9ODyAvOP6zVuuzoa9i6Ui/MFJxQVOzJj9gD9Wca0ug28tbn9xGkjmQDLV8cDHW9VGM6
         u88Qdnvkj6dnlJGkvc0NdKGlXOgR25uP4QVqf0kng9qpVVnry//Fhc8JoLn8kiU9BrUq
         Myzg==
X-Received: by 10.68.125.226 with SMTP id mt2mr36860492pbb.115.1380162427321;
        Wed, 25 Sep 2013 19:27:07 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id bt1sm50857702pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:02 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235388>

This will come handy for verifying binary files like .pack, .idx or
$GIT_DIR/index. For now the only supported command is "ntohl". This
command looks into the given file at the given offset, do ntohl() and
return the value in decimal.

More commands may be added later to decode varint, or decompress a
zlib stream and so on...

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore        |  1 +
 Makefile          |  1 +
 test-dump.c (new) | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 test-dump.c

diff --git a/.gitignore b/.gitignore
index 2e2ae2b..6d835e2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -182,6 +182,7 @@
 /test-ctype
 /test-date
 /test-delta
+/test-dump
 /test-dump-cache-tree
 /test-scrap-cache-tree
 /test-genrandom
diff --git a/Makefile b/Makefile
index af2e3e3..a07a194 100644
--- a/Makefile
+++ b/Makefile
@@ -560,6 +560,7 @@ TEST_PROGRAMS_NEED_X +=3D test-chmtime
 TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
+TEST_PROGRAMS_NEED_X +=3D test-dump
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-index-version
diff --git a/test-dump.c b/test-dump.c
new file mode 100644
index 0000000..71c6f8f
--- /dev/null
+++ b/test-dump.c
@@ -0,0 +1,27 @@
+#include "cache.h"
+
+static inline uint32_t ntoh_l_force_align(void *p)
+{
+	uint32_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohl(x);
+}
+
+int main(int ac, char **av)
+{
+	unsigned char *p;
+	int fd =3D open(av[2], O_RDONLY);
+	struct stat st;
+	if (lstat(av[2], &st))
+		return 1;
+	p =3D mmap(0, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (p =3D=3D (unsigned char*)MAP_FAILED)
+		return 2;
+	if (!strcmp(av[1], "ntohl"))
+		printf("%u\n", ntoh_l_force_align(p + atoi(av[3])));
+	else {
+		fprintf(stderr, "unknown command %s\n", av[1]);
+		return 3;
+	}
+	return 0;
+}
--=20
1.8.2.82.gc24b958
