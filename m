From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/9] pv4_tree_desc: use struct tree_desc from pv4_tree_desc
Date: Wed,  9 Oct 2013 21:46:11 +0700
Message-ID: <1381329976-32082-5-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuyy-0007Mi-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab3JIOnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:16 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54765 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3JIOnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:16 -0400
Received: by mail-pa0-f47.google.com with SMTP id kp14so1115502pab.20
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6DYSvZW4zXUzhk6l/N6MBDXp5jWY6g4gjfFM+wDv4dc=;
        b=oV4UMiZsm/PQV7RDesYUPHKoxqSTnSQezefE3aS/jBKnAWiqJlJVfRcncWCbMbhpZC
         k+mo2EGtmlltg4Jm7zdp1cGvKIkgINhvqz1yeOOfGsCYCUcSKUnm5MmG386Luk80+DY5
         jvzUNGpH+hhsWWefWRtqLsAKQbA8EJXerbd0+NiSRkwNpv1/2+fUHLDOrrQ9yxwIyoDg
         9ULEr7l2po92zEnJveHlaUxbzUrJUfeiKhnnKvX8+47ET7I+eDprui9Cj4g9n9cgmahr
         zlFHuzgQyudaEjUnpxT8VbtMv6HPqPRjjRJtCo1cAflp2nirXpwjpCp0p+zrcIDwVqTF
         hYQg==
X-Received: by 10.66.147.230 with SMTP id tn6mr9914237pab.135.1381329794842;
        Wed, 09 Oct 2013 07:43:14 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id bp4sm44474368pbb.42.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:46:57 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235817>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 13 ++++++-------
 packv4-parse.h |  5 +++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index f9db364..f5c486e 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -10,7 +10,6 @@
=20
 #include "cache.h"
 #include "packv4-parse.h"
-#include "tree-walk.h"
 #include "varint.h"
=20
 const unsigned char *get_sha1ref(struct packed_git *p,
@@ -351,7 +350,7 @@ static int copy_canonical_tree_entries(struct pv4_t=
ree_desc *v4, off_t offset,
 	const unsigned char *from, *end;
 	enum object_type type;
 	unsigned long size;
-	struct tree_desc desc;
+	struct tree_desc *desc =3D &v4->v2;
=20
 	data =3D unpack_entry(v4->p, offset, &type, &size);
 	if (!data)
@@ -361,15 +360,15 @@ static int copy_canonical_tree_entries(struct pv4=
_tree_desc *v4, off_t offset,
 		return -1;
 	}
=20
-	init_tree_desc(&desc, data, size);
+	init_tree_desc(desc, data, size);
=20
 	while (start--)
-		update_tree_entry(&desc);
+		update_tree_entry(desc);
=20
-	from =3D desc.buffer;
+	from =3D desc->buffer;
 	while (count--)
-		update_tree_entry(&desc);
-	end =3D desc.buffer;
+		update_tree_entry(desc);
+	end =3D desc->buffer;
=20
 	if (end - from > strbuf_avail(&v4->buf)) {
 		free(data);
diff --git a/packv4-parse.h b/packv4-parse.h
index cad7a82..04b9a59 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -1,6 +1,8 @@
 #ifndef PACKV4_PARSE_H
 #define PACKV4_PARSE_H
=20
+#include "tree-walk.h"
+
 struct packv4_dict {
 	const unsigned char *data;
 	unsigned int nb_entries;
@@ -27,6 +29,9 @@ struct pv4_tree_desc {
 	struct packed_git *p;
 	struct pack_window *w_curs;
=20
+	/* v2 entry */
+	struct tree_desc v2;
+
 	/* full canonical tree */
 	struct strbuf buf;
 };
--=20
1.8.2.83.gc99314b
