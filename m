From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] git-gui: make sure placement of panedwindow sashes happens
 correctly on startup
Date: Sat, 1 May 2010 19:29:18 +0100
Message-ID: <20100501182918.GA19769@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat May 01 21:02:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Hxi-000284-Th
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab0EATCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:02:46 -0400
Received: from arctic.adamspiers.org ([212.13.194.176]:48963 "EHLO
	arctic.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab0EATCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:02:44 -0400
X-Greylist: delayed 2003 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2010 15:02:44 EDT
Received: from localhost (dsl-217-155-199-114.zen.co.uk [217.155.199.114])
	by arctic.adamspiers.org (Postfix) with ESMTP id F216324017;
	Sat,  1 May 2010 18:29:19 +0000 (UTC)
Mail-Followup-To: Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysgit@googlegroups.com
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146110>

On 20 December 2009 01:46, Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
> This patch enables the use of themed Tk widgets with Tk 8.5 and above.
> These make a significant difference on Windows in making the application
> appear native. The gui.usettk git config variable may be set to disable
> this if the user prefers the classic Tk look.
> On Windows and MacOSX ttk defaults to the native look as much as possible.
> On X11 the user may select a theme using the TkTheme XRDB resource class.
> Some support is included for Tk 8.6 features (themed spinbox and native
> font chooser for MacOSX and Windows).

For me this broke persistence of the panedwindow's vertical sash
positioning in between invocations of git-gui.  Upon further
investigation and discussion with helpful #git inhabitants, it
transpired that setting gui.usettk to false is a workaround, but that
the position of panedwindow's *horizontal* sash which sits in between
the panes for unstaged and staged files *never* persisted, regardless
of gui.usettk, and even going back to old 1.6.x versions.

I looked at this a bit closer, and the code seems to be doing exactly
the right thing, but it seems to be some weird kind of Tk timing
issue.  I found that the below trivial patch fixes it completely, but
then I'm completely ignorant when it comes to Tk, so it may not be the
right fix.

Thanks,
Adam

P.S. This is my first patch submission via git - after poring over the
man pages and a lengthy discussion on #git, I still couldn't find a
way to send it which satisfied all of the following:

  (a) formatted as a single mail, with the context and discussion
      first, then the patch at the end,
  (b) no MIME, and
  (c) can be piped to `git am' without including the whole
      mail body in the commit log.

Hopefully this is the best compromise, since everything up to the end
of this sentence can be trimmed before piping to `git am'; if not
please let me know any better alternative for future reference.

>From 3a6ce310f8b3d1e45f7a8d7ac15af7c360847ee4 Mon Sep 17 00:00:00 2001
From: Adam Spiers <git@adamspiers.org>
Date: Sat, 1 May 2010 17:15:18 +0100
Subject: [PATCH] git-gui: make sure placement of panedwindow sashes happens correctly on startup

---
 git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8996d2d..9585d7f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3466,6 +3466,7 @@ $main_status show [mc "Initializing..."]
 catch {
 set gm $repo_config(gui.geometry)
 wm geometry . [lindex $gm 0]
+update
 if {$use_ttk} {
 	.vpane sashpos 0 [lindex $gm 1]
 	.vpane.files sashpos 0 [lindex $gm 2]
-- 
1.7.1
