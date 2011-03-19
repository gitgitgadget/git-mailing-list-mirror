From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/2] gitweb: rename parse_date() to format_date()
Date: Fri, 18 Mar 2011 22:39:33 -0700
Message-ID: <ab54ba2199cc7487e383a31e3aa65885@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 06:44:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0oxU-0001ca-78
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 06:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab1CSFoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 01:44:11 -0400
Received: from [69.28.251.93] ([69.28.251.93]:46140 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753280Ab1CSFoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 01:44:09 -0400
Received: (qmail 1327 invoked from network); 19 Mar 2011 05:44:07 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 19 Mar 2011 05:44:07 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 18 Mar 2011 22:44:07 -0700
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169384>

One might reasonably expect a function named parse_date() to be used
for something along these lines:

$unix_time_t = parse_date("2011-03-19");

But instead, gitweb's parse_date works more like:

&parse_date(1300505805) = {
        'hour' => 3,
        'minute' => 36,
        ...
        'rfc2822' => 'Sat, 19 Mar 2011 03:36:45 +0000',
        ...
}

Rename the function to improve clarity.  No change to functionality.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b04ab8c..57ef08c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2893,7 +2893,7 @@ sub git_get_rev_name_tags {
 ## ----------------------------------------------------------------------
 ## parse to hash functions
 
-sub parse_date {
+sub format_date {
 	my $epoch = shift;
 	my $tz = shift || "-0000";
 
@@ -3953,7 +3953,7 @@ sub git_print_authorship {
 	my $tag = $opts{-tag} || 'div';
 	my $author = $co->{'author_name'};
 
-	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
+	my %ad = format_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
 	      " [$ad{'rfc2822'}";
@@ -3973,7 +3973,7 @@ sub git_print_authorship_rows {
 	my @people = @_;
 	@people = ('author', 'committer') unless @people;
 	foreach my $who (@people) {
-		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
+		my %wd = format_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
 		print "<tr><td>$who</td><td>" .
 		      format_search_author($co->{"${who}_name"}, $who,
 			       esc_html($co->{"${who}_name"})) . " " .
@@ -4906,7 +4906,7 @@ sub git_log_body {
 		next if !%co;
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
-		my %ad = parse_date($co{'author_epoch'});
+		my %ad = format_date($co{'author_epoch'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
 		               esc_html($co{'title'}) . $ref,
@@ -5369,7 +5369,7 @@ sub git_project_index {
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
 	my %co = parse_commit("HEAD");
-	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
+	my %cd = %co ? format_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
 	my $head = $co{'id'};
 	my $remote_heads = gitweb_check_feature('remote_heads');
 
@@ -5674,7 +5674,7 @@ sub git_blame_common {
 			my $short_rev = substr($full_rev, 0, 8);
 			my $author = $meta->{'author'};
 			my %date =
-				parse_date($meta->{'author-time'}, $meta->{'author-tz'});
+				format_date($meta->{'author-time'}, $meta->{'author-tz'});
 			my $date = $date{'iso-tz'};
 			if ($group_size) {
 				$current_color = ($current_color + 1) % $num_colors;
@@ -6702,7 +6702,7 @@ sub git_commitdiff {
 			-charset => 'utf-8',
 			-expires => $expires,
 			-content_disposition => 'inline; filename="' . "$filename" . '"');
-		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
+		my %ad = format_date($co{'author_epoch'}, $co{'author_tz'});
 		print "From: " . to_utf8($co{'author'}) . "\n";
 		print "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n";
 		print "Subject: " . to_utf8($co{'title'}) . "\n";
@@ -7064,7 +7064,7 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
 		my $latest_epoch = $latest_commit{'committer_epoch'};
-		%latest_date   = parse_date($latest_epoch);
+		%latest_date   = format_date($latest_epoch);
 		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
 		if (defined $if_modified) {
 			my $since;
@@ -7195,7 +7195,7 @@ XML
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'author_epoch'});
+		my %cd = format_date($co{'author_epoch'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
1.7.4.1
