From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 04:56:28 +0200
Message-ID: <20061010025627.19317.70511.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 10 04:56:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX7nG-0005Zn-Tt
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 04:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWJJC4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 22:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWJJC4a
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 22:56:30 -0400
Received: from rover.dkm.cz ([62.24.64.27]:58335 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1751993AbWJJC4a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 22:56:30 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 221398BBE0;
	Tue, 10 Oct 2006 04:56:28 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28598>

If the project includes a README file, show it in the summary page.
The usual "this should be in the config file" argument does not apply here
since this can be larger and having such a big string in the config file
would be impractical.

I don't know if this is suitable upstream, but it's one of the repo.or.cz
custom modifications that I've thought could be interesting for others
as well.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7547c4d..4e56af9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2535,6 +2535,14 @@ sub git_summary {
 	}
 	print "</table>\n";
 
+	if (-s "$projectroot/$project/README") {
+		if (open my $fd, "$projectroot/$project/README") {
+			print "<div class=\"title\">readme</div>\n";
+			print $_ while (<$fd>);
+			close $fd;
+		}
+	}
+
 	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
 		git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
