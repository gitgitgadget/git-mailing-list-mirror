From: Max Horn <max@quendi.de>
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20Document=20rev=5E!=20and=20rev=5E=40=20as=20revision=20specifiers?=
Date: Fri,  6 Jul 2012 02:01:30 +0200
Message-ID: <1341532890-13829-2-git-send-email-max@quendi.de>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
 <1341532890-13829-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 02:01:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smvza-0004io-4h
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 02:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab2GFABo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 20:01:44 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:35266 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756324Ab2GFABo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 20:01:44 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1SmvzT-00007R-0G; Fri, 06 Jul 2012 02:01:43 +0200
X-Mailer: git-send-email 1.7.11.1.145.g4722b29.dirty
In-Reply-To: <1341532890-13829-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341532904;fb23f14d;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201080>

Previously, the rev^! and rev^@ syntax were only described in the
SPECIFYING RANGES section of revisions.txt, making it a bit harder to
find information about it. Moreover, that description was slightly
confusing as it described the technical definition of rev^! and rev^@
without making it completely clear what the end effect was.
This patch attempts to address this by adding dedicate entries
for rev^! and rev^@ in the SPECIFYING REVISIONS section, rewording
the existing explanation, and adding two select additional examples.

=46inally, it also adds an example for the B..C range syntax, to
help illustrate how it differs from B...C.

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/revisions.txt | 24 +++++++++++++++++++++---
 1 Datei ge=C3=A4ndert, 21 Zeilen hinzugef=C3=BCgt(+), 3 Zeilen entfern=
t(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f4f6f28..2784298 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -128,6 +128,20 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DI=
R/packed-refs' file.
   it returns the youngest matching commit which is reachable from
   the '<rev>' before '{caret}'.
=20
+'<rev>{caret}@', e.g. 'HEAD{caret}@'::
+  A suffix '{caret}' followed by an at sign
+  means all parents of '<rev>'.
+  This is somewhat different from the other specifiers in this
+  section in that it may refer to multiple commits at once.
+  See also the next section on SPECIFYING RANGES.
+
+'<rev>{caret}!', e.g. 'HEAD{caret}!'::
+  A suffix '{caret}' followed by an exclamation mark
+  means commit '<rev>' but forces all of its parents to be excluded. F=
or
+  commands that deal with a single revision, this is the same as '<rev=
>".
+  Hence it is primarily used with commands expecting commit ranges.
+  See also the next section on SPECIFYING RANGES.
+
 ':/<text>', e.g. ':/fix nasty bug'::
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expressi=
on.
@@ -214,9 +228,10 @@ It is the set of commits that are reachable from e=
ither one of
 'r1' or 'r2' but not from both.
=20
 Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The 'r1{caret}@' notation means all
-parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
-all of its parents.
+and its parent commits exist.  Recall that 'r1{caret}@' means all
+parents of 'r1'. When specifying ranges, this effectively includes
+all ancestors of 'r1' but excludes 'r1' itself. In contrast to this,
+'r1{caret}!' includes commit 'r1' but excludes all of its ancestors.
=20
 Here are a handful of examples:
=20
@@ -224,7 +239,10 @@ Here are a handful of examples:
    D F              G H I J D F
    ^G D             H D
    ^D B             E I J F B
+   B..C             C
    B...C            G H D E B C
    ^D B C           E I J F B C
+   C                I J F C
    C^@              I J F
+   C^!              C
    F^! D            G H D F
--=20
1.7.11.1.145.g4722b29.dirty
