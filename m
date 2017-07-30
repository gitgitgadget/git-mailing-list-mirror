Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA532089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbdG3LQk (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:16:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34689 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdG3LQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:16:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id t86so1974537pfe.1
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QhNnY67S93ieFxFas5WEpP6VConSbFrKjj45PEVuGDg=;
        b=kbEBTb+qXmkcrCmGCRF4c2kBFiI+sQLW2w8a5bxrsXApImGHRWPjOU7H543zpszLW3
         tJTeGtB5KRb5m8ZdAyjLGBEj4j8W09Tk5i191Fz80ETwxjn6WqYlHxYprVKqTkNruLIV
         R4ORxk1YYDj1vRvciBpnj0p9yuHBuc44sGISVS6YnpnlskJIu5iewzJkN1Q5GcWPj7la
         f5nDNTBPPHjPjfycJfbKoDgD9yKbcvo3/rnAX0T5ht3F6bzixeXc+uX3u78vcl8gw84V
         xMS8MLqadJ8jHxohvQu1DTsrGjeGh1MtNR6mSByMDjSlWz6QA394dLveUvGrNP4dlEKS
         z7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QhNnY67S93ieFxFas5WEpP6VConSbFrKjj45PEVuGDg=;
        b=WgPbcZhxci4+erWP2ff5HooDZj8UBGpKghdbBG4ZpBCrx2e+0nbuVt3mhnCuiPyTVQ
         3VUfNaepikdDgwARvEnnqrmNPNh+UJYy1X3amBm4blwQlJSO6sEuVJEgh6bru4ye93O6
         nwniUEk8Hlp+a32RlqNTmP7aXZfBwHsb2+29vyC0kIEZ8u5YcMiUhH2s6Fz2KRCAh+oX
         hn0m/ZngQNVJiWBJhm8BUbTchfIoBsvk6GVW1nxzFVDQ4UKUsY5Tipnbpj6cqDku7J37
         E+dvkgrskt2F4mFAeeke7cAtz7nRecffseTzlwvd8/vf6oc/t1pZt1NaSf/3P03/wsHB
         4mTA==
X-Gm-Message-State: AIVw112wgDgj60NqLQJdH+gab54vIjyrRBK2GMHtLPtCw7MnsM07RF1r
        mNR3yyAiN0Zy0A==
X-Received: by 10.84.128.9 with SMTP id 9mr5647124pla.98.1501413399094;
        Sun, 30 Jul 2017 04:16:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.gmail.com with ESMTPSA id t12sm25069004pfg.12.2017.07.30.04.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2017 04:16:38 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] remote: split and simplify messages
Date:   Sun, 30 Jul 2017 16:47:05 +0530
Message-Id: <20170730111705.12444-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <0102015d7f0c9403-16bd1de5-3b6c-4d23-a3fb-75a26c378c62-000000@eu-west-1.amazonses.com>
References: <0102015d7f0c9403-16bd1de5-3b6c-4d23-a3fb-75a26c378c62-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Splitting a single sentence across multiple lines could
degrade readability. Further, long messages are likely
to be ignored by users.

Split the sentences and simplify it to improve their readability.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 remote.c                   | 18 ++++-----
 t/t2020-checkout-detach.sh |  3 +-
 t/t7508-status.sh          | 96 +++++++++++++++++++++++-----------------------
 3 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/remote.c b/remote.c
index 60d004392..e4e241d5e 100644
--- a/remote.c
+++ b/remote.c
@@ -2093,10 +2093,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
 		strbuf_addf(sb,
-			Q_("Your branch is behind '%s' by %d commit, "
-			       "and can be fast-forwarded.\n",
-			   "Your branch is behind '%s' by %d commits, "
-			       "and can be fast-forwarded.\n",
+			Q_("Your branch is behind '%s' by %d commit.\n"
+			       "It can be fast-forwarded.\n",
+			   "Your branch is behind '%s' by %d commits.\n"
+			       "It can be fast-forwarded.\n",
 			   theirs),
 			base, theirs);
 		if (advice_status_hints)
@@ -2104,12 +2104,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
 		strbuf_addf(sb,
-			Q_("Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commit each, "
-			       "respectively.\n",
-			   "Your branch and '%s' have diverged,\n"
-			       "and have %d and %d different commits each, "
-			       "respectively.\n",
+			Q_("Your branch and '%s' have diverged.\n"
+			       "They have %d and %d different commit, respectively.\n",
+			   "Your branch and '%s' have diverged.\n"
+			       "They have %d and %d different commits, respectively.\n",
 			   ours + theirs),
 			base, ours, theirs);
 		if (advice_status_hints)
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index fbb4ee9bb..4e1c74c87 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -150,7 +150,8 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 '
 
 cat >expect <<'EOF'
-Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
+Your branch is behind 'master' by 1 commit.
+It can be fast-forwarded.
   (use "git pull" to update your local branch)
 EOF
 test_expect_success 'tracking count is accurate after orphan check' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 43d19a9b2..fd7f27ee0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -88,8 +88,8 @@ EOF
 test_expect_success 'status --column' '
 	cat >expect <<\EOF &&
 # On branch master
-# Your branch and '\''upstream'\'' have diverged,
-# and have 1 and 2 different commits each, respectively.
+# Your branch and '\''upstream'\'' have diverged.
+# They have 1 and 2 different commits, respectively.
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
@@ -122,8 +122,8 @@ test_expect_success 'status --column status.displayCommentPrefix=false' '
 
 cat >expect <<\EOF
 # On branch master
-# Your branch and 'upstream' have diverged,
-# and have 1 and 2 different commits each, respectively.
+# Your branch and 'upstream' have diverged.
+# They have 1 and 2 different commits, respectively.
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
@@ -199,8 +199,8 @@ test_expect_success 'commit ignores status.displayCommentPrefix=false in COMMIT_
 
 cat >expect <<\EOF
 On branch master
-Your branch and 'upstream' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and 'upstream' have diverged.
+They have 1 and 2 different commits, respectively.
 
 Changes to be committed:
 	new file:   dir2/added
@@ -272,8 +272,8 @@ test_expect_success 'status with gitignore' '
 
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -341,8 +341,8 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -414,8 +414,8 @@ test_expect_success 'setup dir3' '
 test_expect_success 'status -uno' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -444,8 +444,8 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 test_expect_success 'status -uno (advice.statusHints false)' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
 
 Changes to be committed:
 	new file:   dir2/added
@@ -478,8 +478,8 @@ test_expect_success 'status -s (status.showUntrackedFiles no)' '
 test_expect_success 'status -unormal' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -536,8 +536,8 @@ test_expect_success 'status -s (status.showUntrackedFiles normal)' '
 test_expect_success 'status -uall' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -599,8 +599,8 @@ test_expect_success 'status -s (status.showUntrackedFiles all)' '
 test_expect_success 'status with relative paths' '
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -670,8 +670,8 @@ test_expect_success 'setup unique colors' '
 test_expect_success 'status with color.ui' '
 	cat >expect <<\EOF &&
 On branch <GREEN>master<RESET>
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -796,8 +796,8 @@ test_expect_success 'status --porcelain respects -b' '
 test_expect_success 'status without relative paths' '
 	cat >expect <<\EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -846,8 +846,8 @@ test_expect_success 'status -s without relative paths' '
 test_expect_success 'dry-run of partial commit excluding new file in index' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -890,8 +890,8 @@ test_expect_success 'setup status submodule summary' '
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -950,8 +950,8 @@ head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 test_expect_success 'status submodule summary' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 1 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 1 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1012,8 +1012,8 @@ test_expect_success 'status -s submodule summary' '
 test_expect_success 'status submodule summary (clean submodule): commit' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes not staged for commit:
@@ -1062,8 +1062,8 @@ test_expect_success 'status -z implies porcelain' '
 test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	cat >expect <<EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1119,8 +1119,8 @@ touch .gitmodules
 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1231,8 +1231,8 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1291,8 +1291,8 @@ head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1375,8 +1375,8 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 
 cat > expect << EOF
 ; On branch master
-; Your branch and 'upstream' have diverged,
-; and have 2 and 2 different commits each, respectively.
+; Your branch and 'upstream' have diverged.
+; They have 2 and 2 different commits, respectively.
 ;   (use "git pull" to merge the remote branch into yours)
 ;
 ; Changes to be committed:
@@ -1426,8 +1426,8 @@ test_expect_success "status (core.commentchar with two chars with submodule summ
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes not staged for commit:
@@ -1454,8 +1454,8 @@ EOF
 test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summary' '
 	cat > expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
@@ -1577,8 +1577,8 @@ test_expect_success 'git commit --dry-run will show a staged but ignored submodu
 	git add sm &&
 	cat >expect << EOF &&
 On branch master
-Your branch and '\''upstream'\'' have diverged,
-and have 2 and 2 different commits each, respectively.
+Your branch and '\''upstream'\'' have diverged.
+They have 2 and 2 different commits, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-- 
2.14.0.rc1.434.g6eded367a

