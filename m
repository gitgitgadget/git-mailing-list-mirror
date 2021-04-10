Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C492C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4DC610A2
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhDJRRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJRRe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 13:17:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE20C06138A
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r20so10184983ljk.4
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHqNhUIbOK6irgotcmyaWj/qhfg/uLyG4ON4hmUEDWc=;
        b=VHFKrFWKVpS2JU3tuXxydMkMhayuAL+iDvStQGvIpR+IPYFBy2uji95ARt8Tzvd7fo
         TarFaF5y/b4sBpO9WVNyTBSrHXwXde5RNPStTiGs2iNJQ4wTO0DVzk1ro4W8d/3L7zx9
         GCiaSvVD7xLfDVYQiZ3mIvR8dZLtf8bXubzWOHWJDqolY/u1WDJ9cMi+5Ah/rTJMulmY
         pXfiR1cI534f04SF9V/OrPHcjMDHWlJKA+GK9YJWV3S3mOG2qiSlCP4CCaLdcXaCqHkf
         xh3fJ2oF2NcfLQv0wONDne/tQPtg/wmlvtq/Vw2KlhHR8Xt6qQkHGXJMV9pqs90qlBtN
         V+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHqNhUIbOK6irgotcmyaWj/qhfg/uLyG4ON4hmUEDWc=;
        b=PEkMNXjnHLZRxRqEdSJhlm/9NUidTt7zCzOkKercBTbRmfQFCaReTd17qBeYJWifGs
         WeUvDgv/Zwy/AVXGh2gyepGbsRM6mXVqKSCVRreYaeL3c4p0BwO1Wrj6vGcNIUlf8c9h
         gpQ8Ai+OPHu0qZj4qBdohJjnlc3hEAsukwj4MYsv42RxlKx9P+vW7Rq97f4XZofeBwSz
         u6SFKXEQaLhpwyR08qBHPIEXJQBM1louMX2rnBQ/honzrRGnjBjIIotCH5IdqKtpFli4
         iX7NMmCfZvRJXbuGrlcSqMvpQRZ+w0/QKwogCQq6xKe6100PK+o+VRRY6VMEtr/6Yf+Y
         o4YA==
X-Gm-Message-State: AOAM532w3J7GZ17Coj2n1b+RCKwuSCSIK8M+YNF7k5KUrBzD/UAX5mys
        Zrrh1JXnaE8K2gwTu4cI2WM=
X-Google-Smtp-Source: ABdhPJzX66DOXDiL5kBNebmcEJJIA5AWEEx7vL54eINX+y1FJYVH1bjdcvPvjhSWE9x/vQ4+oerZjA==
X-Received: by 2002:a2e:9cd2:: with SMTP id g18mr12634291ljj.217.1618075037798;
        Sat, 10 Apr 2021 10:17:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm1336543ljo.64.2021.04.10.10.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:17:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 0/5] git log: configurable default format for merge diffs
Date:   Sat, 10 Apr 2021 20:16:52 +0300
Message-Id: <20210410171657.20159-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches introduce capability to configure the default format of
output of diffs for merge commits by means of new log.diffMerges
configuration variable. The default format is then used by -m,
--diff-merges=m, and new --diff-merges=default options.

In particular,

  git config log.diffMerges first-parent

will change -m option format from "separate" to "first-parent" that
will in turn cause, say,

  git show -m <merge_commit>

to output diff to the first parent only, instead of appending
typically large and surprising diff to the second parent at the end of
the output.

Updates in v1:

  * Renamed abbreviated value "def" to full "default"

  * Fixed tests to use "test_config" instead of "git config"

  * Meld all "git config" changes into single commit that includes
    code, documentation, and tests, as they are mutually
    interdependent.

Sergey Organov (5):
  diff-merges: introduce --diff-merges=default
  diff-merges: refactor set_diff_merges()
  diff-merges: adapt -m to enable default diff format
  diff-merges: introduce log.diffMerges config variable
  doc/diff-options: document new --diff-merges features

 Documentation/config/log.txt   |  5 +++
 Documentation/diff-options.txt | 15 ++++++---
 builtin/log.c                  |  2 ++
 diff-merges.c                  | 58 ++++++++++++++++++++++++----------
 diff-merges.h                  |  2 ++
 t/t4013-diff-various.sh        | 31 ++++++++++++++++++
 t/t9902-completion.sh          |  3 ++
 7 files changed, 95 insertions(+), 21 deletions(-)

Interdiff against v0:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 09b07231b5a4..31e2bacf5252 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,7 +34,7 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|def|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--diff-merges=(off|none|default|first-parent|1|separate|m|combined|c|dense-combined|cc)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
@@ -45,7 +45,7 @@ ifdef::git-log[]
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
---diff-merges=def:::
+--diff-merges=default:::
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
diff --git a/diff-merges.c b/diff-merges.c
index f68e4376fd63..75630fb8e6b8 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -67,7 +67,7 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
-	else if (!strcmp(optarg, "m") || !strcmp(optarg, "def"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "default"))
 		return set_to_default;
 	return NULL;
 }
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index ee4afca06ced..87cab7867135 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,37 +452,34 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-test_expect_success 'log --diff-merges=def matches --diff-merges=separate' '
+test_expect_success 'log --diff-merges=default matches --diff-merges=separate' '
 	git log -p --diff-merges=separate master >result &&
 	process_diffs result >expected &&
-	git log -p --diff-merges=def master >result &&
+	git log -p --diff-merges=default master >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'deny wrong log.diffMerges config' '
-	git config log.diffMerges wrong-value &&
-	test_expect_code 128 git log &&
-	git config --unset log.diffMerges
+	test_config log.diffMerges wrong-value &&
+	test_expect_code 128 git log
 '
 
 test_expect_success 'git config log.diffMerges first-parent' '
 	git log -p --diff-merges=first-parent master >result &&
 	process_diffs result >expected &&
-	git config log.diffMerges first-parent &&
-	git log -p --diff-merges=def master >result &&
+	test_config log.diffMerges first-parent &&
+	git log -p --diff-merges=default master >result &&
 	process_diffs result >actual &&
-	git config --unset log.diffMerges &&
 	test_cmp expected actual
 '
 
 test_expect_success 'git config log.diffMerges first-parent vs -m' '
 	git log -p --diff-merges=first-parent master >result &&
 	process_diffs result >expected &&
-	git config log.diffMerges first-parent &&
+	test_config log.diffMerges first-parent &&
 	git log -p -m master >result &&
 	process_diffs result >actual &&
-	git config --unset log.diffMerges &&
 	test_cmp expected actual
 '
 
-- 
2.25.1

