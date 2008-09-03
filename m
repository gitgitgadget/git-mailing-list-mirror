From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Wed, 3 Sep 2008 16:08:14 -0700
Message-ID: <20080903230814.GJ28315@spearce.org>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 01:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb1TV-0006cU-Tq
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 01:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYICXIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 19:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYICXIP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 19:08:15 -0400
Received: from george.spearce.org ([209.20.77.23]:54924 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbYICXIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 19:08:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 755EC38375; Wed,  3 Sep 2008 23:08:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94871>

Alexander Gladysh <agladysh@gmail.com> wrote:
> On Wed, Aug 27, 2008 at 1:16 PM, Alexander Gladysh <agladysh@gmail.com> wrote:
> > $ git --version
> > git version 1.6.0.GIT
> >
> > $ git gui --version
> > git-gui version 0.11.GITGUI
> >
> > I like 'stage hunk for commit' feature in Git Gui, but often it gives
> > me an error message box:
> >
> > fatal: git-apply: bad git-diff - inconsistent old filename on line 4
...
> Does anyone else encounter this kind of error? Any debugging advice?
> Perhaps I can instrument git gui with logging somewhere (dump diffs
> for example). (I have no experience with TCL though.)

I've never seen that before, but its clearly dumping a bad diff
into git-apply.

Open up lib/diff.tcl and find "proc apply_hunk".  Inside of the
catch maybe insert a puts to see the diff, e.g.:

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 52b79e4..4acaccf 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -341,6 +341,8 @@ proc apply_hunk {x y} {
 		fconfigure $p -translation binary -encoding binary
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p [$ui_diff get $s_lno $e_lno]
+puts -nonewline stdout $current_diff_header
+puts -nonewline stdout [$ui_diff get $s_lno $e_lno]
 		close $p} err]} {
 		error_popup [append $failed_msg "\n\n$err"]
 		unlock_index

Then if you can scrub the context and +/- lines for a bad diff and
send us at least the headers, or tell us how they are malformed,
it would help to debug it.
 
-- 
Shawn.
