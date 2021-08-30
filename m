Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D73C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0755860FC3
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhH3HXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhH3HXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 03:23:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76020C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g9so18551987ioq.11
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhOmvYzGs055OUN7DZHisWkaDRjEAhh0iVyoGOf6s3Q=;
        b=Phl6gnuN2KjrFc/k4lR0CLyBNsxFbYBBDdDbB0Kl+RW6Ch3H/OPDFJxIyTDN88UMyt
         VHJDZX7stcqR+/UpDLu7tl6GuXCQcSMbVV7JZ2QqACyNaYEw/RP2OkqfzDRFSQ1tCA0r
         4TsX+FnUNjzwRTqWrGJRf5Sw70V+WTSJQHbqQt0gJvI4YrcemcSVUjaDdblqI1DGtt1y
         EtDSi2PhqPMbgRxAybaDiFhQiVJe7+ZV/0ISSLtktBWdvlvb9tSWjIHWjFIAM2q/m9/5
         BknVramtbC83Pjg17H2hUyG/bq2e5NSqntJp/85SJONRcH/jth63Sjm+kJ2cncLWDBOM
         o15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EhOmvYzGs055OUN7DZHisWkaDRjEAhh0iVyoGOf6s3Q=;
        b=kYYHWBkVD1FRsiQpsnb8zCULG6bCYvJ2ovFIOegEi4k4/9CDFZc1BnLNGsA502fZdE
         vZ9Ad9+zgjDi9qikY8E57czv5h1LwUTGozRX6HXHlBQtpN1271xQGw8MQ9esi65xU/hn
         s9hO8my6EDDaLTtguQNJpB8qTlkihL0HNzTLeF4P2K/q7gCpIPlDzp49M/yWb84q0uBX
         rktgmdrdFAwrk9Zc/RNQi+oL9RMC0FyYzymqUDTFaeYdnpdXp9+KqfvHjOrP2kCB1Ko9
         VYy2jzL0663ETu73YMRXsMwxwsQXlRWkLRpLXoJ8IY/aMV5HILAXHarlto1PjhdnFUBY
         rzpA==
X-Gm-Message-State: AOAM53374ESI8t6N/+989H3nu/FZsktCcOeqCHgETfqL3wb0D0Urxqjw
        zQkirV6p/Dql+l8TU5R1k8aiXsel1fk=
X-Google-Smtp-Source: ABdhPJwO02Lr6ft68xKLPKxevWQGOdDOL93IM+Bg/+Myd1DQ0StN/1apIxzW6Eo5al466/NcdUMhPg==
X-Received: by 2002:a6b:f702:: with SMTP id k2mr2347429iog.187.1630308171267;
        Mon, 30 Aug 2021 00:22:51 -0700 (PDT)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id a6sm7903840ilb.59.2021.08.30.00.22.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 00:22:50 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] t3301: tolerate minor notes-related presentation changes
Date:   Mon, 30 Aug 2021 03:21:16 -0400
Message-Id: <20210830072118.91921-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24
In-Reply-To: <20210830072118.91921-1-sunshine@sunshineco.com>
References: <20210830072118.91921-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests care about whether intended notes-related functionality
occurred and that `git log` presents the notes in the expected fashion
(or, in some cases, that `git log` suppresses the notes). However, the
tests hard-code the precise indentation of notes by the default `git
log` output, which makes them somewhat brittle since they won't be able
to tolerate even minor changes to the presentation. Make the tests a bit
more robust by ignoring indentation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3301-notes.sh | 321 ++++++++++++++++++++++++-----------------------
 1 file changed, 162 insertions(+), 159 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d742be8840..955b2670a7 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -7,6 +7,11 @@ test_description='Test commit notes'
 
 . ./test-lib.sh
 
+lognotes () {
+	git log "$@" >lognotes.out &&
+	sed 's/^[ 	]*//' lognotes.out
+}
+
 write_script fake_editor <<\EOF
 echo "$MSG" >"$1"
 echo "$MSG" >&2
@@ -14,8 +19,6 @@ EOF
 GIT_EDITOR=./fake_editor
 export GIT_EDITOR
 
-indent="    "
-
 test_expect_success 'cannot annotate non-existing HEAD' '
 	test_must_fail env MSG=3 git notes add
 '
@@ -158,14 +161,14 @@ test_expect_success 'show notes' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:14:13 2005 -0700
 
-		${indent}2nd
+		2nd
 
 		Notes:
-		${indent}b1
+		b1
 	EOF
 	git cat-file commit HEAD >commits &&
 	! grep b1 commits &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -178,16 +181,16 @@ test_expect_success 'show multi-line notes' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:15:13 2005 -0700
 
-		${indent}3rd
+		3rd
 
 		Notes:
-		${indent}b3
-		${indent}c3c3c3c3
-		${indent}d3d3d3
+		b3
+		c3c3c3c3
+		d3d3d3
 
 	EOF
 	cat expect >>expect-multiline &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect-multiline actual
 '
 
@@ -201,21 +204,21 @@ test_expect_success 'show -F notes' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:16:13 2005 -0700
 
-		${indent}4th
+		4th
 
 		Notes:
-		${indent}xyzzy
+		xyzzy
 
 	EOF
 	cat expect-multiline >>expect-F &&
-	git log -3 >actual &&
+	lognotes -3 >actual &&
 	test_cmp expect-F actual
 '
 
 test_expect_success 'Re-adding -F notes without -f fails' '
 	echo "zyxxy" >note5 &&
 	test_must_fail git notes add -F note5 &&
-	git log -3 >actual &&
+	lognotes -3 >actual &&
 	test_cmp expect-F actual
 '
 
@@ -230,9 +233,9 @@ test_expect_success 'git log --pretty=raw does not show notes' '
 		author A U Thor <author@example.com> 1112912173 -0700
 		committer C O Mitter <committer@example.com> 1112912173 -0700
 
-		${indent}4th
+		4th
 	EOF
-	git log -1 --pretty=raw >actual &&
+	lognotes -1 --pretty=raw >actual &&
 	test_cmp expect actual
 '
 
@@ -240,14 +243,14 @@ test_expect_success 'git log --show-notes' '
 	cat >>expect <<-EOF &&
 
 	Notes:
-	${indent}xyzzy
+	xyzzy
 	EOF
-	git log -1 --pretty=raw --show-notes >actual &&
+	lognotes -1 --pretty=raw --show-notes >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git log --no-notes' '
-	git log -1 --no-notes >actual &&
+	lognotes -1 --no-notes >actual &&
 	! grep xyzzy actual
 '
 
@@ -280,25 +283,25 @@ test_expect_success 'setup alternate notes ref' '
 '
 
 test_expect_success 'git log --notes shows default notes' '
-	git log -1 --notes >actual &&
+	lognotes -1 --notes >actual &&
 	grep xyzzy actual &&
 	! grep alternate actual
 '
 
 test_expect_success 'git log --notes=X shows only X' '
-	git log -1 --notes=alternate >actual &&
+	lognotes -1 --notes=alternate >actual &&
 	! grep xyzzy actual &&
 	grep alternate actual
 '
 
 test_expect_success 'git log --notes --notes=X shows both' '
-	git log -1 --notes --notes=alternate >actual &&
+	lognotes -1 --notes --notes=alternate >actual &&
 	grep xyzzy actual &&
 	grep alternate actual
 '
 
 test_expect_success 'git log --no-notes resets default state' '
-	git log -1 --notes --notes=alternate \
+	lognotes -1 --notes --notes=alternate \
 		--no-notes --notes=alternate \
 		>actual &&
 	! grep xyzzy actual &&
@@ -306,7 +309,7 @@ test_expect_success 'git log --no-notes resets default state' '
 '
 
 test_expect_success 'git log --no-notes resets ref list' '
-	git log -1 --notes --notes=alternate \
+	lognotes -1 --notes --notes=alternate \
 		--no-notes --notes \
 		>actual &&
 	grep xyzzy actual &&
@@ -322,18 +325,18 @@ test_expect_success 'show -m notes' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-		${indent}5th
+		5th
 
 		Notes:
-		${indent}spam
-		${indent}
-		${indent}foo
-		${indent}bar
-		${indent}baz
+		spam
+
+		foo
+		bar
+		baz
 
 	EOF
 	cat expect-F >>expect-m &&
-	git log -4 >actual &&
+	lognotes -4 >actual &&
 	test_cmp expect-m actual
 '
 
@@ -345,18 +348,18 @@ test_expect_success 'remove note with add -f -F /dev/null' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-		${indent}5th
+		5th
 
 	EOF
 	cat expect-F >>expect-rm-F &&
-	git log -4 >actual &&
+	lognotes -4 >actual &&
 	test_cmp expect-rm-F actual &&
 	test_must_fail git notes show
 '
 
 test_expect_success 'do not create empty note with -m ""' '
 	git notes add -m "" &&
-	git log -4 >actual &&
+	lognotes -4 >actual &&
 	test_cmp expect-rm-F actual &&
 	test_must_fail git notes show
 '
@@ -390,17 +393,17 @@ test_expect_success 'remove note with "git notes remove"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-		${indent}5th
+		5th
 
 		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:16:13 2005 -0700
 
-		${indent}4th
+		4th
 
 	EOF
 	cat expect-multiline >>expect-rm-remove &&
-	git log -4 >actual &&
+	lognotes -4 >actual &&
 	test_cmp expect-rm-remove actual &&
 	test_must_fail git notes show HEAD^
 '
@@ -570,35 +573,35 @@ test_expect_success 'create other note on a different notes ref (setup)' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-		${indent}6th
+		6th
 	EOF
 	cp expect-not-other expect-other &&
 	cat >>expect-other <<-EOF
 
 		Notes (other):
-		${indent}other note
+		other note
 	EOF
 '
 
 test_expect_success 'Do not show note on other ref by default' '
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect-not-other actual
 '
 
 test_expect_success 'Do show note when ref is given in GIT_NOTES_REF' '
-	GIT_NOTES_REF="refs/notes/other" git log -1 >actual &&
+	test_env GIT_NOTES_REF="refs/notes/other" lognotes -1 >actual &&
 	test_cmp expect-other actual
 '
 
 test_expect_success 'Do show note when ref is given in core.notesRef config' '
 	test_config core.notesRef "refs/notes/other" &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect-other actual
 '
 
 test_expect_success 'Do not show note when core.notesRef is overridden' '
 	test_config core.notesRef "refs/notes/other" &&
-	GIT_NOTES_REF="refs/notes/wrong" git log -1 >actual &&
+	test_env GIT_NOTES_REF="refs/notes/wrong" lognotes -1 >actual &&
 	test_cmp expect-not-other actual
 '
 
@@ -610,36 +613,36 @@ test_expect_success 'Show all notes when notes.displayRef=refs/notes/*' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-		${indent}6th
+		6th
 
 		Notes:
-		${indent}order test
+		order test
 
 		Notes (other):
-		${indent}other note
+		other note
 
 		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-		${indent}5th
+		5th
 
 		Notes:
-		${indent}replacement for deleted note
+		replacement for deleted note
 	EOF
 	GIT_NOTES_REF=refs/notes/commits git notes add \
 		-m"replacement for deleted note" HEAD^ &&
 	GIT_NOTES_REF=refs/notes/commits git notes add -m"order test" &&
 	test_unconfig core.notesRef &&
 	test_config notes.displayRef "refs/notes/*" &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect-both actual
 '
 
 test_expect_success 'core.notesRef is implicitly in notes.displayRef' '
 	test_config core.notesRef refs/notes/commits &&
 	test_config notes.displayRef refs/notes/other &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect-both actual
 '
 
@@ -647,7 +650,7 @@ test_expect_success 'notes.displayRef can be given more than once' '
 	test_unconfig core.notesRef &&
 	test_config notes.displayRef refs/notes/commits &&
 	git config --add notes.displayRef refs/notes/other &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect-both actual
 '
 
@@ -658,17 +661,17 @@ test_expect_success 'notes.displayRef respects order' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-		${indent}6th
+		6th
 
 		Notes (other):
-		${indent}other note
+		other note
 
 		Notes:
-		${indent}order test
+		order test
 	EOF
 	test_config core.notesRef refs/notes/other &&
 	test_config notes.displayRef refs/notes/commits &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect-both-reversed actual
 '
 
@@ -678,8 +681,8 @@ test_expect_success 'notes.displayRef with no value handled gracefully' '
 '
 
 test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
-	GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
-		git log -2 >actual &&
+	test_env GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
+		lognotes -2 >actual &&
 	test_cmp expect-both actual
 '
 
@@ -691,21 +694,21 @@ test_expect_success 'GIT_NOTES_DISPLAY_REF overrides config' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-		${indent}6th
+		6th
 
 		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:17:13 2005 -0700
 
-		${indent}5th
+		5th
 	EOF
 	test_config notes.displayRef "refs/notes/*" &&
-	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 >actual &&
+	test_env GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= lognotes -2 >actual &&
 	test_cmp expect-none actual
 '
 
 test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
-	GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 >actual &&
+	test_env GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= lognotes --show-notes=* -2 >actual &&
 	test_cmp expect-both actual
 '
 
@@ -716,24 +719,24 @@ test_expect_success '--no-standard-notes' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
 
-		${indent}6th
+		6th
 
 		Notes:
-		${indent}order test
+		order test
 	EOF
-	git log --no-standard-notes --show-notes=commits -1 >actual &&
+	lognotes --no-standard-notes --show-notes=commits -1 >actual &&
 	test_cmp expect-commits actual
 '
 
 test_expect_success '--standard-notes' '
 	test_config notes.displayRef "refs/notes/*" &&
-	git log --no-standard-notes --show-notes=commits \
+	lognotes --no-standard-notes --show-notes=commits \
 		--standard-notes -2 >actual &&
 	test_cmp expect-both actual
 '
 
 test_expect_success '--show-notes=ref accumulates' '
-	git log --show-notes=other --show-notes=commits \
+	lognotes --show-notes=other --show-notes=commits \
 		 --no-standard-notes -1 >actual &&
 	test_cmp expect-both-reversed actual
 '
@@ -765,14 +768,14 @@ test_expect_success 'create note from other note with "git notes add -C"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:19:13 2005 -0700
 
-		${indent}7th
+		7th
 
 		Notes:
-		${indent}order test
+		order test
 	EOF
 	note=$(git notes list HEAD^) &&
 	git notes add -C $note &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD^ >expect &&
 	git notes list HEAD >actual &&
@@ -800,14 +803,14 @@ test_expect_success 'create note from blob with "git notes add -C" reuses blob i
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:20:13 2005 -0700
 
-		${indent}8th
+		8th
 
 		Notes:
-		${indent}This is a blob object
+		This is a blob object
 	EOF
 	echo "This is a blob object" | git hash-object -w --stdin >blob &&
 	git notes add -C $(cat blob) &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD >actual &&
 	test_cmp blob actual
@@ -821,14 +824,14 @@ test_expect_success 'create note from other note with "git notes add -c"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:21:13 2005 -0700
 
-		${indent}9th
+		9th
 
 		Notes:
-		${indent}yet another note
+		yet another note
 	EOF
 	note=$(git notes list HEAD^^) &&
 	MSG="yet another note" git notes add -c $note &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -845,16 +848,16 @@ test_expect_success 'append to note from other note with "git notes append -C"'
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:21:13 2005 -0700
 
-		${indent}9th
+		9th
 
 		Notes:
-		${indent}yet another note
-		${indent}
-		${indent}yet another note
+		yet another note
+
+		yet another note
 	EOF
 	note=$(git notes list HEAD^) &&
 	git notes append -C $note HEAD^ &&
-	git log -1 HEAD^ >actual &&
+	lognotes -1 HEAD^ >actual &&
 	test_cmp expect actual
 '
 
@@ -865,14 +868,14 @@ test_expect_success 'create note from other note with "git notes append -c"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:22:13 2005 -0700
 
-		${indent}10th
+		10th
 
 		Notes:
-		${indent}other note
+		other note
 	EOF
 	note=$(git notes list HEAD^) &&
 	MSG="other note" git notes append -c $note &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -883,16 +886,16 @@ test_expect_success 'append to note from other note with "git notes append -c"'
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:22:13 2005 -0700
 
-		${indent}10th
+		10th
 
 		Notes:
-		${indent}other note
-		${indent}
-		${indent}yet another note
+		other note
+
+		yet another note
 	EOF
 	note=$(git notes list HEAD) &&
 	MSG="yet another note" git notes append -c $note &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -903,13 +906,13 @@ test_expect_success 'copy note with "git notes copy"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:16:13 2005 -0700
 
-		${indent}4th
+		4th
 
 		Notes:
-		${indent}This is a blob object
+		This is a blob object
 	EOF
 	git notes copy 8th 4th &&
-	git log 3rd..4th >actual &&
+	lognotes 3rd..4th >actual &&
 	test_cmp expect actual &&
 	git notes list 4th >expect &&
 	git notes list 8th >actual &&
@@ -924,15 +927,15 @@ test_expect_success 'copy note with "git notes copy" with default' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:23:13 2005 -0700
 
-		${indent}11th
+		11th
 
 		Notes:
-		${indent}other note
-		${indent}
-		${indent}yet another note
+		other note
+
+		yet another note
 	EOF
 	git notes copy HEAD^ &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD^ >expect &&
 	git notes list HEAD >actual &&
@@ -946,14 +949,14 @@ test_expect_success 'prevent overwrite with "git notes copy"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:23:13 2005 -0700
 
-		${indent}11th
+		11th
 
 		Notes:
-		${indent}other note
-		${indent}
-		${indent}yet another note
+		other note
+
+		yet another note
 	EOF
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD^ >expect &&
 	git notes list HEAD >actual &&
@@ -967,13 +970,13 @@ test_expect_success 'allow overwrite with "git notes copy -f"' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:23:13 2005 -0700
 
-		${indent}11th
+		11th
 
 		Notes:
-		${indent}This is a blob object
+		This is a blob object
 	EOF
 	git notes copy -f HEAD~3 HEAD &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD~3 >expect &&
 	git notes list HEAD >actual &&
@@ -987,15 +990,15 @@ test_expect_success 'allow overwrite with "git notes copy -f" with default' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:23:13 2005 -0700
 
-		${indent}11th
+		11th
 
 		Notes:
-		${indent}yet another note
-		${indent}
-		${indent}yet another note
+		yet another note
+
+		yet another note
 	EOF
 	git notes copy -f HEAD~2 &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD~2 >expect &&
 	git notes list HEAD >actual &&
@@ -1016,23 +1019,23 @@ test_expect_success 'git notes copy --stdin' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:25:13 2005 -0700
 
-		${indent}13th
+		13th
 
 		Notes:
-		${indent}yet another note
-		${indent}
-		${indent}yet another note
+		yet another note
+
+		yet another note
 
 		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:24:13 2005 -0700
 
-		${indent}12th
+		12th
 
 		Notes:
-		${indent}other note
-		${indent}
-		${indent}yet another note
+		other note
+
+		yet another note
 	EOF
 	from=$(git rev-parse HEAD~3) &&
 	to=$(git rev-parse HEAD^) &&
@@ -1041,7 +1044,7 @@ test_expect_success 'git notes copy --stdin' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >>copy &&
 	git notes copy --stdin <copy &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect actual &&
 	git notes list HEAD~2 >expect &&
 	git notes list HEAD >actual &&
@@ -1061,13 +1064,13 @@ test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:26:13 2005 -0700
 
-		${indent}14th
+		14th
 	EOF
 	from=$(git rev-parse HEAD~3) &&
 	to=$(git rev-parse HEAD^) &&
@@ -1076,7 +1079,7 @@ test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >>copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect actual
 '
 
@@ -1088,23 +1091,23 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		Notes:
-		${indent}yet another note
-		${indent}
-		${indent}yet another note
+		yet another note
+
+		yet another note
 
 		commit $parent
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:26:13 2005 -0700
 
-		${indent}14th
+		14th
 
 		Notes:
-		${indent}other note
-		${indent}
-		${indent}yet another note
+		other note
+
+		yet another note
 	EOF
 	test_config notes.rewriteMode overwrite &&
 	test_config notes.rewriteRef "refs/notes/*" &&
@@ -1115,7 +1118,7 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >>copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect actual
 '
 
@@ -1125,7 +1128,7 @@ test_expect_success 'git notes copy --for-rewrite (disabled)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >copy &&
 	git notes copy --for-rewrite=bar <copy &&
-	git log -2 >actual &&
+	lognotes -2 >actual &&
 	test_cmp expect actual
 '
 
@@ -1136,10 +1139,10 @@ test_expect_success 'git notes copy --for-rewrite (overwrite)' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		Notes:
-		${indent}a fresh note
+		a fresh note
 	EOF
 	git notes add -f -m"a fresh note" HEAD^ &&
 	test_config notes.rewriteMode overwrite &&
@@ -1148,7 +1151,7 @@ test_expect_success 'git notes copy --for-rewrite (overwrite)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1159,7 +1162,7 @@ test_expect_success 'git notes copy --for-rewrite (ignore)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1170,12 +1173,12 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		Notes:
-		${indent}a fresh note
-		${indent}
-		${indent}another fresh note
+		a fresh note
+
+		another fresh note
 	EOF
 	git notes add -f -m"another fresh note" HEAD^ &&
 	test_config notes.rewriteMode concatenate &&
@@ -1184,7 +1187,7 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1195,16 +1198,16 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		Notes:
-		${indent}a fresh note
-		${indent}
-		${indent}another fresh note
-		${indent}
-		${indent}append 1
-		${indent}
-		${indent}append 2
+		a fresh note
+
+		another fresh note
+
+		append 1
+
+		append 2
 	EOF
 	git notes add -f -m"append 1" HEAD^ &&
 	git notes add -f -m"append 2" HEAD^^ &&
@@ -1217,7 +1220,7 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >>copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1229,7 +1232,7 @@ test_expect_success 'git notes copy --for-rewrite (append empty)' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >copy &&
 	git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1240,10 +1243,10 @@ test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		Notes:
-		${indent}replacement note 1
+		replacement note 1
 	EOF
 	test_config notes.rewriteMode concatenate &&
 	test_config notes.rewriteRef "refs/notes/*" &&
@@ -1252,7 +1255,7 @@ test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
 	to=$(git rev-parse HEAD) &&
 	echo "$from" "$to" >copy &&
 	GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1263,10 +1266,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF works' '
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:27:13 2005 -0700
 
-		${indent}15th
+		15th
 
 		Notes:
-		${indent}replacement note 2
+		replacement note 2
 	EOF
 	git notes add -f -m"replacement note 2" HEAD^ &&
 	test_config notes.rewriteMode overwrite &&
@@ -1276,7 +1279,7 @@ test_expect_success 'GIT_NOTES_REWRITE_REF works' '
 	echo "$from" "$to" >copy &&
 	GIT_NOTES_REWRITE_REF=refs/notes/commits:refs/notes/other \
 		git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -1289,7 +1292,7 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	echo "$from" "$to" >copy &&
 	GIT_NOTES_REWRITE_REF=refs/notes/commits \
 		git notes copy --for-rewrite=foo <copy &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	grep "replacement note 3" actual
 '
 
@@ -1372,13 +1375,13 @@ EOF
 
 test_expect_success 'empty notes are displayed by git log' '
 	test_commit 17th &&
-	git log -1 >expect &&
+	lognotes -1 >expect &&
 	cat >>expect <<-EOF &&
 
 		Notes:
 	EOF
 	git notes add -C "$empty_blob" --allow-empty &&
-	git log -1 >actual &&
+	lognotes -1 >actual &&
 	test_cmp expect actual
 '
 
-- 
2.33.0.153.gba50c8fa24

