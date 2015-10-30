From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] git-gui (Windows): use git-gui.exe in `Create Desktop
 Shortcut`
Date: Fri, 30 Oct 2015 20:10:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510302010010.31610@s15462909.onlinehome-server.info>
References: <cover.1443619795.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Oct 30 20:10:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsF44-0005V2-0E
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760544AbbJ3TKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:10:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:53196 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760493AbbJ3TKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:10:10 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MYOY5-1ZwLon0emn-00VAU7;
 Fri, 30 Oct 2015 20:10:08 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1443619795.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:t8KnWcmHxJ+F3BJqWPGZi5rZI3FGChHJziXV4mneNZDdBZu0I6b
 qybDRulahkIz9LvS3gEOZCHNksHeCv5X18/HBZilFeS2fxaZDmWpf7nN2YUQMbgA0EkTrh3
 PjSqG4Ll5xm+/RIir2DEvdORYIS8nWGyMDl2PPbXYvzdZpXgsn+cW1tIzBt2/X5f6qaEORG
 uSS5rQqdnWOU7iFGsvsQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A/CgYP9dhkM=:K7F5/b5rcSmZXbcKVFFOvW
 uFgUrnr1BRyD9l4kqZGvgzb4Oea3oUSx71KNRJke3MeU8RlVwzThtGb3CKJPV34da3nWIpTWg
 yLBkTftnl3Z6C9/fJZfPMRIZQmBcyDSKg8rcYVtrhgh5rya4aPbcxrswzYH2eu6f8Sy50rmNL
 jBVVu8k4BlGLM0y3fgCgW8s+fixQL5muhxq8z3mGFkjxbEJEBZhIz/ZxlfR09CpiQuO61/Gut
 WQRyNCEsPdXyIs9isY8DM3HRCZD6Vn7ocIJOL67VCc8vBlm/x5jn9t+ctEsvuY1N+PVSqYVK+
 17d0X+jfRkBSal+Mm1kk/jDW0LuEPnW9XJQ5dASdv1aeoJ13X4dKqYqlqBBzcMZGJEpxPrCYE
 hkaYRkG99GHlrGGVB+ZfsdvIEGJuh33sjkM83uOPYTfLyf53tiyYAer0tc6AvQ5aZ6qIeA6gJ
 pel62Dx9z+RTnzYH56zzW4LpQAq9a8CzK0fzDZEsNlv40WCJXWO/PL+4Pn0WNSqE2VAW731sO
 XEKEx9O3sRbHsxkwaNIklOuAvFomSyfHTwAaC3wn39V2QRpUU4KU1LEa3mjdQwvoTcELa9H6I
 2qPoNiwmWOH0fQf3gXYQj4nMZ0AYxeheH86WJ4Ju4Dch8D444zRinWA/LhfLZU9R40Y8SsgK8
 jRJiLU7zbasTElk5E/0vXN9/PU+E58i5vtJmssHCguo9u7RzHChIwIlEKH46hTLFoyvlkIfJc
 Ll+f6naPWh2fUuTT2UyoZ4Biz92iTwo+wYuQp5BqXy5qEpwGsaPQwMsyd4ewIFHidR7hmwVa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280524>

When calling `Repository>Create Desktop Shortcut`, Git GUI assumes
that it is okay to call `wish.exe` directly on Windows. However, in
Git for Windows 2.x' context, that leaves several crucial environment
variables uninitialized, resulting in a shortcut that does not work.

To fix those environment variable woes, Git for Windows comes with a
convenient `git-gui.exe`, so let's just use it when it is available.

This fixes https://github.com/git-for-windows/git/issues/448

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 lib/shortcut.tcl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 78878ef..715916b 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -11,11 +11,17 @@ proc do_windows_shortcut {} {
 		if {[file extension $fn] ne {.lnk}} {
 			set fn ${fn}.lnk
 		}
+		# Use /cmd/git-gui.exe if available
+		set normalized [file normalize $::argv0]
+		regsub "/mingw../libexec/git-core/git-gui$" \
+			$normalized "/cmd/git-gui.exe" cmdLine
+		if {$cmdLine != $normalized && [file exists $cmdLine]} {
+			set cmdLine [list [file nativename $cmdLine]]
+		} else {
+			set cmdLine [list [info nameofexecutable] $normalized]
+		}
 		if {[catch {
-				win32_create_lnk $fn [list \
-					[info nameofexecutable] \
-					[file normalize $::argv0] \
-					] \
+				win32_create_lnk $fn $cmdLine \
 					[file normalize $_gitworktree]
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
-- 
2.5.3.windows.1.3.gc322723
