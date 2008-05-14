From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2 v2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Wed, 14 May 2008 23:30:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805142327520.30431@racer>
References: <alpine.DEB.1.00.0805141526160.30431@racer> <7vskwkojhy.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141936410.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPVd-000335-B6
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760148AbYENWao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 18:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760098AbYENWao
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:30:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:32845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760058AbYENWan (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 18:30:43 -0400
Received: (qmail invoked by alias); 14 May 2008 22:30:41 -0000
Received: from R2b68.r.pppool.de (EHLO racer.local) [89.54.43.104]
  by mail.gmx.net (mp041) with SMTP; 15 May 2008 00:30:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uFmwl5Ddu3pcSF0VyZUXvWLrux1cc/KqxSOAAsg
	d4z8Ze8jGDL5ux
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141936410.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82154>


In commit fef3a7cc(cvsexportcommit: be graceful when "cvs status"
reorders the arguments), caution was taken to get the status even
for files with leading or trailing whitespace.

However, the author of that commit missed that chomp() removes only
trailing newlines.  With help of the mailing list, the author realized
his mistake and provided this patch.

The idea is that we do not want to rely on a certain layout of the 
output of "cvs status".  Therefore we only call it with files that are 
unambiguous after stripping leading and trailing whitespace.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 14 May 2008, Johannes Schindelin wrote:

	> To prevent bad things from happening, the status is checked on a 
	> set of files which have unique names with regard to the chomp()ed
	> name (well, whatever we do to the name, really).
	> 
	> So yes, this patch needs an update.
	> 
	> Will do so in a couple of hours,

	And so I did.

 git-cvsexportcommit.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index b6036bd..52ba7de 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -210,7 +210,7 @@ if (@canstatusfiles) {
 	my $basename = basename($name);
 
 	$basename = "no file " . $basename if (exists($added{$basename}));
-	chomp($basename);
+	$basename =~ s/^\s+(.*?)\s*$/$1/;
 
 	if (!exists($fullname{$basename})) {
 	  $fullname{$basename} = $name;
-- 
1.5.5.1.375.g1becb
