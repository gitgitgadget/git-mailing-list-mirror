From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Allow arbitrary strings to be dug with pickaxe
Date: Thu, 17 May 2007 04:30:42 +0200
Message-ID: <20070517023042.19611.59572.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 04:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVlU-0003xa-QO
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbXEQCap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbXEQCap
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:30:45 -0400
Received: from rover.dkm.cz ([62.24.64.27]:54556 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbXEQCao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:30:44 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id BE21B8B4BF;
	Thu, 17 May 2007 04:30:42 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47487>

Currently, there are rather draconian restrictions on the strings accepted
by the pickaxe search, which degrades its usefulness for digging in code
significantly. This patch remedies mentioned limitation.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4a1a423..8dc009a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -404,7 +404,7 @@ if (defined $searchtype) {
 our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
-	if ($searchtype ne 'grep' and $searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
+	if ($searchtype ne 'grep' and $searchtype ne 'pickaxe' and $searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
 		die_error(undef, "Invalid search parameter");
 	}
 	if (length($searchtext) < 2) {
@@ -4794,8 +4794,10 @@ sub git_search {
 		my $alternate = 1;
 		$/ = "\n";
 		my $git_command = git_cmd_str();
+		my $searchqtext = $searchtext;
+		$searchqtext =~ s/'/'\\''/;
 		open my $fd, "-|", "$git_command rev-list $hash | " .
-			"$git_command diff-tree -r --stdin -S\'$searchtext\'";
+			"$git_command diff-tree -r --stdin -S\'$searchqtext\'";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
