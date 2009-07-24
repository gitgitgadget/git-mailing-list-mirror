From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 08/10] gitweb: Add optional "time to generate page" info in footer
Date: Sat, 25 Jul 2009 00:44:08 +0200
Message-ID: <1248475450-5668-9-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTYM-00007K-Cg
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbZGXWro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbZGXWrn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:47:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:17767 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbZGXWrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:47:43 -0400
Received: by fg-out-1718.google.com with SMTP id e21so528578fga.17
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VnHOjeZFeYBvcyQMRgBwu38xJiKHqyB1Aug8yMsly8c=;
        b=w8aVXlhrtKdtAe4J8qfmGoA7cySrvqQMmGAQ7y9R1dt5j5yeLcx+uWqh20N60MwVW+
         IjzTnjjHdAoXDtQZ5Vh4S6eeygfSy92/j5+cWU3ffQ4WLxfGH328CU4XieZdUXaKr8Q4
         3Vv5192s2dsZEQwW4Feq67fWnItreqirVhHLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pEFY6yqfsihsEnLwmxJ9w2s+CxGtoUxa+t09TTDeA70xPhODLHYG24xDCa0YmATNHw
         HQ/WC7EMNW2hsH4iRzVCAaHceO/sFf2IIh+qFNtp+Qnpksv7rQV78oLtKbgKAfxDgrAG
         KkQoFTT39qXSb9Mlar4NBweA4ldhTlDddf4+g=
Received: by 10.86.86.8 with SMTP id j8mr161683fgb.70.1248475662268;
        Fri, 24 Jul 2009 15:47:42 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id 3sm9217610fge.28.2009.07.24.15.47.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:47:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMrEA4005860;
	Sat, 25 Jul 2009 00:53:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMqckA005847;
	Sat, 25 Jul 2009 00:52:39 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123967>

Add "This page took XXXs and Y git commands to generate" to page
footer, if global feature 'timed' is enabled (disabled by default).
Requires Time::HiRes installed for high precision 'wallclock' time.

This code is based on example code by Petr 'Pasky' Baudis.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was extracted from 5/3 patch implementing interactive
blame, and modified to be conditional on 'timed' feature, and to show
also number of git commands used.

Note that setting $t0 variable should be fairly early to have running
time of the whole script.  The same for $number_of_git_cmds.

Current formatting is very basic, just like before.  It simply uses 
'page_footer' style.

Variable names and name of feature is up to debate.

 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0d91ac7..bd77b31 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,6 +18,12 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
+our $t0;
+if (eval { require Time::HiRes; 1; }) {
+	$t0 = [Time::HiRes::gettimeofday()];
+}
+our $number_of_git_cmds = 0;
+
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
@@ -394,6 +400,13 @@ our %feature = (
 		'sub' => \&feature_avatar,
 		'override' => 0,
 		'default' => ['']},
+
+	# Enable displaying how much time and how many git commands
+	# it took to generate and display page.  Disabled by default.
+	# Project specific override is not supported.
+	'timed' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -507,6 +520,7 @@ if (-e $GITWEB_CONFIG) {
 
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+$number_of_git_cmds++;
 
 $projects_list ||= $projectroot;
 
@@ -1956,6 +1970,7 @@ sub get_feed_info {
 
 # returns path to the core git executable and the --git-dir parameter as list
 sub git_cmd {
+	$number_of_git_cmds++;
 	return $GIT, '--git-dir='.$git_dir;
 }
 
@@ -3206,6 +3221,20 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
+	if (defined $t0 && gitweb_check_feature('timed')) {
+		print "<div id=\"generate_info\" class=\"page_footer\">\n";
+		print 'This page took '.
+		      '<span id="generate_time" class="time_span">'.
+		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).'s'.
+		      '</span>'.
+		      ' and '.
+		      '<span id="generate_cmd">'.
+		      $number_of_git_cmds.
+		      '</span> git commands '.
+		      " to generate.\n";
+		print "</div>\n"; # class="page_footer"
+	}
+
 	if (-f $site_footer) {
 		insert_file($site_footer);
 	}
-- 
1.6.3.3
