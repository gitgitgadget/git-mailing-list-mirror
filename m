From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v3 2/3 (amend)] Documentation: complete config list from other manpages
Date: Sun, 24 Oct 2010 22:55:13 +0200
Message-ID: <201010242255.14379.jnareb@gmail.com>
References: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch> <201010241636.51106.jnareb@gmail.com> <201010242244.24326.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 24 22:55:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA7bQ-0004zv-4D
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 22:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950Ab0JXUzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 16:55:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57262 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab0JXUzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 16:55:19 -0400
Received: by fxm16 with SMTP id 16so2288552fxm.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JvBu3EhSQbQNes3EtMCzFfvHxUZrrHsJsEzLsZxx8Xs=;
        b=dE2Q7x7TY5WsEMKatfcJR3lBL2II/ZJo49HQv/B1TcQLxrKQM8cTetaebGSyagbDIf
         UUPQL1Kcxik1eItS0Sbhco4Xuoue7zCvG7GEqo34vYheAt8ZDhSOQlo9DctWdwFWr80C
         KWdoHd7mDgvd1ipk/8NxlsiRULipXbwKeUPRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mY8WIr2CMmndk3AGTKVcRzeI3p6aa1S8npp5TbNOzVYESAF/Q5JB7KNE4QI6d4atq3
         9fumVjcmHErMg/BlligGAaCP80csrJieYaw4Qvi6B7Ql08PyEOjXB+j+UURTTt9BLe/E
         cIunlyvUCmPQBK+a6PXkbuyfG3e43nAM+Szig=
Received: by 10.103.124.13 with SMTP id b13mr7219406mun.49.1287953717484;
        Sun, 24 Oct 2010 13:55:17 -0700 (PDT)
Received: from [192.168.1.13] (abvu207.neoplus.adsl.tpnet.pl [83.8.218.207])
        by mx.google.com with ESMTPS id u8sm2510365fah.36.2010.10.24.13.55.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 13:55:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201010242244.24326.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159890>

From: Thomas Rast <trast@student.ethz.ch>

Add an autogeneration script Documentation/make-config-list.perl
that complete list of config variables with missing variables
from other manpages.

This script generates minimal documentation for those missing config
variables at appropriate place in Documentation/config-vars.txt,
using the following form:

    foo.bar::
    foo.baz::
        See linkgit:git-foo[1].


It does that as follows:

* parse config-vars-src.txt (was config-vars.txt, which is now generated)
  to find out config variables it contains

* parse each manpage source (following includes) for config variable
  headers

* assemble a new config-vars.txt that completes the original list with
  "See linkgit:git-foo[1]" entries for all variables that were not in
  it config-vars-src.txt

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version has removed stray commented out remains of debugging the
make-config-list.perl script, and has it slightly reordered for better
readibility.

I have accidentally included old version of a patch.  I am very sorry.

Below there comments from previous email (without references to
attachements, which are not included in this email)
...

The differences from v2 by Thomas Rast:
* Removed stray changes to Documentation/Makefile and 
  Documentation/config-vars-src.txt

* The config-vars.txt target now depends on $(cmds_txt), which are 
  included by git.txt (without it, and without 'make doc' ran, the
  generation of "make -C Documentation config-vars.txt" failed because
  it couldn't find IIRC cmds-mainporcelain.txt).  See below.

* The config-vars.txt target now uses $(QUIET_GEN) and $(PERL_PATH),
  and makes use of make's automatic variables ($@, $<), like other
  targets that run *.perl scripts.  It uses $(MAN_TXT) in place of
  its definition, i.e. '$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)'

* The make-config-vars.perl invocation in config-vars.txt target
  now has extra '--ignore=merge-config.txt' because config-vars.src.txt
  contains 'include::merge-config.txt[]'.  See below.

* The make-config-vars.perl got rewritten according to proposals in
  parent email.  In general this means that instead of decomposing
  config-vars-src.txt, adding documentation of missing variables,
  and then recomposing it into config-vars.txt (with side-effects
  such as lowercasing variable names, and sorting variables), it
  simply finds places where to insert missing documentation, and
  generates and inserts it there.

  This means that read_varlist() got simplified, and main code got
  rewritten.


Issues to be solved (aka why this is an RFC):
* Dependencies for config-vars.txt target; probably just needs 
  modification to build-docdep.perl script.

* read_varlist does not follow includes, and that is why we had to
  manually ignore merge-config.txt

* Either sorting or inserting generated documentation could be
  improved; as can be seen in attached config-vars.txt the variables
  from manpage for git-http-backend got split.

 Documentation/Makefile                             |    5 +
 .../{config-vars.txt => config-vars-src.txt}       |    0
 Documentation/make-config-list.perl                |  168 ++++++++++++++++++++
 3 files changed, 173 insertions(+), 0 deletions(-)
 rename Documentation/{config-vars.txt => config-vars-src.txt} (100%)
 create mode 100755 Documentation/make-config-list.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..8ce75d2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -320,6 +320,11 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
 
+config-vars.txt: config-vars-src.txt $(MAN_TXT) $(cmds_txt)
+	$(QUIET_GEN)$(PERL_PATH) ./make-config-list.perl \
+		--mainlist=$< --ignore=$@ --ignore=merge-config.txt $(MAN_TXT) >$@+ && \
+	mv $@+ $@
+
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
 
diff --git a/Documentation/config-vars.txt b/Documentation/config-vars-src.txt
similarity index 100%
rename from Documentation/config-vars.txt
rename to Documentation/config-vars-src.txt
diff --git a/Documentation/make-config-list.perl b/Documentation/make-config-list.perl
new file mode 100755
index 0000000..2894d96
--- /dev/null
+++ b/Documentation/make-config-list.perl
@@ -0,0 +1,168 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use Getopt::Long;
+
+
+my %ignore;
+my $rc = GetOptions(
+	"mainlist=s" => \my $mainlistfile,
+	"ignore=s" => sub { $ignore{$_[1]} = 1 },
+);
+
+if (!$rc || !defined $mainlistfile) {
+	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
+	exit 1;
+}
+
+my %var_manpages;
+my %manpage_section;
+
+foreach my $name (@ARGV) {
+	read_man_txt($name);
+}
+
+my ($mainlist, $mainvars) = read_varlist($mainlistfile);
+
+my @missing_vars =
+	grep { !exists $mainlist->{lc($_)} } keys %var_manpages;
+my %missing_vars =
+	map { $_ => $var_manpages{$_} } @missing_vars;
+
+my %insert = find_insertion_points($mainlist, \%missing_vars);
+
+open my $fh, '<', $mainlistfile
+	or die "Couldn't open '$mainlistfile' for reading: $!";
+while (<$fh>) {
+	if (exists $insert{$.}) {
+		print vars_documentation($insert{$.}, \%missing_vars);
+		print "\n";
+	}
+	print;
+}
+# special case: insertion after last line in $mainlistfile
+print vars_documentation($insert{-1}, \%missing_vars)
+	if exists $insert{-1};
+close $fh
+	or die "Couldn't close '$mainlistfile': $!";
+
+exit 0;
+
+# ----------------------------------------------------------------------
+# ----------------------------------------------------------------------
+# ----------------------------------------------------------------------
+
+sub read_varlist {
+	my ($filename) = @_;
+
+	open my $fh, '<', $filename
+		or die "Couldn't open '$filename' for reading: $!";
+
+	my (%mainlist, @mainvars);
+	while (<$fh>) {
+		if (/^(\S+)::/) {
+			my $v = $1;
+			push @mainvars, $v;
+			$mainlist{lc($v)} = $.;
+		}
+	}
+
+	close $fh
+		or die "Couldn't close '$filename': $!";
+
+	return \%mainlist, \@mainvars;
+}
+
+sub read_man_txt {
+	my ($filename, $manpage) = @_;
+	if (!defined $manpage) {
+		$manpage = $filename;
+		$manpage =~ s/\.txt//;
+	}
+
+	open my $fh, '<', $filename
+		or die "Couldn't open '$filename' for reading: $!";
+	while (<$fh>) {
+		if ($. < 5 && /^$manpage\((\d+)\)/) {
+			$manpage_section{$manpage} = $1;
+		}
+		if (/^([a-z0-9]+\.[a-zA-Z<>0-9.]+)::/) {
+			push @{$var_manpages{$1}}, $manpage;
+		}
+		if (/^include::\s*(\S+)\s*\[\]/ &&
+		    !exists $ignore{$1}) {
+			read_man_txt($1, $manpage);
+		}
+	}
+	close $fh
+		or die "Couldn't close '$filename': $!";
+}
+
+sub find_insertion_points {
+	my ($mainlist, $missing_vars) = @_;
+	my %insert;
+
+	my %all_vars = (%$mainlist, %$missing_vars);
+	my $lineno = -1; # means after last line
+
+	# reverse order because we want to find a place before which to insert
+	# generated documentation; it is easy to find where description
+	# of variable begins, but in general harder to find where it ends.
+	my @sorted_vars = reverse sort { lc($a) cmp lc($b) } keys %all_vars;
+	foreach my $key (@sorted_vars) {
+		my $val = $all_vars{$key};
+		if (ref $val) {
+			# this came from %$missing_vars
+			push @{$insert{$lineno}}, $key;
+		} else {
+			# this came from %$mainlist
+			if ($lineno < 0) {
+				# $lineno < 0 means after end of file (special case)
+				$lineno = $val;
+			} else {
+				# this is in case of unsorted entries in $mainlistfile
+				$lineno = $val < $lineno ? $val : $lineno; # min($val, $lineno)
+			}
+		}
+	}
+	return %insert;
+}
+
+sub vars_documentation {
+	my ($keylist, $vars) = @_;
+	my @keys = sort @$keylist;
+	my %out;
+
+	# generate output for each key now, because it is easier to compare
+	# strings than arrays; comparing which is needed for compacting output
+	foreach my $k (@keys) {
+		$out{$k} = "\tSee: ".gen_links($vars->{$k}).".\n";
+	}
+
+	my $output = '';
+	while (my $k = pop @keys) {
+		$output .= $k."::\n";
+		unless (@keys && $out{$k} eq $out{$keys[0]}) {
+			$output .= $out{$k};
+		}
+	}
+	return $output;
+}
+
+sub gen_links {
+	my $manpages = shift;
+	return join(", ", map { linkgit($_) } @$manpages);
+}
+
+sub linkgit {
+	my $manpage = shift;
+
+	if (!exists $manpage_section{$manpage}) {
+		warn "section for $manpage unknown, assuming '1'\n";
+		$manpage_section{$manpage} = 1;
+	}
+	return "linkgit:${manpage}[$manpage_section{$manpage}]";
+}
+
+__END__
-- 
1.7.3
