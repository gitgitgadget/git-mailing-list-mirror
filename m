From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] Document pack v4 format
Date: Sat, 31 Aug 2013 09:49:53 +0700
Message-ID: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 04:47:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFbDO-0003j8-ST
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 04:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab3HaCrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 22:47:00 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53303 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3HaCrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 22:47:00 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so2570662pbc.32
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rjbSiRuZRmUhE0mQdAqh5c8j8d0v6/bUkNxJPm45kx8=;
        b=0HiD0EUm8ffxE04hu30rkvDylvhGUs9J1UNbDXVNcLoOzkL8HL8n1gTA6QkkHjlXki
         BaMejZtMYCAK5ub8g3JMvvHDw8DnshJjnDpS2yZ5ctKL8Soxh/q5a4sjUiFUrnAsz/44
         stVA6mmHMqnK1KqEDRSgfd7ebIfGa/3fImn6/xIISJ3pkn2Dch0tnJDx/xc0cSE4NDUs
         yfMu71sB7XlLRYkjaMbLHm6mD0MCgX2N70UxsqTGEI38h2DDHwfGknX1azmGT1swFDFV
         Sblg1xInftTjBqw3YJ+3RmXq2ePtH+tN5/+YY+TTI+S758Q6WuwgErfCTMiYtUycCM0V
         KDpw==
X-Received: by 10.67.30.70 with SMTP id kc6mr13943619pad.32.1377917219502;
        Fri, 30 Aug 2013 19:46:59 -0700 (PDT)
Received: from lanh ([115.73.192.224])
        by mx.google.com with ESMTPSA id w8sm1372450paj.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 19:46:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 31 Aug 2013 09:50:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233492>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Incorporated suggestions by Nico and Junio. I went ahead and added
 escape hatches for converting thin packs to full ones so the document
 does not really match the code (I've been watching Nico's repository,
 commit reading is added, good stuff!)

 The proposal is, value 0 in the index to ident table is reserved,
 followed by the ident string. The real index to ident table is idx-1.

 Similarly, the value 1 in the index to path name table is reserved=20
 (value 0 is already used for referring back to base tree) so the
 actual index is idx-2.

 Documentation/technical/pack-format.txt | 128 ++++++++++++++++++++++++=
+++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/te=
chnical/pack-format.txt
index 8e5bf60..c866287 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,7 +1,7 @@
 Git pack format
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-=3D=3D pack-*.pack files have the following format:
+=3D=3D pack-*.pack files version 2 and 3 have the following format:
=20
    - A header appears at the beginning and consists of the following:
=20
@@ -36,6 +36,127 @@ Git pack format
=20
   - The trailer records 20-byte SHA-1 checksum of all of the above.
=20
+=3D=3D pack-*.pack files version 4 have the following format:
+
+   - A header appears at the beginning and consists of the following:
+
+     4-byte signature:
+	The signature is: {'P', 'A', 'C', 'K'}
+
+     4-byte version number (network byte order): must be 4
+
+     4-byte number of objects contained in the pack (network byte orde=
r)
+
+   - A series of tables, described separately.
+
+   - The tables are followed by number of object entries, each of
+     which looks like below:
+
+     (undeltified representation)
+     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     data
+
+     (deltified representation)
+     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     base object name in SHA-1 reference encoding
+     compressed delta data
+
+     In undeltified format, blobs and tags ares compressed. Trees are
+     not compressed at all. Some headers in commits are stored
+     uncompressed, the rest is compressed. Tree and commit
+     representations are described in detail separately.
+
+     Blobs and tags are deltified and compressed the same way in
+     v3. Commits are not delitifed. Trees are deltified using
+     undeltified representation.
+
+  - The trailer records 20-byte SHA-1 checksum of all of the above.
+
+=3D=3D=3D Pack v4 tables
+
+ - A table of sorted SHA-1 object names for all objects contained in
+   the pack.
+
+   This table can be referred to using "SHA-1 reference encoding":
+   It's an index number in variable length encoding. If it's
+   non-zero, its value minus one is the index in this table. If it's
+   zero, 20 bytes of SHA-1 is followed.
+
+ - Ident table: the uncompressed length in variable encoding,
+   followed by zlib-compressed dictionary. Each entry consists of
+   two prefix bytes storing timezone followed by a NUL-terminated
+   string.
+
+   Entries should be sorted by frequency so that the most frequent
+   entry has the smallest index, thus most efficient variable
+   encoding.
+
+   The table can be referred to using "ident reference encoding":
+   It's an index number in variable length encoding. If it's
+   non-zero, its value minus one is the index in this table. If it's
+   zero, a new entry in the same format is followed: two prefix
+   bytes and a NUL-terminated string.
+
+ - Tree path table: the same format to ident table. Each entry
+   consists of two prefix bytes storing tree entry mode, then a
+   NUL-terminated path name. Same sort order recommendation applies.
+
+=3D=3D=3D Commit representation
+
+  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+
+  - Tree SHA-1 in SHA-1 reference encoding
+
+  - Parent count in variable length encoding
+
+  - Parent SHA-1s in SHA-1 reference encoding
+
+  - Author reference in ident reference encoding
+
+  - Author timestamp in variable length encoding
+
+  - Committer reference in ident reference encoding
+
+  - Committer timestamp in variable length encoding
+
+  - Compressed data of remaining header and the body
+
+=3D=3D=3D Tree representation
+
+  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+
+  - Number of tree entries in variable length encoding
+
+  - A number of entries, each starting with path component reference:
+    an number, in variable length encoding.
+
+    If the path component reference is greater than 1, its value minus
+    two is the index in tree path table. The path component reference
+    is followed by the tree entry SHA-1 in SHA-1 reference encoding.
+
+    If the path component reference is 1, it's followed by
+
+    - two prefix bytes representing tree entry mode
+
+    - NUL-terminated path name
+
+    - tree entry SHA-1 in SHA-1 reference encoding
+
+    If the path component reference is zero, tree entries will be
+    copied from another tree. It's followed by:
+
+    - the starting index number, in variable length encoding, in the
+      base tree object to copy from. Bit zero in this number is base
+      tree flag, so the actual index is this number shifted right by
+      one bit.
+
+    - number of tree entries to copy from, in variable length encoding
+
+    - base tree in SHA-1 reference encoding if base tree flag is
+      set. If the flag is cleared, the previous base tree encountered
+      is used. This avoids repeating the same base tree SHA-1 in the
+      common case.
+
 =3D=3D Original (version 1) pack-*.idx files have the following format=
:
=20
   - The header consists of 256 4-byte network byte order
@@ -160,3 +281,8 @@ Pack file entry: <+
     corresponding packfile.
=20
     20-byte SHA-1-checksum of all of the above.
+
+=3D=3D Version 3 pack-*.idx files support only *.pack files version 4.=
 The
+   format is the same as version 2 except that the table of sorted
+   20-byte SHA-1 object names is missing in the .idx files. The same
+   table exists in .pack files and will be used instead.
--=20
1.8.2.83.gc99314b
