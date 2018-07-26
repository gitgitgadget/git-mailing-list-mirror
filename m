Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238A31F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbeGZRX4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:23:56 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:45350 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbeGZRXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:23:55 -0400
Received: from lindisfarne.localdomain ([89.242.182.230])
        by smtp.talktalk.net with SMTP
        id iimGfHvLPoI6LiimWfsryr; Thu, 26 Jul 2018 17:06:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532621184;
        bh=IMBHT8Ad0nfGUS8Yp8Rttqtpz+VvAxv9i7/r7xlXvWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=AlZ9EOOMHoaHHCGKSY/UzQCKL1NdvmliMjPp9FKpCxCTcZU6HV6QDWLj43yN+x2CR
         jS90NpVH4lu1xkwRSutckcFL4pJyRmGpW8Zey0RAIScykOlR0zzyoh0MAM3EGs/Dzr
         jSm6fJ+vgBiuHSm7F1PCd8AFFDoUYCcRn+piZU+Y=
X-Originating-IP: [89.242.182.230]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=tQBg3IHG1C6KDs2Ec9TG5Q==:117
 a=tQBg3IHG1C6KDs2Ec9TG5Q==:17 a=evINK-nbAAAA:8 a=AYlvAQ_5uU6KR0DxsCcA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=j6ol63fQbFhTYyq0:21 a=FjtkH5aydcWljJhY:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 3/4] add -p: allow line selection to be inverted
Date:   Thu, 26 Jul 2018 16:58:53 +0100
Message-Id: <20180726155854.20832-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726155854.20832-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfETtKrC4aUFTmSgqhS+nIthsSi4Kqj8RNt5bg2otOFzguMJqMWOkzZdrUk775fFGONGaG5hOE8mS5E8OsrCGRHvW/xQ4dLUG+R2uDf47Yb4eFv58qlJb
 WNJzqwgU85mu3r75JRWzXf8r3k2mZT8qqF5wFP4pEX37g/nN50g/vTlB/2JJc9s2Amaw0TPSo5Y4Ra0mUkgP7GAazopgtmGA2XVJnf7Vjh5XRDdoDiiqkrOA
 oS4T6VTI8qcRdGxeUFf72bf5qZWMLk3O9jCwiYlCX1qJ+eH8gQyrqNfZeF+dY2R2mKdy5grZQavvF7GuM8f3zieREc/OfzQvXIP+OzlY2Y8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the list of lines to be selected begins with '-' select all the
lines except the ones listed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-add.txt  |  3 ++-
 git-add--interactive.perl  | 19 +++++++++++++++++++
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 965e192a09..01ff4d7d24 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -342,7 +342,8 @@ deletion labelled with a number and you will be prompted to enter which
 lines you wish to select. Individual line numbers should be separated by
 a space or comma, to specify a range of lines use a dash between
 them. If the upper bound of a range of lines is omitted it defaults to
-the last line.
+the last line. To invert the selection prefix it with "-" so "-3-5,8"
+will select everything except lines 3, 4, 5 and 8.
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 7e4daee2fc..63541d0f90 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1247,8 +1247,21 @@ sub parse_hunk_selection {
 	my ($hunk, $line) = @_;
 	my $lines = $hunk->{LABELS}->{LINES};
 	my $max_label = $#{$lines};
+	my $invert = undef;
 	my %selected;
 	my @fields = split(/[,\s]+/, $line);
+	if (my ($rest) = ($fields[0] =~ /^-(.*)/)) {
+		$invert = 1;
+		if ($rest ne '') {
+			$fields[0] = $rest;
+		} else {
+			shift @fields;
+			unless (@fields) {
+				error_msg __("no lines to invert\n");
+				return undef;
+			}
+		}
+	}
 	for my $f (@fields) {
 		if (my ($lo, $hi) = ($f =~ /^([0-9]+)-([0-9]*)$/)) {
 			if ($hi eq '') {
@@ -1268,6 +1281,12 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
+	if ($invert) {
+		my %inverted;
+		undef @inverted{1..$max_label};
+		delete @inverted{keys(%selected)};
+		%selected = %inverted;
+	}
 	return process_hunk_selection($hunk, keys(%selected));
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 1d917ad018..2fd456017f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -457,7 +457,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l 4,1,3 |
+	printf "%s\n" l -6,2,5 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.18.0

