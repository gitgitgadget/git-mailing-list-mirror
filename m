From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: complete config list from other manpages
Date: Sun, 24 Oct 2010 00:24:09 +0200
Message-ID: <8145782bddf60325909f328337cb76d25c4402cf.1287872553.git.trast@student.ethz.ch>
References: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 24 00:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9mVk-0005Za-47
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 00:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758249Ab0JWWYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 18:24:19 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:53081 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757921Ab0JWWYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 18:24:18 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 24 Oct
 2010 00:24:17 +0200
Received: from localhost.localdomain (129.132.210.217) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 24 Oct
 2010 00:24:16 +0200
X-Mailer: git-send-email 1.7.3.2.239.gbefc4
In-Reply-To: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.210.217]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159829>

Add an autogeneration script that inserts links to other manpages
describing config variables, as follows:

* parse config-vars-src.txt (as it now needs to be renamed) to find
  out its current contents

* parse each manpage source (following includes) for config variable
  headers (the blocks are ignored)

* assemble a new config-vars.txt that completes the original list with
  "See linkgit:git-foo[1]" entries for all variables that were not in
  it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Jakub Narebski wrote:
> Could you please resend this patch using rename detection 
> (git format-patch -M)?  It would make it clear what the difference
> between config-vars and config-vars-src is, if any.

Right, sorry about that.  There wasn't supposed to be any; I'm
resending what I pushed out for everyone's convenience, but the stray
change will be gone in the final version.


 Documentation/Makefile                             |    9 ++-
 .../{config-vars.txt => config-vars-src.txt}       |    2 +-
 Documentation/make-config-list.perl                |  131 ++++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)
 rename Documentation/{config-vars.txt => config-vars-src.txt} (99%)
 create mode 100755 Documentation/make-config-list.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..747b849 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -125,7 +125,7 @@ endif
 
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'
 
 #
 # Please note that there is a minor bug in asciidoc.
@@ -320,6 +320,13 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
 
+config-vars.txt: config-vars-src.txt $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
+	./make-config-list.perl --mainlist=config-vars-src.txt \
+		--ignore=config-vars.txt \
+		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT) \
+		> config-vars.txt+ && \
+	mv config-vars.txt+ config-vars.txt
+
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
 
diff --git a/Documentation/config-vars.txt b/Documentation/config-vars-src.txt
similarity index 99%
rename from Documentation/config-vars.txt
rename to Documentation/config-vars-src.txt
index a8d37a7..949259c 100644
--- a/Documentation/config-vars.txt
+++ b/Documentation/config-vars-src.txt
@@ -936,7 +936,7 @@ gitcvs.dbname::
 
 gitcvs.dbdriver::
 	Used Perl DBI driver. You can specify any available driver
-        for this here, but it might not work. git-cvsserver is tested
+	for this here, but it might not work. git-cvsserver is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
 	reported *not* to work with 'DBD::mysql'. Experimental feature.
 	May not contain double colons (`:`). Default: 'SQLite'.
diff --git a/Documentation/make-config-list.perl b/Documentation/make-config-list.perl
new file mode 100755
index 0000000..f086867
--- /dev/null
+++ b/Documentation/make-config-list.perl
@@ -0,0 +1,131 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use Getopt::Long;
+
+my %ignore;
+
+my $rc = GetOptions(
+	"mainlist=s" => \my $mainlistfile,
+	"ignore=s" => sub { $ignore{$_[1]} = 1 },
+	"no-sort" => \my $no_sort,
+	);
+
+if (!$rc or (!-r $mainlistfile)) {
+	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
+	exit 1;
+}
+
+sub read_varlist {
+	my ($file) = @_;
+
+	open my $fh, "<", $file or die "cannot open $file: $!";
+	my (%mainlist, @mainvars);
+
+	my ($v, $last_v);
+	my $in_block = 0;
+	while (<$fh>) {
+		if (/^(\S+)::/) {
+			$v = lc $1;
+			$in_block = 0;
+			push @{$mainlist{$v}}, $_;
+			push @mainvars, $v;
+		} elsif (/^$/ && !$in_block) {
+			if (defined $last_v && !$#{$mainlist{$last_v}}) {
+				$mainlist{$last_v} = $mainlist{$v};
+			}
+			$last_v = $v;
+		} elsif (defined $v) {
+			push @{$mainlist{$v}}, $_;
+			$in_block = !$in_block if /^--$/;
+		}
+	}
+
+	close $fh or die "eh? close failed: $!";
+
+	return \%mainlist, \@mainvars;
+}
+
+my %vars;
+my %sections;
+
+sub read_file {
+	my ($name, $main_name) = @_;
+	if (!defined $main_name) {
+		$main_name = $name;
+	}
+	my $manpage_name = $main_name;
+	$manpage_name =~ s/\.txt//;
+	my $fp;
+	open $fp, '<', $name or die "open $name failed: $!";
+	while (<$fp>) {
+		if ($. < 5 && /^$manpage_name\((\d+)\)/) {
+			$sections{$manpage_name} = $1;
+		}
+		if (/^([a-z0-9]+\.[a-z<>0-9.]+)::/) {
+			push @{$vars{$1}}, $manpage_name;
+		}
+		if (/^include::\s*(\S+)\s*\[\]/
+		    && !exists $ignore{$1}) {
+			read_file($1, $main_name);
+		}
+	}
+	close $fp or die "close $name failed: $!";
+}
+
+foreach my $name (@ARGV) {
+	read_file($name);
+}
+
+my ($mainlist, $mainvars) = read_varlist($mainlistfile);
+
+my @all_keys = @$mainvars;
+foreach my $k (keys %vars) {
+	if (!exists $mainlist->{$k}) {
+		push @all_keys, $k;
+	}
+}
+
+@all_keys = sort @all_keys unless $no_sort;
+
+my %out;
+foreach my $k (@all_keys) {
+	if (exists $mainlist->{$k}) {
+		push @{$out{$k}}, @{$mainlist->{$k}}, "\n";
+	} elsif (exists $vars{$k}) {
+		push @{$out{$k}}, $k . "::\n";
+		push @{$out{$k}}, "\tSee ";
+		my $sep = " ";
+		foreach my $p (sort @{$vars{$k}}) {
+			next if ($p =~ /$mainlistfile/);
+			if (!exists $sections{$p}) {
+				warn "section for $p unknown";
+				$sections{$p} = 1;
+			}
+			push @{$out{$k}}, $sep . "linkgit:" . $p . "[" . $sections{$p} . "]";
+			$sep = ", ";
+		}
+		push @{$out{$k}}, ".\n\n";
+	} else {
+		die "can't happen: $k not in any source";
+	}
+}
+
+for (my $i = 0; $i < $#all_keys; $i++) {
+	next if $#{$out{$all_keys[$i]}} != $#{$out{$all_keys[$i+1]}};
+	my $same = 1;
+	for (my $j = 1; $j <= $#{$out{$all_keys[$i]}}; $j++) {
+		if ($out{$all_keys[$i]}[$j] ne $out{$all_keys[$i+1]}[$j]) {
+			$same = 0;
+			last;
+		}
+	}
+	if ($same) {
+		$out{$all_keys[$i]} = [$out{$all_keys[$i]}[0]];
+	}
+}
+
+foreach my $k (@all_keys) {
+	print @{$out{$k}};
+}
-- 
1.7.3.2.239.gbefc4
