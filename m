From: Thomas Klausner <tk@giga.or.at>
Subject: cogito-0.18.2: Portability problems with utility arguments
Date: Sat, 10 Mar 2007 21:21:43 +0100
Message-ID: <20070310202143.GA25193@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 21:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ8U8-0002Wq-Hb
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 21:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbXCJUsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbXCJUsF
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 15:48:05 -0500
Received: from danbala.ifoer.tuwien.ac.at ([128.130.168.64]:63053 "EHLO
	danbala.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbXCJUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 15:48:04 -0500
X-Greylist: delayed 1579 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Mar 2007 15:48:03 EST
Received: by danbala.tuwien.ac.at (Postfix, from userid 116)
	id 6340813A7D6; Sat, 10 Mar 2007 21:21:43 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41884>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I just updated the NetBSD pkgsrc package for cogito[1] to 0.18.2.
Currently there are three patches in pkgsrc for cogito, all of
them submitted for inclusion by Anthony Mallet, see
	http://www.NetBSD.org/cgi-bin/query-pr-single.pl?number=35020
	http://www.NetBSD.org/cgi-bin/query-pr-single.pl?number=35147

Here are the patches and the explanations.

patch-ab:
xargs on NetBSD does not know "--null", it does however know
the equivalent "-0".

patch-ac, patch-ad:
fmt on NetBSD does not know "-s". These patches just remove
the "-s". I'm not sure how to fix this, really.

Please include patch-aa, and if you find a way to work
around the "fmt -s", I'd appreciate it.

Cheers,
 Thomas

P.S.: Please cc me on replies, I'm not on this list.

[1] http://www.netbsd.org/packages/devel/cogito/README.html

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ab

$NetBSD: patch-ab,v 1.2 2007/03/10 19:09:33 wiz Exp $

>From PR 35020.

--- cg-Xlib.orig	2006-11-17 00:37:24.000000000 +0000
+++ cg-Xlib
@@ -615,7 +615,7 @@ tree_timewarp()
 		# Kill gone files
 		git-diff-tree -z --name-status -r "$base" "$branch" |
 			perl -n0e 'chomp; if (defined $meta) { print "$_\0" if $meta eq 'D'; $meta=undef } else { $meta = $_ }' |
-			xargs --null rm -f --
+			xargs -0 rm -f --
 		git-checkout-index -u -f -a
 
 		# FIXME: Can produce bogus "contains only garbage" messages.

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ac

$NetBSD: patch-ac,v 1.1 2006/11/09 02:19:59 rillig Exp $

>From PR 35020.

--- cg-tag~	2006-09-29 13:58:15.000000000 +0200
+++ cg-tag	2006-11-08 20:59:30.000000000 +0100
@@ -105,7 +105,7 @@
 
 for msg in "${msgs[@]}"; do
 	[ "$written" ] && echo >>"$LOGMSG"
-	echo "$msg" | fmt -s >>"$LOGMSG"
+	echo "$msg" | fmt >>"$LOGMSG"
 	written=1
 done
 

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ad

$NetBSD: patch-ad,v 1.1 2006/12/03 22:15:48 rillig Exp $

See PR 35147.

--- cg-commit.orig	2006-09-29 13:58:15.000000000 +0200
+++ cg-commit	2006-12-03 23:01:18.000000000 +0100
@@ -382,7 +382,7 @@ elif [ "$merging" ]; then
 fi
 for msg in "${msgs[@]}"; do
 	[ "$written" ] && echo >>"$LOGMSG"
-	echo "$msg" | fmt -s >>"$LOGMSG"
+	echo "$msg" | fmt >>"$LOGMSG"
 	written=1
 done
 

--+QahgC5+KEYLbs62--
