Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84BA1F42D
	for <e@80x24.org>; Wed, 25 Apr 2018 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755177AbeDYQNG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:13:06 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42730 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755688AbeDYQMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:12:38 -0400
Received: by mail-wr0-f171.google.com with SMTP id v5-v6so3135372wrf.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k+p1+Au1ylJweNGE5LOGKsl4hvcyzdqIQmnHJimtwD8=;
        b=G5nY7kp0srVXMfFxxtMDqUOacu4OD4wKDmFsViD2VkdUWYxtkkpuyMRpBB1sazz4bK
         NAWzA0MpT+kN6aNYEvwEKiXkvx7odicsGHfoJCVUUtwefkaiT5UpMmHgJ1f2k9d0YSzJ
         La+UhJDEZ5iqp9ru3pteOzFpi5lSa1vwSCQzXuuwwifGJgVjdqzKtezKxMLewRcbg/mT
         gI9GdSJiKAWT9K/soOSKrOdZF/Gj+R/vyNJaIW1t66fnaZ6x2wpkxeykSEZex2Mc2a2E
         CBCgXLB2YG5U0EY6nAxKvYK8oY+wcZVXa1/38vb4/vYWSgVD7MsOAHl0dccqm3IJwl5S
         RmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k+p1+Au1ylJweNGE5LOGKsl4hvcyzdqIQmnHJimtwD8=;
        b=rkodeLCZt6N77I4gU32VzBwgssbBJyY/2GR5UZeRcyIB+IzW8jNyF5jfpgBtVBUR1n
         Qxa74a3tMKNr6nv6gFRm5CwxIjrayX5J8RD+9NlKDEXrS3SUbi/77jYMIsL4Nn5uY+kR
         2O2u3owjyyG/JXyiFylNQwAE7I6BmLbkwXE/174X0hoeVEMZbWDhWcNVauYIuZ3sjTWJ
         XNDf3yUCx5UVafKyhXHqLTgcnRQv/kdZ206fk5XY48eXF52KEWUP/np/HIgzz1QwLmWn
         8GxzIzpyh8XY9s3a0K+PuBDBDrTP1jzUFQYfhaTseDWAc1hbRNwrKGg/r0AARRAlpqxe
         CHTw==
X-Gm-Message-State: ALQs6tCVafqRSx0TRM59UZQCKyKPKwYw3ECS64USSqRjwbSiafB/t0e3
        RjomO+0Mzw2wPTTCcdqVLYiaUw+6
X-Google-Smtp-Source: AIpwx4/vykXQd90sMKODnqWTt7dW0k8XqMni05Oou3Ddl7p42KPC5S6ysoHKVscP5jv7gp5KDXLTnA==
X-Received: by 2002:adf:bbce:: with SMTP id z14-v6mr24547261wrg.183.1524672756861;
        Wed, 25 Apr 2018 09:12:36 -0700 (PDT)
Received: from localhost.localdomain ([80.215.246.209])
        by smtp.gmail.com with ESMTPSA id w14sm13946705wmd.1.2018.04.25.09.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:12:36 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] perf/aggregate: use Getopt::Long for option parsing
Date:   Wed, 25 Apr 2018 18:10:25 +0200
Message-Id: <20180425161025.3242-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.257.g28b659db43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When passing an option '--foo' that it does not recognize, the
aggregate.perl script should die with an helpful error message
like:

Unknown option: foo
./aggregate.perl [options] [--] [<dir_or_rev>...] [--] \
[<test_script>...] >

  Options:
    --codespeed          * Format output for Codespeed
    --reponame    <str>  * Send given reponame to codespeed
    --sort-by     <str>  * Sort output (only "regression" \
criteria is supported)

rather than:

  fatal: Needed a single revision
  rev-parse --verify --foo: command returned error: 128

To implement that let's use Getopt::Long for option parsing
instead of the current manual and sloppy parsing. This should
save some code and make option parsing simpler, tighter and
safer.

This will avoid something like 'foo--sort-by=regression' to
be handled as if '--sort-by=regression' had been used, for
example.

As Getopt::Long eats '--' at the end of options, this changes
a bit the way '--' is handled as we can now have '--' both
after the options and before the scripts.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Actually it looks like we should not use:

  Getopt::Long::Configure qw/ pass_through /;

as GetOptions() would not error out when an unknown option
like --foo is used.

 t/perf/aggregate.perl | 62 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 48637ef64b..bc865160e7 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -4,6 +4,7 @@ use lib '../../perl/build/lib';
 use strict;
 use warnings;
 use JSON;
+use Getopt::Long;
 use Git;
 
 sub get_times {
@@ -36,46 +37,34 @@ sub format_times {
 	return $out;
 }
 
+sub usage {
+	print <<EOT;
+./aggregate.perl [options] [--] [<dir_or_rev>...] [--] [<test_script>...] >
+
+  Options:
+    --codespeed          * Format output for Codespeed
+    --reponame    <str>  * Send given reponame to codespeed
+    --sort-by     <str>  * Sort output (only "regression" criteria is supported)
+    --subsection  <str>  * Use results from given subsection
+
+EOT
+	exit(1);
+}
+
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
     $codespeed, $sortby, $subsection, $reponame);
+
+Getopt::Long::Configure qw/ require_order /;
+
+my $rc = GetOptions("codespeed"     => \$codespeed,
+		    "reponame=s"    => \$reponame,
+		    "sort-by=s"     => \$sortby,
+		    "subsection=s"  => \$subsection);
+usage() unless $rc;
+
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
-	if ($arg eq "--codespeed") {
-		$codespeed = 1;
-		shift @ARGV;
-		next;
-	}
-	if ($arg =~ /--sort-by(?:=(.*))?/) {
-		shift @ARGV;
-		if (defined $1) {
-			$sortby = $1;
-		} else {
-			$sortby = shift @ARGV;
-			if (! defined $sortby) {
-				die "'--sort-by' requires an argument";
-			}
-		}
-		next;
-	}
-	if ($arg eq "--subsection") {
-		shift @ARGV;
-		$subsection = $ARGV[0];
-		shift @ARGV;
-		if (! $subsection) {
-			die "empty subsection";
-		}
-		next;
-	}
-	if ($arg eq "--reponame") {
-		shift @ARGV;
-		$reponame = $ARGV[0];
-		shift @ARGV;
-		if (! $reponame) {
-			die "empty reponame";
-		}
-		next;
-	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -225,7 +214,8 @@ sub print_sorted_results {
 	my ($sortby) = @_;
 
 	if ($sortby ne "regression") {
-		die "only 'regression' is supported as '--sort-by' argument";
+		print "Only 'regression' is supported as '--sort-by' argument\n";
+		usage();
 	}
 
 	my @evolutions;
-- 
2.17.0.257.g28b659db43

