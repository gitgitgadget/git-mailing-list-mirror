From: Michal Rokos <michal@rokos.info>
Subject: Re: [cogito] paged output for cg-diff
Date: Fri, 20 May 2005 15:17:05 +0200
Message-ID: <200505201517.05995.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 20 15:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ7Ni-0007im-4m
	for gcvg-git@gmane.org; Fri, 20 May 2005 15:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVETNSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 09:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVETNSX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 09:18:23 -0400
Received: from black.click.cz ([62.141.0.10]:28833 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261462AbVETNR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 09:17:56 -0400
Received: from rokos.ack-prg.csas.cz (gprsh1.isp.t-mobile.cz [62.141.24.1])
	by click.cz (8.12.9/8.12.9) with ESMTP id j4KDH091025239
	for <git@vger.kernel.org>; Fri, 20 May 2005 15:17:05 +0200 (MET DST)
Received: from ip6-localhost (ip6-localhost [IPv6:::1])
	by rokos.ack-prg.csas.cz (Postfix) with ESMTP id 99C76F9000
	for <git@vger.kernel.org>; Fri, 20 May 2005 15:17:07 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

Junio is right, following is sufficent. Tested with 'more' too.

 Michal

PS: I'm off the list, so please CC me.

Signed-off-by: Michal Rokos <michal@rokos.info>
Idea-from: Junio C Hamano <junkio@cox.net>

Index: cg-Xlib
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-Xlib  (mode:100755)
+++ uncommitted/cg-Xlib  (mode:100755)
@@ -91,3 +91,8 @@

 export BROKEN_MKTEMP=1
 del=$($(which mktemp) -t 2>/dev/null) && { rm $del; export BROKEN_MKTEMP=; }
+
+PAGER () {
+       ${PAGER:-less} ${PAGER_FLAGS:--R}
+}
+
Index: cg-diff
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-diff  (mode:100755)
+++ uncommitted/cg-diff  (mode:100755)
@@ -71,7 +71,7 @@
        # FIXME: Update ret based on what did we match. And take "$@"
        # to account after all.
        ret=
-       git-diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree" uncommitted "$filter"
+       git-diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree" uncommitted "$filter" | PAGER

        [ "$filter" ] && rm $filter

@@ -85,7 +85,7 @@

 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"

-git-diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 $id2 "$filter"
+git-diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 $id2 "$filter" | PAGER

 [ "$filter" ] && rm $filter
 exit 0
Index: cg-log
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -181,4 +181,4 @@

                done
        echo
-done | ${PAGER:-less} ${PAGER_FLAGS:--R}
+done | PAGER
