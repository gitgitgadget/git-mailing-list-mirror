Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A981F404
	for <e@80x24.org>; Mon, 19 Mar 2018 23:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755949AbeCSXS4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 19:18:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37333 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755941AbeCSXSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 19:18:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id 139so78609wmn.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UkmqR+SjO9BU0XsheJQJfKpqvEQpYNfaPWZ6t1jJ3jU=;
        b=ZPQvh452PulrMOeiOWHc941EUZa6kV8QHGhYAKtaWQxQjvMx8hPySUrBromL8zpyH9
         1IQmzMC64L9uU2aOxcqpyaqH/YNNYCShc4vEPQ+GR0wQuHE+Cau8spNEKSLALWNDNJs8
         sNdkUKDXfPzboehGhSHHreUP8lJL5aml1wY2eDkkcCZlcV+bBrwKDHtD2DmUeMwtnupg
         n2Nu16rF86VBa8/gQh4mqCqzgfLLzz9EUB9V06jN5QcD/oeQPSJxYkLzPS4fwfu34Ac0
         vSYn+AQOBFBucLOeikviDPY/eCH0a/yzNusfz7VdTSSK1u+GTNqwekXFEz9E7FmDAEp7
         25lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UkmqR+SjO9BU0XsheJQJfKpqvEQpYNfaPWZ6t1jJ3jU=;
        b=WisJFjX7a5HY9UO04sz4Sb8H/cDgHSSuX+AcQkrH4BDrKz/hyiFbQ+IDXR6LctrS3/
         GcGLtT5VWGR6hVIRSrmF/5KTpOIWdjMmT7CcZaV0ViYSeQD+bW/pMF7OQiO4OAzA/RTy
         lbqr3+W2NSAjnMYHm+OeOWkLeEXVtqN5gq/WRadQxbCPFHiKnvnx8rjgIuX6UPwV6+F8
         LeU23r0zXW5z4JG3X3Wg+oDr342DtOsuR4IZe421FrHWykEK3pqKP5iS2OhfNsSD1REX
         D2LP7xS1tn6luTYjzpugrzEMBC0k4Ggua7be3NrN7rE8kvjzgZ6MERCKJDCADHA47QPc
         qCPQ==
X-Gm-Message-State: AElRT7Fg+0soJ1WIMyCubMIWQPh5ofaQSpXVHflnsEYe7XgVNI7hlvv7
        b3Ug8oiwg+8ra1FYQIeuAYEX7eFC
X-Google-Smtp-Source: AG47ELvyA4xDVGNoGKOvtX/toQPACuznd8UoAJQ+TYUM18VbZaNLSNFFOMz/6T3jLyZeCzem8fzJnA==
X-Received: by 10.28.35.76 with SMTP id j73mr317760wmj.103.1521501533840;
        Mon, 19 Mar 2018 16:18:53 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f14sm376159wmi.11.2018.03.19.16.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 16:18:52 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 2/3] stash push: avoid printing errors
Date:   Mon, 19 Mar 2018 23:21:55 +0000
Message-Id: <20180319232156.30916-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.33.g3165b24a68
In-Reply-To: <20180319232156.30916-1-t.gummerer@gmail.com>
References: <20180316223715.108044-1-gitster@pobox.com>
 <20180319232156.30916-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Fix this by avoiding the 'git clean' if a pathspec is given, and use the
pipeline that's used for pathspec mode to get rid of the untracked files
as well.

Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh                       |  6 +++--
 t/t3905-stash-include-untracked.sh | 46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4c92ec931f..5e06f96da5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -308,14 +308,16 @@ push_stash () {
 	if test -z "$patch_mode"
 	then
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
-		if test -n "$untracked"
+		if test -n "$untracked" && test $# = 0
 		then
 			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
 		if test $# != 0
 		then
-			git add -u -- "$@"
+			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
+			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
+			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
 			git diff-index -p --cached --binary HEAD -- "$@" |
 			git apply --index -R
 		else
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index bfde4057ad..2f9045553e 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -228,4 +228,50 @@ test_expect_success 'stash previously ignored file' '
 	test_path_is_file ignored.d/foo
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
+test_expect_success 'stash -u -- <tracked> <untracked> clears changes in both' '
+	>tracked &&
+	git add tracked &&
+	>untracked &&
+	git stash push -u -- tracked untracked &&
+	test_path_is_missing tracked &&
+	test_path_is_missing untracked
+'
+
+test_expect_success 'stash --all -- <ignored> stashes ignored file' '
+	>ignored.d/bar &&
+	git stash push --all -- ignored.d/bar &&
+	test_path_is_missing ignored.d/bar
+'
+
+test_expect_success 'stash --all -- <tracked> <ignored> clears changes in both' '
+	>tracked &&
+	git add tracked &&
+	>ignored.d/bar &&
+	git stash push --all -- tracked ignored.d/bar &&
+	test_path_is_missing tracked &&
+	test_path_is_missing ignored.d/bar
+'
+
+test_expect_success 'stash -u -- <ignored> leaves ignored file alone' '
+	>ignored.d/bar &&
+	git stash push -u -- ignored.d/bar &&
+	test_path_is_file ignored.d/bar
+'
+
 test_done
-- 
2.15.1.33.g3165b24a68

