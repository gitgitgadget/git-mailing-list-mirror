Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599241F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeCPWhY (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:37:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40046 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeCPWhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:37:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id t6so5700820wmt.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7iZNnSg6xNH7aI9TMEZ5YRvsf52X9FW2+63ggBKnddM=;
        b=Y3u8FivZbA97GOiR4RUgjYuwevncoTO+uuX6B6U1Qx42gbrGGUlNF1ucxLxlLy7Bux
         72KxM9c27K+1ZIWcaetxSjdbeiLhLnFcq2auLtbaB+UxrxqeccnzHZ0NLQmr9mxrPM6M
         51OebP5ETGqxSo6mzI2p2tSveJEZfHQVtvuhoNluZfBQEeRxgzdShoYXZnvh9QRAvAl5
         pZiYFIsrgbUAhDDPXdqpEayIiFduM+8P9ekYKAwBMcA3IVCvu9zo4bdkrpIeLDYA28UP
         xHGJQohoq4161LUoDvkRXwUGM5wPTMCInYdQ8BH/0FwTIzIZjnhqeLcQ0F2uycWG5try
         HzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7iZNnSg6xNH7aI9TMEZ5YRvsf52X9FW2+63ggBKnddM=;
        b=Co8KG83hBDCgjndp9eYnSB0HsKopQ+qBZNKzYODEVIFzAwV0kIulLZxt9JEMz/z5sw
         Fo3ck0GMPEyDZ8s58NElhymt4p3tqx7CldqfosDF1HLfkMmn0IPdOSXepkczVDdUfnYk
         j5a2rr1CqLpwlw2EhHN6fgH0DJcUhNK0P1FtVp8ZvIapim/JUlEPoJu/wPQ+tMs/S0tI
         hCkxFrj5EP627UguUICxOXSTtHCufVvvUkviikb1MUKmzYhasrXwJyH/A6BCnWK/FGtw
         tbZLXzJPZS8krTSQ2wCUvA1+1aHpYx8j9x8s303V8lLIYXrPet+cIfTY1mQT0qEJxOl6
         Vu5A==
X-Gm-Message-State: AElRT7E6yQanZZwmtzuZYX0yLiFZeMPjWy+qIWKY7WrTXIHzd/fA1ALr
        NuwjQbgmZC4MvVmQc5PQaP6azx+g
X-Google-Smtp-Source: AG47ELtnwIzFKO9iOjjlAJv1XMQkx5T0zvS9Ji0oN6s9KyGJJ8m6wATa8gIV3EHJgIIS8WNcbiJToA==
X-Received: by 10.28.145.76 with SMTP id t73mr3148857wmd.77.1521239839648;
        Fri, 16 Mar 2018 15:37:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 93sm7895027wrh.46.2018.03.16.15.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 15:37:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/3] stash push: avoid printing errors
Date:   Fri, 16 Mar 2018 15:37:14 -0700
Message-Id: <20180316223715.108044-3-gitster@pobox.com>
X-Mailer: git-send-email 2.17.0-rc0
In-Reply-To: <20180316223715.108044-1-gitster@pobox.com>
References: <20180316204306.862-1-t.gummerer@gmail.com>
 <20180316223715.108044-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Gummerer <t.gummerer@gmail.com>

'git stash push -u -- <pathspec>' prints the following errors if
<pathspec> only matches untracked files:

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

[jc: swapped the order of if/elseif chain to reduce nesting levels]

Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh     |  7 ++++---
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4c92ec931f..fa61151548 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -313,13 +313,14 @@ push_stash () {
 			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
-		if test $# != 0
+		if test $# = 0
+		then
+			git reset --hard -q
+		elif git ls-files --error-unmatch -- "$@" >/dev/null 2>&1
 		then
 			git add -u -- "$@"
 			git diff-index -p --cached --binary HEAD -- "$@" |
 			git apply --index -R
-		else
-			git reset --hard -q
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1cd85e70e9..f5b102a958 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1003,4 +1003,20 @@ test_expect_success 'stash -- <subdir> works with binary files' '
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
2.17.0-rc0

