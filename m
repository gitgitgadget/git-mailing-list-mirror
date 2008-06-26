From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Thu, 26 Jun 2008 15:47:51 +0200
Message-ID: <1214488071-6721-1-git-send-email-LeWiemann@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 15:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBrqP-0007Sy-9m
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 15:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYFZNsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 09:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYFZNsA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 09:48:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55584 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYFZNr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 09:47:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so17286fgg.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=PjMZbSBrUdnF0xPOuNF9ZxK57WTnAFVL3kF1qx2LysA=;
        b=p95AyXCSZZPdJzzQKMYIqZJwToPtNWilBBlkU5XDjaNNxakd1b6X7CL+bO+scBOsOt
         zma+jsJKsxOdkruPPI6JRzd8q67whHMl0juBlzFHrQl04S1nkiuv+VcsCt1n0ITWgZhT
         fX7UjCIai8/ap1nHXvr52Q8QnRnL9d7v1HLGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=BgJT4qmxtbWXWb3l+pWk2wElkDdUYgb8+tvFuaJjOIVSBVXKPLMnhFcL02oJkyhOiO
         mTM4CjOkMGV0WP27Q6LWFp+64yuwGv6PsglWJzPFyStBsh12fIMnm/2IMUyytayC3lwE
         Ire6QsAFguwEXfQJpimtWth0HdHantKL8lhcw=
Received: by 10.86.68.20 with SMTP id q20mr183299fga.2.1214488074952;
        Thu, 26 Jun 2008 06:47:54 -0700 (PDT)
Received: from fly ( [91.33.220.151])
        by mx.google.com with ESMTPS id 12sm218344fgg.0.2008.06.26.06.47.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 06:47:54 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KBrpH-0001kt-Vu; Thu, 26 Jun 2008 15:47:52 +0200
X-Mailer: git-send-email 1.5.6.109.g33ded.dirty
In-Reply-To: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86452>

This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
also uses HTML::Lint, XML::Parser, and Archive::Tar (if present, each)
to validate the HTML/XML/tgz output, and checks all links on the
tested pages if --long-tests is given.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
This patch applies on next.

Changes since v7:

- In Makefile, dump $PERL_PATH to GIT-BUILD-OPTIONS (which gets
  source'd by test-lib.sh), and use it in t9710-perl-git-repo.sh.

- .git/description in the test repository no longer depends on $0
  (this would e.g. cause 'cd t; make' to fail).

- Add test_link subroutine and use it everywhere in place of
  ok(find_link...) so that links whose presence get tested get checked
  and spidered in --long-tests mode.

- Add simple page caching (reduces execution time without --long-tests
  by 25%).  That's *really* helpful when you have to run those tests
  on a regular basis. ;)  (WWW::Mechanize::Cached won't work with
  TWM::CGI, so we have to implement it ourselves; but it's easier
  anyway.)

- Follow redirects rather than failing.

- Test subdirectories in tree view.

- Test error handling for non-existent hashes or hashes of wrong type.

- Test commitdiff_plain view.

- Expand test for history view.

- Test tag objects (not just symbolic tags) in tag list.

- Test a specific bug (under "diff formatting", marked TODO).

- Do not test correctness of line number fragments (#l[0-9]+); they're
  broken too often right now.

- Probably some more minor improvements I've forgotten about. :)

 Makefile                    |    1 +
 t/t9503-gitweb-Mechanize.sh |  138 +++++++++++
 t/t9503/test.pl             |  553 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 692 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503-gitweb-Mechanize.sh
 create mode 100755 t/t9503/test.pl

diff --git a/Makefile b/Makefile
index a129491..3bf4f14 100644
--- a/Makefile
+++ b/Makefile
@@ -1251,6 +1251,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
+	@echo PERL_PATH=\''$(PERL_PATH_SQ)'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
new file mode 100755
index 0000000..4585cea
--- /dev/null
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -0,0 +1,138 @@
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
+"$PERL_PATH" -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, perl version is too old' :
+	test_done
+	exit
+}
+
+"$PERL_PATH" -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
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
+	mkdir dir1 &&
+	echo "New file" >> dir1/file1 &&
+	git add dir1/file1 &&
+	test_tick && git commit -a -m "File added in subdirectory." &&
+	git tag -m "creating a tag object" tag-object
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
+safe_pwd="$("$PERL_PATH" -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
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
+gitweb test repository
+EOF
+
+GITWEB_CONFIG="$(pwd)/gitweb_config.perl"
+export GITWEB_CONFIG
+
+# run tests
+
+test_external \
+	'test gitweb output' \
+	"$PERL_PATH" ../t9503/test.pl
+
+test_done
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
new file mode 100755
index 0000000..43ad062
--- /dev/null
+++ b/t/t9503/test.pl
@@ -0,0 +1,553 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+# This test supports the --long-tests option.
+
+use warnings;
+use strict;
+
+use Cwd qw( abs_path );
+use File::Spec;
+use File::Temp;
+use Storable;
+
+use Test::More qw(no_plan);
+
+die "this must be run by calling the t/t*.sh shell script(s)\n"
+    if Cwd->cwd !~ /trash directory$/;
+
+our $long_tests = $ENV{GIT_TEST_LONG}; # "our" so we can use "local $long_tests"
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
+
+package OurMechanize;
+
+use base qw( Test::WWW::Mechanize::CGI );
+
+my %page_cache;
+# Cache requests.
+sub _make_request {
+	my ($self, $request) = (shift, shift);
+
+	my $response;
+	unless ($response = Storable::thaw($page_cache{$request->uri})) {
+		$response = $self->SUPER::_make_request($request, @_);
+		$page_cache{$request->uri} = Storable::freeze($response);
+	}
+	return $response;
+}
+
+# Fix whitespace problem.
+sub cgi_application {
+	my ($self, $application) = @_;
+
+	# This subroutine was copied (and modified) from
+	# WWW::Mechanize::CGI 0.3, which is licensed 'under the same
+	# terms as perl itself' and thus GPL compatible.
+	my $cgi = sub {
+		# Use exec, not the shell, to support embedded
+		# whitespace in the path to $application.
+		# http://rt.cpan.org/Ticket/Display.html?id=36654
+		my $status = system $application $application;
+		my $value  = $status >> 8;
+
+		croak( qq/Failed to execute application '$application'. Reason: '$!'/ )
+		    if ( $status == -1 );
+		croak( qq/Application '$application' exited with value: $value/ )
+		    if ( $value > 0 );
+	};
+
+	$self->cgi($cgi);
+}
+
+package main;
+
+
+my @revisions = split /\s/, `git-rev-list --first-parent HEAD`;
+chomp(my @heads = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/heads`);
+chomp(my @tags = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/tags`);
+my @tag_objects = grep { get_type($_) eq 'tag' } @tags;
+chomp(my @root_entries = `git-ls-tree --name-only HEAD`);
+my @files = grep { get_type("HEAD:$_") eq 'blob' } @root_entries or die;
+my @directories = grep { get_type("HEAD:$_") eq 'tree' } @root_entries or die;
+# Only test one file and directory each.
+@files = $files[0] unless $long_tests;
+@directories = $directories[0] unless $long_tests;
+
+my $gitweb = abs_path(File::Spec->catfile('..', '..', 'gitweb', 'gitweb.cgi'));
+
+my $mech = OurMechanize->new;
+$mech->cgi_application($gitweb);
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
+	TODO: {
+		local $TODO = 'line number fragments can be broken for diffs and blames'
+		    if $fragment && $fragment =~ /^l[0-9]+$/;
+		$mech->content_like(qr/(name|id)="$fragment"/,
+				    "[auto] fragment #$fragment exists ($uri)")
+		    if $fragment;
+	}
+
+	return 1 if $verified_uris{$uri};
+	$verified_uris{$uri} = 1;
+
+	# Internal errors yield 200 but cause gitweb.cgi to exit with
+	# non-zero exit code, which Mechanize::CGI translates to 500,
+	# so we don't really need to check for "Software error" here,
+	# provided that the test cases always check the status code.
+	#$mech->content_lacks('<h1>Software error:</h1>') or return 0;
+
+	# Validate.  This is fast, so we can do it even without
+	# $long_tests.
+	$mech->html_lint_ok('[auto] validate HTML') or return 0
+	    if $html_lint_installed && $mech->is_html;
+	my $content_type = $mech->response->header('Content-Type')
+	    or die "$uri does not have a Content-Type header";
+	if ($xml_parser_installed && $content_type =~ /xml/) {
+		eval { XML::Parser->new->parse($mech->content); };
+		ok(!$@, "[auto] check for XML well-formedness ($uri)") or diag($@);
+	}
+	if ($archive_tar_installed && $uri =~ /sf=tgz/) {
+		my $snapshot_file = File::Temp->new;
+		print $snapshot_file $mech->content;
+		close $snapshot_file;
+		my $t = Archive::Tar->new;
+		$t->read($snapshot_file->filename, 1);
+		ok($t->get_files, "[auto] valid tgz snapshot ($uri)");
+	}
+	# WebService::Validator::Feed::W3C would be nice to
+	# use, but it doesn't support direct input (as opposed
+	# to URIs) long enough for our feeds.
+
+	return 1;
+}
+
+# Verify and spider the current page, the latter only if --long-tests
+# (-l) is given.  Do not check the status code of the current page.
+my %spidered_uris;  # pages whose links have been checked
+my %status_checked_uris;  # verified pages whose status is known to be 2xx
+sub check_page {
+	_verify_page or return 0;
+	if ($long_tests && !$spidered_uris{$mech->uri} ) {
+		$spidered_uris{$mech->uri} = 1;
+		my $orig_url = $mech->uri;
+		TODO: {
+			local $TODO = "blame links can be broken sometimes"
+			    if $orig_url =~ /a=blame/;
+			for my $url (map { $_->url_abs } $mech->followable_links) {
+				if (!$status_checked_uris{$url}) {
+					$status_checked_uris{$url} = 1;
+					local $long_tests = 0;  # stop recursing
+					test_page($url, "[auto] check link ($url)")
+					    or diag("broken link to $url on $orig_url");
+					$mech->back;
+				}
+			}
+		}
+	}
+	return 1;
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
+	# missing $pagedesc is usually accidental
+	die "$params: no pagedesc given" unless defined $pagedesc;
+	if($params =~ /^$baseurl/) {
+		$url = "$params";
+	} else {
+		$url = "$baseurl$params";
+	}
+	$mech->get($url);
+	like($mech->status, $status ? qr/$status/ : qr/^[23][0-9][0-9]$/,
+	     "$pagedesc: $url" . ($status ? " -- yields $status" : ""))
+	    or return 0;
+	if ($mech->status =~ /^3/) {
+		# Don't check 3xx, they tend to look funny.
+		my $location = $mech->response->header('Location');
+		$mech->back;  # compensate for history
+		return test_page($location, "follow redirect from $url");
+	} else {
+		return check_page;
+	}
+}
+
+# follow_link ( \%parms, $pagedesc )
+# Example:
+# if (follow_link( { text => 'commit' }, 'first commit link')) {
+#     $mech->...;
+#     $mech->back;
+# }
+# Like test_page, but does not support status code testing, and
+# returns true if there was a link at all, regardless of whether it
+# was [23]xx or not.
+sub follow_link {
+	(my $parms, $pagedesc) = @_;
+	my $link = $mech->find_link(%$parms);
+	my $current_url = $mech->uri;
+	ok($link, "link exists: $pagedesc (on page $current_url)") or return 0;
+	test_page($link->url, "follow link: $pagedesc (on page $current_url)");
+	return 1;
+}
+
+# like follow_link, except that only checks and goes back immediately;
+# use this instead of ok(find_link...).
+sub test_link {
+	my ($parms, $pagedesc) = @_;
+	my $current_url = $mech->uri;
+	if($long_tests) {
+		# Check status, validate, spider.
+		return follow_link($parms, $pagedesc) && $mech->back;
+	} else {
+		# Only check presence of the link (much faster).
+		return ok($mech->find_link(%$parms),
+			  "link exists: $pagedesc (on page $current_url)");
+	}
+}
+
+sub get_summary {
+	test_page('?p=.git', 'repository summary')
+}
+
+if (test_page '', 'project list (implicit)') {
+	$mech->title_like(qr!$site_name!,
+		"title contains $site_name");
+	$mech->content_contains('gitweb test repository',
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
+if (get_summary && $mech->submit_form_ok(
+	    { form_number => 1, fields => { 's' => 'Initial' } },
+	    'submit search form (default)')) {
+	check_page;
+	$mech->content_contains('Initial commit',
+				'content contains commit we searched for');
+}
+
+test_page('?p=non-existent.git', 'non-existent project', 404);
+test_page('?p=.git;a=commit;h=non-existent', 'non-existent commit', 404);
+
+
+# Summary view
+
+get_summary or die 'summary page failed; no point in running the remaining tests';
+
+# Check short log.  To do: Extract into separate test_short_log
+# function since the short log occurs on several pages.
+for my $revision (@revisions) {
+	for my $link_text qw( commit commitdiff tree snapshot ) {
+		test_link( { url_abs_regex => qr/h=$revision/, text => $link_text },
+			   "$link_text link for $revision");
+	}
+}
+
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
+		test_link( { url_abs_regex => qr{h=refs/heads/$head}, text => $link_text },
+			   "$link_text link for head '$head'");
+	}
+}
+
+# Check tags (assume we only have tags referring to commits, not to
+# blobs or trees).
+for my $tag (@tags) {
+	my $commit = rev_parse("$tag^{commit}");
+	test_link( { url_abs_regex => qr{h=refs/tags/$tag}, text => 'shortlog' },
+		   "shortlog link for tag '$tag'");
+	test_link( { url_abs_regex => qr{h=refs/tags/$tag}, text => 'log' },
+		   "log link for tag '$tag'");
+	test_link( { url_abs_regex => qr{h=$commit}, text => 'commit' },
+		   "commit link for tag '$tag'");
+	test_link( { url_abs_regex => qr{h=$commit}, text => $tag },
+	   "'$tag' links to the commit as well");
+	# To do: Test tag link for tag objects.
+	# Why don't we have tree + snapshot links?
+}
+for my $tag (@tag_objects) {
+	my $tag_sha1 = rev_parse($tag);
+	test_link( { url_abs_regex => qr{h=$tag_sha1}, text => 'tag' },
+		   "tag link for tag object '$tag'" );
+}
+
+
+# RSS/Atom/OPML view
+# Simply retrieve and verify well-formedness, but don't spider.
+$mech->get_ok('?p=.git;a=atom', 'Atom feed') and _verify_page;
+$mech->get_ok('?p=.git;a=rss', 'RSS feed') and _verify_page;
+TODO: {
+	# Now spider -- but there are broken links.
+	# http://mid.gmane.org/485EB333.5070108@gmail.com
+	local $TODO = "fix broken links in Atom/RSS feeds";
+	test_page('?p=.git;a=atom', 'Atom feed');
+	test_page('?p=.git;a=rss', 'RSS feed');
+}
+test_page('?a=opml', 'OPML outline');
+
+
+# Commit view
+if (test_page('?p=.git;a=commit;h=master', 'view HEAD commit')) {
+	my $tree_sha1 = rev_parse('master:');
+	test_link( { url_abs_regex => qr/a=tree/, text => rev_parse('master:') },
+		   "SHA1 link to tree on commit page ($url)");
+	test_link( { url_abs_regex => qr/h=$tree_sha1/, text => 'tree' },
+		   "'tree' link to tree on commit page ($url)");
+	$mech->content_like(qr/A U Thor/, "author mentioned on commit page ($url)");
+}
+
+
+# Commitdiff view
+if (get_summary &&
+    follow_link( { text_regex => qr/file added/i }, 'commit with added file') &&
+    follow_link( { text => 'commitdiff' }, 'commitdiff')) {
+	$mech->content_like(qr/new file with mode/, "commitdiff has diffstat ($url)");
+	$mech->content_like(qr/new file mode/, "commitdiff has diff ($url)");
+}
+test_page("?p=.git;a=commitdiff;h=$revisions[-1]",
+	  'commitdiff without parent');
+
+# Diff formattting problem.
+if (get_summary &&
+    follow_link( { text_regex => qr/renamed/ }, 'commit with rename') &&
+    follow_link( { text => 'commitdiff' }, 'commitdiff')) {
+	TODO: {
+		local $TODO = "bad a/* link in diff";
+		if (follow_link( { text_regex => qr!^a/! },
+				 'a/* link (probably wrong)')) {
+			# The page we land on here is broken already.
+			follow_link( { url_abs_regex => qr/a=blob_plain/ },
+				     'linked file name');  # bang
+		}
+	}
+}
+
+
+# Raw commitdiff (commitdiff_plain) view
+if (test_page('?p=.git;a=commit;h=refs/tags/tag-object',
+	      'commit view of tags/tag-object') &&
+    follow_link( { text => 'commitdiff' }, "'commitdiff'") &&
+    follow_link( { text => 'raw' }, "'raw' (commitdiff_plain)")) {
+	$mech->content_like(qr/^From: A U Thor <author\@example.com>$/m,
+			    'commitdiff_plain: From header');
+	TODO: {
+		local $TODO = 'date header mangles timezone';
+		$mech->content_like(qr/^Date: Thu, 7 Apr 2005 15:..:13 -0700$/m,
+				    'commitdiff_plain: Date header (correct)');
+	}
+	$mech->content_like(qr/^Date: Thu, 7 Apr 2005 22:..:13 \+0000 \(-0700\)$/m,
+			    'commitdiff_plain: Date header (UTC, wrong)');
+	$mech->content_like(qr/^Subject: .+$/m,
+			    'commitdiff_plain: Subject header');
+	# $ markers inexplicably don't work here if we use like(...)
+	# or $mech->content_like().
+	ok($mech->content =~ /^X-Git-Tag: tag-object\^0$/m,
+	   'commitdiff_plain: X-Git-Tag header');
+	ok($mech->content =~ /^X-Git-Url: $baseurl\?p=\.git;a=commitdiff_plain;h=refs%2Ftags%2Ftag-object$/m,
+	   'commitdiff_plain: X-Git-Url header');
+	ok($mech->content =~ /^---$/m, 'commitdiff_plain: separator$');
+	$mech->content_like(qr/^diff --git /m, 'commitdiff_plain: diff$');
+}
+
+
+# Tree view
+if (get_summary && follow_link( { text => 'tree' }, 'first tree link')) {
+	for my $file (@files) {
+		my $sha1 = rev_parse("HEAD:$file");
+		test_link( { text => $file, url_abs_regex => qr/h=$sha1/ },
+			   "'$file' is listed and linked");
+		test_link({ url_abs_regex => qr/f=$file/, text => $_ },
+			  "'$_' link") foreach qw( blame blob history raw );
+	}
+	for my $directory (@directories) {
+		my $sha1 = rev_parse("HEAD:$directory");
+		test_link({ url_abs_regex => qr/f=$directory/, text => $_ },
+			  "'$_' link") foreach qw( tree history );
+		if(follow_link( { text => $directory, url_abs_regex => qr/h=$sha1/ },
+				"'$directory is listed and linked" )) {
+			if(follow_link( { text => '..' }, 'parent directory')) {
+				test_link({ url_abs_regex => qr/h=$sha1/,
+					    text => $directory },
+					  'back to original tree view');
+				$mech->back;
+			}
+			$mech->back;
+		}
+	}
+}
+
+
+# Blame view
+if (get_summary && follow_link( { text => 'tree' }, 'first tree link')) {
+	for my $blame_link ($mech->find_all_links(text => 'blame')) {
+		my $url = $blame_link->url;
+		$mech->get_ok($url, "get $url -- blame link on tree view")
+		    and _verify_page;
+		$mech->content_like(qr/A U Thor/,
+				    "author mentioned on blame page");
+		TODO: {
+			# Now spider -- but there are broken links.
+			# http://mid.gmane.org/485EC621.7090101@gmail.com
+			local $TODO = "fix broken links in certain blame views";
+			check_page;
+		}
+		last unless $long_tests; # only test first blame link
+	}
+}
+
+
+# History view
+if (get_summary && follow_link( { text => 'tree' }, 'first tree link')) {
+	for my $file (@files, @directories) {
+		my $type = get_type("HEAD:$file");  # blob or tree
+		if (follow_link( { text => 'history', url_abs_regex => qr/f=$file/ },
+				 "history link for '$file'")) {
+			# There is at least one commit, so A U Thor is mentioned.
+			$mech->content_contains('A U Thor', 'A U Thor mentioned');
+			# The following tests test for at least *one*
+			# link of each type and are weak since we
+			# don't have any knowledge of commit hashes.
+			test_link( { text => $type, url_abs_regex => qr/f=$file/ },
+				   "$type");
+			test_link( { text => 'commitdiff' },
+				   "commitdiff");
+			test_link( { url_abs_regex => qr/a=commit;.*h=[a-f0-9]{40}/ },
+				   "subject links to commit"); # weak, brittle
+			$mech->back;
+		}
+	}
+}
+
+
+# Blob view
+if (get_summary && follow_link( { text => 'tree' }, 'first tree link')) {
+	for my $file (@files) {
+		if (follow_link( { text => $file, url_abs_regex => qr/a=blob/ },
+				 "\"$file\" (blob) entry on tree view")) {
+			chomp(my $first_line_regex = (`cat "$file"`)[0]);
+			$first_line_regex =~ s/ / |&nbsp;/g;
+			# Hope that the first line doesn't contain any
+			# HTML-escapable character.
+			$mech->content_like(qr/$first_line_regex/,
+					    "blob view contains first line of file ($url)");
+			$mech->back;
+		}
+	}
+}
+
+
+# Raw (blob_plain) view
+if (get_summary && follow_link( { text => 'tree' }, 'first tree link')) {
+	for my $file (@files) {
+		if (follow_link( { text => 'raw', url_abs_regex => qr/f=$file/ },
+				 "raw (blob_plain) entry for \"$file\" in tree view")) {
+			chomp(my $first_line = (`cat "$file"`)[0]);
+			$mech->content_contains(
+				$first_line, "blob_plain view contains first line of file");
+			$mech->back;
+		}
+	}
+}
+
+
+# Error handling
+# Pass valid and invalid paths to various file-based actions
+for my $action qw( blame blob blob_plain blame ) {
+	test_page("?p=.git;a=$action;f=$files[0];hb=HEAD",
+		  "$action: look up existent file");
+	test_page("?p=.git;a=$action;f=does_not_exist;hb=HEAD",
+		  "$action: look up non-existent file", 404);
+	TODO: {
+		local $TODO = 'wrong error code (but using Git::Repo will fix this)';
+		test_page("?p=.git;a=$action;f=$directories[0];hb=HEAD",
+			  "$action: look up directory", 400);
+	}
+}
+TODO: {
+	local $TODO = 'wrong error code (but using Git::Repo will fix this)';
+	test_page("?p=.git;a=tree;f=$files[0];hb=HEAD",
+		  'tree: look up existent file', 400);
+}
+# Pass valid and invalid paths to tree action
+test_page("?p=.git;a=tree;f=does_not_exist;hb=HEAD",
+	  'tree: look up non-existent file', 404);
+test_page("?p=.git;a=tree;f=$directories[0];hb=HEAD",
+	  'tree: look up directory');
+TODO: {
+	local $TODO = 'cannot use f=/ or f= for trees';
+	test_page("?p=.git;a=tree;f=/;hb=HEAD", 'tree: look up directory');
+}
+
+
+1;
+__END__
-- 
1.5.6.109.g33ded.dirty
