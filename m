From: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] shut up gcc4's signed pointer warnings
Date: Thu, 5 May 2005 03:30:37 +0200
Message-ID: <20050505013037.GA26290@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu May 05 03:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTV6E-00013j-6q
	for gcvg-git@gmane.org; Thu, 05 May 2005 03:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEEBar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 May 2005 21:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEEBar
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 21:30:47 -0400
Received: from soundwarez.org ([217.160.171.123]:5588 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261757AbVEEBak (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 21:30:40 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id C4DA52CEEF; Thu,  5 May 2005 03:30:37 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Suppress these stupid warnings if gcc supports it:

  ls-tree.c: In function =E2=80=98list_recursive=E2=80=99:
  ls-tree.c:34: warning: pointer targets in passing argument 1 of =E2=80=
=98strlen=E2=80=99 differ in signedness
  ls-tree.c:34: warning: pointer targets in passing argument 1 of =E2=80=
=98__builtin_strcmp=E2=80=99 differ in signedness
  ls-tree.c:34: warning: pointer targets in passing argument 1 of =E2=80=
=98strlen=E2=80=99 differ in signedness
  ls-tree.c:34: warning: pointer targets in passing argument 1 of =E2=80=
=98__builtin_strcmp=E2=80=99 differ in signedness
  ls-tree.c:34: warning: pointer targets in passing argument 1 of =E2=80=
=98__builtin_strcmp=E2=80=99 differ in signedness
  ls-tree.c:34: warning: pointer targets in passing argument 1 of =E2=80=
=98__builtin_strcmp=E2=80=99 differ in signedness
  ls-tree.c:66: warning: pointer targets in passing argument 2 of =E2=80=
=98list_recursive=E2=80=99 differ in signedness

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

--- a/Makefile
+++ b/Makefile
@@ -7,7 +7,11 @@
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely =
randomly
 # break unless your underlying filesystem supports those sub-second ti=
mes
 # (my ext3 doesn't).
+
+cc-supports =3D ${shell if $(CC) ${1} -S -o /dev/null -xc /dev/null > =
/dev/null 2>&1; then echo "$(1)"; fi;}
+
 CFLAGS=3D-g -O2 -Wall
+CFLAGS+=3D $(call cc-supports,-Wno-pointer-sign)
=20
 CC=3Dgcc
 AR=3Dar

