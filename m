Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4B11F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbdLMPOA (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:14:00 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43797 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbdLMPN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:13:57 -0500
Received: by mail-wm0-f68.google.com with SMTP id n138so5693182wmg.2
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fKwKfZVFLxztnBpNny8YKb7n0Ha5cvesi50Ost7/mH8=;
        b=gny3QL9493IsJrbiuvTzlANqXJHDY+/j6JH5tThEZgLEyGRLsgR33e9dNBnOG2vcxm
         aRzuEZ57lIfuGsOWbAOWjxninT9RimHe77MJEnJKWHdDn8TQpSECN5WUGJp/VtTI82mr
         1ocB1K4pZQhxggOJGawn2wt9Gb2UkphTlcWGbiYc11pL7kmcYW+2xfcL5uyCvD28OvNl
         YdeMnJMLX7IDGF4ziJxgoEvINazkaMBAmr9FnL3h5cCPSZr9XayRu7bImq3mzp/tZdZ3
         QrdR1XAXV3ver2Ip+R+sN6bWT6wNtjrEPsGa3ZPEIG7d402scVVX3oVd1QJ3enVAyDBh
         CwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fKwKfZVFLxztnBpNny8YKb7n0Ha5cvesi50Ost7/mH8=;
        b=YLpdFuhJnZOTmOH9yHc+UPaxtrpZtmGDNyOc5H61YPldFQjgauutj+F6EtjTiM52gI
         IFFo6rHwm9yakO6WDOd1dtXUORhS+AX5hpwNJ/ybjWJFaAoQ0E8i+waKABRYahNDCLca
         /fk4nERI1v5Nr0dS6itpedamBF5raOW9nXhiEsDgvgW0hNHQOfjDmM0aDf47W85bwEmq
         Zlg38uRmkvmuN3EoeqAbR3QoRcIDP4J7Q0w6YaC8EI4wkGUaEWY+JI1DTRGZ9gEDdRcx
         MXTrQz1qLrtQcnMHKnRYVEOun2Bmv6Cq42hxsRpUNUEpmhyL+z1jnkA/4KJUWS+FK1jV
         Hg+Q==
X-Gm-Message-State: AKGB3mLHfCPfEUeGSLyR/P1LRH6zqMHxMG1PpFyOLu65F54nh/lwLbqN
        9NMbO2xIuCONTsQxtcCcoydmAEDb
X-Google-Smtp-Source: ACJfBovkCl2MvHTYL8zH/c7SOYtS1kpu1ZUoMBtSEqKJKrnSyjVhFoAosr7QRFXkBSPmSoLFNjAddQ==
X-Received: by 10.80.215.89 with SMTP id i25mr8406925edj.274.1513178035456;
        Wed, 13 Dec 2017 07:13:55 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:54 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/8] perf/aggregate: refactor printing results
Date:   Wed, 13 Dec 2017 16:13:38 +0100
Message-Id: <20171213151344.2138-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 96 +++++++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 769d418708..3609cb5dc3 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -100,13 +100,6 @@ sub read_descr {
 	return $line;
 }
 
-my %descrs;
-my $descrlen = 4; # "Test"
-for my $t (@subtests) {
-	$descrs{$t} = $shorttests{$t}.": ".read_descr("$resultsdir/$t.descr");
-	$descrlen = length $descrs{$t} if length $descrs{$t}>$descrlen;
-}
-
 sub have_duplicate {
 	my %seen;
 	for (@_) {
@@ -122,54 +115,65 @@ sub have_slash {
 	return 0;
 }
 
-my %newdirabbrevs = %dirabbrevs;
-while (!have_duplicate(values %newdirabbrevs)) {
-	%dirabbrevs = %newdirabbrevs;
-	last if !have_slash(values %dirabbrevs);
-	%newdirabbrevs = %dirabbrevs;
-	for (values %newdirabbrevs) {
-		s{^[^/]*/}{};
+sub print_default_results {
+	my %descrs;
+	my $descrlen = 4; # "Test"
+	for my $t (@subtests) {
+		$descrs{$t} = $shorttests{$t}.": ".read_descr("$resultsdir/$t.descr");
+		$descrlen = length $descrs{$t} if length $descrs{$t}>$descrlen;
 	}
-}
 
-my %times;
-my @colwidth = ((0)x@dirs);
-for my $i (0..$#dirs) {
-	my $d = $dirs[$i];
-	my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
-	$colwidth[$i] = $w if $w > $colwidth[$i];
-}
-for my $t (@subtests) {
-	my $firstr;
+	my %newdirabbrevs = %dirabbrevs;
+	while (!have_duplicate(values %newdirabbrevs)) {
+		%dirabbrevs = %newdirabbrevs;
+		last if !have_slash(values %dirabbrevs);
+		%newdirabbrevs = %dirabbrevs;
+		for (values %newdirabbrevs) {
+			s{^[^/]*/}{};
+		}
+	}
+
+	my %times;
+	my @colwidth = ((0)x@dirs);
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		my $w = length format_times($r,$u,$s,$firstr);
+		my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
 		$colwidth[$i] = $w if $w > $colwidth[$i];
-		$firstr = $r unless defined $firstr;
 	}
-}
-my $totalwidth = 3*@dirs+$descrlen;
-$totalwidth += $_ for (@colwidth);
-
-binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+	for my $t (@subtests) {
+		my $firstr;
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
+			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+			my $w = length format_times($r,$u,$s,$firstr);
+			$colwidth[$i] = $w if $w > $colwidth[$i];
+			$firstr = $r unless defined $firstr;
+		}
+	}
+	my $totalwidth = 3*@dirs+$descrlen;
+	$totalwidth += $_ for (@colwidth);
 
-printf "%-${descrlen}s", "Test";
-for my $i (0..$#dirs) {
-	my $d = $dirs[$i];
-	printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
-}
-print "\n";
-print "-"x$totalwidth, "\n";
-for my $t (@subtests) {
-	printf "%-${descrlen}s", $descrs{$t};
-	my $firstr;
+	printf "%-${descrlen}s", "Test";
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
-		$firstr = $r unless defined $firstr;
+		printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
 	}
 	print "\n";
+	print "-"x$totalwidth, "\n";
+	for my $t (@subtests) {
+		printf "%-${descrlen}s", $descrs{$t};
+		my $firstr;
+		for my $i (0..$#dirs) {
+			my $d = $dirs[$i];
+			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+			printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
+			$firstr = $r unless defined $firstr;
+		}
+		print "\n";
+	}
 }
+
+binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+
+print_default_results();
-- 
2.15.1.361.g8b07d831d0

