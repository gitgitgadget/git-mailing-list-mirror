Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B5C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF2361029
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhHQRvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhHQRvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:51:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EDC0612A3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b10so31749645eju.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D7lLB7b9HmvsDCMnHMwFTTABabjUTpmNVn/sekC87mI=;
        b=laubahN1er3idHXK2uQo35ajFZn+D4wLsSUkDHSPHjshucgvxIuWFygeyRaz1UZTN2
         8s2XqO1Zza/09oZS6L5bLXqWd7YfNUT7NTmOx5Pv+OCi4ZJnwPuoiMUhOpmqnC1ab7Tt
         M8Phq2PrTW3A8KM6QJ6hXQcLG/TedfX2Fde9TOUmFdQAgzoGJ6lvh9LmgMMqCj7gUhvS
         Z9rS5LyPn0XqnZIvh6pMEpz9ea329rprmlteyOmkwzIY9smFAczWczquCWD8s9PH/gCl
         21ys5e1YgG6/ViYD1sOwGRxQI+5WdN6UqoahHmtcLZ9dkkeUl6rhHz+C0mRapmwo+aD0
         w2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7lLB7b9HmvsDCMnHMwFTTABabjUTpmNVn/sekC87mI=;
        b=gpbpBV/F4srG8kYuTy61jcmj/SAT5JNgVMXk0a9xgQy2dWTbJrwNM+lMl7lgVNg0lf
         lvLRWCyeaSQ7pGa9zVW+oX86ZC9aO9b2eVIO2qgq3MGIWtTUrWaoTmvPV8UPdBMMuJeq
         nOqCSr3VppoD5iVbKjO4zEg7wRiW6X9SH+EBmmnpoKSzey9HelohDloH/b04J/oTrAQV
         Hf+lW/4rNatpH4WRroYa3oALWS2dSgpVh16IoDfKBbTciSxbQccPRYgyO0Fv5bFQWtac
         X4tIibjop2QWqinPchvcBeAvBJKXgD0GtFQ6Ji4tQsBBzzzwusy2isnQRw/N9OHyQNsi
         5U/A==
X-Gm-Message-State: AOAM532wp2GJdE0fTI+ynl08yGSMFDRij3WtNZVWUKWIxHRukWZx50zf
        s+j4N2sdBWp3DEoCcrmZuKqj44Kj9W0=
X-Google-Smtp-Source: ABdhPJwRFpOqMmHmj1IhF9ZKkutAXWKEWli4lZ7AQ6WX0qUXZlnQpEwFfQw/0s3dkT2iGdvEdHh9kw==
X-Received: by 2002:a17:907:9604:: with SMTP id gb4mr5385413ejc.142.1629222612375;
        Tue, 17 Aug 2021 10:50:12 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:50:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 6/6] read-cache: fix GIT_TEST_SPLIT_INDEX
Date:   Tue, 17 Aug 2021 19:49:38 +0200
Message-Id: <20210817174938.3009923-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running tests with GIT_TEST_SPLIT_INDEX=1 is supposed to turn on the
split index feature and trigger index splitting (mostly) randomly.
Alas, this has been broken since 6e37c8ed3c (read-cache.c: fix writing
"link" index ext with null base oid, 2019-02-13), and
GIT_TEST_SPLIT_INDEX=1 hasn't triggered any index splitting since
then.

This patch makes GIT_TEST_SPLIT_INDEX work again, though it doesn't
restore the pre-6e37c8ed3c behavior.  To understand the bug, the fix,
and the behavior change we first have to look at how
GIT_TEST_SPLIT_INDEX used to work before 6e37c8ed3c:

  There are two places where we check the value of
  GIT_TEST_SPLIT_INDEX, and before 6e37c8ed3c they worked like this:

    1) In the lower-level do_write_index(), where, if
       GIT_TEST_SPLIT_INDEX is enabled, we call init_split_index().
       This call merely allocates and zero-initializes
       'istate->split_index', but does nothing else (i.e. doesn't fill
       the base/shared index with cache entries, doesn't actually
       write a shared index file, etc.).  Pertinent to this issue, the
       hash of the base index remains all zeroed out.

    2) In the higher-level write_locked_index(), but only when
       'istate->split_index' has already been initialized.  Then, if
       GIT_TEST_SPLIT_INDEX is enabled, it randomly sets the flag that
       triggers index splitting later in this function.  This
       randomness comes from the first byte of the hash of the base
       index via an 'if ((first_byte & 15) < 6)' condition.

       However, if 'istate->split_index' hasn't been initialized (i.e.
       it is still NULL), then write_locked_index() just calls
       do_write_locked_index(), which internally calls the above
       mentioned do_write_index().

  This means that while GIT_TEST_SPLIT_INDEX=1 usually triggered index
  splitting randomly, the first two index writes were always
  deterministic (though I suspect this was unintentional):

    - The initial index write never splits the index.
      During the first index write write_locked_index() is called with
      'istate->split_index' still uninitialized, so the check in 2) is
      not executed.  It still calls do_write_index(), though, which
      then executes the check in 1).  The resulting all zero base
      index hash then leads to the 'link' extension being written to
      '.git/index', though a shared index file is not written:

        $ rm .git/index
        $ GIT_TEST_SPLIT_INDEX=1 git update-index --add file
        $ test-tool dump-split-index .git/index
        own c6ef71168597caec8553c83d9d0048f1ef416170
        base 0000000000000000000000000000000000000000
        100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 file
        replacements:
        deletions:
        $ ls -l .git/sharedindex.*
        ls: cannot access '.git/sharedindex.*': No such file or directory

    - The second index write always splits the index.
      When the index written in the previous point is read,
      'istate->split_index' is initialized because of the presence of
      the 'link' extension.  So during the second write
      write_locked_index() does run the check in 2), and the first
      byte of the all zero base index hash always fulfills the
      randomness condition, which in turn always triggers the index
      splitting.

    - Subsequent index writes will find the 'link' extension with a
      real non-zero base index hash, so from then on the check in 2)
      is executed and the first byte of the base index hash is as
      random as it gets (coming from the SHA-1 of index data including
      timestamps and inodes...).

All this worked until 6e37c8ed3c came along, and stopped writing the
'link' extension if the hash of the base index was all zero:

  $ rm .git/index
  $ GIT_TEST_SPLIT_INDEX=1 git update-index --add file
  $ test-tool dump-split-index .git/index
  own abbd6f6458d5dee73ae8e210ca15a68a390c6fd7
  not a split index
  $ ls -l .git/sharedindex.*
  ls: cannot access '.git/sharedindex.*': No such file or directory

So, since the first index write with GIT_TEST_SPLIT_INDEX=1 doesn't
write a 'link' extension, in the second index write
'istate->split_index' remains uninitialized, and the check in 2) is
not executed, and ultimately the index is never split.

Fix this by modifying write_locked_index() to make sure to check
GIT_TEST_SPLIT_INDEX even if 'istate->split_index' is still
uninitialized, and initialize it if necessary.  The check for
GIT_TEST_SPLIT_INDEX and separate init_split_index() call in
do_write_index() thus becomes unnecessary, so remove it.  Furthermore,
add a test to 't1700-split-index.sh' to make sure that
GIT_TEST_SPLIT_INDEX=1 will keep working (though only check the
index splitting on the first index write, because after that it will
be random).

Note that this change does not restore the pre-6e37c8ed3c behaviour,
as it will deterministically split the index already on the first
index write.  Since GIT_TEST_SPLIT_INDEX is purely a developer aid,
there is no backwards compatibility issue here.  The new behaviour did
trigger test failures in 't0003-attributes.sh' and 't1600-index.sh',
though, which have been fixed in preparatory patches in this series.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 read-cache.c           | 23 ++++++++++++++---------
 t/t1700-split-index.sh | 11 +++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index fbd59886a3..335242c1cf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2824,11 +2824,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		}
 	}
 
-	if (!istate->version) {
+	if (!istate->version)
 		istate->version = get_index_format_default(the_repository);
-		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
-			init_split_index(istate);
-	}
 
 	/* demote version 3 to version 2 when the latter suffices */
 	if (istate->version == 3 || istate->version == 2)
@@ -3255,7 +3252,7 @@ static int too_many_not_shared_entries(struct index_state *istate)
 int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		       unsigned flags)
 {
-	int new_shared_index, ret;
+	int new_shared_index, ret, test_split_index_env;
 	struct split_index *si = istate->split_index;
 
 	if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
@@ -3270,7 +3267,10 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (istate->fsmonitor_last_update)
 		fill_fsmonitor_bitmap(istate);
 
-	if (!si || alternate_index_output ||
+	test_split_index_env = git_env_bool("GIT_TEST_SPLIT_INDEX", 0);
+
+	if ((!si && !test_split_index_env) ||
+	    alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			oidclr(&si->base_oid);
@@ -3278,10 +3278,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		goto out;
 	}
 
-	if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0)) {
-		int v = si->base_oid.hash[0];
-		if ((v & 15) < 6)
+	if (test_split_index_env) {
+		if (!si) {
+			si = init_split_index(istate);
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
+		} else {
+			int v = si->base_oid.hash[0];
+			if ((v & 15) < 6)
+				istate->cache_changed |= SPLIT_INDEX_ORDERED;
+		}
 	}
 	if (too_many_not_shared_entries(istate))
 		istate->cache_changed |= SPLIT_INDEX_ORDERED;
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index e2aa0bd949..decd2527ed 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -533,4 +533,15 @@ test_expect_success 'reading split index at alternate location' '
 	test_cmp expect actual
 '
 
+test_expect_success 'GIT_TEST_SPLIT_INDEX works' '
+	git init git-test-split-index &&
+	(
+		cd git-test-split-index &&
+		>file &&
+		GIT_TEST_SPLIT_INDEX=1 git update-index --add file &&
+		ls -l .git/sharedindex.* >actual &&
+		test_line_count = 1 actual
+	)
+'
+
 test_done
-- 
2.33.0.453.gc5e41af357

