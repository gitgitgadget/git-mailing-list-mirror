From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH] gitk: Added support for OS X mouse wheel
Date: Sat, 13 Oct 2007 18:33:07 +0100
Message-ID: <193EA1A3-1BE3-42E4-8A47-0F025E0D3645@steelskies.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 19:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igkrc-0000mV-0W
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 19:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbXJMRdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2007 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbXJMRdM
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 13:33:12 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:36747 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbXJMRdL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 13:33:11 -0400
Received: from [192.168.1.65] (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id 9543F98142;
	Sat, 13 Oct 2007 18:33:09 +0100 (BST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(V=E4in=F6 J=E4rvel=E4 supplied this patch a while ago for 1.5.2.  It n=
o longer
applied cleanly, so I'm reposting it.)

MacBook doesn't seem to recognize MouseRelease-4 and -5 events, at all.
So i added a support for the MouseWheel event, which i limited to Tcl/t=
k
aqua, as i couldn't test it neither on Linux or Windows. Tcl/tk needs t=
o
be updated from the version that is shipped with OS X 10.4 Tiger, for
this patch to work.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
  gitk |   14 ++++++++++----
  1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..9b3e627 100755
--- a/gitk
+++ b/gitk
@@ -838,11 +838,17 @@ proc makewindow {} {
      bindall <1> {selcanvline %W %x %y}
      #bindall <B1-Motion> {selcanvline %W %x %y}
      if {[tk windowingsystem] =3D=3D "win32"} {
-	bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D }
-	bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %X %Y %=20
D ; break }
+        bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y =20
%D }
+        bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %=20
X %Y %D ; break }
      } else {
-	bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
-	bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+        bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
+        bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+        if {[tk windowingsystem] eq "aqua"} {
+            bindall <MouseWheel> {
+                set delta [expr {- (%D)}]
+                allcanvs yview scroll $delta units
+            }
+        }
      }
      bindall <2> "canvscan mark %W %x %y"
      bindall <B2-Motion> "canvscan dragto %W %x %y"
--=20
1.5.3.1
