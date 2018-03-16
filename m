Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367951F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeCPUj6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:39:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55890 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeCPUjx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:39:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id q83so5365673wme.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c2PgyZzYgehqTOmh06Z2hzn/DanQ2dWJqBU4fnsEbeg=;
        b=kFavhi09WyGFYMUkrHbmoWRcXMS6oypBiyTVn0fuvOp64GHbtIDqDjtVvg1IQ3GdsN
         moImjLfic5wWx3vJSyEgGJI47tsx3xW9AUk7g7VXcSLfTaVV51SOjVcARdqi6ep/hNV+
         b1lLsyT/ylnjfqKtkGDoYR6BWyhU5rrow1HaTomDmFxx5dhUxxtXosfoB5i1HFHmGC9d
         WdgVrgGLKqjd7QyIX8G+nZ3JQhUmQYAv7bkTIwtzhGXg1PDzjwR+VXbKGjAyf84PQXR8
         8/IM2LqUAk8kxsmMSQhGdjCryLEvJIk7t21dax5R9iHk6pwoskyZ83g7qIh8KitHyUYJ
         12FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c2PgyZzYgehqTOmh06Z2hzn/DanQ2dWJqBU4fnsEbeg=;
        b=WUNbCLWjIljwSx29rkHNHlXvSg4mL4rvqiIz7YrpYD3xVR8RcI6NS7j07kNY1hwIZC
         wwUZWC4cmNq2eutXp6PhlJByUgBTq0/uxeMu79+poTcUSx26g6NTOpwk22VjrqPXhlCv
         2WU3l6oyHJlAGxeKFzI0jjZRTyL+YB1E6mQ6kuN8yCSWL7uVlVSaJACblaFDtAXuAHwY
         ue/802NzRhVWYdNdR2IBwR35JCCkGe+QrrtjAe1lYXRHNIyiSXVSciVgi68FXKZmw0lG
         rhfDSl+YQM1Y8aHdbX9zLjOdj8E9KX8KHKoMfrlCiOzNAEbJrM0QKKMRJxmfdl1mhwEv
         O09g==
X-Gm-Message-State: AElRT7FdPfFOJ3x65g8PV6bgUtTQRa1JL8XWkiksbSWG7LCBal2KUpXi
        NAAtlOwa+euTm7/VEsE7Qrodoxn9
X-Google-Smtp-Source: AG47ELthqSux4ZEsktSw49Q83bScBQtvrC0LT+zzqQyld1Pf+Ev7grxFvZ4U/skr733ndWFT5qNhKg==
X-Received: by 10.28.20.74 with SMTP id 71mr2613340wmu.71.1521232791596;
        Fri, 16 Mar 2018 13:39:51 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c192sm7238410wma.12.2018.03.16.13.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:39:50 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/2] stash push -u -- <pathspec> fixes
Date:   Fri, 16 Mar 2018 20:43:04 +0000
Message-Id: <20180316204306.862-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e11
In-Reply-To: <20180314214642.22185-1-t.gummerer@gmail.com>
References: <20180314214642.22185-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Marc for catching the regression I almost introduced and Junio
for the review of the second patch.  Here's a re-roll that should fix
the issues of v2.

Interdiff below:

diff --git a/git-stash.sh b/git-stash.sh
index 7a4ec98f6b..dbedc7fb9f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -39,7 +39,7 @@ fi
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
 	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files $@)")
+	(test -z "$untracked" || test -z "$(untracked_files "$@")")
 }
 
 untracked_files () {
@@ -320,11 +320,14 @@ push_stash () {
 			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
-		if test $# != 0 && git ls-files --error-unmatch -- "$@" >/dev/null 2>/dev/null
+		if test $# != 0
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
index 5e7078c083..7efc52fe11 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1103,6 +1103,15 @@ test_expect_success 'stash -u -- <untracked> doesnt print error' '
 	test_line_count = 0 actual
 '
 
+test_expect_success 'stash -u -- <untracked> leaves rest of working tree in place' '
+	>tracked &&
+	git add tracked &&
+	>untracked &&
+	git stash push -u -- untracked &&
+	test_path_is_missing untracked &&
+	test_path_is_file tracked
+'
+
 test_expect_success 'stash -u -- <non-existant> shows no changes when there are none' '
 	git stash push -u -- non-existant >actual &&
 	echo "No local changes to save" >expect &&

Thomas Gummerer (2):
  stash push: avoid printing errors
  stash push -u: don't create empty stash

 git-stash.sh     | 11 +++++++----
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.16.2.804.g6dcf76e11
