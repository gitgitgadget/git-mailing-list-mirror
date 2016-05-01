From: Andrew Janke <floss@apjanke.net>
Subject: gitk: "lime" color incompatible with older Tk versions
Date: Sun, 1 May 2016 13:03:50 -0400
Message-ID: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 19:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awumj-00064y-Kn
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 19:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcEARDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 13:03:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53350 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467AbcEARDw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 13:03:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BB6CA20641
	for <git@vger.kernel.org>; Sun,  1 May 2016 13:03:50 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Sun, 01 May 2016 13:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=LKneO/n7TEDVeL2o+EocBElDpcE=; b=eibgq
	l8GEKyIQ+sV0CGGfVjp5d1zhT+cfJO1GR87aeKhKnWK4VHwEQXoIPhR3E7ODsQUS
	Xg1H68PMJQqxtOR65DzQ3ONnOYRZMMAogZh8Xq0eRYaRTVr//8AY5cT6DNMbPjfG
	z+d2Q9ajeOnkgPO50gn4Hj4dUY+oje7f8J9Dqk=
X-Sasl-enc: tBTunpCCxa1LrNBnxX0xliT2cUe3ERBpwec3Oo8oqgE6 1462122230
Received: from eilonwy.local (cpe-66-65-75-142.nyc.res.rr.com [66.65.75.142])
	by mail.messagingengine.com (Postfix) with ESMTPA id 765156800CD
	for <git@vger.kernel.org>; Sun,  1 May 2016 13:03:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293199>

Hi, git folks,

I'm having trouble running gitk on Mac OS X 10.9.5. The gitk program 
uses the color "lime", which is not present in older versions of Tk, 
apparently including the Tk 8.5 which ships with 10.9.

When I try to launch it, I get this error.

|$ gitk Error in startup script: unknown color name "lime" (processing 
"-fore" option) invoked from within "$ctext tag conf m2 -fore [lindex 
$mergecolors 2]" (procedure "makewindow" line 347) invoked from within 
"makewindow" (file "/usr/local/bin/gitk" line 12434)|

This compatibility problem was noted before back in 2012, in 
http://www.mail-archive.com/git%40vger.kernel.org/msg14496.html.

Would you consider switching from lime to a hex value color, for 
compatibility with users of older versions of Tk? A patch to do so is 
below; only the file gitk-git/gitk needs to be changed.

Cheers,
Andrew Janke


diff --git a/gitk-git/gitk b/gitk-git/gitk
index 805a1c7..db5560d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2265,7 +2265,7 @@ proc makewindow {} {
      set h [expr {[font metrics uifont -linespace] + 2}]
      set progresscanv .tf.bar.progress
      canvas $progresscanv -relief sunken -height $h -borderwidth 2
-    set progressitem [$progresscanv create rect -1 0 0 $h -fill lime]
+    set progressitem [$progresscanv create rect -1 0 0 $h -fill "#99FF00"]
      set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
      set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
      }
@@ -3397,7 +3397,7 @@ set rectmask {
         0x00, 0x00, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f,
         0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0x00, 0x00};
  }
-image create bitmap reficon-H -background black -foreground lime \
+image create bitmap reficon-H -background black -foreground "#99FF00" \
      -data $rectdata -maskdata $rectmask
  image create bitmap reficon-o -background black -foreground "#ddddff" \
      -data $rectdata -maskdata $rectmask
@@ -12188,7 +12188,7 @@ if {[tk windowingsystem] eq "aqua"} {
      set extdifftool "meld"
  }

-set colors {lime red blue magenta darkgrey brown orange}
+set colors {"#99FF00" red blue magenta darkgrey brown orange}
  if {[tk windowingsystem] eq "win32"} {
      set uicolor SystemButtonFace
      set uifgcolor SystemButtonText
@@ -12206,12 +12206,12 @@ if {[tk windowingsystem] eq "win32"} {
  }
  set diffcolors {red "#00a000" blue}
  set diffcontext 3
-set mergecolors {red blue lime purple brown "#009090" magenta "#808000" 
"#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff70b0"}
+set mergecolors {red blue "#99FF00" purple brown "#009090" magenta 
"#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" 
"#f0b070" "#ff70b0"}
  set ignorespace 0
  set worddiff ""
  set markbgcolor "#e0e0ff"

-set headbgcolor lime
+set headbgcolor "#99FF00"
  set headfgcolor black
  set headoutlinecolor black
  set remotebgcolor #ffddaa
@@ -12226,7 +12226,7 @@ set linehoverfgcolor black
  set linehoveroutlinecolor black
  set mainheadcirclecolor yellow
  set workingfilescirclecolor red
-set indexcirclecolor lime
+set indexcirclecolor "#99FF00"
  set circlecolors {white blue gray blue blue}
  set linkfgcolor blue
  set circleoutlinecolor $fgcolor
