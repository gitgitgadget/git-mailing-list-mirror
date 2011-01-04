From: Mathias Lafeldt <misfire@debugon.org>
Subject: BUG: gitk fails to parse 1.7.4-rc0 version string
Date: Tue, 04 Jan 2011 13:44:54 +0100
Message-ID: <4D231646.5080005@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 04 13:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa6GF-0003GQ-AE
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 13:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1ADMpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 07:45:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53040 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1ADMpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 07:45:00 -0500
Received: from [172.20.2.23] (p54854BA0.dip.t-dialin.net [84.133.75.160])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LmNJC-1Q8sqQ22pm-00aDuh; Tue, 04 Jan 2011 13:44:57 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
X-Provags-ID: V02:K0:WiFyk3g2DuDbeH11M+jyezgyj4LzFb1LoI6AWqJaTuQ
 cv4gqWwCUl8wDRHE7XOF/HbeC8+Ow1mtYrKNIXD0CklcZ6aHKn
 ApOa6IVN12KV4hns4vqSRxfAzcMqSOe6hbLKWB5RrETvGw4u0r
 HzwCsz1fNb9bxt7L7/wvEPAv/wJFyIKxiY95/eMdxeAmhGSDmy
 v9hUr0tpTTe0f36mGx+OQRyhHesSfm04lR3T/2opZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164487>

Looks like gitk doesn't like the "-rc0" suffix.

$ git --version
git version 1.7.4-rc0

$ gitk
Error in startup script: expected version number but got "1.7.4-rc0"
    while executing
"package vcompare $git_version "1.6.6.2""
    (file "/usr/local/bin/gitk" line 1)

I temporarily fixed it by hard-coding the version string:

diff --git a/gitk-git/gitk b/gitk-git/gitk
index e82c6bf..367446e 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11581,7 +11581,7 @@ if {![info exists have_ttk]} {
 set use_ttk [expr {$have_ttk && $want_ttk}]
 set NS [expr {$use_ttk ? "ttk" : ""}]

-set git_version [join [lrange [split [lindex [exec git version] end] .]
0 2] .]
+set git_version "1.7.4"


 set show_notes {}
 if {[package vcompare $git_version "1.6.6.2"] >= 0} {


-Mathias
