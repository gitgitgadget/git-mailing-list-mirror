From: =?utf-8?q?Adam=20Pi=C4=85tyszek?= <ediap@users.sourceforge.net>
Subject: [PATCH] git-gui: Add option for changing the width of the commit message text box
Date: Thu,  6 Mar 2008 20:38:40 +0100
Message-ID: <1204832320-22800-1-git-send-email-ediap@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Adam=20Pi=C4=85tyszek?= <ediap@users.sourceforge.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXM2e-0002kn-9u
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 20:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762328AbYCFTpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762069AbYCFTpb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 14:45:31 -0500
Received: from pictor.et.put.poznan.pl ([150.254.29.68]:53058 "EHLO
	pictor.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761511AbYCFTp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 14:45:27 -0500
Received: from cygnus.et.put.poznan.pl (cygnus.et.put.poznan.pl [150.254.29.66])
	by pictor.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m26Jfihu022908;
	Thu, 6 Mar 2008 20:41:44 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from lespaul (addr34.neoplus.adsl.tpnet.pl [79.184.69.34])
	by cygnus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with SMTP id m26JcfK01533;
	Thu, 6 Mar 2008 20:38:41 +0100 (MET)
Received: by lespaul (sSMTP sendmail emulation); Thu,  6 Mar 2008 20:38:40 +0100
X-Mailer: git-send-email 1.5.4.3.450.gb92176.dirty
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.3.1.94157
X-PMX-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76412>

The width of the commit message text area is currently hard-coded
to 75 characters. This value might be not optimal for some projects.
=46or instance users who would like to generate GNU-style ChangeLog
file from git commit message might prefer commit messages of width
no longer than 70 characters.

This patch adds a global and per repository option "Commit Message
Text Width", which could be used to change the width of the commit
message text area.

Signed-off-by: Adam Pi=C4=85tyszek <ediap@users.sourceforge.net>
---
Ideally, I would like to have an automated line wrapping in the commit
message text area. Unfortunately the "-wrap words" switch only wraps th=
e
lines for displaying purposes and this has no effect on the committed m=
essage
itself.

Anyway, the patch I prepared allows at least for configuring the width =
of
the commit message text box, so it is easier to manually wrap lines to
expected width.

This patch is against git.git's master branch. I hope this is fine.

/Adam

 git-gui/git-gui.sh     |    3 ++-
 git-gui/lib/option.tcl |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 238a239..f617a4a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -611,6 +611,7 @@ set default_config(gui.matchtrackingbranch) false
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.diffcontext) 5
+set default_config(gui.commitmsgwidth) 75
 set default_config(gui.newbranchtemplate) {}
 set default_config(gui.spellingdictionary) {}
 set default_config(gui.fontui) [font configure font_ui]
@@ -2421,7 +2422,7 @@ text $ui_comm -background white -borderwidth 1 \
 	-maxundo 20 \
 	-autoseparators true \
 	-relief sunken \
-	-width 75 -height 9 -wrap none \
+	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
 	-font font_diff \
 	-yscrollcommand {.vpane.lower.commarea.buffer.sby set}
 scrollbar .vpane.lower.commarea.buffer.sby \
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index ea80df0..9270512 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -124,6 +124,7 @@ proc do_options {} {
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
 		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		} {
 		set type [lindex $option 0]
--=20
1.5.4.3.450.gb92176.dirty

