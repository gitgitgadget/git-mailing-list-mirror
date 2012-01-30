From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH 1/6] gitweb: move hard coded .git suffix out of
 git_get_projects_list
Date: Mon, 30 Jan 2012 21:05:47 +0100
Message-ID: <20120130200547.GB2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:05:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxTs-0002Rm-Q0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2A3UFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:05:30 -0500
Received: from server.brlink.eu ([78.46.187.186]:54106 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab2A3UF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:05:29 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxTk-0005v9-4v; Mon, 30 Jan 2012 21:05:28 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxU3-0001Bf-1w; Mon, 30 Jan 2012 21:05:47 +0100
Content-Disposition: inline
In-Reply-To: <20120130200355.GA2584@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189410>

Use of the filter option of git_get_projects_list is currently
limited to forks. It hard codes removal of ".git" suffixes from
the filter.

To make it more generic move the .git suffix removal to the callers.
Signed-off-by: Bernhard R. Link <brlink@debian.org>
---

Changes to v5.5:
	- split first patch in two as suggested by Jakub Narebski
---
 gitweb/gitweb.perl |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9cf7e71..0ee3290 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2831,8 +2831,6 @@ sub git_get_projects_list {
 	my $filter = shift || '';
 	my @list;
 
-	$filter =~ s/\.git$//;
-
 	if (-d $projects_list) {
 		# search in directory
 		my $dir = $projects_list;
@@ -6007,7 +6005,7 @@ sub git_forks {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list($project);
+	my @list = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
 	if (!@list) {
 		die_error(404, "No forks found");
 	}
@@ -6066,7 +6064,7 @@ sub git_summary {
 
 	if ($check_forks) {
 		# find forks of a project
-		@forklist = git_get_projects_list($project);
+		@forklist = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
 		# filter out forks of forks
 		@forklist = filter_forks_from_projects_list(\@forklist)
 			if (@forklist);
-- 
1.7.8.3
