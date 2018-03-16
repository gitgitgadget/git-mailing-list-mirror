Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE1D1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeCPUl7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:41:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36994 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeCPUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:39:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id 139so5333016wmn.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Skp1YP3Vla4XXfwmIQf0Ydtm9AwkLlm8+ib2hZiH/XA=;
        b=vZ9awn6rUsA5kyZ2m7KHqExuTygpGe1KU4uKtcVBagIU3ivR9TfhnmlcayU8fnRa8D
         CFqZLlOLwG5B4nwYCoQ/zlgJ/JzM5R7joWnJ+qOFch3CENpCEXhhhTmK2OINrmvSIttY
         WOYJo/5o18802ciYOL7C6wa4av+LRct7M7xE8CjZacxEy62bVIz4FWLN6aLjw1hJcXIR
         SexrIwzyIfIHNhTMeH+yU7ysqA/SDTA6BekOvqcucyyCS1URultLkjw9XqEkhO9/Xdqj
         ZAmrYPLLJ26W7MV+SRVM7+ffdZu3E92enywDl6GDegYyaPTkfqWx3ukJuEwuxEKoa6Y5
         oZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Skp1YP3Vla4XXfwmIQf0Ydtm9AwkLlm8+ib2hZiH/XA=;
        b=AojqEth1ZpJEUpDOuxBQ4ZxuBJ9N1mTdjBzWmKvNaJgC63RwcaW+hPQvt1uAYlQgiY
         C91kmQ/pBnawN+kZ4pTEJ2sLRXh9vBMZSEPfzkPoTFvZHUwxvyvLv51qr90F1cIOXvAt
         qULLGKUhwuB0Tccm0mx7k+qVSk6ShBUOcwiT5caDgOU6ChZqPBy4F0E1guDhwmBewD4D
         I+1P2MaGWoyw0+gBHNN51mSDAy+cFfSayl+DY2ruaxoQF3vzkaIFKD4Jkd1Ry30gBpKa
         h7bzkBivK/P73kt5uARnI4Ll1j+FhRMeJjR0I3mCwKWB1SBAP7UZu/jH/3Gk/rZ0Uwg1
         hPaw==
X-Gm-Message-State: AElRT7GJmEYME/kbKSgTNCRpLjPXR5jCOKqlS4WX7s2Dt4bT+vIYo5SS
        cYvLU7leUEZtwRerIQgo1cX5n+wC
X-Google-Smtp-Source: AG47ELuwslqaGD0nEyRRThLtpH4Qp0c2pG7m0Qn66rJFqw55xGIJG0Xy+Dc+kAvR+5AmIQ7f7pBaUQ==
X-Received: by 10.28.59.130 with SMTP id i124mr2617440wma.23.1521232794213;
        Fri, 16 Mar 2018 13:39:54 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m129sm6913056wma.44.2018.03.16.13.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:39:53 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/2] stash push: avoid printing errors
Date:   Fri, 16 Mar 2018 20:43:05 +0000
Message-Id: <20180316204306.862-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e11
In-Reply-To: <20180316204306.862-1-t.gummerer@gmail.com>
References: <20180314214642.22185-1-t.gummerer@gmail.com>
 <20180316204306.862-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git stash push -u -- <pathspec>' prints the following errors
if <pathspec> only matches untracked files:

    fatal: pathspec 'untracked' did not match any files
    error: unrecognized input

This is because we first clean up the untracked files using 'git clean
<pathspec>', and then use a command chain involving 'git add -u
<pathspec>' and 'git apply' to clear the changes to files that are in
the index and were stashed.

As the <pathspec> only includes untracked files that were already
removed by 'git clean', the 'git add' call will barf, and so will 'git
apply', as there are no changes that need to be applied.

Fix this by making sure to only call this command chain if there are
still files that match <pathspec> after the call to 'git clean'.

Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     |  9 ++++++---
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index fc8f8ae640..4de9f9bea8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,9 +322,12 @@ push_stash () {
 
 		if test $# != 0
 		then
-			git add -u -- "$@" |
-			git checkout-index -z --force --stdin
-			git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R
+			if git ls-files --error-unmatch -- "$@" >/dev/null 2>/dev/null
+			then
+				git add -u -- "$@" |
+				git checkout-index -z --force --stdin
+				git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R
+			fi
 		else
 			git reset --hard -q
 		fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b172..8b1a8d2982 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,4 +1096,20 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_success 'stash -u -- <untracked> doesnt print error' '
+	>untracked &&
+	git stash push -u -- untracked 2>actual &&
+	test_path_is_missing untracked &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'stash -u -- <untracked> leaves rest of working tree in place' '
+	>tracked &&
+	git add tracked &&
+	>untracked &&
+	git stash push -u -- untracked &&
+	test_path_is_missing untracked &&
+	test_path_is_file tracked
+'
+
 test_done
-- 
2.16.2.804.g6dcf76e11

