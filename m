Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583941F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeCPKN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 06:13:59 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:33181 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeCPKN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 06:13:57 -0400
Received: from lindisfarne.localdomain ([92.22.2.60])
        by smtp.talktalk.net with SMTP
        id wmMuefAH1C0WbwmN0espwO; Fri, 16 Mar 2018 10:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521195235;
        bh=uDcNj50cgrFJIAM3yp/5m+7OT5SJRPB11qUhtEoj+HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=T8SZh70Yh4OCpNmhCuqcZ3VbAqasTkP6j8DPr2XOMZj576FvWDaBDjN9skNL47YqP
         O1nB/FRZEal77tUmqA35MDdXio2zmkb3ePYzLwlwj3UCtcQrSW45NxMaXlrw2kS/tZ
         sYtvACXgtsULcZiIdei9DzT9lDbvT3ahvG8Xn1Tw=
X-Originating-IP: [92.22.2.60]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=pcfIiQRzx6UxJOplHTSsng==:117
 a=pcfIiQRzx6UxJOplHTSsng==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=vZxbLtyPAAAA:8 a=fPcIgsD2O02UIh48eRIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=Y9S9A-nIRBK2sq-f:21 a=9TPxIhVsPFXsXNIm:21 a=RfR_gqz1fSpA9VikTjo0:22
 a=PwKx63F5tFurRwaNxrlG:22 a=YIznc7gRMHvxYRuyG5Sm:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/3] add -p: select individual hunk lines
Date:   Fri, 16 Mar 2018 10:13:43 +0000
Message-Id: <20180316101346.7137-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJi55mw+sGMxRGRRon2LcCVnYgsxEbXE+paEd/M/gxlepCkEEQ02n+Ot80YBNaqvYbA9wL20sp/aI6XobGwZjolDIaF63OEdslTc8Fu/8sDuWH0GZQZ9
 u+O+G4TTmLUpkS5ura4zWgB0Q3OH+CNfjoJXINK+JAdF7XRnV1m9Q3mOjQ/t4bUdzwD+4CjDlJhP51cjiGFeo9hjST8sVPYm1DA/fTdAqucJKo0yjqOjmpSv
 PQtV5bBdRcjpL+uaKSVPmmydivY7PnqyLsH5N9B5eIlXMWyIkaA7mVlPSlwQ4NMkt/BxDArr0lpSCJUtd6Mpj/1+nIZvifrgQu2p6Dsr9kQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since v2 I've updated the patches to use '-' instead of '^' to invert
the selection to match the rest of add -i and clean -i.

These patches build on top of the recount fixes in [1]. The commit
message for the first patch describes the motivation:

"When I end up editing hunks it is almost always because I want to
stage a subset of the lines in the hunk. Doing this by editing the
hunk is inconvenient and error prone (especially so if the patch is
going to be reversed before being applied). Instead offer an option
for add -p to stage individual lines. When the user presses 'l' the
hunk is redrawn with labels by the insertions and deletions and they
are prompted to enter a list of the lines they wish to stage. Ranges
of lines may be specified using 'a-b' where either 'a' or 'b' may be
omitted to mean all lines from 'a' to the end of the hunk or all lines
from 1 upto and including 'b'."

[1] https://public-inbox.org/git/xmqqbmg29x1n.fsf@gitster-ct.c.googlers.com/T/#m01d0f1af90f32b698e583b56f8e53b986bcec7c6

Interdiff to v2:
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d52acfc722..f3c81dfb11 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -337,13 +337,14 @@ patch::
        e - manually edit the current hunk
        ? - print help
 +
-If you press "l" then the hunk will be reprinted with each insertion
-or deletion labelled with a number and you will be prompted to enter
-which lines you wish to select. Individual line numbers should be
-separated by a space or comma (these can be omitted if there are fewer
-than ten labelled lines), to specify a range of lines use a dash
-between them. To invert the selection prefix it with "\^" so "^3-5,8"
-will select everything except lines 3, 4, 5 and 8.
+If you press "l" then the hunk will be reprinted with each insertion or
+deletion labelled with a number and you will be prompted to enter which
+lines you wish to select. Individual line numbers should be separated by
+a space or comma (these can be omitted if there are fewer than ten
+labelled lines), to specify a range of lines use a dash between them. If
+the upper bound of a range of lines is omitted it defaults to the last
+line. To invert the selection prefix it with "-" so "-3-5,8" will select
+everything except lines 3, 4, 5 and 8.
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 9a6bcd5085..d65ad7c26d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1087,10 +1087,6 @@ sub split_hunk_selection {
 	my @fields = @_;
 	my @ret;
 	for (@fields) {
-		if (/^(-[0-9])(.*)/) {
-			push @ret, $1;
-			$_ = $2;
-		}
 		while ($_ ne '') {
 			if (/^[0-9]-$/) {
 				push @ret, $_;
@@ -1115,7 +1111,7 @@ sub parse_hunk_selection {
 	my ($max_label, $invert) = ($hunk->{MAX_LABEL}, undef);
 	my @selected = (0) x ($max_label + 1);
 	my @fields = split(/[,\s]+/, $line);
-	if ($fields[0] =~ /^\^(.*)/) {
+	if ($fields[0] =~ /^-(.*)/) {
 		$invert = 1;
 		if ($1 ne '') {
 			$fields[0] = $1;
@@ -1131,13 +1127,10 @@ sub parse_hunk_selection {
 		@fields = split_hunk_selection(@fields) or return undef;
 	}
 	for (@fields) {
-		if (/^([0-9]*)-([0-9]*)$/) {
-			if ($1 eq '' and $2 eq '') {
-				error_msg __("range '-' missing upper or lower bound\n");
-				return undef;
+		if (my ($lo, $hi) = /^([0-9]+)-([0-9]*)$/) {
+			if ($hi eq '') {
+				$hi = $max_label;
 			}
-			my $lo = $1 eq '' ? 1 : $1;
-			my $hi = $2 eq '' ? $max_label : $2;
 			check_hunk_label($hunk, $lo) or return undef;
 			check_hunk_label($hunk, $hi) or return undef;
 			if ($hi < $lo) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d3bce154da..467c6eff0e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -383,7 +383,7 @@ test_expect_success 'setup expected diff' '
 test_expect_success 'can stage individual lines of patch' '
 	git reset &&
 	printf 61 >>test &&
-	printf "%s\n" l "-2 4" |
+	printf "%s\n" l "1,2 4-" |
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
@@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l ^13 |
+	printf "%s\n" l -13 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&


Phillip Wood (3):
  add -p: select individual hunk lines
  add -p: allow line selection to be inverted
  add -p: optimize line selection for short hunks

 Documentation/git-add.txt  |  10 +++
 git-add--interactive.perl  | 181 +++++++++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  65 ++++++++++++++++
 3 files changed, 256 insertions(+)

-- 
2.16.2

