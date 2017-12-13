Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B7B1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbdLMPOH (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38451 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbdLMPN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:13:58 -0500
Received: by mail-wm0-f65.google.com with SMTP id 64so5773788wme.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ojJovuPmWVz2S9ZXhoZd6u1TtxI71FGRMhGofH1RnrQ=;
        b=aaKzI6yw5HZ7cPKyQcJC6ipjKwLylHn5ZDCMGiLB9S3zjxm8BKZ4Di2lnrD0UsAEZv
         Z21O0x4Wx879y1rEnldva22HoPidIl/povxODl2hPGqvLz2muDLNgh6SfoPuwsdNjW+f
         P301jS/IuyACbuDo7zVCFcrxZSLKDcEd3JO8bbjzcIJ70dXbj7XqPpEw2m7WX8rtqQEO
         YaD6fx80EocDnBcW7trbU7QyO9kUr1rqj3VxKU1xiptOZABGFcoNUG/sJNXJW+z1HYkB
         1pniiiGkFZRUcZl2jaLO63oOVF9TY+G0yiBozBn7vvP5VhVypsoepfmJqzVpedkGHHGX
         PPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ojJovuPmWVz2S9ZXhoZd6u1TtxI71FGRMhGofH1RnrQ=;
        b=dSU619TL5SDPYsREiYWoU2vM5Of9vJ/QX5zzZIVrxkMBWFl1PBVA+q4oPcN6TWDTyE
         lJtSG3PwGI55dUPmQ01Bvn0msVpDvvhjd+JDHyacH8n7WvH24Y07q4PLKRAbl5TsBQQ+
         4dGdv0X3We8Eu7azacKgYMP1Afg6katYq5JDmrL/EZLuyOe0g9HSErbePpzcO1TP3tD9
         jnNziCe3ORWbqUWPRUgbqBhvw2/+wADR+uy2ohi9MhKnRM5g8ewv+W58WIrdN9fq7Qom
         nBJKWsrfb+LvhcddfK0j5aXi3jrIYZUgSQ+JZtAQWrjP4F/tbMpfpaR0bePiHxyaRHVs
         V12g==
X-Gm-Message-State: AKGB3mJX/kXnB7vKjOJowdffKd4HV3G8UR79e+0VrLcjr9YOjVHnI9xW
        CoYXMvF7QdqP2Nj8wXC22gqWv6y6
X-Google-Smtp-Source: ACJfBouDjnFHEcYLmtV0lL/y1ZV8ozTt4ERjGXOT+rz1GqH90ciVC+xwrS9WggNcaWx4nrHF7hLLww==
X-Received: by 10.80.195.85 with SMTP id q21mr7896295edb.1.1513178036510;
        Wed, 13 Dec 2017 07:13:56 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:55 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/8] perf/aggregate: implement codespeed JSON output
Date:   Wed, 13 Dec 2017 16:13:39 +0100
Message-Id: <20171213151344.2138-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Codespeed (https://github.com/tobami/codespeed/) is an open source
project that can be used to track how some software performs over
time. It stores performance test results in a database and can show
nice graphs and charts on a web interface.

As it can be interesting to Codespeed to see how Git performance
evolves over time and releases, let's implement a Codespeed output
in "perf/aggregate.perl".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 68 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 3609cb5dc3..6e15f62a9e 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -35,10 +35,15 @@ sub format_times {
 	return $out;
 }
 
-my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests);
+my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests, $codespeed);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
+	if ($arg eq "--codespeed") {
+		$codespeed = 1;
+		shift @ARGV;
+		next;
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -70,8 +75,10 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
+my $results_section = "";
 if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
 	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
+	$results_section = $ENV{GIT_PERF_SUBSECTION};
 }
 
 my @subtests;
@@ -174,6 +181,63 @@ sub print_default_results {
 	}
 }
 
+sub print_codespeed_results {
+	my ($results_section) = @_;
+
+	my $project = "Git";
+
+	my $executable;
+	if ($results_section eq "") {
+		$executable = `uname -o -p`;
+	} else {
+		$executable = $results_section;
+		chomp $executable;
+	}
+
+	my $environment;
+	if (exists $ENV{GIT_TEST_REPO_NAME} and $ENV{GIT_TEST_REPO_NAME} ne "") {
+		$environment = $ENV{GIT_TEST_REPO_NAME};
+	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
+		$environment = $ENV{GIT_TEST_INSTALLED};
+		$environment =~ s|/bin-wrappers$||;
+	} else {
+		$environment = `uname -r`;
+		chomp $environment;
+	}
+
+	my @data;
+
+	for my $t (@subtests) {
+		for my $d (@dirs) {
+			my $commitid = $prefixes{$d};
+			$commitid =~ s/^build_//;
+			$commitid =~ s/\.$//;
+			my ($result_value, $u, $s) = get_times("$resultsdir/$prefixes{$d}$t.times");
+
+			my %vals = (
+				"commitid" => $commitid,
+				"project" => $project,
+				"branch" => $dirnames{$d},
+				"executable" => $executable,
+				"benchmark" => $shorttests{$t} . " " . read_descr("$resultsdir/$t.descr"),
+				"environment" => $environment,
+				"result_value" => $result_value,
+			    );
+			push @data, \%vals;
+		}
+	}
+
+	#use Data::Dumper qw/ Dumper /;
+	#print Dumper(\@data);
+
+	use JSON;
+	print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
+}
+
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
 
-print_default_results();
+if ($codespeed) {
+	print_codespeed_results($results_section);
+} else {
+	print_default_results();
+}
-- 
2.15.1.361.g8b07d831d0

