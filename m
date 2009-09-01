From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/5] gitweb: Add optional "time to generate page" info in footer
Date: Tue,  1 Sep 2009 13:39:16 +0200
Message-ID: <1251805160-5303-2-git-send-email-jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 13:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiRau-0001Co-7M
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 13:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZIALcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 07:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZIALcC
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 07:32:02 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:36393 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbZIALb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 07:31:59 -0400
Received: by fxm17 with SMTP id 17so3435900fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xrRIl/vWN5PnflOkpcjIx48DuD8yRGzlH4mhE9GVrE4=;
        b=LLb18aaH/Vi/SZ2CW9kltQ1l2CzoFTq8oOnolwQINkTWZOTfYBw9BjAzvLsxSbm2o8
         81iBM4foRQgTDIFGjRl+hAi6vb/f08UR4Zr3Ok8PSH+HyXYULaqc9ndUPNcy2F+fOG9K
         9Nh6Eap+jukBHXnJVV0Qudn8UFLxaKGUEP9E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B0SFcfad5tKfI1MrLKwR7niZsW6KfpS+NMrhG11+bgARS4QnwfbwieIw7UgctSNPDO
         xdH4m1sXC4nn8CdH5hbzwfjwCtJidxOZaIlww7zhSJTNIVQILCmpDVRZkN6WK+4ZjSLC
         Ys8y4zjCI3yZf/Z81zZzec4FWq8INF4EuI3Sw=
Received: by 10.102.13.21 with SMTP id 21mr2847674mum.100.1251804720507;
        Tue, 01 Sep 2009 04:32:00 -0700 (PDT)
Received: from localhost.localdomain (abwl209.neoplus.adsl.tpnet.pl [83.8.235.209])
        by mx.google.com with ESMTPS id j2sm4496553mue.38.2009.09.01.04.31.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 04:31:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n81BdTiF005337;
	Tue, 1 Sep 2009 13:39:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n81BdTU4005336;
	Tue, 1 Sep 2009 13:39:29 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127531>

Add "This page took XXX seconds and Y git commands to generate"
to page footer, if global feature 'timed' is enabled (disabled
by default).  Requires Time::HiRes installed for high precision
'wallclock' time.

Note that Time::HiRes is being required unconditionally of 'timed'
feature, because setting $t0 variable should be fairly early to have
running time of the whole script.  If Time::HiRes module was required
only if 'timed' feature is enabled, the earliest place where starting
time ($t0) could be calculated would be after reading gitweb config,
making "time to generate page" info inaccurate.

This code is based on example code by Petr 'Pasky' Baudis.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version adds custom formatting for "time to generate page"
information in the page footer, instead of reusing 'page_footer'
style.  It is now clearly separated from the gitweb footer proper.

While at it the ids were changed from "generate_info" etc. to
"generating_info" etc.

There is still a question whether Time::HiRes should be require'd
unconditionally, but otherwise this patch is out of RFC stage.


Sidenote: I have noticed that gitweb's CSS rules are unnecessary
strict, making rendering slower because of extra non needed checks
(the rule is that selectors should be as simple as possible).

 gitweb/gitweb.css  |    7 +++++++
 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index b59fcaf..00e2e4c 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -75,6 +75,13 @@ div.page_footer_text {
 	font-style: italic;
 }
 
+div#generating_info {
+	margin: 4px;
+	font-size: smaller;
+	text-align: center;
+	color: #505050;
+}
+
 div.page_body {
 	padding: 8px;
 	font-family: monospace;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ff2d42a..08d410d 100755
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
@@ -404,6 +410,13 @@ our %feature = (
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
@@ -518,6 +531,7 @@ if (-e $GITWEB_CONFIG) {
 
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+$number_of_git_cmds++;
 
 $projects_list ||= $projectroot;
 
@@ -1969,6 +1983,7 @@ sub get_feed_info {
 
 # returns path to the core git executable and the --git-dir parameter as list
 sub git_cmd {
+	$number_of_git_cmds++;
 	return $GIT, '--git-dir='.$git_dir;
 }
 
@@ -3218,6 +3233,20 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
+	if (defined $t0 && gitweb_check_feature('timed')) {
+		print "<div id=\"generating_info\">\n";
+		print 'This page took '.
+		      '<span id="generating_time" class="time_span">'.
+		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+		      ' seconds </span>'.
+		      ' and '.
+		      '<span id="generating_cmd">'.
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
