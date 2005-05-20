From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [cogito] paged output for cg-diff
Date: Fri, 20 May 2005 11:05:08 +0200
Organization: NextSoft
Message-ID: <200505201105.08711.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri May 20 11:05:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ3R0-0001Bm-Ix
	for gcvg-git@gmane.org; Fri, 20 May 2005 11:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVETJFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 May 2005 05:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVETJFj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 05:05:39 -0400
Received: from black.click.cz ([62.141.0.10]:10944 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261390AbVETJFY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 05:05:24 -0400
Received: from rokos.ack-prg.csas.cz (gprsh1.isp.t-mobile.cz [62.141.24.1])
	by click.cz (8.12.9/8.12.9) with ESMTP id j4K95691027775
	for <git@vger.kernel.org>; Fri, 20 May 2005 11:05:17 +0200 (MET DST)
Received: from ip6-localhost (ip6-localhost [IPv6:::1])
	by rokos.ack-prg.csas.cz (Postfix) with ESMTP id 2CA80F9000
	for <git@vger.kernel.org>; Fri, 20 May 2005 11:05:10 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

I'm a bit curious what is going on in development so I'm using cg-diff
often. Usually I pipe it to the less. So for me it would be very nice
when cg-diff behaves as cg-log that pipes output to pager.

So I changed cg-diff to do so.

New function PAGER() determines whether output is terminal and uses
PAGER in that case.

Do you like it?

 Michal

Signed-off-by: Michal Rokos <michal@rokos.info>

Index: cg-Xlib
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-Xlib  (mode:100755)
+++ uncommitted/cg-Xlib  (mode:100755)
@@ -91,3 +91,12 @@
=20
 export BROKEN_MKTEMP=3D1
 del=3D$($(which mktemp) -t 2>/dev/null) && { rm $del; export BROKEN_MK=
TEMP=3D; }
+
+PAGER () {
+ if [ -t 1 ]; then
+  ${PAGER:-less} ${PAGER_FLAGS:--R}
+ else
+  cat
+ fi
+}
+
Index: cg-diff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-diff  (mode:100755)
+++ uncommitted/cg-diff  (mode:100755)
@@ -71,7 +71,7 @@
  # FIXME: Update ret based on what did we match. And take "$@"
  # to account after all.
  ret=3D
- git-diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree"=
 uncommitted "$filter"
+ git-diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree"=
 uncommitted "$filter" | PAGER
=20
  [ "$filter" ] && rm $filter
=20
@@ -85,7 +85,7 @@
=20
 [ "$id1" =3D "$id2" ] && die "trying to diff $id1 against itself"
=20
-git-diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 =
$id2 "$filter"
+git-diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 =
$id2 "$filter" | PAGER
=20
 [ "$filter" ] && rm $filter
 exit 0
Index: cg-log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -181,4 +181,4 @@
=20
   done
  echo
-done | ${PAGER:-less} ${PAGER_FLAGS:--R}
+done | PAGER

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
tel: +420 267 224 311
fax: +420 267 224 307
mobil: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
