From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/9] gitweb: Don't undefine query parameter related variables before die_error
Date: Sat, 05 Aug 2006 12:58:06 +0200
Organization: At home
Message-ID: <eb1tij$6kf$4@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:10:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9K2n-0001kS-7P
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161596AbWHELKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWHELKH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:10:07 -0400
Received: from main.gmane.org ([80.91.229.2]:9403 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161598AbWHELKF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:10:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9K2c-0001hx-An
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:10:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:10:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:10:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24903>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It would allow to include value of invalid parameter in error message

 gitweb/gitweb.perl |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9b9bf37..6f3f465 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -76,7 +76,6 @@ # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
        if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
-               undef $action;
                die_error(undef, "Invalid action parameter.");
        }
        # action which does not check rest of parameters
@@ -89,16 +88,13 @@ if (defined $action) {
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
 if (defined $project) {
        $project =~ s|^/||; $project =~ s|/$||;
-       $project = validate_input($project);
-       if (!defined($project)) {
+       if (!validate_input($project)) {
                die_error(undef, "Invalid project parameter.");
        }
        if (!(-d "$projectroot/$project")) {
-               undef $project;
                die_error(undef, "No such directory.");
        }
        if (!(-e "$projectroot/$project/HEAD")) {
-               undef $project;
                die_error(undef, "No such project.");
        }
        $rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
@@ -111,32 +107,28 @@ if (defined $project) {
 
 our $file_name = $cgi->param('f');
 if (defined $file_name) {
-       $file_name = validate_input($file_name);
-       if (!defined($file_name)) {
+       if (!validate_input($file_name)) {
                die_error(undef, "Invalid file parameter.");
        }
 }
 
 our $hash = $cgi->param('h');
 if (defined $hash) {
-       $hash = validate_input($hash);
-       if (!defined($hash)) {
+       if (!validate_input($hash)) {
                die_error(undef, "Invalid hash parameter.");
        }
 }
 
 our $hash_parent = $cgi->param('hp');
 if (defined $hash_parent) {
-       $hash_parent = validate_input($hash_parent);
-       if (!defined($hash_parent)) {
+       if (!validate_input($hash_parent)) {
                die_error(undef, "Invalid hash parent parameter.");
        }
 }
 
 our $hash_base = $cgi->param('hb');
 if (defined $hash_base) {
-       $hash_base = validate_input($hash_base);
-       if (!defined($hash_base)) {
+       if (!validate_input($hash_base)) {
                die_error(undef, "Invalid hash base parameter.");
        }
 }
@@ -144,7 +136,6 @@ if (defined $hash_base) {
 our $page = $cgi->param('pg');
 if (defined $page) {
        if ($page =~ m/[^0-9]$/) {
-               undef $page;
                die_error(undef, "Invalid page parameter.");
        }
 }
@@ -152,7 +143,6 @@ if (defined $page) {
 our $searchtext = $cgi->param('s');
 if (defined $searchtext) {
        if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
-               undef $searchtext;
                die_error(undef, "Invalid search parameter.");
        }
        $searchtext = quotemeta $searchtext;
@@ -182,7 +172,6 @@ my %actions = (
 
 $action = 'summary' if (!defined($action));
 if (!defined($actions{$action})) {
-       undef $action;
        die_error(undef, "Unknown action.");
 }
 $actions{$action}->();
-- 
1.4.1.1
