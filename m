From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] doc: technical details about the index file format
Date: Mon,  6 Sep 2010 20:37:10 +1000
Message-ID: <1283769430-9263-1-git-send-email-pclouds@gmail.com>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 07 00:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OskB7-0002TU-Mg
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab0IFW2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:28:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41444 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0IFW2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 18:28:24 -0400
Received: by pwi3 with SMTP id 3so1194595pwi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cp+Q+2rRK6Ofe1++L2nX+6FHfSvPYFLtjtV6v94Sx2U=;
        b=hu/jpddlimCPDsP8rp8krn+i+ytkk0vvreOaP6lYrQVrE3NRShZ+U1DrPrpaCZNS5r
         L4xL6KQg69xtJNZvkSd7MOM5l+RPdyJipO06uRkMAmPuWgduFIETbnEmeiqKmAyBN8rX
         d0BsJnvSIA0oKNGmwVN2EAXpy715Oq/N5Zg9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=A0wX3zR7Jb1RfuNH7Mmez2lQoU7tbo3ETK3nF5CZl2BLQQV2XUpHG4uc1vYRhWo7eW
         AxMS+tdlioAdrdzYFQ4INgvKTbHwIVUbtlp8ynqwIzsAKTAs0biov2xd/C8sl9E6Ab8c
         Yp81f5OajcBrXrc+RDqEBVs7cpn/DlwZGegNg=
Received: by 10.114.113.9 with SMTP id l9mr3429541wac.109.1283812103421;
        Mon, 06 Sep 2010 15:28:23 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d2sm12142825wam.2.2010.09.06.15.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 15:28:21 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  6 Sep 2010 20:37:11 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155635>

This bases on the original work by Robin Rosenberg.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 "nanoseconds (modulo 1G)" is changed to "nanosecond fractions"

 Documentation/technical/index-format.txt |  144 ++++++++++++++++++++++=
++++++++
 1 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/index-format.txt

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
new file mode 100644
index 0000000..5b1d70d
--- /dev/null
+++ b/Documentation/technical/index-format.txt
@@ -0,0 +1,144 @@
+GIT index format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=3D The git index file has the following format
+
+  All binary numbers are in network byte order. Version 2 is described
+  here unless stated otherwise.
+
+   - A 12-byte header consisting of
+
+     4-byte signature:
+       The signature is { 'D', 'I', 'R', 'C' }
+
+     4-byte version number:
+       The current supported versions are 2 and 3.
+
+     32-bit number of index entries.
+
+   - A number of sorted index entries
+
+   - Extensions
+
+     Extensions are identified by signature. Optional extensions can
+     be ignored if GIT does not understand them.
+
+     GIT currently supports tree cache and resolve undo extensions.
+
+     4-byte extension signature. If the first byte is 'A'..'Z' the
+     extension is optional and can be ignored.
+
+     32-bit size of the extension
+
+     Extension data
+
+   - 160-bit SHA-1 over the content of the index file before this
+     checksum.
+
+=3D=3D Index entry
+
+  Index entries are sorted in ascending order on the name field,
+  interpreted as a string of unsigned bytes. Entries with the same
+  name are sorted by their stage field.
+
+  32-bit ctime seconds, the last time a file's metadata changed
+    this is stat(2) data
+
+  32-bit ctime nanosecond fractions
+    this is stat(2) data
+
+  32-bit mtime seconds, the last time a file's data changed
+    this is stat(2) data
+
+  32-bit mtime nanosecond fractions
+    this is stat(2) data
+
+  32-bit dev
+    this is stat(2) data
+
+  32-bit ino
+    this is stat(2) data
+
+  32-bit mode, split into (high to low bits)
+
+    4-bit object type
+      valid values in binary are 1000 (blob), 1010 (symbolic link)
+      and 1110 (gitlink)
+
+    3-bit unused
+
+    9-bit unix permission (only 0755 and 0644 are valid)
+
+  32-bit uid
+    this is stat(2) data
+
+  32-bit gid
+    this is stat(2) data
+
+  32-bit file size
+    This is the on-disk size from stat(2)
+
+  160-bit SHA-1 for the represented object
+
+  A 16-bit field split into (high to low bits)
+
+    1-bit assume-valid flag
+
+    1-bit extended flag (must be zero in version 2)
+
+    2-bit stage (during merge)
+
+    12-bit name length if the length is less than 0x0FFF
+
+  (Version 3) A 16-bit field, only applicable if the "extended flag"
+  above is 1, split into (high to low bits).
+
+    1-bit reserved for future
+
+    1-bit skip-worktree flag (used by sparse checkout)
+
+    1-bit intent-to-add flag (used by "git add -N")
+
+    13-bit unused, must be zero
+
+  Entry path name (variable length) relative to top level directory
+    (without leading slash). '/' is used as path separator. The specia=
l
+    paths ".", ".." and ".git" (without quotes) are disallowed.
+    Trailing slash is also disallowed.
+
+    The exact encoding is undefined, but the '.' and '/' characters
+    are encoded in 7-bit ASCII and the encoding cannot contain a nul
+    byte. Generally a superset of ASCII.
+
+  1-8 nul bytes as necessary to pad the entry to a multiple of eight b=
ytes
+  while keeping the name NUL-terminated.
+
+=3D=3D Extensions
+
+=3D=3D=3D Tree cache
+
+  Tree cache extension contains pre-computes hashes for all trees that
+  can be derived from the index
+
+  - Extension tag { 'T', 'R', 'E', 'E' }
+
+  - 32-bit size
+
+  - A number of entries
+
+     NUL-terminated tree name
+
+     Blank-terminated ASCII decimal number of entries in this tree
+
+     Newline-terminated position of this tree in the parent tree. 0 fo=
r
+     the root tree
+
+     160-bit SHA-1 for this tree and it's children
+
+=3D=3D=3D Resolve undo
+
+  TODO
+
+  - Extension tag { 'R', 'E', 'U', 'C' }
+
+  - 32-bit size
--=20
1.7.1.rc1.69.g24c2f7
