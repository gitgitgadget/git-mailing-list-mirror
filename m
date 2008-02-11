From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH/UTF-8] gitk: properly deal with tag names containing /
	(slash)
Date: Mon, 11 Feb 2008 10:57:40 +0000
Message-ID: <20080211105741.16353.qmail@d33cfe7d8389ec.315fe32.mid.smarden.org>
References: <20080206070608.6881.qmail@096465580ae94c.315fe32.mid.smarden.org> <7vtzkm35d1.fsf@gitster.siamese.dyndns.org> <20080207093415.13241.qmail@945a2ee23beef0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:58:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWMI-00084M-6Z
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbYBKK5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 05:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbYBKK5X
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:57:23 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58839 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753287AbYBKK5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:57:23 -0500
Received: (qmail 16354 invoked by uid 1000); 11 Feb 2008 10:57:41 -0000
Content-Disposition: inline
In-Reply-To: <20080207093415.13241.qmail@945a2ee23beef0.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73514>

When creating a tag through gitk, and the tag name includes a slash (or
slashes), gitk errors out in a popup window.  This patch makes gitk use
'git tag' to create the tag instead of modifying files in refs/tags/,
which fixes the issue; if 'git tag' throws an error, gitk pops up with
the error message.

The problem was reported by Fr=E9d=E9ric Bri=E8re through
 http://bugs.debian.org/464104

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitk-git/gitk |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5560e4d..00d791f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6137,11 +6137,7 @@ proc domktag {} {
 	return
     }
     if {[catch {
-	set dir [gitdir]
-	set fname [file join $dir "refs/tags" $tag]
-	set f [open $fname w]
-	puts $f $id
-	close $f
+	exec git tag $tag $id
     } err]} {
 	error_popup "[mc "Error creating tag:"] $err"
 	return
--=20
1.5.4
