From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH-resent] gitk: fix in procedure drawcommits
Date: Fri, 19 Oct 2007 15:44:22 +0200
Message-ID: <200710191544.22228.barra_cuda@katamail.com>
References: <20071019052823.GI14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 15:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iis5m-0001js-PU
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762995AbXJSNka convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 09:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762899AbXJSNk3
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:40:29 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:59453 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762105AbXJSNk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 09:40:27 -0400
Received: from host123-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.123]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.123+xjKoK4QXXf5; Fri, 19 Oct 2007 15:40:24 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20071019052823.GI14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61708>

This patch indroduces a check before unsetting an array element.

Without this, gitk may complain with

	can't unset "prevlines(...)": no such element in array

when scrolling happens.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

There's an error that seems to occur in gitk only on
mutt's imported repo, but I don't know why. This is
hopefully the right fix.

An example of this error:

can't unset "prevlines(a3b4383d69e0754346578c85ba8ff7c05bd88705)": no s=
uch element in array
can't unset "prevlines(a3b4383d69e0754346578c85ba8ff7c05bd88705)": no s=
uch element in array
=C2=A0 =C2=A0 while executing
"unset prevlines($lid)"
=C2=A0 =C2=A0 (procedure "drawcommits" line 39)
=C2=A0 =C2=A0 invoked from within
"drawcommits $row $endrow"
=C2=A0 =C2=A0 (procedure "drawfrac" line 10)
=C2=A0 =C2=A0 invoked from within
"drawfrac $f0 $f1"
=C2=A0 =C2=A0 (procedure "scrollcanv" line 3)
=C2=A0 =C2=A0 invoked from within
"scrollcanv .tf.histframe.csb 0.00672513 0.0087015"

 gitk |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..527b716 100755
--- a/gitk
+++ b/gitk
@@ -3697,7 +3697,9 @@ proc drawcommits {row {endrow {}}} {
=20
 	if {[info exists lineends($r)]} {
 	    foreach lid $lineends($r) {
-		unset prevlines($lid)
+		if {[info exists prevlines($lid)]} {
+		    unset prevlines($lid)
+		}
 	    }
 	}
 	set rowids [lindex $rowidlist $r]
--=20
1.5.3
