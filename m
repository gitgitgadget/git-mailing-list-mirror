Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AAC1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeFQF7S (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:18 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43974 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753576AbeFQF7M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:12 -0400
Received: by mail-ot0-f194.google.com with SMTP id i19-v6so15208630otk.10
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bUBzVeE6v3BztA0jaCRuxBP8fuIC3fLnqz+pqzq4odg=;
        b=iGA254c5UmtSrkvuJpGCk5pqY71+rz137O+kCE1LYEpYVBvvhtFMOlW8sTh+jrqJMp
         8KKeR3s/89nzadgL03AbXwZ46JE40CFfHopiSjf+zKYM4u7ka0AHFUC7+WbJjmuniTz9
         bh72QK03JsYE7O4zGnqpIDzRbuvZUzblusvfKzqgBfJhyLk1als+DiOmmKHyspHK8qdI
         vUe4AO81Xm/7cOfir52tR7TopKn2H3VbUl+RqP11WgWu0P3140UWfTMB5UjAr6ZBZw3A
         KZFKWBfOhZBRrSB+Pk+T8yRFG84qVsC8gejhIDrVQialQKVlXuZ0G6FucdDKLzRypI6R
         UGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bUBzVeE6v3BztA0jaCRuxBP8fuIC3fLnqz+pqzq4odg=;
        b=P4zw+q5jjr+NgvGtini/Tu/xGALMuFVUaHm9yivauDo6ioBmX0ucuaNHTkY1g+TUlk
         TSh8lcT60RfNCZad2SStHK5Al5X4ePe0CimSsYSmiEXaf+37bGoQO5vTEo7nuV0Aj0pO
         NYVnJZnRn1ByTfIEPVHansqNNZmnq9EjTx6sOIN/odZK97AfiZ1FOGkzP0nytFCHgU+j
         2TzGMz17PlxT7PUI60z57bYaCs2y7+XwrKsv4ajZ7jdqeCpRX4nP3gloP4T+w3xH1Uy+
         0cLkHiY+FHkiLXY4eAQ0HV0y9kXyBknkjDiCA6bWShRS7xsJs5tU/ywYcpGVGIREeF+m
         zv0w==
X-Gm-Message-State: APt69E28/zNKez40hMx9N1VqLK1nWPjj7j3RZfPytD4RLqhGh5HM70Re
        dpYxlEjZ/AgkJ8K4ewL1betuHA==
X-Google-Smtp-Source: ADUXVKJ15m6VArNxoYoDSPhr1bsC/wZafsWrBsPmH7A1tH90r08B7gH42eTLtHdX4ZYV3bJRrDKn7Q==
X-Received: by 2002:a9d:307:: with SMTP id 7-v6mr5335084otv.300.1529215151689;
        Sat, 16 Jun 2018 22:59:11 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 7/7] git-rebase: make --allow-empty-message the default
Date:   Sat, 16 Jun 2018 22:58:56 -0700
Message-Id: <20180617055856.22838-8-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

am-based rebases already apply commits with an empty commit message
without requiring the user to specify an extra flag.  Make merge-based and
interactive-based rebases behave the same.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt  | 10 ----------
 git-rebase.sh                 |  2 +-
 t/t3404-rebase-interactive.sh |  7 ++++---
 t/t3405-rebase-malformed.sh   | 11 +++--------
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7a2ed9efdc..a5608f481f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -562,16 +562,6 @@ BEHAVIORAL INCONSISTENCIES
     The --keep-empty option exists for interactive rebases to allow
     it to keep commits that started empty.
 
-  * empty commit messages:
-
-    am-based rebase will silently apply commits with empty commit
-    messages.
-
-    merge-based and interactive-based rebases will by default halt
-    on any such commits.  The --allow-empty-message option exists to
-    allow interactive-based rebases to apply such commits without
-    halting.
-
   * directory rename detection:
 
     merge-based and interactive-based rebases work fine with
diff --git a/git-rebase.sh b/git-rebase.sh
index 5f891214fa..bf033da4e5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -95,7 +95,7 @@ rebase_cousins=
 preserve_merges=
 autosquash=
 keep_empty=
-allow_empty_message=
+allow_empty_message=--allow-empty-message
 signoff=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c65826ddac..f84fa63b15 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -553,15 +553,16 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 '
 
 test_expect_success 'aborted --continue does not squash commits after "edit"' '
+	test_when_finished "git rebase --abort" &&
 	old=$(git rev-parse HEAD) &&
 	test_tick &&
 	set_fake_editor &&
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	echo "edited again" > file7 &&
 	git add file7 &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue &&
-	test $old = $(git rev-parse HEAD) &&
-	git rebase --abort
+	echo all the things >>conflict &&
+	test_must_fail git rebase --continue &&
+	test $old = $(git rev-parse HEAD)
 '
 
 test_expect_success 'auto-amend only edited commits after "edit"' '
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index cb7c6de84a..da94dddc86 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -77,19 +77,14 @@ test_expect_success 'rebase commit with diff in message' '
 '
 
 test_expect_success 'rebase -m commit with empty message' '
-	test_must_fail git rebase -m master empty-message-merge &&
-	git rebase --abort &&
-	git rebase -m --allow-empty-message master empty-message-merge
+	git rebase -m master empty-message-merge
 '
 
 test_expect_success 'rebase -i commit with empty message' '
 	git checkout diff-in-message &&
 	set_fake_editor &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
-		git rebase -i HEAD^ &&
-	git rebase --abort &&
-	FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
-		git rebase -i --allow-empty-message HEAD^
+	env FAKE_COMMIT_MESSAGE=" " FAKE_LINES="reword 1" \
+		git rebase -i HEAD^
 '
 
 test_done
-- 
2.18.0.rc2.1.g5453d3f70b.dirty

