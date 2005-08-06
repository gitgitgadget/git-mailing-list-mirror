From: Linus Torvalds <torvalds@osdl.org>
Subject: gitk SHA link hovers
Date: Sat, 6 Aug 2005 10:59:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508061056200.3258@g5.osdl.org>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org> <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
 <17140.47152.672091.474748@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508060919150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Epler <jepler@unpythonic.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 20:00:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1Sxn-0000pz-Dv
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 20:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbVHFR75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbVHFR75
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 13:59:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263343AbVHFR74 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 13:59:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j76HxljA027673
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 10:59:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j76HxkMW025042;
	Sat, 6 Aug 2005 10:59:46 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0508060919150.3258@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This makes the cursor change when you hover over a SHA1 link with the new 
"hypertext" gitk commit ID linking feature.

All credit goes to Jeff Epler <jepler@unpythonic.net> and bugs are mine. 
I don't actually know any tcl/tk, I'm just acting as a random monkey that 
looks at what others do and mix it up.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -1802,10 +1802,13 @@ proc selectline {l isnew} {
 	set linkid [string range $comment $s $e]
 	if {![info exists idline($linkid)]} continue
 	incr e
-	$ctext tag conf link$i -foreground blue -underline 1
+	$ctext tag add link "$commentstart + $s c" "$commentstart + $e c"
 	$ctext tag add link$i "$commentstart + $s c" "$commentstart + $e c"
 	$ctext tag bind link$i <1> [list selectline $idline($linkid) 1]
     }
+    $ctext tag conf link -foreground blue -underline 1
+    $ctext tag bind link <Enter> { %W configure -cursor hand2 }
+    $ctext tag bind link <Leave> { %W configure -cursor {} }
 
     $ctext tag delete Comments
     $ctext tag remove found 1.0 end
