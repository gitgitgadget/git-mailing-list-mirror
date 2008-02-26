From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] gitweb: Clearly distinguish regexp / exact match searches
Date: Tue, 26 Feb 2008 13:22:08 +0100
Message-ID: <1204028528-18941-5-git-send-email-jnareb@gmail.com>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@ucw.cz>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 13:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyqO-000223-0t
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbYBZMWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbYBZMWb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:22:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:60359 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYBZMW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:22:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1231685ugc.16
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 04:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VWSH0kK/7q4dhV8/iHHQp2Lc8KzQTQ0UBoUkzNUMVMw=;
        b=AKFoU5Ifd1ZzqATII/fiQC0P8/yvTpRNcgZTlR0pq0HRrAxafpug8asPL2sJ5ah+3jv8OOI1XuOylk6+HjTzfWg8cZRz9R8GQDg3ckVz7OZfzWDjzqlVPxitNQACa0JFzmGhmCneWsCPF1nP+w60Suxo9XhT4ryrUjhCmbW6yGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v/reaEDcCOBRDDY7banvTjHRI+u0HDUAf6q2GI0/ZGYxOYWyqYLXZVk1trbKO10A47DPvLVn93xqz3fGgiDY7GcUQnmJF7COrjkxJGCq/colVdkZYP+tlqd7Kw5CTtSxV5WKwUqizEw5BbrhrvgctIcNwMu32M85+oXtu6znzBk=
Received: by 10.78.199.8 with SMTP id w8mr2476793huf.46.1204028543327;
        Tue, 26 Feb 2008 04:22:23 -0800 (PST)
Received: from localhost.localdomain ( [83.8.218.226])
        by mx.google.com with ESMTPS id 32sm10894309nfu.7.2008.02.26.04.22.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Feb 2008 04:22:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1QCMICu018976;
	Tue, 26 Feb 2008 13:22:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1QCMCJU018975;
	Tue, 26 Feb 2008 13:22:12 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75131>

From: Petr Baudis <pasky@ucw.cz>

This patch does a couple of things:

* Makes commit/author/committer search case insensitive

	To be consistent with the grep search; I see no convincing
	reason for the search to be case sensitive, and you might
	get in trouble especially with contributors e.g. from Japan
	or France where they sometimes like to uppercase their last
	name.

* Makes grep search by default search for fixed strings

	Since we will have a checkbox.

* Introduces 're' checkbox that enables POSIX extended regexp searches

	This works for all the search types. The idea comes from Jakub.

It does not make much sense (and is not easy at all) to untangle most
of these changes from each other, thus they all go in a single patch.

[jn: Cherry-picked from Pasky's http://repo.or.cz/git/gitweb.git]

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Cherry-picked, and resolved conflict.

 gitweb/gitweb.perl |   44 ++++++++++++++++++++++++++++++--------------
 1 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cf78e..20dc5d5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -472,13 +472,15 @@ if (defined $searchtype) {
 	}
 }
 
+our $search_use_regexp = $cgi->param('sr');
+
 our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
-	$search_regexp = quotemeta $searchtext;
+	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
 
 # now read PATH_INFO and use it as alternative to parameters
@@ -608,6 +610,7 @@ sub href(%) {
 		searchtype => "st",
 		snapshot_format => "sf",
 		extra_options => "opt",
+		search_use_regexp => "sr",
 	);
 	my %mapping = @mapping;
 
@@ -2584,6 +2587,10 @@ EOF
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+		      "<span title=\"Extended regular expression\">" .
+		      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
+		                     -checked => $search_use_regexp) .
+		      "</span>" .
 		      "</div>" .
 		      $cgi->end_form() . "\n";
 	}
@@ -5256,7 +5263,8 @@ sub git_search {
 		}
 		$greptype .= $searchtext;
 		my @commitlist = parse_commits($hash, 101, (100 * $page), undef,
-		                               $greptype, '--fixed-strings');
+		                               $greptype, '--regexp-ignore-case',
+		                               $search_use_regexp ? '--extended-regexp' : '--fixed-strings');
 
 		my $paging_nav = '';
 		if ($page > 0) {
@@ -5300,8 +5308,9 @@ sub git_search {
 		my $git_command = git_cmd_str();
 		my $searchqtext = $searchtext;
 		$searchqtext =~ s/'/'\\''/;
+		my $pickaxe_flags = $search_use_regexp ? '--pickaxe-regex' : '';
 		open my $fd, "-|", "$git_command rev-list $hash | " .
-			"$git_command diff-tree -r --stdin -S\'$searchqtext\'";
+			"$git_command diff-tree -r --stdin -S\'$searchqtext\' $pickaxe_flags";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -5365,7 +5374,9 @@ sub git_search {
 		my $alternate = 1;
 		my $matches = 0;
 		$/ = "\n";
-		open my $fd, "-|", git_cmd(), 'grep', '-n', '-i', '-E', $searchtext, $co{'tree'};
+		open my $fd, "-|", git_cmd(), 'grep', '-n',
+			$search_use_regexp ? ('-E', '-i') : '-F',
+			$searchtext, $co{'tree'};
 		my $lastfile = '';
 		while (my $line = <$fd>) {
 			chomp $line;
@@ -5395,7 +5406,7 @@ sub git_search {
 				print "<div class=\"binary\">Binary file</div>\n";
 			} else {
 				$ltext = untabify($ltext);
-				if ($ltext =~ m/^(.*)($searchtext)(.*)$/i) {
+				if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
 					$ltext = esc_html($1, -nbsp=>1);
 					$ltext .= '<span class="match">';
 					$ltext .= esc_html($2, -nbsp=>1);
@@ -5430,27 +5441,31 @@ sub git_search_help {
 	git_header_html();
 	git_print_page_nav('','', $hash,$hash,$hash);
 	print <<EOT;
+<p><strong>Pattern</strong> is by default a normal string that is matched precisely (but without
+regard to case, except in the case of pickaxe). However, when you check the <em>re</em> checkbox,
+the pattern entered is recognized as the POSIX extended
+<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a> (also case
+insensitive).</p>
 <dl>
 <dt><b>commit</b></dt>
-<dd>The commit messages and authorship information will be scanned for the given string.</dd>
+<dd>The commit messages and authorship information will be scanned for the given pattern.</dd>
 EOT
 	my ($have_grep) = gitweb_check_feature('grep');
 	if ($have_grep) {
 		print <<EOT;
 <dt><b>grep</b></dt>
 <dd>All files in the currently selected tree (HEAD unless you are explicitly browsing
-    a different one) are searched for the given
-<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a>
-(POSIX extended) and the matches are listed. On large
-trees, this search can take a while and put some strain on the server, so please use it with
-some consideration.</dd>
+    a different one) are searched for the given pattern. On large trees, this search can take
+a while and put some strain on the server, so please use it with some consideration. Note that
+due to git-grep peculiarity, currently if regexp mode is turned off, the matches are
+case-sensitive.</dd>
 EOT
 	}
 	print <<EOT;
 <dt><b>author</b></dt>
-<dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given string.</dd>
+<dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given pattern.</dd>
 <dt><b>committer</b></dt>
-<dd>Name and e-mail of the committer and date of commit will be scanned for the given string.</dd>
+<dd>Name and e-mail of the committer and date of commit will be scanned for the given pattern.</dd>
 EOT
 	my ($have_pickaxe) = gitweb_check_feature('pickaxe');
 	if ($have_pickaxe) {
@@ -5458,7 +5473,8 @@ EOT
 <dt><b>pickaxe</b></dt>
 <dd>All commits that caused the string to appear or disappear from any file (changes that
 added, removed or "modified" the string) will be listed. This search can take a while and
-takes a lot of strain on the server, so please use it wisely.</dd>
+takes a lot of strain on the server, so please use it wisely. Note that since you may be
+interested even in changes just changing the case as well, this search is case sensitive.</dd>
 EOT
 	}
 	print "</dl>\n";
-- 
1.5.4.2
