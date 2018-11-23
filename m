Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C691F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503653AbeKWWBH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:07 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:17855 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbeKWWBG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:06 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9SUg6d24; Fri, 23 Nov 2018 11:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971834;
        bh=z9oX6mxY5hZK7Y2LnqBmzbtmAs2p3+nqqfKICwWGNPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=EGmKVRSCPIVPf6mx0SFqXbn9f3odRcxi8gyjUHHO0JeVJnTZWu/9ZX1HyS6LXqC82
         D4vMerqGj46oPQFd3G0Q0sZWbyf2ZlQaeD48v0GCrjTXBUJRu/zI55yMpmqqWJTHG/
         NOIeWxF/EUeaP3vedFOP4rholFClIbkWZUDhaBXc=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=jXCYYOxaiYF5wbv4ZvcA:9
 a=s1rkbyRdG-LNbfjc:21 a=rbZOPNKEenb8vpLT:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/9] diff --color-moved-ws: demonstrate false positives
Date:   Fri, 23 Nov 2018 11:16:53 +0000
Message-Id: <20181123111658.30342-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfL5VdPov7uGQMRUdM8eUhpqyUM5U1yv0VtIWx6/gBhCEX4Nx5bgXaHrra07C5LPbn0sOCVvY8HLWtVnW4XDVcv3cgMLbD1NTQ/8PE5RPtPzXHKFR+UkF
 /YEjMvVSAHi2ftVdxCvjCbXfsKwvHCmgLPMq6xePATB7tae2uH2I4QWkIP+Sv/V8hy+dwy9RcHuyEOowEOCr5ozCxJdogP242lzf6Cx8tIFa9tpy1zDk8HDs
 HSCmLOma6PzjSB4AAeeg0v8RWdShkbzLw5JdgqkxyBvXtlJO2vgRnTiiCF4HNhPa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

'diff --color-moved-ws=allow-indentation-change' can highlight lines
that have internal whitespace changes rather than indentation
changes. For example in commit 1a07e59c3e ("Update messages in
preparation for i18n", 2018-07-21) the lines

-               die (_("must end with a color"));
+               die(_("must end with a color"));

are highlighted as moved when they should not be. Modify an existing
test to show the problem that will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t4015-diff-whitespace.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index a9fb226c5a..eee81a1987 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1809,7 +1809,7 @@ test_expect_success 'only move detection ignores white spaces' '
 	test_cmp expected actual
 '
 
-test_expect_success 'compare whitespace delta across moved blocks' '
+test_expect_failure 'compare whitespace delta across moved blocks' '
 
 	git reset --hard &&
 	q_to_tab <<-\EOF >text.txt &&
@@ -1827,6 +1827,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 	QQQthat has similar lines
 	QQQto previous blocks, but with different indent
 	QQQYetQAnotherQoutlierQ
+	QLine with internal w h i t e s p a c e change
 	EOF
 
 	git add text.txt &&
@@ -1847,6 +1848,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 	QQthat has similar lines
 	QQto previous blocks, but with different indent
 	QQYetQAnotherQoutlier
+	QLine with internal whitespace change
 	EOF
 
 	git diff --color --color-moved --color-moved-ws=allow-indentation-change >actual.raw &&
@@ -1856,7 +1858,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD>diff --git a/text.txt b/text.txt<RESET>
 		<BOLD>--- a/text.txt<RESET>
 		<BOLD>+++ b/text.txt<RESET>
-		<CYAN>@@ -1,14 +1,14 @@<RESET>
+		<CYAN>@@ -1,15 +1,15 @@<RESET>
 		<BOLD;MAGENTA>-QIndented<RESET>
 		<BOLD;MAGENTA>-QText across<RESET>
 		<BOLD;MAGENTA>-Qsome lines<RESET>
@@ -1871,6 +1873,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD;MAGENTA>-QQQthat has similar lines<RESET>
 		<BOLD;MAGENTA>-QQQto previous blocks, but with different indent<RESET>
 		<RED>-QQQYetQAnotherQoutlierQ<RESET>
+		<RED>-QLine with internal w h i t e s p a c e change<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Indented<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Text across<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>some lines<RESET>
@@ -1885,6 +1888,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>that has similar lines<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>to previous blocks, but with different indent<RESET>
 		<GREEN>+<RESET>QQ<GREEN>YetQAnotherQoutlier<RESET>
+		<GREEN>+<RESET>Q<GREEN>Line with internal whitespace change<RESET>
 	EOF
 
 	test_cmp expected actual
-- 
2.19.1.1690.g258b440b18

