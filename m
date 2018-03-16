Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33941F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeCPKOH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 06:14:07 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:31837 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeCPKN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 06:13:57 -0400
Received: from lindisfarne.localdomain ([92.22.2.60])
        by smtp.talktalk.net with SMTP
        id wmMuefAH1C0WbwmN2espwZ; Fri, 16 Mar 2018 10:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521195236;
        bh=j3qkYszxrlx5LN+wGI6b4NsYx+EVusIiRVptX5Qh9yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SXr50BB1v2NFWrv5OnU/4eVSo7drh1jN6gSvyX6cjIJ9mjbzXOM/hLZQ1S2b0ETKB
         MJEtZ+x/FvXmLQKpLrGZAxHzH8oDJ4kHFcym6ecommtrRyKwgVRF1TwdpY9gAwn+yk
         eFCYbg7Rd73CgF8QmMjXIFitXVssWs0AY/mR/5BY=
X-Originating-IP: [92.22.2.60]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=pcfIiQRzx6UxJOplHTSsng==:117
 a=pcfIiQRzx6UxJOplHTSsng==:17 a=evINK-nbAAAA:8 a=AYlvAQ_5uU6KR0DxsCcA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=ZL07o4cLyB1067NK:21 a=MlVOGJ78PxrSdl1w:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 2/3] add -p: allow line selection to be inverted
Date:   Fri, 16 Mar 2018 10:13:45 +0000
Message-Id: <20180316101346.7137-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316101346.7137-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180316101346.7137-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPwJZMM99MjpD9xfwZJVlUqj2t6LbiDD4fzaymXk/iv41QKDvKvPaBSZuzEgGA9+aWg8P1h0I4ob7RA47XIik/0/mAW7QSgphI+B8Fl87gELvhgej5oy
 L0lgL7/Bp7jQ05IOYRy5MG5qGDPQfeRfWoKmgWQDbvPao+RehKwkG2MpAzq5VDHcsOnuk0H9QlAbYQK4RqbdzvfG6RYI0nbspZHH4wdkaGEGGey+2KTQ9fKT
 gZgsuUOH0T5BCDVVNVN5wBVi1zjEf9ApvcPj0KSxLfI7bpQ3/CuJzAFpi4oczNbvGP+gUdP/KCpHkA2cZXNWokhnOvNmEWKwHzvhmzwicHE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the list of lines to be selected begins with '-' select all the
lines except the ones listed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - use '-' to invert the selection instead of '^' to be consistent
       with the rest of add -i and clean -i.

 Documentation/git-add.txt  |  3 ++-
 git-add--interactive.perl  | 17 ++++++++++++++++-
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

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
index 712226b34c..54fbe114f3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1085,9 +1085,21 @@ sub check_hunk_label {
 sub parse_hunk_selection {
 	local $_;
 	my ($hunk, $line) = @_;
-	my $max_label = $hunk->{MAX_LABEL};
+	my ($max_label, $invert) = ($hunk->{MAX_LABEL}, undef);
 	my @selected = (0) x ($max_label + 1);
 	my @fields = split(/[,\s]+/, $line);
+	if ($fields[0] =~ /^-(.*)/) {
+		$invert = 1;
+		if ($1 ne '') {
+			$fields[0] = $1;
+		} else {
+			shift @fields;
+			unless (@fields) {
+				error_msg __("no lines to invert\n");
+				return undef;
+			}
+		}
+	}
 	for (@fields) {
 		if (my ($lo, $hi) = /^([0-9]+)-([0-9]*)$/) {
 			if ($hi eq '') {
@@ -1107,6 +1119,9 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
+	if ($invert) {
+		@selected = map { !$_ } @selected;
+	}
 	return \@selected;
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5f3fcb1758..46814babf3 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l 2 |
+	printf "%s\n" l "-1 3" |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.16.2

