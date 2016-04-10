From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 08/21] bisect: make bisect compile if DEBUG_BISECT is set
Date: Sun, 10 Apr 2016 15:19:01 +0200
Message-ID: <1460294354-7031-9-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFJ3-0000h0-6k
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbcDJNVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:21:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:51381 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbcDJNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:07 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LnDof-1bS9PS0fSn-00hJuR; Sun, 10 Apr 2016 15:20:03
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:wry55k+Iag2kHDJImIVO0gqOLtzaAkjIEXY18rTZ9q3xdLyJGjl
 MPYOe+WX0RYAa/8Njn8SiGAPfhrtfS/3Ym0yI8ls0flMdYDzhcklldqcyaW3SeMeprAQMYj
 2aaHXIpaGz6P8rwyWK6r+MaWRmTeVOlFd5RjGth7sPHVh6uopVSbIGD9SJSOQXFWJGcoZga
 HqN8jpl5rqU16IVwEm+BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Ljb7RaCKPY=:HQ9ZdHXSZzwoCsZ2VwCL7D
 rQWI7b59R24nNuUxb6hTQThq9OHk86F/d7o15USVzGeLb0pRf6LloqaCdgGxJ8cj/MGPHh/iq
 0HbMkq34+BJI/d5vENzpIBTk6tHWW/epzoHagEtFLnT5Af4xbSJW1sxRl3khdhrobYd0UbVQf
 tFqhP5wb9Xp65TopkrU70glN+flLZSiIGNsVqQe2lC/X1pbW1APQPuL7hlCjIpgQn3xMqXnfX
 2Elsysw5LP51cOZpGd2adjjEndMjd0zfY9weodxfmbkIuSw18dyXwJxZxWuQmmPFcyWIhsLUN
 3Ecso3m6N2wsaSeZeMDUJhEtIlselMBLjXYVXsOiyQiCIwJK96grvVQnvSivtnwCBzo4mrdMz
 f2RVANOkeBxPG4SCwEqe8O1tBkBFP8hBJd8NCpv4reomqL00AQVaO5Py0mN1maUjiKPiGle0/
 YiBkgG03HyT5hLVoB0JNsa0pUDTo03+QCCKo8HZA29cKv7r32xE4sCFsvmgH8iuALltL8aFUY
 kBk3skNwHAXHaxex66ldno/zGKT6bNk2dBA1EVYAJ1/jwK+72WEvXRsjusqKg8RcyV8UlqaiZ
 XSEkOB2SBN8zedUs9ajh0sDeizVpy98Fn3cLeZscotDDa228VEzzfLp/Iem7mVsymxOnyuVHo
 Z4fa0oHtKnIJ9FP2ekoU3EwpHn7G7qSqXBmNKV9TeFlswhSCQRuk7bU1BMMmjOkup8jJaDFP1
 TtGlniGuCEU8IdCBf2EkXjb1x1kdgoOc+jPPRbkkE2xJzZZr0RZ8+E0BDC0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291166>

Setting the macro DEBUG_BISECT to 1 enables debugging information
for the bisect algorithm. The code did not compile due to struct
changes.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 901e4d3..2f54d96 100644
--- a/bisect.c
+++ b/bisect.c
@@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+		char *buf = read_sha1_file(commit->object.oid.hash, &type, &size);
 		const char *subject_start;
 		int subject_len;
 
@@ -143,10 +143,10 @@ static void show_list(const char *debug, int counted, int nr,
 			fprintf(stderr, "%3d", weight(p));
 		else
 			fprintf(stderr, "---");
-		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
+		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
 		for (pp = commit->parents; pp; pp = pp->next)
 			fprintf(stderr, " %.*s", 8,
-				sha1_to_hex(pp->item->object.sha1));
+				sha1_to_hex(pp->item->object.oid.hash));
 
 		subject_len = find_commit_subject(buf, &subject_start);
 		if (subject_len)
-- 
2.8.1.137.g522756c
