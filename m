From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 05:23:46 +0200
Message-ID: <20061024032346.4185.85330.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 05:23:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcCtL-0005Ow-Kt
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWJXDXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWJXDXs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:23:48 -0400
Received: from rover.dkm.cz ([62.24.64.27]:28078 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932406AbWJXDXs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:23:48 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id CB8928BC3B;
	Tue, 24 Oct 2006 05:23:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29917>

If the repository includes a README.html file, show it in the summary page.
The usual "this should be in the config file" argument does not apply here
since this can be larger and having such a big string in the config file
would be impractical.

I don't know if this is suitable upstream, but it's one of the repo.or.cz
custom modifications that I've thought could be interesting for others
as well.

Compared to the previous patch, this adds the '.html' extension to the
filename, so that it's clear it is, well, HTML.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b26ec3..81adc71 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2538,6 +2538,14 @@ sub git_summary {
 	}
 	print "</table>\n";
 
+	if (-s "$projectroot/$project/README.html") {
+		if (open my $fd, "$projectroot/$project/README.html") {
+			print "<div class=\"title\">readme</div>\n";
+			print $_ while (<$fd>);
+			close $fd;
+		}
+	}
+
 	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
 		git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
