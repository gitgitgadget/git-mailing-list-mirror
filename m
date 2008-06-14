From: Lea Wiemann <lewiemann@gmail.com>
Subject: [RFC/WIP/PATCH v2] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Sun, 15 Jun 2008 01:57:24 +0200
Message-ID: <1213487844-685-1-git-send-email-LeWiemann@gmail.com>
References: <200806141447.28052.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 01:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7fdM-0006gQ-AY
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 01:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbYFNX4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbYFNX4u
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 19:56:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:51649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbYFNX4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 19:56:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3042858fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=sVcnCGjOvjfokPY/TywxjBZHrJf9HeugFxEECbOub7k=;
        b=cIzHKKO1KZynYBQBYOtbusidAgEwqDYj5VjSFYg0Px2cHS73B9/4A9D3sw1R3QB0aT
         yjUMuYujfedRUsGtFuUpt4hBerwktQBI/yfhJgT6xEPS9fFTzlmpCzi4kmP3W/astaW5
         r6qFEsGedDo9Oem0RvKzFOhE+oVQ0XeMDtz5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=gstTDZXjLdJqqYVGz7JXDKJbhnrbWg5maaH6RtqPKtxUbdoIptl3SrykGmzSmDeG0X
         Jsl1tsOR5535aBfKiOWdda+qLDTphG7jRkzQbP/MV/9n0aeg2nZ93xp4UWhnS9gAoquX
         gQKwhSM0S4ZNRuKth/XdcluePbEI3z4iZKMpc=
Received: by 10.86.28.2 with SMTP id b2mr6478430fgb.10.1213487807298;
        Sat, 14 Jun 2008 16:56:47 -0700 (PDT)
Received: from fly ( [91.33.200.93])
        by mx.google.com with ESMTPS id l12sm8565569fgb.6.2008.06.14.16.56.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 16:56:46 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K7fca-0000BV-QL; Sun, 15 Jun 2008 01:57:24 +0200
X-Mailer: git-send-email 1.5.6.rc2.51.g4d03a.dirty
In-Reply-To: <200806141447.28052.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85054>

From: Jakub Narebski <jnareb@gmail.com>

This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
also uses HTML::Lint (if present) to validate the HTML.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
This requires the following two patches:
[PATCH] gitweb: Make it work with $GIT containing spaces
    http://article.gmane.org/gmane.comp.version-control.git/85036/raw
[PATCH] t/test-lib.sh: add test_external and test_external_without_stderr
    http://article.gmane.org/gmane.comp.version-control.git/83415/raw

Changed since v1:

- Use "$GIT_EXEC_PATH/git" instead of "git" for the git binary path,
  since on my system $PATH gets lost mysteriously.

- Use test_external instead of test_external_without_stderr so that
  the test doesn't fail if there is output on stderr.

  Discarding and restoring STDERR (as I mentioned in a recent message)
  doesn't work with Mechanize, as Mechanize somehow seems to save the
  STDERR handle and reuse it, so subsequent calls to Mechanize keep
  using the discarded STDERR.  (The discard/restore functions work
  fine in other test modules, it's really just Mechanize here.)

  Using test_external means that in verbose mode we get some spurious
  error messages in the test output, but they're not harmful (and it
  should be clear to anyone running the test suite that they're OK).

- Reworded commit message a little for clarity.

The test works now on my system.  If you run this successfully (or
unsuccessfully), please post a note on the list.
Comments/patches/additions, in particular from people who've used
Mechanize before, is still much appreciated!

This patch is WIP and not for inclusion.  At some point we'll take
further revisions off the list and use a public repository instead
(once repo.or.cz is up again); we'll post a notice when that happens.
When the test suite is finished we'll post it here again.

 t/t9503-gitweb-Mechanize.sh |  127 +++++++++++++++++++++++++++++++++++++++++++
 t/t9503/test.pl             |   91 +++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503-gitweb-Mechanize.sh
 create mode 100755 t/t9503/test.pl

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
new file mode 100755
index 0000000..8720aea
--- /dev/null
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -0,0 +1,127 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jakub Narebski
+#
+
+test_description='gitweb as CGI (using WWW::Mechanize)
+
+This test uses Perl module Test::WWW::Mechanize::CGI to
+check gitweb output, using HTML::Lint to validate HTML.'
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
+perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, perl version is too old' :
+	test_done
+	exit
+}
+
+perl -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
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
+safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
+cat >gitweb_config.perl <<EOF
+#!/usr/bin/perl
+
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
+	perl ../t9503/test.pl
+
+test_done
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
new file mode 100755
index 0000000..7d081b9
--- /dev/null
+++ b/t/t9503/test.pl
@@ -0,0 +1,91 @@
+#!/usr/bin/perl
+
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Cwd qw(abs_path);
+use File::Spec;
+use Test::More qw(no_plan);
+use Test::WWW::Mechanize::CGI;
+
+eval { require HTML::Lint };
+my $lint_installed = !$@;
+diag('HTML::Lint is not installed; no HTML validation tests')
+	unless $lint_installed;
+
+my $gitweb = File::Spec->catfile('..','..','gitweb','gitweb.perl');
+# the followin two lines of code are workaround for bug in
+# Test::WWW::Mechanize::CGI::cgi_application version up to 0.3
+# (http://rt.cpan.org/Ticket/Display.html?id=36654)
+# for pathnames with spaces (because of "trash directory")
+$gitweb = File::Spec->rel2abs($gitweb);
+$gitweb = Cwd::abs_path($gitweb);
+
+my $mech = new Test::WWW::Mechanize::CGI;
+$mech->cgi_application($gitweb);
+$mech->env(GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'});
+
+# import config, pedeclaring config variables
+our $site_name = '';
+require_ok($ENV{'GITWEB_CONFIG'})
+	or diag('Could not load gitweb config; some tests would fail');
+
+my $pagename = '';
+my $get_ok;
+SKIP: {
+	$pagename = 'project list (implicit)';
+	skip "Could not get $pagename", 2 + $lint_installed
+		unless $mech->get_ok('http://localhost/', "GET $pagename");
+	$mech->html_lint_ok('page validates') if $lint_installed;
+	$mech->title_like(qr!$site_name!,
+		'title contains $site_name');
+	$mech->content_contains('./t9503-gitweb-Mechanize.sh test repository', 
+		'lists test repository (by description)');
+}
+
+$mech->get_ok('http://localhost/?p=.git',
+	'GET test repository summary (implicit)');
+$mech->get_ok('http://localhost/.git',
+	'GET test repository summary (implicit, pathinfo)');
+$get_ok = 0;
+SKIP: {
+	$pagename = 'test repository summary (explicit)';
+	$get_ok = $mech->get_ok('http://localhost/?p=.git;a=summary',
+		"GET $pagename");
+	skip "Could not get $pagename", 1 + $lint_installed
+		unless $get_ok;
+	$mech->html_lint_ok('page validates') if $lint_installed;
+	$mech->title_like(qr!$site_name.*\.git/summary!,
+		'title contains $site_name and ".git/summary"');
+}
+
+SKIP: {
+	skip "Could not get starting page $pagename", 2 + $lint_installed
+		unless $get_ok;
+	$pagename = 'search test repository (from search form)';
+	$get_ok = $mech->submit_form_ok(
+		{form_number=>1,
+		 fields=> {'s' => 'Initial commit'}
+		},
+		"submit search form (default)");
+	skip "Could not submit search form", 1 + $lint_installed
+		unless $get_ok;
+	$mech->html_lint_ok('page validates') if $lint_installed;
+	$mech->content_contains('Initial commit',
+		'content contains searched text');
+}
+
+$pagename = 'non existent project';
+$mech->get('http://localhost/?p=non-existent.git');
+like($mech->status, qr/40[0-9]/, "40x status response for $pagename");
+$mech->html_lint_ok('page validates') if $lint_installed;
+
+$pagename = 'non existent commit';
+$mech->get('http://localhost/?p=.git;a=commit;h=non-existent');
+like($mech->status, qr/40[0-9]/, "40x status response for $pagename");
+$mech->html_lint_ok('page validates') if $lint_installed;
+
+1;
+__END__
-- 
1.5.6.rc2.51.g4d03a.dirty
