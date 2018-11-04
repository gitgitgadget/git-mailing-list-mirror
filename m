Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235D21F453
	for <e@80x24.org>; Sun,  4 Nov 2018 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeKDQg6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 11:36:58 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36048 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKDQg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 11:36:58 -0500
Received: by mail-lj1-f173.google.com with SMTP id s15-v6so5236411lji.3
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEgH5PkL59cCr6dCdeAsyCooGDQ5oqCtoEV366lbf2M=;
        b=t0KT+lEKTqzwc+ks4mLEUIownguVVnRiPiZd7dcFq01I7LgaXBcUurle2ITTBxTB2a
         TaM4QSGcwCgjNudLcbe1kiLZniX8bxaaJKccK0jTHjR3omSt2DisSEvRlyyil/nOrvOm
         7wFMSFqE56Txpe3CFyNJtXHd20Z77J13gP2d8DjCTo5iSh8Mq0QV2iW1XbEHcZLzYOY+
         An/+WG5KPErbdz8312M09thi9nRfSTfeERaZtzvWdeV+jPeN5IlJElVzLN/BA6WXgfMN
         9lR7whZW8I/y0TXr3nxf6SR2TJhkLpAesAXr8NzPxmVYMbmTwCCh7kUOgg/2cs3922L8
         ynxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEgH5PkL59cCr6dCdeAsyCooGDQ5oqCtoEV366lbf2M=;
        b=jJLDq/yneYXfBRNiCewyEjUQ1Ohq1NsoYkDWppb8B6najUlQmwjAZ7DFmus+LVZleh
         2gC4B2WEFqcwqwbU7aD0lGFjwLvZSskIAXPu6pRN9Aa3aOYbfraJ7CUiIElbpRZZYIR/
         nuVI+Kee4+OzRHHSU0SbtfnrlMjHepMiwig3zMVZswIbwQW4oXuvhew+1LWpyg6vey1P
         Fnw0h3g3QXTokl01WLwf927zW3TaS1Yn+f93jBdqaHUZl3UcYjEppRN1V5SORZespzwf
         xnJK8JTkipwQVGwUYYZeO1ZiWz/OlJml/7F1l5xzfAqhUCwH9KoxKBzyAufphePBGRgh
         1YRQ==
X-Gm-Message-State: AGRZ1gLguLR+BATRBCI7uX/LHwpJgkKopFw5K5bYHaVl1sIVZbNwFgsd
        l//Fz5LCAZbwb2Fz0xCoudyBv0IK
X-Google-Smtp-Source: AJdET5f18k5ZQG41B27xCqRsBaD75ysBwlpVKos5p1N9pBft3sl64yDPpBL91q1zRE3fvc19dNnPWw==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr12177957lje.86.1541316177876;
        Sun, 04 Nov 2018 00:22:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c5-v6sm3009355lja.62.2018.11.04.00.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 00:22:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with trailer lines
Date:   Sun,  4 Nov 2018 08:22:53 +0100
Message-Id: <20181104072253.12357-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit is reverted (or cherry-picked with -x) we add an English
sentence recording that commit id in the new commit message. Make
these real trailer lines instead so that they are more friendly to
parsers (especially "git interpret-trailers").

A reverted commit will have a new trailer

    Revert: <commit-id>

Similarly a cherry-picked commit with -x will have

    Cherry-Pick: <commit-id>

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I think standardizing how we record commit ids in the commit message
 is a good idea. Though to be honest this started because of my irk of
 an English string "cherry picked from..." that cannot be translated.
 It might as well be a computer language that happens to look like
 English.

 Documentation/git-cherry-pick.txt |  5 ++---
 sequencer.c                       | 20 ++++++--------------
 t/t3510-cherry-pick-sequence.sh   | 12 ++++++------
 t/t3511-cherry-pick-x.sh          | 26 +++++++++++++-------------
 4 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc8..8ffbaed1a0 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -58,9 +58,8 @@ OPTIONS
 	message prior to committing.
 
 -x::
-	When recording the commit, append a line that says
-	"(cherry picked from commit ...)" to the original commit
-	message in order to indicate which commit this change was
+	When recording the commit, append "Cherry-Pick:" trailer line
+	recording the commit name which commit this change was
 	cherry-picked from.  This is done only for cherry
 	picks without conflicts.  Do not use this option if
 	you are cherry-picking from your private branch because
diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..f7318f2862 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,7 +36,6 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 const char sign_off_header[] = "Signed-off-by: ";
-static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
 
@@ -1758,16 +1757,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		strbuf_addstr(&msgbuf, "Revert \"");
-		strbuf_addstr(&msgbuf, msg.subject);
-		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
-		strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-
-		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
-			strbuf_addstr(&msgbuf, oid_to_hex(&parent->object.oid));
-		}
-		strbuf_addstr(&msgbuf, ".\n");
+		strbuf_addf(&msgbuf, "Revert \"%s\"\n\n", msg.subject);
+
+		strbuf_addf(&msgbuf, "Revert: %s\n",
+			    oid_to_hex(&commit->object.oid));
 	} else {
 		const char *p;
 
@@ -1784,9 +1777,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_complete_line(&msgbuf);
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-			strbuf_addstr(&msgbuf, ")\n");
+			strbuf_addf(&msgbuf, "Cherry-Pick: %s\n",
+				    oid_to_hex(&commit->object.oid));
 		}
 		if (!is_fixup(command))
 			author = get_author(msg.message);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c84eeefdc9..89b6e7fc1e 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -390,10 +390,10 @@ test_expect_success '--continue respects opts' '
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	! grep "cherry picked from" initial_msg &&
-	grep "cherry picked from" unrelatedpick_msg &&
-	grep "cherry picked from" picked_msg &&
-	grep "cherry picked from" anotherpick_msg
+	! grep "Cherry-Pick:" initial_msg &&
+	grep "Cherry-Pick: " unrelatedpick_msg &&
+	grep "Cherry-Pick: " picked_msg &&
+	grep "Cherry-Pick: " anotherpick_msg
 '
 
 test_expect_success '--continue of single-pick respects -x' '
@@ -404,7 +404,7 @@ test_expect_success '--continue of single-pick respects -x' '
 	git cherry-pick --continue &&
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD >msg &&
-	grep "cherry picked from" msg
+	grep "Cherry-Pick:" msg
 '
 
 test_expect_success '--continue respects -x in first commit in multi-pick' '
@@ -416,7 +416,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD^ >msg &&
 	picked=$(git rev-parse --verify picked) &&
-	grep "cherry picked from.*$picked" msg
+	grep "Cherry-Pick: $picked" msg
 '
 
 test_expect_failure '--signoff is automatically propagated to resolved conflict' '
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9888bf34b9..db11dd2430 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -32,7 +32,7 @@ mesg_with_footer_sob="$mesg_with_footer
 Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 
 mesg_with_cherry_footer="$mesg_with_footer_sob
-(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+Cherry-Pick: da39a3ee5e6b4b0d3255bfef95601890afd80709
 Tested-by: C.U. Thor <cuthor@example.com>"
 
 mesg_unclean="$mesg_one_line
@@ -81,7 +81,7 @@ test_expect_success 'cherry-pick -x inserts blank line after one line subject' '
 	cat <<-EOF >expect &&
 		$mesg_one_line
 
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
@@ -129,7 +129,7 @@ test_expect_success 'cherry-pick -x inserts blank line when conforming footer no
 	cat <<-EOF >expect &&
 		$mesg_no_footer
 
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
@@ -154,7 +154,7 @@ test_expect_success 'cherry-pick -x -s inserts blank line when conforming footer
 	cat <<-EOF >expect &&
 		$mesg_no_footer
 
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -178,7 +178,7 @@ test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match commi
 	git cherry-pick -x -s mesg-with-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -201,7 +201,7 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
 	git cherry-pick -x -s mesg-with-footer-sob &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer_sob
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
@@ -215,7 +215,7 @@ test_expect_success 'cherry-pick -x handles commits with no NL at end of message
 	git cherry-pick -x $sha1 &&
 	git log -1 --pretty=format:%B >actual &&
 
-	printf "\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	printf "\nCherry-Pick: %s\n" $sha1 >>msg &&
 	test_cmp msg actual
 '
 
@@ -226,7 +226,7 @@ test_expect_success 'cherry-pick -x handles commits with no footer and no NL at
 	git cherry-pick -x $sha1 &&
 	git log -1 --pretty=format:%B >actual &&
 
-	printf "\n\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	printf "\n\nCherry-Pick: %s\n" $sha1 >>msg &&
 	test_cmp msg actual
 '
 
@@ -252,19 +252,19 @@ test_expect_success 'cherry-pick -s handles commits with no footer and no NL at
 	test_cmp msg actual
 '
 
-test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -x treats "Cherry-Pick:" line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 	EOF
 	git log -1 --pretty=format:%B >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -s treats "Cherry-Pick:" line as part of footer' '
 	pristine_detach initial &&
 	git cherry-pick -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
@@ -275,13 +275,13 @@ test_expect_success 'cherry-pick -s treats "(cherry picked from..." line as part
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as part of footer' '
+test_expect_success 'cherry-pick -x -s treats "Cherry-Pick:..." line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
-		(cherry picked from commit $sha1)
+		Cherry-Pick: $sha1
 		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
 	EOF
 	git log -1 --pretty=format:%B >actual &&
-- 
2.19.1.1005.gac84295441

