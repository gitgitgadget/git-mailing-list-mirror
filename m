From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/3] git-gui: fix PATH environment for mingw development
	environment
Date: Sat, 27 Feb 2010 21:47:42 +0100
Message-ID: <20100227204741.GC33000@book.hvoigt.net>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> <20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com> <20100227204108.GA33000@book.hvoigt.net> <20100227204549.GB33000@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 21:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTa1-0008Nb-3T
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 21:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030869Ab0B0Urq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 15:47:46 -0500
Received: from darksea.de ([83.133.111.250]:40831 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030861Ab0B0Uro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 15:47:44 -0500
Received: (qmail 2139 invoked from network); 27 Feb 2010 21:47:42 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2010 21:47:42 +0100
Content-Disposition: inline
In-Reply-To: <20100227204549.GB33000@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141223>

When creating a desktop shortcut from the gui the shortcut directly
starts wish with the git-gui script. In the msysgit development
environment some dll's reside in the mingw/bin directory which causes
that git can not start because libiconv2.dll is not found.

When using such a link the error is even more cryptic stating:
"child killed: unknown signal"

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
I am not sure whether this is the most elegant solution, but making this
work would definitely ease the development workflow.

 git-gui/windows/git-gui.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-gui/windows/git-gui.sh b/git-gui/windows/git-gui.sh
index 66bbb2f..b1845c5 100644
--- a/git-gui/windows/git-gui.sh
+++ b/git-gui/windows/git-gui.sh
@@ -13,10 +13,11 @@ if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
 	incr argc -2
 }
 
-set bindir [file dirname \
+set basedir [file dirname \
             [file dirname \
              [file dirname [info script]]]]
-set bindir [file join $bindir bin]
+set bindir [file join $basedir bin]
+set bindir "$bindir;[file join $basedir mingw bin]"
 regsub -all ";" $bindir "\\;" bindir
 set env(PATH) "$bindir;$env(PATH)"
 unset bindir
-- 
1.7.0.m5.rc3.5.g38df2
