Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C13C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B4E20878
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehu94HxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKUAqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:00 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:42926 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:00 -0500
Received: by mail-pl1-f181.google.com with SMTP id j12so668887plt.9
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nG68eLjE2vQanccdIkSXy+v17/W12ai8bBAquu5Lk6k=;
        b=ehu94HxVGmREgjc9wchqdnoZkpyWYNgBI580ZryD7obuXPurJP29e+wuGNUYLDrcTH
         bYFiZs8VUfnjXl6FyaVwv4P8sBxvcIrBxvNK0G7fvdpmoSOpudnFo9kySOi1qQVia66U
         MExmS14pOl7ctG4DKrzCYjHiZJqW20EihmJQKcd82OzGGZXxVAfJb79YJ9G+z2JMYlRf
         jixOi3oOoobUxUQQL2gPBA0/WI22wswaLPi12Ir6MzgT2RlMjH7h/5Z1O09ZwZwHe97K
         UCfgU1A8vKSWTjfy8u+6IPFVE5GebyZVGB9KaiwNrmqJuJu35qz6PXJEHLM7thPQJrpM
         syPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nG68eLjE2vQanccdIkSXy+v17/W12ai8bBAquu5Lk6k=;
        b=i16xXjVweupkCfxNFo2Sr+NM6zBjIllJ3mmUqzwtKDKMN3P9LB8sydHye4XU8t/cbr
         Up64capWO2wby6ApFhecRGkLpJdkI6VAyjKlLTcSpk0TIwQRKkiW4J6OSXNsmu+OHc29
         7cuWKDufGoXo4bBp1tF+DI/DAwWZ57C7knPN7TWZ2sfJ/+9ja1IeI06nq0OGnn/yXcoq
         F3lyLA1rAARANtpGCiKW0okQTxSu9QkheX412vl57ElHAb4+L2+ABbMjux7EBZR9UG1I
         7KW4zk1CW7kuoz7VKmt8mgKXIItUiCOwUbq1BT1cZedimWxMLmb7ezABpyJp9iRcKC5T
         GmCg==
X-Gm-Message-State: APjAAAUmZlUOUS/x3PJMkgCcbFoCwEd78yIsVUR7S6NOghy59NmUUt9l
        4flGIO43XxUlbS/UjagQEG4MKUcW
X-Google-Smtp-Source: APXvYqwjtx6nelEgOzD9zomROGppGExKiRW+5UFgbr0GQxmwkEEcy4w4/othc9KiRMQ8RRm2n7Xn1Q==
X-Received: by 2002:a17:90a:8401:: with SMTP id j1mr7597367pjn.39.1574297158152;
        Wed, 20 Nov 2019 16:45:58 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y36sm395345pgk.66.2019.11.20.16.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:45:57 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:45:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 04/21] t3301: stop losing return codes of git commands
Message-ID: <e8eafa1551163d89b4c643c8e46c79d6aaa02fb5.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this so that git commands are either run
on their own or in an assignment-only command substitution.

This patch fixes a real buggy test: in 'copy note with "git notes
copy"', `git notes` was mistyped as `git note`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3301-notes.sh | 230 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 163 insertions(+), 67 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d66a5f6faa..8f43303007 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -54,7 +54,9 @@ test_expect_success 'create notes' '
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
 	test_line_count = 1 actual &&
-	test "b4" = "$(git notes show)" &&
+	echo b4 >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
@@ -79,14 +81,21 @@ test_expect_success 'edit existing notes' '
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
 	test_line_count = 1 actual &&
-	test "b3" = "$(git notes show)" &&
+	echo b3 >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
 
 test_expect_success 'show notes from treeish' '
-	test "b3" = "$(git notes --ref commits^{tree} show)" &&
-	test "b4" = "$(git notes --ref commits@{1} show)"
+	echo b3 >expect &&
+	git notes --ref commits^{tree} show >actual &&
+	test_cmp expect actual &&
+
+	echo b4 >expect &&
+	git notes --ref commits@{1} show >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'cannot edit notes from non-ref' '
@@ -99,7 +108,9 @@ test_expect_success 'cannot "git notes add -m" where notes already exists' '
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
 	test_line_count = 1 actual &&
-	test "b3" = "$(git notes show)" &&
+	echo b3 >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
@@ -109,7 +120,9 @@ test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
 	test_line_count = 1 actual &&
-	test "b1" = "$(git notes show)" &&
+	echo b1 >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
@@ -119,7 +132,9 @@ test_expect_success 'add w/no options on existing note morphs into edit' '
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
 	test_line_count = 1 actual &&
-	test "b2" = "$(git notes show)" &&
+	echo b2 >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
@@ -129,7 +144,9 @@ test_expect_success 'can overwrite existing note with "git notes add -f"' '
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
 	test_line_count = 1 actual &&
-	test "b1" = "$(git notes show)" &&
+	echo b1 >expect &&
+	git notes show >actual &&
+	test_cmp expect actual &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
 '
@@ -146,7 +163,8 @@ test_expect_success 'show notes' '
 		Notes:
 		${indent}b1
 	EOF
-	! (git cat-file commit HEAD | grep b1) &&
+	git cat-file commit HEAD >commits &&
+	! grep b1 commits &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -472,9 +490,11 @@ test_expect_success 'removing with --stdin --ignore-missing' '
 test_expect_success 'list notes with "git notes list"' '
 	commit_2=$(git rev-parse 2nd) &&
 	commit_3=$(git rev-parse 3rd) &&
+	note_2=$(git rev-parse refs/notes/commits:$commit_2) &&
+	note_3=$(git rev-parse refs/notes/commits:$commit_3) &&
 	sort -t" " -k2 >expect <<-EOF &&
-		$(git rev-parse refs/notes/commits:$commit_2) $commit_2
-		$(git rev-parse refs/notes/commits:$commit_3) $commit_3
+		$note_2 $commit_2
+		$note_3 $commit_3
 	EOF
 	git notes list >actual &&
 	test_cmp expect actual
@@ -486,9 +506,7 @@ test_expect_success 'list notes with "git notes"' '
 '
 
 test_expect_success 'list specific note with "git notes list <object>"' '
-	cat >expect <<-EOF &&
-		$(git rev-parse refs/notes/commits:$commit_3)
-	EOF
+	git rev-parse refs/notes/commits:$commit_3 >expect &&
 	git notes list HEAD^^ >actual &&
 	test_cmp expect actual
 '
@@ -512,10 +530,11 @@ test_expect_success 'append to existing note with "git notes append"' '
 
 test_expect_success '"git notes list" does not expand to "git notes list HEAD"' '
 	commit_5=$(git rev-parse 5th) &&
+	note_5=$(git rev-parse refs/notes/commits:$commit_5) &&
 	sort -t" " -k2 >expect_list <<-EOF &&
-		$(git rev-parse refs/notes/commits:$commit_2) $commit_2
-		$(git rev-parse refs/notes/commits:$commit_3) $commit_3
-		$(git rev-parse refs/notes/commits:$commit_5) $commit_5
+		$note_2 $commit_2
+		$note_3 $commit_3
+		$note_5 $commit_5
 	EOF
 	git notes list >actual &&
 	test_cmp expect_list actual
@@ -721,7 +740,8 @@ test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	git notes show HEAD: >actual &&
 	test_cmp expect actual &&
 	echo "Note on a blob" >expect &&
-	filename=$(git ls-tree --name-only HEAD | head -n1) &&
+	git ls-tree --name-only HEAD >files &&
+	filename=$(head -n1 files) &&
 	git notes add -m "Note on a blob" HEAD:$filename &&
 	git notes show HEAD:$filename >actual &&
 	test_cmp expect actual &&
@@ -745,10 +765,13 @@ test_expect_success 'create note from other note with "git notes add -C"' '
 		Notes:
 		${indent}order test
 	EOF
-	git notes add -C $(git notes list HEAD^) &&
+	note=$(git notes list HEAD^) &&
+	git notes add -C $note &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
+	git notes list HEAD^ >expect &&
+	git notes list HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'create note from non-existing note with "git notes add -C" fails' '
@@ -777,11 +800,12 @@ test_expect_success 'create note from blob with "git notes add -C" reuses blob i
 		Notes:
 		${indent}This is a blob object
 	EOF
-	blob=$(echo "This is a blob object" | git hash-object -w --stdin) &&
-	git notes add -C $blob &&
+	echo "This is a blob object" | git hash-object -w --stdin >blob &&
+	git notes add -C $(cat blob) &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$blob"
+	git notes list HEAD >actual &&
+	test_cmp blob actual
 '
 
 test_expect_success 'create note from other note with "git notes add -c"' '
@@ -797,7 +821,8 @@ test_expect_success 'create note from other note with "git notes add -c"' '
 		Notes:
 		${indent}yet another note
 	EOF
-	MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
+	note=$(git notes list HEAD^^) &&
+	MSG="yet another note" git notes add -c $note &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -822,7 +847,8 @@ test_expect_success 'append to note from other note with "git notes append -C"'
 		${indent}
 		${indent}yet another note
 	EOF
-	git notes append -C $(git notes list HEAD^) HEAD^ &&
+	note=$(git notes list HEAD^) &&
+	git notes append -C $note HEAD^ &&
 	git log -1 HEAD^ >actual &&
 	test_cmp expect actual
 '
@@ -839,7 +865,8 @@ test_expect_success 'create note from other note with "git notes append -c"' '
 		Notes:
 		${indent}other note
 	EOF
-	MSG="other note" git notes append -c $(git notes list HEAD^) &&
+	note=$(git notes list HEAD^) &&
+	MSG="other note" git notes append -c $note &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -858,7 +885,8 @@ test_expect_success 'append to note from other note with "git notes append -c"'
 		${indent}
 		${indent}yet another note
 	EOF
-	MSG="yet another note" git notes append -c $(git notes list HEAD) &&
+	note=$(git notes list HEAD) &&
+	MSG="yet another note" git notes append -c $note &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -878,7 +906,9 @@ test_expect_success 'copy note with "git notes copy"' '
 	git notes copy 8th 4th &&
 	git log 3rd..4th >actual &&
 	test_cmp expect actual &&
-	test "$(git note list 4th)" = "$(git note list 8th)"
+	git notes list 4th >expect &&
+	git notes list 8th >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'copy note with "git notes copy" with default' '
@@ -899,14 +929,30 @@ test_expect_success 'copy note with "git notes copy" with default' '
 	git notes copy HEAD^ &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
+	git notes list HEAD^ >expect &&
+	git notes list HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'prevent overwrite with "git notes copy"' '
 	test_must_fail git notes copy HEAD~2 HEAD &&
+	cat >expect <<-EOF &&
+		commit $commit
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:23:13 2005 -0700
+
+		${indent}11th
+
+		Notes:
+		${indent}other note
+		${indent}
+		${indent}yet another note
+	EOF
 	git log -1 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
+	git notes list HEAD^ >expect &&
+	git notes list HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'allow overwrite with "git notes copy -f"' '
@@ -924,7 +970,9 @@ test_expect_success 'allow overwrite with "git notes copy -f"' '
 	git notes copy -f HEAD~3 HEAD &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$(git notes list HEAD~3)"
+	git notes list HEAD~3 >expect &&
+	git notes list HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'allow overwrite with "git notes copy -f" with default' '
@@ -944,7 +992,9 @@ test_expect_success 'allow overwrite with "git notes copy -f" with default' '
 	git notes copy -f HEAD~2 &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
+	git notes list HEAD~2 >expect &&
+	git notes list HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'cannot copy note from object without notes' '
@@ -979,13 +1029,21 @@ test_expect_success 'git notes copy --stdin' '
 		${indent}
 		${indent}yet another note
 	EOF
-	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
-	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
-	git notes copy --stdin &&
+	from=$(git rev-parse HEAD~3) &&
+	to=$(git rev-parse HEAD^) &&
+	echo "$from" "$to" >copy &&
+	from=$(git rev-parse HEAD~2) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >>copy &&
+	git notes copy --stdin <copy &&
 	git log -2 >actual &&
 	test_cmp expect actual &&
-	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
-	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
+	git notes list HEAD~2 >expect &&
+	git notes list HEAD >actual &&
+	test_cmp expect actual &&
+	git notes list HEAD~3 >expect &&
+	git notes list HEAD^ >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
@@ -1006,9 +1064,13 @@ test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
 
 		${indent}14th
 	EOF
-	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
-	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD~3) &&
+	to=$(git rev-parse HEAD^) &&
+	echo "$from" "$to" >copy &&
+	from=$(git rev-parse HEAD~2) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >>copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -2 >actual &&
 	test_cmp expect actual
 '
@@ -1041,17 +1103,23 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 	EOF
 	test_config notes.rewriteMode overwrite &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^) &&
-	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD~3) &&
+	to=$(git rev-parse HEAD^) &&
+	echo "$from" "$to" >copy &&
+	from=$(git rev-parse HEAD~2) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >>copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -2 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git notes copy --for-rewrite (disabled)' '
 	test_config notes.rewrite.bar false &&
-	echo $(git rev-parse HEAD~3) $(git rev-parse HEAD) |
-	git notes copy --for-rewrite=bar &&
+	from=$(git rev-parse HEAD~3) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	git notes copy --for-rewrite=bar <copy &&
 	git log -2 >actual &&
 	test_cmp expect actual
 '
@@ -1071,8 +1139,10 @@ test_expect_success 'git notes copy --for-rewrite (overwrite)' '
 	git notes add -f -m"a fresh note" HEAD^ &&
 	test_config notes.rewriteMode overwrite &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1080,8 +1150,10 @@ test_expect_success 'git notes copy --for-rewrite (overwrite)' '
 test_expect_success 'git notes copy --for-rewrite (ignore)' '
 	test_config notes.rewriteMode ignore &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1103,8 +1175,10 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 	git notes add -f -m"another fresh note" HEAD^ &&
 	test_config notes.rewriteMode concatenate &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1131,9 +1205,13 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 	git notes add -f -m"append 2" HEAD^^ &&
 	test_config notes.rewriteMode concatenate &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	(echo $(git rev-parse HEAD^) $(git rev-parse HEAD) &&
-	echo $(git rev-parse HEAD^^) $(git rev-parse HEAD)) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	from=$(git rev-parse HEAD^^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >>copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1142,8 +1220,10 @@ test_expect_success 'git notes copy --for-rewrite (append empty)' '
 	git notes remove HEAD^ &&
 	test_config notes.rewriteMode concatenate &&
 	test_config notes.rewriteRef "refs/notes/*" &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
-	git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1163,8 +1243,10 @@ test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
 	test_config notes.rewriteMode concatenate &&
 	test_config notes.rewriteRef "refs/notes/*" &&
 	git notes add -f -m"replacement note 1" HEAD^ &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
-	GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo &&
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
+	GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1184,9 +1266,11 @@ test_expect_success 'GIT_NOTES_REWRITE_REF works' '
 	git notes add -f -m"replacement note 2" HEAD^ &&
 	test_config notes.rewriteMode overwrite &&
 	test_unconfig notes.rewriteRef &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
 	GIT_NOTES_REWRITE_REF=refs/notes/commits:refs/notes/other \
-		git notes copy --for-rewrite=foo &&
+		git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -1195,9 +1279,11 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	git notes add -f -m"replacement note 3" HEAD^ &&
 	test_config notes.rewriteMode overwrite &&
 	test_config notes.rewriteRef refs/notes/other &&
-	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	from=$(git rev-parse HEAD^) &&
+	to=$(git rev-parse HEAD) &&
+	echo "$from" "$to" >copy &&
 	GIT_NOTES_REWRITE_REF=refs/notes/commits \
-		git notes copy --for-rewrite=foo &&
+		git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
 	grep "replacement note 3" actual
 '
@@ -1212,26 +1298,36 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 test_expect_success 'git notes get-ref expands refs/heads/master to refs/notes/refs/heads/master' '
 	test_unconfig core.notesRef &&
 	sane_unset GIT_NOTES_REF &&
-	test "$(git notes --ref=refs/heads/master get-ref)" = "refs/notes/refs/heads/master"
+	echo refs/notes/refs/heads/master >expect &&
+	git notes --ref=refs/heads/master get-ref >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes get-ref (no overrides)' '
 	test_unconfig core.notesRef &&
 	sane_unset GIT_NOTES_REF &&
-	test "$(git notes get-ref)" = "refs/notes/commits"
+	echo refs/notes/commits >expect &&
+	git notes get-ref >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes get-ref (core.notesRef)' '
 	test_config core.notesRef refs/notes/foo &&
-	test "$(git notes get-ref)" = "refs/notes/foo"
+	echo refs/notes/foo >expect &&
+	git notes get-ref >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes get-ref (GIT_NOTES_REF)' '
-	test "$(GIT_NOTES_REF=refs/notes/bar git notes get-ref)" = "refs/notes/bar"
+	echo refs/notes/bar >expect &&
+	GIT_NOTES_REF=refs/notes/bar git notes get-ref >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git notes get-ref (--ref)' '
-	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
+	echo refs/notes/baz >expect &&
+	GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'setup testing of empty notes' '
-- 
2.24.0.450.g7a9a4598a9

