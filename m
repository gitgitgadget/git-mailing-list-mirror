From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] gitk: add menuitem for file checkout from this or
	parent commit
Date: Thu, 30 Sep 2010 20:29:49 +0200
Message-ID: <20100930182949.GA15412@book.hvoigt.net>
References: <20100928200344.GA12843@book.hvoigt.net> <AANLkTi=GmR3kV-ChSNybcaw4c=Dwt5G98e31WVuzJcfC@mail.gmail.com> <20100929152259.GA13887@book.hvoigt.net> <AANLkTinn-_Npv4+wGRkS6Sonf1VRV-cEMtHBEtyQeq8O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Michele Ballabio <barra_cuda@katamail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 20:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1NtG-00085N-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 20:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab0I3S3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 14:29:52 -0400
Received: from darksea.de ([83.133.111.250]:37414 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755340Ab0I3S3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 14:29:52 -0400
Received: (qmail 25019 invoked from network); 30 Sep 2010 20:29:49 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 30 Sep 2010 20:29:49 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTinn-_Npv4+wGRkS6Sonf1VRV-cEMtHBEtyQeq8O@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157698>

This is useful if a user wants to checkout a file from a certain
commit. This is equivalent to

  git checkout $commit $file

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

On Wed, Sep 29, 2010 at 03:48:03PM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> But as Michele points out you probably shouldn't update these, some
> projects do, but it probably makes more sense to leave these updates
> up to translators.

Here is an updated version of that patch without the po changes.

 gitk |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..c582bb5 100755
--- a/gitk
+++ b/gitk
@@ -2497,6 +2497,8 @@ proc makewindow {} {
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
 	{mc "Blame parent commit" command {external_blame 1}}
+	{mc "Checkout from this commit" command {external_checkout}}
+	{mc "Checkout from parent commit" command {external_checkout 1}}
     }
     $flist_menu configure -tearoff 0
=20
@@ -3533,6 +3535,20 @@ proc make_relative {f} {
 }
=20
 proc external_blame {parent_idx {line {}}} {
+
+    set cmdline [list git gui blame]
+    if {$line ne {} && $line > 1} {
+	lappend cmdline "--line=3D$line"
+    }
+    run_command_on_selected_file $cmdline $parent_idx
+}
+
+proc external_checkout {{parent_idx 0}} {
+    set cmdline [list git checkout]
+    run_command_on_selected_file $cmdline $parent_idx
+}
+
+proc run_command_on_selected_file {cmdline parent_idx} {
     global flist_menu_file gitdir
     global nullid nullid2
     global parentlist selectedline currentid
@@ -3548,17 +3564,13 @@ proc external_blame {parent_idx {line {}}} {
 	return
     }
=20
-    set cmdline [list git gui blame]
-    if {$line ne {} && $line > 1} {
-	lappend cmdline "--line=3D$line"
-    }
     set f [file join [file dirname $gitdir] $flist_menu_file]
-    # Unfortunately it seems git gui blame doesn't like
+    # Unfortunately some commands do not like
     # being given an absolute path...
     set f [make_relative $f]
     lappend cmdline $base_commit $f
     if {[catch {eval exec $cmdline &} err]} {
-	error_popup "[mc "git gui blame: command failed:"] $err"
+	error_popup "[mc "$cmdline: command failed:"] $err"
     }
 }
=20
--=20
1.7.2.2.177.geec0d
