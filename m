From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 04/14] gitweb: separate heads and remotes list in summary view
Date: Fri, 31 Aug 2007 12:55:31 +0200
Message-ID: <11885577311796-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 12:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4C6-0005R7-Us
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXHaK5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbXHaK5g
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:57:36 -0400
Received: from averell.tiscali.it ([213.205.33.55]:59595 "EHLO
	averell.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbXHaK5f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:57:35 -0400
Received: from localhost.localdomain (84.221.55.162) by averell.tiscali.it (7.3.122)
        id 468D1A8000685A4A; Fri, 31 Aug 2007 12:57:10 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57152>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4b27352..6aec28e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3804,6 +3804,7 @@ sub git_summary {
 	my %co = parse_commit("HEAD");
 	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
+	my ($remote_heads) = gitweb_check_feature('remote_heads');
 
 	my $owner = git_get_project_owner($project);
 
@@ -3811,7 +3812,8 @@ sub git_summary {
 	# These get_*_list functions return one more to allow us to see if
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
-	my @headlist = git_get_heads_list(16);
+	my @headlist = git_get_heads_list(16, 'heads');
+	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
 	my @forklist;
 	my ($check_forks) = gitweb_check_feature('forks');
 
@@ -3874,6 +3876,13 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
+	if (@remotelist) {
+		git_print_header_div('remotes');
+		git_heads_body(\@remotelist, $head, 0, 15,
+		               $#remotelist <= 15 ? undef :
+		               $cgi->a({-href => href(action=>"heads")}, "..."));
+	}
+
 	if (@forklist) {
 		git_print_header_div('forks');
 		git_project_list_body(\@forklist, undef, 0, 15,
-- 
1.5.2.5
