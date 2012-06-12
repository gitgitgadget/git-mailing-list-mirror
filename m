From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCH 2/6] Test environment of git-remote-mediawiki
Date: Tue, 12 Jun 2012 23:12:40 +0200
Message-ID: <1339535563-18958-2-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
 <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Cathebras <simon.cathebras@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 23:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYOk-0008Q5-6o
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab2FLVNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 17:13:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45737 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783Ab2FLVND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 17:13:03 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5CL3t9R001168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 23:03:55 +0200
Received: from Hithlum.crous-grenoble.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5CLCjpJ032065;
	Tue, 12 Jun 2012 23:12:52 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 23:03:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CL3t9R001168
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340139837.08844@kvpHJ3QwkNmbBtoyKBGl2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199856>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

In order to test git-remote-mediawiki, we need a package of functions
to manage a MediaWiki: edit a page, remove a page, fetch a page,
fetch all pages on a given wiki.

We also need functions to compare the content of directories.

This patch provide these functions in the file
git/contrib/mw-to-git/t/test-gitmw-lib.sh and
git/contrib/mw-to-git/t/test-gitmw.pl

In addition, this patch provide Makefiles to execute tests.
See README file for more details.

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
---
 contrib/mw-to-git/Makefile            |  48 +++++++
 contrib/mw-to-git/t/Makefile          |  27 ++++
 contrib/mw-to-git/t/README            |  33 +++++
 contrib/mw-to-git/t/test-gitmw-lib.sh | 137 ++++++++++++++++++++
 contrib/mw-to-git/t/test-gitmw.pl     | 230 ++++++++++++++++++++++++++++++++++
 5 files changed, 475 insertions(+)
 create mode 100644 contrib/mw-to-git/Makefile
 create mode 100644 contrib/mw-to-git/t/Makefile
 create mode 100644 contrib/mw-to-git/t/README
 create mode 100755 contrib/mw-to-git/t/test-gitmw.pl

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
new file mode 100644
index 0000000..c9b1795
--- /dev/null
+++ b/contrib/mw-to-git/Makefile
@@ -0,0 +1,48 @@
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+## Build git-remote-mediawiki
+
+-include ../../config.mak.autogen
+-include ../../config.mak
+
+ifndef PERL_PATH
+	PERL_PATH = /usr/bin/perl
+endif
+ifndef gitexecdir
+	gitexecdir = $(shell git --exec-path)
+endif
+
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+SCRIPT = git-remote-mediawiki
+
+.PHONY: install help doc test clean
+
+help:
+	@echo 'This is the help target of the Makefile. Current configuration:'
+	@echo '  gitexecdir = $(gitexecdir_SQ)'
+	@echo '  PERL_PATH = $(PERL_PATH_SQ)'
+	@echo 'Run "$(MAKE) install" to install $(SCRIPT) in gitexecdir'
+	@echo 'Run "$(MAKE) test" to run the testsuite'
+
+install:
+	sed -e '1s|#!.*/perl|#!$(PERL_PATH_SQ)|' $(SCRIPT) \
+            > '$(gitexecdir_SQ)/$(SCRIPT)'
+	chmod +x '$(gitexecdir)/$(SCRIPT)'
+
+doc:
+	@echo 'Sorry, "make doc" is not implemented yet for $(SCRIPT)'
+
+test:
+	$(MAKE) -C t/ test
+
+clean:
+	$(RM) '$(gitexecdir)/$(SCRIPT)'
+	$(MAKE) -C t/ clean
+
diff --git a/contrib/mw-to-git/t/Makefile b/contrib/mw-to-git/t/Makefile
new file mode 100644
index 0000000..752fd1f
--- /dev/null
+++ b/contrib/mw-to-git/t/Makefile
@@ -0,0 +1,27 @@
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+## Test git-remote-mediawiki
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
+
+.PHONY: help test clean
+
+help:
+	@echo 'Run "$(MAKE) test" to launch test scripts'
+	@echo 'Run "$(MAKE)" clean to remove trash folders'
+
+test:
+	for t in $(T); do "./$$t"; done
+
+clean:
+	$(RM) -r 'trash directory'.*
+
diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
new file mode 100644
index 0000000..b68147b
--- /dev/null
+++ b/contrib/mw-to-git/t/README
@@ -0,0 +1,33 @@
+Tests for Mediawiki-to-Git
+==========================
+
+
+Installation
+------------
+These tests require a mediawiki with admin access to work on; you can install one
+on localhost/wiki simply by running:
+	./install-wiki.sh install
+Be aware that the tests will flush the wiki database, thus if you own a wiki at
+this adress, it is strongly advised to configure another name in test-gitmw-lib.sh
+before running the script.
+Note that the wiki will be installed in /tmp (this can be configured too), meaning
+you might have to install it again when you run tests later.
+
+
+Running
+-------
+You can run these tests either individually or with make (recommended). Remember
+to use make clean when you're done. You have access to all options from git core
+tests.
+
+
+Limitations
+-------
+This test environment does not allow you to test the behavior of git-remote-mediawiki
+for name containing backslashes.
+
+t9360: tests git clone.
+
+t9361: tests git pull and git push.
+
+t9362: tests how UTF-8 special characters are handled.
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 160f97b..30be380 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -22,6 +22,143 @@ else
 	WIKI_DIR_INST="$CURR_DIR/$WEB_WWW"
 fi
 
+
+wiki_getpage () {
+	"$CURR_DIR"/test-gitmw.pl get_page "$@"
+}
+
+wiki_delete_page () {
+	"$CURR_DIR"/test-gitmw.pl delete_page "$@"
+}
+
+wiki_editpage () {
+	"$CURR_DIR"/test-gitmw.pl edit_page "$@"
+}
+
+die () {
+	die_with_status 1 "$@"
+}
+
+die_with_status () {
+	status=$1
+	shift
+	echo >&2 "$*"
+	exit "$status"
+}
+
+
+# Check the preconditions to run git-remote-mediawiki's tests
+test_check_precond () {
+	if ! test_have_prereq PERL
+	then
+		skip_all='skipping gateway git-mw tests, perl not available'
+		test_done
+	fi
+
+	if [ ! -f $GIT_BUILD_DIR/git-remote-mediawiki ];
+	then
+		skip_all='skipping gateway git-mw tests, no remote mediawiki for git found' \
+		'please try: cp git/contrib/mw-to-git/git-remote-mediawiki git/'
+		test_done
+	fi
+
+	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ;
+	then
+		skip_all='skipping gateway git-mw tests, no mediawiki found'
+		test_done
+	fi
+}
+
+# test_diff_directories <dir_git> <dir_wiki>
+#
+# Compare the contents of directories <dir_git> and <dir_wiki> with diff
+# and errors if they do not match. The program will
+# not look into .git in the process.
+# Warning: the first argument MUST be the directory containing the git data
+test_diff_directories () {
+	rm -rf "$1_tmp"
+	mkdir -p "$1_tmp"
+	cp "$1"/*.mw "$1_tmp"
+	diff -r -b "$1_tmp" "$2"
+}
+
+# $1=<dir>
+# $2=<N>
+#
+# Check that <dir> contains exactly <N> files
+test_contains_N_files () {
+	test `ls "$1" | wc -l` -eq "$2";
+}
+
+
+# wiki_check_content <file_name> <page_name>
+#
+# Compares the contents of the file <file_name> and the wiki page
+# <page_name> and exits with error 1 if they do not match.
+wiki_check_content () {
+	mkdir -p wiki_tmp
+	wiki_getpage "$2" wiki_tmp
+	#replacement of forbidden character in file name
+	page_name=$(printf "%s\n" "$2" | sed -e "s/\//%2F/g")
+
+	diff -b "$1" wiki_tmp/"$page_name".mw
+	if test $? -ne 0
+	then
+		rm -rf wiki_tmp
+		error "ERROR: file $2 not found on wiki"
+	fi
+	rm -rf wiki_tmp
+}
+
+# wiki_page_exist <page_name>
+#
+# Check the existence of the page <page_name> on the wiki and exits
+# with error if it is absent from it.
+wiki_page_exist () {
+	mkdir -p wiki_tmp
+	wiki_getpage "$1" wiki_tmp
+	page_name=$(printf "%s\n" "$1" | sed "s/\//%2F/g")
+	if test -f wiki_tmp/"$page_name".mw ; then
+		rm -rf wiki_tmp
+	else
+		rm -rf wiki_tmp
+		error "test failed: file $1 not found on wiki"
+	fi
+}
+
+# wiki_getallpagename
+#
+# Fetch the name of each page on the wiki.
+wiki_getallpagename () {
+	$CURR_DIR/test-gitmw.pl getallpagename
+}
+
+# wiki_getallpagecategory <category>
+#
+# Fetch the name of each page belonging to <category> on the wiki.
+wiki_getallpagecategory () {
+	$CURR_DIR/test-gitmw.pl getallpagename "$@"
+}
+
+# wiki_getallpage <dest_dir> [<category>]
+#
+# Fetch all the pages from the wiki and place them in the directory
+# <dest_dir>.
+# If <category> is define, then wiki_getallpage fetch the pages included
+# in <category>.
+wiki_getallpage () {
+	if test -z "$2";
+	then
+		wiki_getallpagename
+	else
+		wiki_getallpagecategory "$2"
+	fi
+	mkdir -p "$1"
+	while read -r line; do
+		wiki_getpage "$line" $1;
+	done < all.txt
+}
+
 # ================= Install part =================
 
 error () {
diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
new file mode 100755
index 0000000..43faee5
--- /dev/null
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -0,0 +1,230 @@
+#!/usr/bin/perl -w -s
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+# License: GPL v2 or later
+
+# Usage:
+#       ./test-gitmw.pl <command> [argument]*
+# Execute in terminal using the name of the function to call as first
+# parameter, and the function's arguments as following parameters
+#
+# Example:
+#     ./test-gitmw.pl "get_page" foo .
+# will call <wiki_getpage> with arguments <foo> and <.>
+#
+# Available functions are:
+#     "get_page"
+#     "delete_page"
+#     "edit_page"
+#     "getallpagename"
+
+use MediaWiki::API;
+use Getopt::Long;
+use Switch;
+use encoding 'utf8';
+use DateTime::Format::ISO8601;
+use open ':encoding(utf8)';
+use constant SLASH_REPLACEMENT => "%2F";
+
+#Parsing of the config file
+
+my $configfile = "$ENV{'CURR_DIR'}/test.config";
+my %config;
+open (CONFIG,"< $configfile") || die "can't open $configfile: $!";
+while (<CONFIG>)
+{
+        chomp;
+        s/#.*//;
+        s/^\s+//;
+        s/\s+$//;
+        next unless length;
+        my ($key, $value) = split (/\s*=\s*/,$_, 2);
+        $config{$key} = $value;
+	last if ($key eq 'LIGHTTPD' and $value eq 'false');
+	last if ($key eq 'PORT');
+}
+
+my $wiki_address = "http://$config{'SERVER_ADDR'}".":"."$config{'PORT'}";
+my $wiki_url = "$wiki_address/$config{'WIKI_DIR_NAME'}/api.php";
+my $wiki_admin = "$config{'WIKI_ADMIN'}";
+my $wiki_admin_pass = "$config{'WIKI_PASSW'}";
+my $mw = MediaWiki::API->new;
+$mw->{config}->{api_url} = $wiki_url;
+
+sub mediawiki_clean_filename {
+	my $filename = shift;
+	$filename =~ s/@{[SLASH_REPLACEMENT]}/\//g;
+	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
+	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
+	# but with _ added to prevent MediaWiki from thinking this is
+	# an actual special character.
+	$filename =~ s/[\[\]\{\}\|]/sprintf("_%%_%x", ord($&))/ge;
+	# If we use the uri escape before
+	# we should unescape here, before anything
+
+	return $filename;
+}
+
+sub mediawiki_smudge_filename {
+	my $filename = shift;
+	$filename =~ s/\//@{[SLASH_REPLACEMENT]}/g;
+	$filename =~ s/ /_/g;
+	# Decode forbidden characters encoded in mediawiki_clean_filename
+	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/ge;
+	return $filename;
+}
+
+
+# wiki_login <name> <password>
+#
+# Logs the user with <name> and <password> in the global variable
+# of the mediawiki $mw
+sub wiki_login {
+	$mw->login( { lgname => "$_[0]",lgpassword => "$_[1]" } )
+	|| die "getpage: login failed";
+}
+
+# wiki_getpage <wiki_page> <dest_path>
+#
+# fetch a page <wiki_page> from the wiki referenced in the global variable
+# $mw and copies its content in directory dest_path
+sub wiki_getpage {
+	my $pagename = $_[0];
+	my $destdir = $_[1];
+
+	my $page = $mw->get_page( { title => $pagename } );
+	if (!defined($page)) {
+		die "getpage: wiki does not exist";
+	}
+
+	my $content = $page->{'*'};
+	if (!defined($content)) {
+		die "getpage: page does not exist";
+	}
+
+	# Replace spaces by underscore in the page name
+	$pagename=$page->{'title'};
+	$pagename = mediawiki_smudge_filename $pagename;
+	open(my $file, ">$destdir/$pagename.mw");
+	print $file "$content";
+	close ($file);
+
+}
+
+# wiki_delete_page <page_name>
+#
+# delete the page with name <page_name> from the wiki referenced
+# in the global variable $mw
+sub wiki_delete_page {
+	my $pagename = $_[0];
+
+	my $exist=$mw->get_page({title => $pagename});
+
+	if (defined($exist->{'*'})){
+		$mw->edit({ action => 'delete',
+				title => $pagename})
+		|| die $mw->{error}->{code} . ": " . $mw->{error}->{details};
+	} else {
+		die "no page with such name found: $pagename\n";
+	}
+}
+
+# wiki_editpage <wiki_page> <wiki_content> <wiki_append> [-c=<category>] [-s=<summary>]
+#
+# Edit a page named <wiki_page> with content <wiki_content> on the wiki
+# referenced with the global variable $mw
+# If <wiki_append> == true : append <wiki_content> at the end of the actual
+# content of the page <wiki_page>
+# If <wik_page> doesn't exist, that page is created with the <wiki_content>
+sub wiki_editpage {
+	my $wiki_page = mediawiki_clean_filename $_[0];
+	my $wiki_content = $_[1];
+	my $wiki_append = $_[2];
+	my $summary = "";
+	my ($summ, $cat) = ();
+	GetOptions('s=s' => \$summ, 'c=s' => \$cat);
+
+	my $append = 0;
+	if (defined($wiki_append) && $wiki_append eq 'true') {
+		$append=1;
+	}
+
+	my $previous_text ="";
+
+	if ($append) {
+		my $ref = $mw->get_page( { title => $wiki_page } );
+		$previous_text = $ref->{'*'};
+	}
+
+	my $text = $wiki_content;
+	if (defined($previous_text)) {
+		$text="$previous_text$text";
+	}
+
+	# Eventually, add this page to a category.
+	if (defined($cat)) {
+		my $category_name="[[Category:$cat]]";
+		$text="$text\n $category_name";
+	}
+	if(defined($summ)){
+		$summary=$summ;
+	}
+
+	$mw->edit( { action => 'edit', title => $wiki_page, summary => $summary, text => "$text"} );
+}
+
+# wiki_getallpagename [<category>]
+#
+# Fetch all pages of the wiki referenced by the global variable $mw
+# and print the names of each one in the file all.txt with a new line
+# ("\n") between these.
+# If the argument <category> is defined, then this function get only the pages
+# belonging to <category>.
+sub wiki_getallpagename {
+	# fetch the pages of the wiki
+	if (defined($_[0])) {
+		my $mw_pages = $mw->list ( { action => 'query',
+				list => 'categorymembers',
+				cmtitle => "Category:$_[0]",
+				cmnamespace => 0,
+				cmlimit=> 500 },
+		)
+		|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
+		open(my $file, ">all.txt");
+		foreach my $page (@{$mw_pages}) {
+			print $file "$page->{title}\n";
+		}
+		close ($file);
+
+	} else {
+		my $mw_pages = $mw->list({
+				action => 'query',
+				list => 'allpages',
+				aplimit => 500,
+			})
+		|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
+		open(my $file, ">all.txt");
+		foreach my $page (@{$mw_pages}) {
+			print $file "$page->{title}\n";
+		}
+		close ($file);
+	}
+}
+
+# Main part of this script: parse the command line arguments
+# and select which function to execute
+my $fct_to_call = shift;
+
+&wiki_login($wiki_admin,$wiki_admin_pass);
+
+switch ($fct_to_call) {
+	case "get_page" { &wiki_getpage(@ARGV)}
+	case "delete_page" { &wiki_delete_page(@ARGV)}
+	case "edit_page" { &wiki_editpage(@ARGV)}
+	case "getallpagename" { &wiki_getallpagename(@ARGV)}
+	else { die("test-gitmw.pl ERROR: wrong argument")}
+}
-- 
1.7.10.2.552.gaa3bb87
