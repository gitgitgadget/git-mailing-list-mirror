From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GIT-GUI PATCH] Teach git gui about file type changes
Date: Sun, 24 Aug 2008 21:36:04 -0700
Message-ID: <20080825043604.GB19127@spearce.org>
References: <1219435827-11122-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon Aug 25 06:37:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXTpI-0007Yl-7R
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 06:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbYHYEgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 00:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbYHYEgH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 00:36:07 -0400
Received: from george.spearce.org ([209.20.77.23]:34404 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbYHYEgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 00:36:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A780E38375; Mon, 25 Aug 2008 04:36:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219435827-11122-1-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93593>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> First of all, I'm really new to tcl/tk and the git gui code base so I
> would appreciate any and all pointers here to make the changes
> acceptable.

Your patch looks good, but I am squashing this into it.  By using
?T rather than _T we can correctly handle MT, which I think happens
when the user modifies the file content, stages the file, then
changes the mode (644->755).

diff --git a/lib/index.tcl b/lib/index.tcl
index 0a98715..7c27f2a 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -233,7 +233,7 @@ proc write_checkout_index {fd pathList totalCnt batch after} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
-		_T -
+		?T -
 		?D {
 			puts -nonewline $fd "[encoding convertto $path]\0"
 			display_file $path ?_
@@ -300,7 +300,7 @@ proc add_helper {txt paths} {
 		_O -
 		?M -
 		?D -
-		_T -
+		?T -
 		U? {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
@@ -341,7 +341,7 @@ proc do_add_all {} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
-		_T -
+		?T -
 		?D {lappend paths $path}
 		}
 	}
@@ -359,7 +359,7 @@ proc revert_helper {txt paths} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
-		_T -
+		?T -
 		?D {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
 
> Secondly, I could really not come up with an icon to represent a type
> change of a file.  Right now it is just different from all the others
> and not illustrative at all...

I think the icon looks fine.  I cannot come up with anything
better myself.

-- 
Shawn.
