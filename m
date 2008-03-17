From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3 v2] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 16:09:27 +0100
Message-ID: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 16:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbGyn-00070S-2X
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYCQPJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYCQPJp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:09:45 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:1384 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbYCQPJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:09:43 -0400
Received: by mu-out-0910.google.com with SMTP id i10so11308554mue.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8sZkYonAU7VFuIcdnBpuRom6UM3gVLyxEI0Fjxwa+ug=;
        b=wD7ROxmUO6bPAakOZdtL8i4E4Yp9QtUnrLn/QsTfAhxW5bifHme3L+xnSHUeLQ/BPD65CcahyJo2RchB8qMCWjyHxbb4TNonCia/kZ33Wj1vfiEVhQgcN7kswngyE0DVsIhzHv0FtHu+uAIwqytRcQjdwJF6QZt0V6PpANt+Vl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dfnCyWJ30f20NS7dZDoIh++rwryxnqsdYp/coxEqhLQJuKRuAraHBIKeYxdy6zL3jz6YIQ0DF6NxjzarcUx4IFAnTljRqp/sw1T8K5QwiGDfLv38OE66pc+TT8FOMtrEqWm/9KplC6EWxFP9ADqYJ9bHb2uDCzpFSXA7YjsYZxo=
Received: by 10.78.201.2 with SMTP id y2mr42379258huf.41.1205766578627;
        Mon, 17 Mar 2008 08:09:38 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.138])
        by mx.google.com with ESMTPS id j12sm7852580fkf.6.2008.03.17.08.09.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 08:09:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HF9W80013570;
	Mon, 17 Mar 2008 16:09:32 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HF9UX4013569;
	Mon, 17 Mar 2008 16:09:30 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77437>

This series of patches is resend of patch by Petr 'Pasky' Baudis with
the same subject, which can be found in,
  Message-ID: <20080313231413.27966.3383.stgit@rover>
  http://permalink.gmane.org/gmane.comp.version-control.git/77151
split into two patches (so the exact details of serializing and
caching can be separated from independent code improvement), and with
added lazy filling of details for a project.

At the bottom there is interdiff between Pasky's result and result
after first two patches here.  Besides a bit of style changes the main
difference is that in this version dump of @projects array is done in
'terse' form, so it can be eval'ed directly into @projects.

Table of contents:
==================
 [PATCH 1/3] gitweb: Separate filling projects info
             into git_get_projects_details()
 [PATCH 2/3] gitweb: Support caching projects list
 [PATCH 3/3] gitweb: Fill project details only if project path
              mtime changed

Shortlog:
=========
Jakub Narebski (1):
  gitweb: Fill project details only if project path mtime changed

Petr Baudis (2):
  gitweb: Separate filling projects info into git_get_projects_details()
  gitweb: Support caching projects list

Diffstat:
=========
 gitweb/gitweb.css  |    6 ++++
 gitweb/gitweb.perl |   73 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 5 deletions(-)

Interdiff:
==========
 gitweb/gitweb.perl |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bee5ec8..5527378 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -123,7 +123,7 @@ our @diff_opts = ('-M'); # taken from git_commit
 # index lifetime in minutes
 # the cached list version is stored in /tmp and can be tweaked
 # by other scripts running with the same uid as gitweb - use this
-# only at secure installations; only single gitweb project root per
+# ONLY at secure installations; only single gitweb project root per
 # system is supported!
 our $projlist_cache_lifetime = 0;
 
@@ -3482,6 +3482,8 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
+# fill age, description, owner, forks (last one only if $check_forks)
+# for all projects in $projlist reference; fill projects info
 sub git_get_projects_details {
 	my ($projlist, $check_forks) = @_;
 
@@ -3521,34 +3523,37 @@ sub git_project_list_body {
 
 	my ($check_forks) = gitweb_check_feature('forks');
 
-	my $cache_file = '/tmp/gitweb.index.cache';
 	use File::stat;
+	use POSIX qw(:fcntl_h);
+
+	my $cache_file =  '/tmp/gitweb.index.cache';
 
 	my @projects;
 	my $stale = 0;
-	if ($cache_lifetime and -f $cache_file
-	    and stat($cache_file)->mtime + $cache_lifetime * 60 > time()
-	    and open (my $fd, $cache_file)) {
-		$stale = time() - stat($cache_file)->mtime;
-		my @dump = <$fd>;
+	my $now = time();
+	if ($cache_lifetime && -f $cache_file &&
+	    stat($cache_file)->mtime + $cache_lifetime * 60 > $now &&
+	    open(my $fd, '<', $cache_file)) {
+		$stale = $now - stat($cache_file)->mtime;
+		local $/ = undef;
+		my $dump = <$fd>;
 		close $fd;
-		# Hack zone start
-		my $VAR1;
-		eval join("\n", @dump);
-		@projects = @$VAR1;
-		# Hack zone end
+		@projects = @{ eval $dump };
 	} else {
-		if ($cache_lifetime and -f $cache_file) {
+		if ($cache_lifetime && -f $cache_file) {
 			# Postpone timeout by two minutes so that we get
 			# enough time to do our job.
 			my $time = time() - $cache_lifetime + 120;
 			utime $time, $time, $cache_file;
 		}
 		@projects = git_get_projects_details($projlist, $check_forks);
-		if ($cache_lifetime and open (my $fd, '>'.$cache_file)) {
+		if ($cache_lifetime &&
+		    sysopen(my $fd, "$cache_file.lock", O_WRONLY|O_CREAT|O_EXCL, 0600)) {
 			use Data::Dumper;
+			$Data::Dumper::Terse = 1;
 			print $fd Dumper(\@projects);
 			close $fd;
+			rename "$cache_file.lock", $cache_file;
 		}
 	}
 
@@ -3556,7 +3561,7 @@ sub git_project_list_body {
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
-	if ($cache_lifetime and $stale) {
+	if ($cache_lifetime && $stale) {
 		print "<div class=\"stale_info\">Cached version (${stale}s old)</div>\n";
 	}
 
