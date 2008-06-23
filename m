From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 23 Jun 2008 03:14:48 +0200
Message-ID: <1214183688-8544-1-git-send-email-LeWiemann@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 03:15:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAaev-0006FK-FF
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 03:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYFWBO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 21:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYFWBO4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 21:14:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:28812 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbYFWBOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 21:14:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1023930fgg.17
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 18:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=T89KU7L0OJ6mES0yMkqwlarjeCBKev2vRcc1zThpadg=;
        b=pQlnU9PzoMQD1Cq7bjI6Xxptq9yCEjCl344/Vj7wJXNP4lC6IjfS4zMXQf9OTKJlxu
         PIwwjq4TXtUhRV4l2Q3rR3vPtGzuDcBZXcBw63wqWyWXH2wgXwjzP/HYEfxShlzXtnIe
         4CpAywCeW48maZSxcWcubAzAxqtr5PYhe7lBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=tvnbS8bUMs4tKdSOmyHuqmyrX+S1f537HBdUuLO6YuAzWiTk+YxFGU5HIJSDIRWonv
         I02QK/siNga4qJn4SyUAtNRWePaSHYGxD0bmq3hNRZvbzq+yI8VEfkKbKsqbp3Uv9gSR
         wZfR0ecnIlxDnzKk/wxrz4Wep019KEVEQRIQw=
Received: by 10.86.98.10 with SMTP id v10mr7667599fgb.39.1214183693421;
        Sun, 22 Jun 2008 18:14:53 -0700 (PDT)
Received: from fly ( [91.33.209.241])
        by mx.google.com with ESMTPS id l19sm9824784fgb.7.2008.06.22.18.14.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Jun 2008 18:14:52 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KAadt-0002IR-1u; Mon, 23 Jun 2008 03:14:49 +0200
X-Mailer: git-send-email 1.5.6.86.g5139f.dirty
In-Reply-To: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85823>

This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
also uses HTML::Lint, XML::Parser, and Archive::Tar (if present, each)
to validate the HTML/XML/tgz output, and checks all links on the
tested pages if --long-tests is given.

Also add a GITPERL environment variable that allows running Perl-based
tests with different perl binaries (and thus under different
versions).

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changed since v5: honor $ENV{GITPERL} for gitweb.cgi execution, not
just test execution:

    diff --git a/t/t9503/test.pl b/t/t9503/test.pl
    index 28894c5..947e2e8 100755
    --- a/t/t9503/test.pl
    +++ b/t/t9503/test.pl
    @@ -54,5 +54,5 @@ my $gitweb = abs_path(File::Spec->catfile('..', '..', 'gitweb', 'gitweb.cgi'));
     my $cgi = sub {
            # Use exec, not the shell, to support blanks in the path.
    -	my $status = system $gitweb $gitweb;
    +	my $status = system { $ENV{GITPERL} } $ENV{GITPERL}, $gitweb;
            my $value  = $status >> 8;


 t/t9503-gitweb-Mechanize.sh |  132 ++++++++++++++++
 t/t9503/test.pl             |  354 +++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh               |    2 +
 3 files changed, 488 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503-gitweb-Mechanize.sh
 create mode 100755 t/t9503/test.pl

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
new file mode 100755
index 0000000..3fe6d8b
--- /dev/null
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jakub Narebski
+# Copyright (c) 2008 Lea Wiemann
+#
+
+# This test supports the --long-tests option.
+
+# This test only runs on Perl 5.8 and later versions, since
+# Test::WWW::Mechanize::CGI requires Perl 5.8.
+
+test_description='gitweb tests (using WWW::Mechanize)
+
+This test uses Test::WWW::Mechanize::CGI to test gitweb.'
+
+# helper functions
+
+safe_chmod () {
+	chmod "$1" "$2" &&
+	if [ "$(git config --get core.filemode)" = false ]
+	then
+		git update-index --chmod="$1" "$2"
+	fi
+}
+
+. ./test-lib.sh
+
+# check if test can be run
+"$GITPERL" -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, perl version is too old' :
+	test_done
+	exit
+}
+
+"$GITPERL" -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, Test::WWW::Mechanize::CGI not found' :
+	test_done
+	exit
+}
+
+# set up test repository
+test_expect_success 'set up test repository' '
+
+	echo "Not an empty file." > file &&
+	git add file &&
+	test_tick && git commit -a -m "Initial commit." &&
+	git branch b &&
+
+	echo "New file" > new_file &&
+	git add new_file &&
+	test_tick && git commit -a -m "File added." &&
+
+	safe_chmod +x new_file &&
+	test_tick && git commit -a -m "Mode changed." &&
+
+	git mv new_file renamed_file &&
+	test_tick && git commit -a -m "File renamed." &&
+
+	rm renamed_file &&
+	ln -s file renamed_file &&
+	test_tick && git commit -a -m "File to symlink." &&
+	git tag with-symlink &&
+
+	git rm renamed_file &&
+	rm -f renamed_file &&
+	test_tick && git commit -a -m "File removed." &&
+
+	cp file file2 &&
+	git add file2 &&
+	test_tick && git commit -a -m "File copied." &&
+
+	echo "New line" >> file2 &&
+	safe_chmod +x file2 &&
+	test_tick && git commit -a -m "Mode change and modification." &&
+
+	git checkout b &&
+	echo "Branch" >> b &&
+	git add b &&
+	test_tick && git commit -a -m "On branch" &&
+	git checkout master &&
+	test_tick && git pull . b
+'
+
+# set up empty repository
+# TODO!
+
+# set up repositories for gitweb
+# TODO!
+
+# set up gitweb configuration
+safe_pwd="$("$GITPERL" -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
+cat >gitweb_config.perl <<EOF
+# gitweb configuration for tests
+
+our \$version = "current";
+our \$GIT = "$GIT_EXEC_PATH/git";
+our \$projectroot = "$safe_pwd";
+our \$project_maxdepth = 8;
+our \$home_link_str = "projects";
+our \$site_name = "[localhost]";
+our \$site_header = "";
+our \$site_footer = "";
+our \$home_text = "indextext.html";
+our @stylesheets = ("file:///$safe_pwd/../../gitweb/gitweb.css");
+our \$logo = "file:///$safe_pwd/../../gitweb/git-logo.png";
+our \$favicon = "file:///$safe_pwd/../../gitweb/git-favicon.png";
+our \$projects_list = "";
+our \$export_ok = "";
+our \$strict_export = "";
+our %feature;
+\$feature{'blame'}{'default'} = [1];
+
+1;
+__END__
+EOF
+
+cat >.git/description <<EOF
+$0 test repository
+EOF
+
+GITWEB_CONFIG="$(pwd)/gitweb_config.perl"
+export GITWEB_CONFIG
+
+# run tests
+
+test_external \
+	'test gitweb output' \
+	"$GITPERL" ../t9503/test.pl
+
+test_done
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
new file mode 100755
index 0000000..947e2e8
--- /dev/null
+++ b/t/t9503/test.pl
@@ -0,0 +1,354 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+# This test supports the --long-tests option.
+
+use warnings;
+use strict;
+
+use Cwd qw(abs_path);
+use File::Spec;
+use File::Temp;
+
+# We don't count properly when skipping, so no_plan is necessary.
+use Test::More qw(no_plan);
+use Test::WWW::Mechanize::CGI;
+
+our $long_tests = $ENV{GIT_TEST_LONG};
+
+eval { require Archive::Tar; };
+my $archive_tar_installed = !$@
+    or diag('Archive::Tar is not installed; no tests for valid snapshots');
+
+eval { require HTML::Lint; };
+my $html_lint_installed = !$@
+    or diag('HTML::Lint is not installed; no HTML validation tests');
+
+eval { require XML::Parser; };
+my $xml_parser_installed = !$@
+    or diag('XML::Parser is not installed; no tests for well-formed XML');
+
+my @revisions = split /\s/, `git-rev-list --first-parent HEAD`;
+chomp(my @heads = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/heads`);
+chomp(my @tags = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/tags`);
+# files and directories in HEAD root:
+chomp(my @files = map { (split("\t", $_))[1] } `git-ls-tree HEAD`);
+
+sub rev_parse {
+	my $name = shift;
+	chomp(my $hash = `git rev-parse $name 2> /dev/null`);
+	$hash or undef;
+}
+
+sub get_type {
+	my $name = shift;
+	chomp(my $type = `git cat-file -t $name 2> /dev/null`);
+	$type or undef;
+}
+
+my $gitweb = abs_path(File::Spec->catfile('..', '..', 'gitweb', 'gitweb.cgi'));
+
+# Thus subroutine was copied (and modified to work with blanks in the
+# application path) from WWW::Mechanize::CGI 0.3, which is licensed
+# 'under the same terms as perl itself' and thus GPL compatible.
+my $cgi = sub {
+	# Use exec, not the shell, to support blanks in the path.
+	my $status = system { $ENV{GITPERL} } $ENV{GITPERL}, $gitweb;
+	my $value  = $status >> 8;
+
+	croak( qq/Failed to execute application '$gitweb'. Reason: '$!'/ )
+	    if ( $status == -1 );
+	croak( qq/Application '$gitweb' exited with value: $value/ )
+	    if ( $value > 0 );
+};
+
+my $mech = new Test::WWW::Mechanize::CGI;
+$mech->cgi($cgi);
+# On some systems(?) it's necessary to have %ENV here, otherwise the
+# CGI process won't get *any* of the current environment variables
+# (not even PATH, etc.)
+$mech->env(%ENV,
+	   GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'},
+	   SCRIPT_FILENAME => $gitweb,
+	   $mech->env);
+
+# import config, predeclaring config variables
+our $site_name;
+require_ok($ENV{'GITWEB_CONFIG'})
+	or diag('Could not load gitweb config; some tests would fail');
+
+# Perform non-recursive checks on the current page, but do not check
+# the status code.
+my %verified_uris;
+sub _verify_page {
+	my ($uri, $fragment) = split '#', $mech->uri;
+	if (!$verified_uris{$uri}) {
+		$verified_uris{$uri} = 1;
+
+		# Internal errors yield 200, but cause gitweb.cgi to
+		# exit with non-zero exit code, which Mechanize::CGI
+		# translates to 500, so we don't really need to check
+		# for "Software error" here, provided that the test
+		# cases always check the status code.
+		#$mech->content_lacks('<h1>Software error:</h1>') or return 0;
+
+		# Validating is fast, so we can do it even without
+		# $long_tests.
+		$mech->html_lint_ok('[auto] validate HTML') or return 0
+		    if $html_lint_installed && $mech->is_html;
+		my $content_type = $mech->response->header('Content-Type')
+		    or die "$uri does not have a Content-Type header";
+		if ($xml_parser_installed && $content_type =~ /xml/) {
+			eval { XML::Parser->new->parse($mech->content); };
+			ok(!$@, "[auto] check for XML well-formedness ($uri)") or diag($@);
+		}
+		if ($archive_tar_installed && $uri =~ /sf=tgz/) {
+			my $snapshot_file = File::Temp->new;
+			print $snapshot_file $mech->content;
+			close $snapshot_file;
+			my $t = Archive::Tar->new;
+			$t->read($snapshot_file->filename, 1);
+			ok($t->get_files, "[auto] valid tgz snapshot ($uri)");
+		}
+		# WebService::Validator::Feed::W3C would be nice to
+		# use, but it doesn't support direct input (as opposed
+		# to URIs) long enough for our feeds.
+	}
+	$mech->content_like(qr/(name|id)="$fragment"/,
+			    "[auto] fragment #$fragment exists ($uri)")
+	    if $fragment;
+	return 1;
+}
+
+# Verify and spider the current page, the latter only if --long-tests
+# (-l) is given.  Do not check the status code of the current page.
+my %spidered_uris;  # pages whose links have been checked
+my %status_checked_uris;  # verified pages whose status is known to be 2xx
+sub check_page {
+	_verify_page or return 0;
+	my $orig_url = $mech->uri;
+	if ($long_tests && !$spidered_uris{$mech->uri} ) {
+		$spidered_uris{$mech->uri} = 1;
+		for my $url (map { $_->url_abs } $mech->followable_links) {
+			if (!$status_checked_uris{$url}) {
+				$status_checked_uris{$url} = 1;
+				$mech->get_ok($url, "[auto] check link ($url)")
+				    or diag("broken link to $url on $orig_url");
+				_verify_page;
+				$mech->back;
+			}
+		}
+	}
+	return 1
+}
+
+my $baseurl = "http://localhost";
+my ($params, $url, $pagedesc, $status);
+
+# test_page ( <params>, <page_description>, <expected_status> )
+# Example:
+# if (test_page('?p=.git;a=summary', 'repository summary')) {
+#     $mech->...;
+#     $mech->...;
+# }
+#
+# Test that the page can be opened, call _verify_page on it, and
+# return true if there was no test failure.  Also set the global
+# variables $params, $pagedesc, and $url for use in the if block.
+# Optionally pass a third parameter $status to test the HTTP status
+# code of the page (useful for error pages).  You can also pass a full
+# URL instead of just parameters as the first parameter.
+sub test_page {
+	($params, $pagedesc, $status) = @_;
+	$pagedesc = $pagedesc ? " -- $pagedesc" : '';
+	if($params =~ /^$baseurl/) {
+		$url = "$params";
+	} else {
+		$url = "$baseurl$params";
+	}
+	if ($status) {
+		$mech->get($url);
+	} else {
+		$mech->get_ok($url, "get $url$pagedesc") or return 0;
+	}
+	check_page or return 0;
+	if ($status) {
+		return is($mech->status, $status, "getting $url$pagedesc -- yields $status");
+	} else {
+		return 1;
+	}
+}
+
+# follow_link ( \%parms, $pagedesc )
+# Example: follow_link( { text => 'commit' }, 'first commit link')
+# Like test_page, but does not support status code testing.
+sub follow_link {
+	(my $parms, $pagedesc) = @_;
+	$mech->follow_link_ok($parms, "follow link: $pagedesc") or return 0;
+	$url = $mech->uri;
+	return check_page;
+}
+
+if (test_page '', 'project list (implicit)') {
+	$mech->title_like(qr!$site_name!,
+		"title contains $site_name");
+	$mech->content_contains('./t9503-gitweb-Mechanize.sh test repository', 
+		'lists test repository (by description)');
+}
+
+# Test repository summary: implicit, implicit with pathinfo, explicit.
+for my $sumparams ('?p=.git', '/.git', '?p=.git;a=summary') {
+	if (test_page $sumparams, 'repository summary') {
+		$mech->title_like(qr!$site_name.*\.git/summary!,
+				  "title contains $site_name and \".git/summary\"");
+	}
+}
+
+# Search form (on summary page).
+$mech->get_ok('?p=.git', 'get repository summary');
+if ($mech->submit_form_ok( { form_number => 1,
+			     fields => { 's' => 'Initial' }
+			   }, "submit search form (default)")) {
+	check_page;
+	$mech->content_contains('Initial commit',
+				'content contains searched commit');
+}
+
+test_page('?p=non-existent.git', 'non-existent project', 404);
+test_page('?p=.git;a=commit;h=non-existent', 'non-existent commit', 404);
+
+
+# Summary view
+
+# Check short log.  To do: Extract into separate test_short_log
+# function since the short log occurs on several pages.
+$mech->get_ok('?p=.git', 'get repository summary');
+for my $revision (@revisions[0..2]) {
+	for my $link_text qw( commit commitdiff tree snapshot ) {
+		ok($mech->find_link(url_abs_regex => qr/h=$revision/, text => $link_text), "$link_text link for $revision");
+	}
+}
+# Check that branches and tags are highlighted in green and yellow in
+# the shortlog.  We assume here that we are on master, so it should be
+# at the top.
+$mech->content_like(qr{<span [^>]*class="head"[^>]*>master</span>},
+		    'master branch is highlighted in shortlog');
+$mech->content_like(qr{<span [^>]*class="tag"[^>]*>$tags[0]</span>},
+		    "$tags[0] (most recent tag) is highlighted in shortlog");
+
+# Check heads.  (This should be extracted as well.)
+for my $head (@heads) {
+	for my $link_text qw( shortlog log tree ) {
+		ok($mech->find_link(url_abs_regex => qr{h=refs/heads/$head}, text => $link_text), "$link_text link for head '$head'");
+	}
+}
+
+# Check tags (assume we only have tags referring to commits).
+for my $tag (@tags) {
+	my $commit = rev_parse("$tag^{commit}");
+	ok($mech->find_link(url_abs_regex => qr{h=refs/tags/$tag}, text => 'shortlog'),
+	   "shortlog link for tag '$tag'");
+	ok($mech->find_link(url_abs_regex => qr{h=refs/tags/$tag}, text => 'log'),
+	   "log link for tag '$tag'");
+	ok($mech->find_link(url_abs_regex => qr{h=$commit}, text => 'commit'),
+	   "commit link for tag '$tag'");
+	# To do: Test tag link for tag objects.
+	# Why don't we have tree + snapshot links?
+}
+
+
+# RSS/Atom/OPML view.  Simply retrieve and check.
+{
+	# Broken link in Atom/RSS view -- cannot spider:
+	# http://mid.gmane.org/485EB333.5070108@gmail.com
+	local $long_tests = 0;
+	test_page('?p=.git;a=atom', 'Atom feed');
+	test_page('?p=.git;a=rss', 'RSS feed');
+}
+test_page('?a=opml', 'OPML outline');
+
+
+# Commit view
+if (test_page('?p=.git;a=commit;h=master')) {
+	ok($mech->find_link(url_abs_regex => qr/a=tree/),
+	   "tree link on commit page ($url)");
+	$mech->content_like(qr/A U Thor/, "author mentioned on commit page ($url)");
+}
+
+
+# Commitdiff view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text_regex => qr/file added/i }, 'commit with added file') &&
+    follow_link( { text => 'commitdiff' }, 'commitdiff')) {
+	$mech->content_like(qr/new file with mode/, "commitdiff has diffstat ($url)");
+	$mech->content_like(qr/new file mode/, "commitdiff has diff ($url)");
+}
+
+
+# Tree view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'follow first tree link on page')) {
+	for my $file (@files) {
+		my $file_hash = rev_parse("HEAD:$file");
+		ok($mech->find_link(text => $file), "'$file' listed (and linked) in tree view ($url)");
+		if (get_type("HEAD:$file") eq 'blob') {
+			for my $link_text qw( blob blame history raw ) {
+				my $link = $mech->find_link(url_abs_regex => qr/[^a-z]f=$file(;|$)/,
+							    text => $link_text);
+				ok($link, "'$file' file has $link_text link in tree view ($url)");
+			}
+		} else {
+			# Subtree -- to do: write tests.  (Need to set
+			# up a subtree in t9503-gitweb-Mechanize.sh.)
+		}
+	}
+}
+
+
+# Blame view
+{
+	# Broken link in blame view -- cannot spider:
+	# http://mid.gmane.org/485EC621.7090101@gmail.com
+	local $long_tests = 0;
+	if ($mech->get_ok('?p=.git', 'get repository summary') &&
+	    follow_link( { text => 'tree' }, 'follow first tree link on page')) {
+		for my $blame_link ($mech->find_all_links(text => 'blame')) {
+			test_page($blame_link->url, "follow blame link from tree view");
+			$mech->content_like(qr/A U Thor/,
+					    "author mentioned on blame page");
+		}
+	}
+}
+
+
+# History view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'follow first tree link on page')) {
+	for my $history_link ($mech->find_all_links(text => 'history')) {
+		test_page($history_link->url, "follow history link from tree view");
+		# To do: Expand.
+	}
+}
+
+
+# Blob view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'follow first tree link on page')) {
+	for my $blob_link ($mech->find_all_links(text => 'blob')) {
+		test_page($blob_link->url, "follow blob link from tree view");
+		# To do: Expand beyond standard tests.
+	}
+}
+
+
+# Raw view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'follow first tree link on page')) {
+	for my $raw_link ($mech->find_all_links(text => 'raw')) {
+		test_page($raw_link->url, "follow raw link from tree view");
+	}
+}
+
+
+1;
+__END__
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a9fc621..504c0bb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -472,6 +472,8 @@ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOB
 
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
+GITPERL=${GITPERL:-perl}
+export GITPERL
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
-- 
1.5.6.86.g5139f.dirty
