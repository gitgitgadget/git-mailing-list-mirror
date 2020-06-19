Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F0C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E9D223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tlHgBRTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgFSWwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:52:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729746AbgFSWwH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:52:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F067960A69;
        Fri, 19 Jun 2020 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607095;
        bh=ackgtsKGAbZAljcOkN+4IxjqUnwTxVQfXHXDz875pzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tlHgBRTtQ/I7hDOS1gL3xO75HXpnC+uWjN4khBY/HmklFbQ0ai2NsYMuZHVV3Bla6
         +ZMHFQM25hN5MmBoW7NJLJzYYUHRcwCFUkC6SaGDzrmsX7TKfxBiVF+EVeAIWMiJJz
         PK8MFh1kyybVVESrGFeOhCbPdgh9wheQ3aP23I5Enkfymw/8CFL0N92+hR4Tp+rSTJ
         TycFADZ6uOa/aJolGcfJUArDZqnEsP+qJkBDJWsaUnUUMvLDknqBMh9bOyPBbcoO2y
         xr5uAJ6zkGy897n7t7WtPT0nCuBZ6okbP5yrMllYCknJZffQ3MK4ksrax59EUst/EU
         Oi27gneI2U33ULXqKQd1bs5ZaF66ZNvYrCChTiUxXewLGbN43gJbJHrATgaPiY3ynv
         KslnIjMMy+eX1iqNDnrib8iTNeY8O3tE/5W+suaGfejWmeFNgHRycaNnLz9lJvdaDW
         DLENAVrTUxdzAeP84J5ueSZHp3xMLSeClI18k0n8LFvnkFJLIOH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 08/14] perl: create and switch variables for hash constants
Date:   Fri, 19 Jun 2020 22:39:41 +0000
Message-Id: <20200619223947.947067-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-svn has several variables for SHA-1 constants, including short hash
values and full length hash values.  Since these are no longer SHA-1
specific, let's start them with "oid" instead of "sha1".  Add a
constant, oid_length, which is the length of the hash algorithm in use
in hex.  We use the hex version because overwhelmingly that's what's
used by git-svn.

We don't currently set oid_length based on the repository algorithm, but
we will in a future commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-svn.perl           | 14 ++++++++------
 perl/Git/SVN.pm        | 10 +++++-----
 perl/Git/SVN/Editor.pm |  2 +-
 perl/Git/SVN/Log.pm    |  2 +-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4aa208ff5f..7c735cebd3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5,7 +5,8 @@
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
-		$sha1 $sha1_short $_revision $_repository
+		$oid $oid_short $oid_length
+		$_revision $_repository
 		$_q $_authors $_authors_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
@@ -103,8 +104,9 @@ sub _req_svn {
 	}
 }
 
-$sha1 = qr/[a-f\d]{40}/;
-$sha1_short = qr/[a-f\d]{4,40}/;
+$oid = qr/(?:[a-f\d]{40}(?:[a-f\d]{24})?)/;
+$oid_short = qr/[a-f\d]{4,64}/;
+$oid_length = 40;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file, $_branch_dest,
 	$_template, $_shared,
@@ -582,7 +584,7 @@ sub cmd_set_tree {
 		print "Reading from stdin...\n";
 		@commits = ();
 		while (<STDIN>) {
-			if (/\b($sha1_short)\b/o) {
+			if (/\b($oid_short)\b/o) {
 				unshift @commits, $1;
 			}
 		}
@@ -1831,7 +1833,7 @@ sub get_tree_from_treeish {
 	if ($type eq 'commit') {
 		$expected = (grep /^tree /, command(qw/cat-file commit/,
 		                                    $treeish))[0];
-		($expected) = ($expected =~ /^tree ($sha1)$/o);
+		($expected) = ($expected =~ /^tree ($oid)$/o);
 		die "Unable to get tree from $treeish\n" unless $expected;
 	} elsif ($type eq 'tree') {
 		$expected = $treeish;
@@ -2036,7 +2038,7 @@ sub working_head_info {
 	my $hash;
 	my %max;
 	while (<$fh>) {
-		if ( m{^commit ($::sha1)$} ) {
+		if ( m{^commit ($::oid)$} ) {
 			unshift @$refs, $hash if $hash and $refs;
 			$hash = $1;
 			next;
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 4b28b87784..fcf1e3bb5e 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -874,7 +874,7 @@ sub assert_index_clean {
 		command_noisy('read-tree', $treeish) unless -e $self->{index};
 		my $x = command_oneline('write-tree');
 		my ($y) = (command(qw/cat-file commit/, $treeish) =~
-		           /^tree ($::sha1)/mo);
+		           /^tree ($::oid)/mo);
 		return if $y eq $x;
 
 		warn "Index mismatch: $y != $x\nrereading $treeish\n";
@@ -1020,7 +1020,7 @@ sub do_git_commit {
 		$tree = $self->tmp_index_do(sub {
 		                            command_oneline('write-tree') });
 	}
-	die "Tree is not a valid sha1: $tree\n" if $tree !~ /^$::sha1$/o;
+	die "Tree is not a valid oid $tree\n" if $tree !~ /^$::oid$/o;
 
 	my @exec = ('git', 'commit-tree', $tree);
 	foreach ($self->get_commit_parents($log_entry)) {
@@ -1048,8 +1048,8 @@ sub do_git_commit {
 	close $out_fh or croak $!;
 	waitpid $pid, 0;
 	croak $? if $?;
-	if ($commit !~ /^$::sha1$/o) {
-		die "Failed to commit, invalid sha1: $commit\n";
+	if ($commit !~ /^$::oid$/o) {
+		die "Failed to commit, invalid oid: $commit\n";
 	}
 
 	$self->rev_map_set($log_entry->{revision}, $commit, 1);
@@ -2150,7 +2150,7 @@ sub rebuild {
 	my $svn_uuid = $self->rewrite_uuid || $self->ra_uuid;
 	my $c;
 	while (<$log>) {
-		if ( m{^commit ($::sha1)$} ) {
+		if ( m{^commit ($::oid)$} ) {
 			$c = $1;
 			next;
 		}
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 0df16ed726..70b6d78cd9 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -63,7 +63,7 @@ sub generate_diff {
 	my @mods;
 	while (defined($_ = get_record($diff_fh, "\0"))) {
 		if ($state eq 'meta' && /^:(\d{6})\s(\d{6})\s
-					($::sha1)\s($::sha1)\s
+					($::oid)\s($::oid)\s
 					([MTCRAD])\d*$/xo) {
 			push @mods, {	mode_a => $1, mode_b => $2,
 					sha1_a => $3, sha1_b => $4,
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 664105357c..3858fcf27d 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -285,7 +285,7 @@ sub cmd_show_log {
 	my (@k, $c, $d, $stat);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
-		if (/^${esc_color}commit (?:- )?($::sha1_short)/o) {
+		if (/^${esc_color}commit (?:- )?($::oid_short)/o) {
 			my $cmt = $1;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
