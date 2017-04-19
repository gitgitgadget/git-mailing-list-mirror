Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57CFE1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 06:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933237AbdDSGtu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 02:49:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35249 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933224AbdDSGts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 02:49:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so1860273wrc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lyCwqZ1btC+ITquk6VTDGDYM3N4EZuWJ1gMXgxWGJig=;
        b=pd/X1A6wP+Pepp9gC9+PH+TKAa3zyil4x5tqYNs8ONmEXPj4XovGq76WYQBQrUGKU2
         RR+cRpCbB9APCsxtZ8QMTtZWwDZvGlNrZIN2Na+SgaiMnTy5xlMnoF6xMIyWI8NszWDl
         0mKUqyKKF8ZDNxBg+GgImNm9natJusrTU70ExC7Ey7TJf0VkaSDtTq9QMjvaMTAnpMkR
         z9IF9QaYY95+qfgzorcPgBUh/YqcVS+/tvGz1g/dMWBjE5ER3dUUznibtuXMx1fh4F/Z
         O/oMfbbt5AcYDen9RmRekbZZsDzM7LN8p+hPZ7fE+t5uzejl19Qj2hvgfFIhZCLfzGYo
         ksuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lyCwqZ1btC+ITquk6VTDGDYM3N4EZuWJ1gMXgxWGJig=;
        b=PORH5olnPzNRg+OsXb5Fuw79LrEBTC0NbzoFUYjVw7aNK1YVzKmavCuUq0J5zXnbwK
         1/SeKKfXQrGmOm3zz8laDuEKdF2SNC6lh4zfBvG8lxjx1lunbQXMPFVDMg4rksftdf62
         Xo8BK9HdYuyKZ66y9bS3bHdFi1bNe+cd/c+RtqUnV0NvYX+H1YGhOAQc05YHcBKf8sRT
         ZQYcz2R7vLrXLwl0FcyxRe364daDx9pkO+zSdzs7kl25jfkc3CLLLReQu6Y5sgj2wuqQ
         u/bYwia3DnW+KRBeovcCUuxYr0PkOYpkY2Yuq/pi0lr68lW/L8T6ylKubcK1drjSZG9J
         jOJg==
X-Gm-Message-State: AN3rC/7DLcPY+vAB7PCKjLN7eWWCSFLLG62gY+2rlzUEdWnNWhFGKIbn
        m6r0xCSedqDJGw==
X-Received: by 10.223.148.7 with SMTP id 7mr1151918wrq.65.1492584586740;
        Tue, 18 Apr 2017 23:49:46 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id m4sm1979568wrm.4.2017.04.18.23.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 23:49:45 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] gitweb: infrastructure for tags feed
Date:   Wed, 19 Apr 2017 08:49:15 +0200
Message-Id: <20170419064916.18663-2-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.822.g5451c77231
In-Reply-To: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
References: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl | 79 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7cf68f07b7..4adea84006 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3807,6 +3807,7 @@ sub git_get_tags_list {
 
 		if ($type eq "tag" || $type eq "commit") {
 			$ref_item{'epoch'} = $epoch;
+			$ref_item{'tz'} = $tz;
 			if ($epoch) {
 				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
 			} else {
@@ -8132,6 +8133,10 @@ sub git_shortlog {
 
 sub git_feed {
 	my $format = shift || 'atom';
+
+	# feed context: log, tags
+	my $ctx = shift || 'log';
+
 	my $have_blame = gitweb_check_feature('blame');
 
 	# Atom: http://www.atomenabled.org/developers/syndication/
@@ -8140,9 +8145,19 @@ sub git_feed {
 		die_error(400, "Unknown web feed format");
 	}
 
+	if ($ctx ne 'log' && $ctx ne 'tags') {
+		die_error(400, "Unknown web feed context");
+	}
+	my $tags = $ctx eq 'tags' ? 1 : 0;
+
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
 	my $head = $hash || 'HEAD';
-	my @commitlist = parse_commits($head, 150, 0, $file_name);
+	my @commitlist;
+	if ($tags) {
+		@commitlist = git_get_tags_list(15);
+	} else {
+		@commitlist = parse_commits($head, 150, 0, $file_name);
+	}
 
 	my %latest_commit;
 	my %latest_date;
@@ -8154,9 +8169,12 @@ sub git_feed {
 	}
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
-		my $latest_epoch = $latest_commit{'committer_epoch'};
+		my $latest_epoch = $tags ? $latest_commit{'epoch'} :
+					   $latest_commit{'committer_epoch'};
 		exit_if_unmodified_since($latest_epoch);
-		%latest_date = parse_date($latest_epoch, $latest_commit{'committer_tz'});
+		%latest_date = parse_date($latest_epoch,
+			$tags ? $latest_commit{'tz'} :
+				$latest_commit{'committer_tz'});
 	}
 	print $cgi->header(
 		-type => $content_type,
@@ -8171,7 +8189,9 @@ sub git_feed {
 	# header variables
 	my $title = "$site_name - $project/$action";
 	my $feed_type = 'log';
-	if (defined $hash) {
+	if ($tags) {
+		$feed_type = 'tags';
+	} elsif (defined $hash) {
 		$title .= " - '$hash'";
 		$feed_type = 'branch log';
 		if (defined $file_name) {
@@ -8189,6 +8209,7 @@ sub git_feed {
 		$descr = esc_html($descr);
 	} else {
 		$descr = "$project " .
+			 ($tags ? 'tags ' : '') .
 		         ($format eq 'rss' ? 'RSS' : 'Atom') .
 		         " feed";
 	}
@@ -8197,7 +8218,9 @@ sub git_feed {
 
 	#header
 	my $alt_url;
-	if (defined $file_name) {
+	if ($tags) {
+		$alt_url = href(-full=>1, action=>"tags");
+	} elsif (defined $file_name) {
 		$alt_url = href(-full=>1, action=>"history", hash=>$hash, file_name=>$file_name);
 	} elsif (defined $hash) {
 		$alt_url = href(-full=>1, action=>"log", hash=>$hash);
@@ -8261,9 +8284,15 @@ XML
 	}
 
 	# contents
+	my $co_action = $tags ? 'tag' : 'commitdiff';
 	for (my $i = 0; $i <= $#commitlist; $i++) {
+		my %clco; # commit info from commitlist, only used for tags
 		my %co = %{$commitlist[$i]};
 		my $commit = $co{'id'};
+		if ($tags) {
+			%clco = %co;
+			%co = parse_tag($commit);
+		}
 		# we read 150, we always show 30 and the ones more recent than 48 hours
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
@@ -8271,44 +8300,52 @@ XML
 		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
 
 		# get list of changed files
-		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			$co{'parent'} || "--root",
-			$co{'id'}, "--", (defined $file_name ? $file_name : ())
-			or next;
-		my @difftree = map { chomp; $_ } <$fd>;
-		close $fd
-			or next;
+		my @difftree;
+		unless ($tags) {
+			open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+				$co{'parent'} || "--root",
+				$co{'id'}, "--", (defined $file_name ? $file_name : ())
+				or next;
+			@difftree = map { chomp; $_ } <$fd>;
+			close $fd
+				or next;
+		}
+
+		my $co_hash = $tags ? $clco{'name'} : $commit;
+		my $co_url = href(-full=>1, action=>$co_action, hash=>$co_hash);
+		my $co_title = esc_html($tags ? $clco{'subject'} : $co{'title'});
 
 		# print element (entry, item)
-		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
 		if ($format eq 'rss') {
 			print "<item>\n" .
-			      "<title>" . esc_html($co{'title'}) . "</title>\n" .
+			      "<title>" . $co_title . "</title>\n" .
 			      "<author>" . esc_html($co{'author'}) . "</author>\n" .
 			      "<pubDate>$cd{'rfc2822'}</pubDate>\n" .
 			      "<guid isPermaLink=\"true\">$co_url</guid>\n" .
 			      "<link>$co_url</link>\n" .
-			      "<description>" . esc_html($co{'title'}) . "</description>\n" .
+			      "<description>" . $co_title . "</description>\n" .
 			      "<content:encoded>" .
 			      "<![CDATA[\n";
 		} elsif ($format eq 'atom') {
 			print "<entry>\n" .
-			      "<title type=\"html\">" . esc_html($co{'title'}) . "</title>\n" .
+			      "<title type=\"html\">" . $co_title . "</title>\n" .
 			      "<updated>$cd{'iso-8601'}</updated>\n" .
 			      "<author>\n" .
 			      "  <name>" . esc_html($co{'author_name'}) . "</name>\n";
 			if ($co{'author_email'}) {
 				print "  <email>" . esc_html($co{'author_email'}) . "</email>\n";
 			}
-			print "</author>\n" .
+			print "</author>\n";
+			unless ($tags) {
 			      # use committer for contributor
-			      "<contributor>\n" .
+			      print "<contributor>\n" .
 			      "  <name>" . esc_html($co{'committer_name'}) . "</name>\n";
-			if ($co{'committer_email'}) {
+			}
+			if (!$tags && $co{'committer_email'}) {
 				print "  <email>" . esc_html($co{'committer_email'}) . "</email>\n";
 			}
-			print "</contributor>\n" .
-			      "<published>$cd{'iso-8601'}</published>\n" .
+			print "</contributor>\n" unless $tags;
+			print "<published>$cd{'iso-8601'}</published>\n" .
 			      "<link rel=\"alternate\" type=\"text/html\" href=\"$co_url\" />\n" .
 			      "<id>$co_url</id>\n" .
 			      "<content type=\"xhtml\" xml:base=\"" . esc_url($my_url) . "\">\n" .
-- 
2.12.2.822.g5451c77231

