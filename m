Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E887F1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeCFKSD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:18:03 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:58991 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeCFKSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:18:01 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id t9fNelwjTlYtpt9fTexEqF; Tue, 06 Mar 2018 10:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520331479;
        bh=M6nco/dDdJtzeZINIU5NdAnRFXqrBuFYDfIDz4ypg4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=DzYSG5YLRWRSuPQap5g0hqpCfiuW/OkE0rJiorDgYv3weNRmuGR9/jG7cf6JgrJG6
         Do5sGmEkNGFTq6WxvIdosGcWqRenrOnklg10QJBdvReAVYRHlx8IqwDyqADrLXkzJz
         L+oUazGuhMOcl1BYjVpTaQbYar4uKRQKt9ddwCHA=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=AYlvAQ_5uU6KR0DxsCcA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=oPOlmhkpbYbxQVkh:21 a=Wx_OaTHVyFH6t0yk:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/3] add -p: allow line selection to be inverted
Date:   Tue,  6 Mar 2018 10:17:49 +0000
Message-Id: <20180306101750.18794-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306101750.18794-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHYtYQHf2D2GAnHM+e11lwl8xMn9Crl2cm1YQUWX/LAbZ/AhaaSzdkNGr5+k+/ko/oJc7hZ8tZpuibDZJod/rl6u6fnMyUzk+nL/NocA0xjhi98qXgr2
 deig4AhCdeBwu+nqpmT5/K8WECR5hZQhLPu+jiR3+1bHE1lDm12UwcMshYXknsw5m35I+cp6KOXmt2RldOLGEladkklhM1pQApuf2mEcOrupTcGAXnrNuHQv
 oQkLkAaJ9UeR/2i0vT6OtiWskmM1f36ZfoFnqiosNlbRNfKwThc3NsGGYdwHAifN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the list of lines to be selected begins with '^' select all the
lines except the ones listed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-add.txt  |  3 ++-
 git-add--interactive.perl  | 17 ++++++++++++++++-
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ad33fda9a2..0e2c11e97b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -341,7 +341,8 @@ If you press "l" then the hunk will be reprinted with each insertion
 or deletion labelled with a number and you will be prompted to enter
 which lines you wish to select. Individual line numbers should be
 separated by a space or comma, to specify a range of lines use a dash
-between them.
+between them. To invert the selection prefix it with "\^" so "^3-5,8"
+will select everything except lines 3, 4, 5 and 8.
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a273b41e95..6fa3d0a87c 100755
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
+	if ($fields[0] =~ /^\^(.*)/) {
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
 		if (/^([0-9]*)-([0-9]*)$/) {
 			if ($1 eq '' and $2 eq '') {
@@ -1110,6 +1122,9 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
+	if ($invert) {
+		@selected = map { !$_ } @selected;
+	}
 	return \@selected;
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65c8c3354b..89c0e73f2b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l 2 |
+	printf "%s\n" l "^1 3" |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.16.2

