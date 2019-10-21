Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39A11F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfJUQBJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:01:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36394 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUQBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:01:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so4252714wmd.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZInRNAA5CbZgJHsyHtxLosgGU6+gqfvMFdYH4Oeahs=;
        b=KuR+aQDJMBT+x1QQM/RZp6/vJ5wxswpm9VYOgpUs9/hGNGcKWbj5fChyH3TejvX/tn
         kYWpUctaAu05WxHdDkX1NM7bYVSYZ4wQx2VLzrv7AB8I9A3SFIauLaXTsPIYzSwL3Yo6
         QShKXC1bFMx0cVGuXVSPgPGLkT08uXQgzs1se2GQ9ULL8t/0wL2dwOtkC3tdChk0CLF3
         DnCBEVwkWj5FIZhwgIGyChEv4zHiRf+sOygMLRgj+iSESJjCYwYlZEUdyLmVLAmR+09Y
         vWr1LOin9vY6lNLrGnBqpZP+ynDGs3zNBoqfg9ukWkH4jVflZfEbRaIC8ZonRxJN6YCL
         ZFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZInRNAA5CbZgJHsyHtxLosgGU6+gqfvMFdYH4Oeahs=;
        b=arEw0tfkUY8XrNnWirMqTneHdwJmoSMmSZ8ygQA/oN5Hlxdb0SAKLL04o5SfgDEcF/
         Zd/LgS4FN8TlPZsF9zFBF1zQkkMg5Dxj5pb4uY7FyvEmNmA32lPwZXZT7oFF3OrjQDlJ
         8lo2pPLM5V7hRUFKaGAC3wDzTIA7IAdfzCDFTHzpeXoHxwI0wV88cf2GWmXpEbRrpxvq
         xwleTB/dCOTegE0QHbEnZa676EPDXk64ZvH59jgnqXciyzWNiF74n6roxKTufUGA2JkQ
         YnMKYwqOyc/HJIw1p6m4LAtZY104LZIMVynNeyQCJGZrn3Uatsx+8wa91LrRkEOb+GWT
         QuKA==
X-Gm-Message-State: APjAAAU+ls24knt9MJy0C3lq0777I/EYzEIWxaj0QPCiLohTHY3fLm/T
        Mz83ZOki2l5fppwT6+RvaN8=
X-Google-Smtp-Source: APXvYqzECrdJmLQSQyq0DoMPkR3urd/8aweTx3oJCCCZ1kGr1Ji5ehoA0IzKC+N2yKCL+nZ39Fzqeg==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr21267399wmj.51.1571673664575;
        Mon, 21 Oct 2019 09:01:04 -0700 (PDT)
Received: from localhost.localdomain (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id u26sm16293196wrd.87.2019.10.21.09.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 09:01:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] path.c: don't call the match function without value in trie_find()
Date:   Mon, 21 Oct 2019 18:00:43 +0200
Message-Id: <20191021160043.701-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.472.ga6f06c86b4
In-Reply-To: <20191021160043.701-1-szeder.dev@gmail.com>
References: <20191021160043.701-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'logs/refs' is not a working tree-specific path, but since commit
b9317d55a3 (Make sure refs/rewritten/ is per-worktree, 2019-03-07)
'git rev-parse --git-path' has been returning a bogus path if a
trailing '/' is present:

  $ git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
  /home/szeder/src/git/.git/logs/refs
  /home/szeder/src/git/.git/worktrees/WT/logs/refs/

We use a trie data structure to efficiently decide whether a path
belongs to the common dir or is working tree-specific.  As it happens
b9317d55a3 triggered a bug that is as old as the trie implementation
itself, added in 4e09cf2acf (path: optimize common dir checking,
2015-08-31).

  - According to the comment describing trie_find(), it should only
    call the given match function 'fn' for a "/-or-\0-terminated
    prefix of the key for which the trie contains a value".  This is
    not true: there are three places where trie_find() calls the match
    function, but one of them is missing the check for value's
    existence.

  - b9317d55a3 added two new keys to the trie: 'logs/refs/rewritten'
    and 'logs/refs/worktree', next to the already existing
    'logs/refs/bisect'.  This resulted in a trie node with the path
    'logs/refs', which didn't exist before, and which doesn't have a
    value attached.  A query for 'logs/refs/' finds this node and then
    hits that one callsite of the match function which doesn't check
    for the value's existence, and thus invokes the match function
    with NULL as value.

  - When the match function check_common() is invoked with a NULL
    value, it returns 0, which indicates that the queried path doesn't
    belong to the common directory, ultimately resulting the bogus
    path shown above.

Add the missing condition to trie_find() so it will never invoke the
match function with a non-existing value.  check_common() will then no
longer have to check that it got a non-NULL value, so remove that
condition.

I believe that there are no other paths that could cause similar bogus
output.  AFAICT the only other key resulting in the match function
being called with a NULL value is 'co' (because of the keys 'common'
and 'config').  However, as they are not in a directory that belongs
to the common directory the resulting working tree-specific path is
expected.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 path.c                | 11 ++++++-----
 t/t0060-path-utils.sh |  2 ++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index cf57bd52dd..e21b00c4d4 100644
--- a/path.c
+++ b/path.c
@@ -299,9 +299,13 @@ static int trie_find(struct trie *root, const char *key, match_fn fn,
 
 	/* Matched the entire compressed section */
 	key += i;
-	if (!*key)
+	if (!*key) {
 		/* End of key */
-		return fn(key, root->value, baton);
+		if (root->value)
+			return fn(key, root->value, baton);
+		else
+			return -1;
+	}
 
 	/* Partial path normalization: skip consecutive slashes */
 	while (key[0] == '/' && key[1] == '/')
@@ -345,9 +349,6 @@ static int check_common(const char *unmatched, void *value, void *baton)
 {
 	struct common_dir *dir = value;
 
-	if (!dir)
-		return 0;
-
 	if (dir->is_dir && (unmatched[0] == 0 || unmatched[0] == '/'))
 		return dir->is_common;
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index c7b53e494b..501e1a288d 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -288,6 +288,8 @@ test_git_path GIT_COMMON_DIR=bar index                    .git/index
 test_git_path GIT_COMMON_DIR=bar HEAD                     .git/HEAD
 test_git_path GIT_COMMON_DIR=bar logs/HEAD                .git/logs/HEAD
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisect/foo     .git/logs/refs/bisect/foo
+test_git_path GIT_COMMON_DIR=bar logs/refs                bar/logs/refs
+test_git_path GIT_COMMON_DIR=bar logs/refs/               bar/logs/refs/
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisec/foo      bar/logs/refs/bisec/foo
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisec          bar/logs/refs/bisec
 test_git_path GIT_COMMON_DIR=bar logs/refs/bisectfoo      bar/logs/refs/bisectfoo
-- 
2.24.0.rc0.472.ga6f06c86b4

