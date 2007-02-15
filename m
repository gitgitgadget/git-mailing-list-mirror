From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git-gui Error
Date: Thu, 15 Feb 2007 07:07:12 +0100
Message-ID: <20070215060712.GA3761@auto.tuwien.ac.at>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org> <20070214060041.GA31871@spearce.org> <20070214174635.GA21612@auto.tuwien.ac.at> <20070215024014.GA29865@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 07:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHZmD-0002LZ-Bu
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 07:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbXBOGHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Feb 2007 01:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXBOGHS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 01:07:18 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:36655 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbXBOGHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 01:07:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D49636800669;
	Thu, 15 Feb 2007 07:07:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kj5VM6rKCNxz; Thu, 15 Feb 2007 07:07:12 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 519F96800655; Thu, 15 Feb 2007 07:07:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070215024014.GA29865@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39797>

On Wed, Feb 14, 2007 at 09:40:14PM -0500, Shawn O. Pearce wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > --- git-gui.sh  2007-02-14 08:51:38.025781229 +0000
> > +++ git-gui     2007-02-14 10:50:13.618870598 +0000
> > @@ -1916,11 +1916,25 @@
> >         return [lsort -unique $all_trackings]
> >  }
>=20
> Unfortunately this patch has severe whitespace damage.  All of the
> tabs were received here as spaces, so nothing applies.
>=20
> >  proc do_create_branch_action {w} {
> >         global all_heads null_sha1 repo_config
> >         global create_branch_checkout create_branch_revtype
> >         global create_branch_head create_branch_trackinghead
> >         global create_branch_name create_branch_revexp
> > +        global create_branch_tag
>=20
> The indentation does not line up here.  All of the existing context
> lines were indented with just one tab, until the whitespace damage
> noted above.

This time, the white spaces/tabs should be correct:

--- git-gui.sh	2007-02-14 09:51:38.025781229 +0100
+++ git-gui	2007-02-15 06:53:40.262295256 +0100
@@ -1916,11 +1916,25 @@
 	return [lsort -unique $all_trackings]
 }
=20
+proc load_all_tags {} {
+	set all_tags [list]
+	set fd [open "| git for-each-ref --format=3D%(refname) refs/tags" r]
+	while {[gets $fd line] > 0} {
+		if {![regsub ^refs/tags/ $line {} name]} continue
+		lappend all_tags $name
+	}
+	close $fd
+
+	return [lsort $all_tags]
+}
+
+
 proc do_create_branch_action {w} {
 	global all_heads null_sha1 repo_config
 	global create_branch_checkout create_branch_revtype
 	global create_branch_head create_branch_trackinghead
 	global create_branch_name create_branch_revexp
+	global create_branch_tag
=20
 	set newbranch $create_branch_name
 	if {$newbranch eq {}
@@ -1959,6 +1973,7 @@
 	switch -- $create_branch_revtype {
 	head {set rev $create_branch_head}
 	tracking {set rev $create_branch_trackinghead}
+	tag {set rev $create_branch_tag}
 	expression {set rev $create_branch_revexp}
 	}
 	if {[catch {set cmt [git rev-parse --verify "${rev}^0"]}]} {
@@ -2015,6 +2030,7 @@
 	global create_branch_checkout create_branch_revtype
 	global create_branch_head create_branch_trackinghead
 	global create_branch_name create_branch_revexp
+	global create_branch_tag
=20
 	set w .branch_editor
 	toplevel $w
@@ -2078,6 +2094,19 @@
 			$all_trackings
 		grid $w.from.tracking_r $w.from.tracking_m -sticky w
 	}
+	set all_tags [load_all_tags]
+	if {$all_tags ne {}} {
+		set create_branch_tag [lindex $all_tags 0]
+		radiobutton $w.from.tag_r \
+			-text {Tag:} \
+			-value tag \
+			-variable create_branch_revtype \
+			-font font_ui
+		eval tk_optionMenu $w.from.tag_m \
+			create_branch_tag \
+			$all_tags
+		grid $w.from.tag_r $w.from.tag_m -sticky w
+	}
 	radiobutton $w.from.exp_r \
 		-text {Revision Expression:} \
 		-value expression \

mfg Martin K=F6gler
