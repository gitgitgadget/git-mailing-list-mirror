Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0870F20248
	for <e@80x24.org>; Sun,  7 Apr 2019 23:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDGXnd (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 19:43:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35576 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDGXnc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 19:43:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so12730838wmd.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Fd32clWMrdA/u2J+Dlj5swAPHfLl7PbzUpnhsonPeg=;
        b=bjH7Lj7BcEIwuLfSLuhWnZ3ekWX15lmIB7LQ9oBnVb4etrR+k15o0icctH8H3aOLE5
         jXQSvf1GUXY5OObAbDZzPd8Sd7L+WZpEwnr3qtgUeH3cBaoc1pfQ59ouGylbh49SNpYi
         3Ilgzn7zsV0oTFfsahzQ8oce8rPZxesD4Af9ouC27cPuqsiWowQFETLdamF4QcSE4w9O
         ILsMcDxCqUtvDpQ5kpYu8IZipoqSswrhlEyN/hqpxuhk7RjDG8k9HW4xmxpbEpZBMNL3
         HMAZAcfJjVpZLVn8utG83+D8qAvrbu1+Pyl4/vYHfGzxkIu+hbwt+vTeDjJGSI/DMmLD
         H9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Fd32clWMrdA/u2J+Dlj5swAPHfLl7PbzUpnhsonPeg=;
        b=hxECk+FkUsrPIKhZtTVWDv3oSacv2cra3g6UKcbd+Rkob5oIVMXzvXzWQCL7gDo14F
         kPfwj/m3wQDsL7cir7tjryLTLSk1fjf3zfEhtE0l5cbsVODTmc3L+1nkz1EO20G12F+0
         lUJ4R+aJo7/22KKdhE3HOdygo5wCLuIEkKrQNgTzf9qL3El2S/GwGudpqmJCcN8ZyWeg
         IYInDv0szAcQFOrDHKgh7mTV+i2XGXXHQYy/Y3KQYydtnPGlkipTeRJmZGdjn2cKnxzg
         eZU0zFb1t8L4ollJmOWWKOj59zG9IElKOHDSRXgKNJ6aRhO4NjTmFfD/mP3pXdJzfZWu
         EIZQ==
X-Gm-Message-State: APjAAAWH/wW/iI0n5L1OnZvtjv+rCdhqazIBuzmqD5QIbF9aPivcCX+D
        YZWvV6TGryjgHzn1Fx1tS+HQBfjP
X-Google-Smtp-Source: APXvYqxYgNf2LR6KwmzLEPp6AzeT4vNP7GSRhcuFdBeXQ5GV0WsiZe5SyHB2nBvRYPTq5X3n9LV7rw==
X-Received: by 2002:a1c:cbc5:: with SMTP id b188mr15240229wmg.87.1554680610726;
        Sun, 07 Apr 2019 16:43:30 -0700 (PDT)
Received: from localhost.localdomain (x4db34ad6.dyn.telefonica.de. [77.179.74.214])
        by smtp.gmail.com with ESMTPSA id e7sm7906320wme.37.2019.04.07.16.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Apr 2019 16:43:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] blame: default to HEAD in a bare repo when no start commit is given
Date:   Mon,  8 Apr 2019 01:43:27 +0200
Message-Id: <20190407234327.25617-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git blame' is invoked without specifying the commit to start
blaming from, it starts from the given file's state in the work tree.
However, when invoked in a bare repository without a start commit,
then there is no work tree state to start from, and it dies with the
following error message:

  $ git rev-parse --is-bare-repository
  true
  $ git blame file.c
  fatal: this operation must be run in a work tree

This is misleading, because it implies that 'git blame' doesn't work
in bare repositories at all, but it does, in fact, work just fine when
it is given a commit to start from.

We could improve the error message, of course, but let's just default
to HEAD in a bare repository instead, as most likely that is what the
user wanted anyway (if they wanted to start from an other commit, then
they would have specified that in the first place).

'git annotate' is just a thin wrapper around 'git blame', so in the
same situation it printed the same misleading error message, and this
patch fixes it, too.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/blame.c     | 13 +++++++++++++
 t/annotate-tests.sh |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 177c1022a0..21cde57e71 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -27,6 +27,7 @@
 #include "object-store.h"
 #include "blame.h"
 #include "string-list.h"
+#include "refs.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -993,6 +994,18 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
+	if (!revs.pending.nr && is_bare_repository()) {
+		struct commit *head_commit;
+		struct object_id head_oid;
+
+		if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+					&head_oid, NULL) ||
+		    !(head_commit = lookup_commit_reference_gently(revs.repo,
+							     &head_oid, 1)))
+			die("no such ref: HEAD");
+
+		add_pending_object(&revs, &head_commit->object, "HEAD");
+	}
 
 	init_scoreboard(&sb);
 	sb.revs = &revs;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 6da48a2e0a..d933af5714 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -68,6 +68,14 @@ test_expect_success 'blame 1 author' '
 	check_count A 2
 '
 
+test_expect_success 'blame in a bare repo without starting commit' '
+	git clone --bare . bare.git &&
+	(
+		cd bare.git &&
+		check_count A 2
+	)
+'
+
 test_expect_success 'blame by tag objects' '
 	git tag -m "test tag" testTag &&
 	git tag -m "test tag #2" testTag2 testTag &&
-- 
2.21.0.539.g07239c3a71.dirty

