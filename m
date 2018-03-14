Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8071F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeCNVnh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:43:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51743 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVng (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:43:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id h21so6793276wmd.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BIO353On3MbGDRiwJweSx3Hchm38l8RzO20xVvAFsA4=;
        b=M5H5tOX4ouMnoeLcd+U4a1G6Ol0lrBioxdycm6zRF6r0B3ufhS/8TsT3SW0S6njxe5
         xZgBqzNUpnwKnyVzt+JLRvl7AG/RRoxMdO/3vl04SjRNuZNwcYmO3w+SyYSBWFQmiuhV
         iF6UQ5bP2SpH7ymrj2ZvX3u5xT4VqJaYfUYNWd+8aoroec+q4DhZ5dKRhmz8T+BTLIAM
         8uu42erJeCJDzPHm5unh4+EGhF3GH9m/zv5A6W7mwtu0cfP69Bwy+R3hx+I+5KfsWirt
         WX7SJav8GgJs1zaS4HdNkIXxZTUm9N8DtvBUzZodbCH+JwIlgMLTUXZvlSqg4kvSuiSd
         dy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BIO353On3MbGDRiwJweSx3Hchm38l8RzO20xVvAFsA4=;
        b=QaBtXdF7CSeG+Dg5UBue8vdhXpICREV064H5cMaqCoS5Asnywklc6PM9lIy6uSS0pF
         R/Ls6RAYfWh1m2YwMhMb722nakKTAsHmkM1P+NPBoUOSyrs2TlUja4lIeBwSPXcCbs9K
         vl09wilUFY3kPcg5GXh42CJtoJxQzokVDA/pbF5BtH1A2IBiMf5LImIsiCIv4BN5Y1nj
         cDmGz2RqAQ5m7cF1E0p9xXTGUX37+jWVOWUE6G1BbPs13H+D6y0E8Gjl8Ky/0Qrm57il
         QK4zqQbLSW9kCKkEcgwq639gBKiG47g9VQ+MS9yYoXbzBh8iC2yFsCV7Y5gfMVk9Fl6I
         CxBA==
X-Gm-Message-State: AElRT7Em0LuQ6o78QxkjH+WZBkrVDkQRiyfE/bRgCjNWirH4D4LM993g
        YHGg4unXJU8pCW/xkkPTcpH5+pCR
X-Google-Smtp-Source: AG47ELs5PybW+RsXaFYHId0EbgWFcRkGTjaTiWSV8T3Qzwa+znnFe6YR8J1M6eAV5DKGmvRNyxyZxA==
X-Received: by 10.28.191.70 with SMTP id p67mr3134132wmf.17.1521063814326;
        Wed, 14 Mar 2018 14:43:34 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i66sm2908884wmd.0.2018.03.14.14.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 14:43:33 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] stash push: avoid printing errors
Date:   Wed, 14 Mar 2018 21:46:41 +0000
Message-Id: <20180314214642.22185-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e11
In-Reply-To: <20180310111215.GA14732@hank>
References: <20180310111215.GA14732@hank>
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

> Either way I'll try to address this as soon as I can get some
> time to look at it.

I finally got around to do this.  The fix (in the second patch) turns
out to be fairly simple, I just forgot to pass the pathspec along to
one function whene originally introducing the pathspec feature in git
stash push (more explanation in the commit message for the patch
itself).  Thanks Marc for reporting the two breakages!

v2 also fixes a couple of typos in the first patch which I failed to
notice when I sent it out last time.

 git-stash.sh     | 2 +-
 t/t3903-stash.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index fc8f8ae640..058ad0bed8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -320,7 +320,7 @@ push_stash () {
 			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
-		if test $# != 0
+		if test $# != 0 && git ls-files --error-unmatch -- "$@" >/dev/null 2>/dev/null
 		then
 			git add -u -- "$@" |
 			git checkout-index -z --force --stdin
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b172..fbfda4b243 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,4 +1096,11 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_success 'stash -u -- <untracked> doesnt print error' '
+	>untracked &&
+	git stash push -u -- untracked 2>actual &&
+	test_path_is_missing untracked &&
+	test_line_count = 0 actual
+'
+
 test_done
-- 
2.16.2.804.g6dcf76e11

