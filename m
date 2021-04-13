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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30217C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5BC6109D
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhDMLmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhDMLmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:42:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF40EC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so8275729ljc.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/L0PhxITkYwVwCtaBePzoPwzMPJCRj3KeJuJ12nfF8=;
        b=givT+GfVgLt7Ffxdro570peDDceevRkDAhLHbmLIxVTqUweY7rg36qvi0AZY/DbMRg
         IxgAskGLFxF4FP8y6jCg480XUP648UTsrWNYWPkVYs3ufGMjXgJhIfqedpsU2wMQ/sQs
         7PwyJHExqooKWZAil6nwO6BBbf9BxfUgqOUk9qoB4MOvk0xXDosLewC2bQnfrL9hGmb/
         aDPTasRuOPL7lSOKIf21IsU4GX3eyyXqQ9Ggr9DMeqKsDKvNztDxCm64T90373wrv/l9
         faSBxUswyMiQX/SMB+iDA2Q9l6gu1W0o8WBfd6gsSkKal269Hz8KU9FcuRv/DgcElVnL
         kzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/L0PhxITkYwVwCtaBePzoPwzMPJCRj3KeJuJ12nfF8=;
        b=lVwEze6wnEKrEew1oqVaMui+qdRfhdmZ74O3hms3haEz5UCKRG9niag1YFTitAeG4m
         XiQRdFOvZZ/qWss0RQA9KlK7fGaQt88RKAHoW5UrL7Y9aAJeaYL2TvN4f5pmjmjqUOyV
         9t0urlXHdsgKfiEh522J75BZXkeu0khBSx/kerJ20Uu3VeS90WC2w6Hfzd2zDSVrIXIn
         84sJmJSNasOhfxngNT552DxeMnpCLIWI+WYmLYpjUbeF2F9pU/qGbFDWvs1gSIuGEWyA
         OPxVdCdn4lK+Tk6+wX59kJcSluYaLiPpFlVGxR0kw9OLTiO1MUOLywvSDjhgpFwmBRcW
         J9uw==
X-Gm-Message-State: AOAM5316D+dhfPH4Qjj2NP9fNj4R2ShN9ZPyMFZjiWb8k1xZRHeiWE1Z
        5s7IHQryxjbraRN2h56E4rw=
X-Google-Smtp-Source: ABdhPJwYPvb/YXs9B3jU4qCbMJs9VXv8dexeymPNBHlT4NMU4lQoKe4bzwh6CSqALGxmF42F6j/AAw==
X-Received: by 2002:a2e:919a:: with SMTP id f26mr20636940ljg.508.1618314106314;
        Tue, 13 Apr 2021 04:41:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm663339lfi.292.2021.04.13.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:41:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 0/5] git log: configurable default format for merge diffs
Date:   Tue, 13 Apr 2021 14:41:13 +0300
Message-Id: <20210413114118.25693-1-sorganov@gmail.com>
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
configuration variable. The default format could be requested by the
new value "on" for --diff-merges option (--diff-merges=on).

Then -m and --diff-merges=m are also changed to use the default
format, in a backward compatible manner, as visible behavior doesn't
change unless user customizes log.diffMerges configuration.

In particular,

  git config log.diffMerges first-parent

will change -m option format from "separate" to "first-parent" that
will in turn cause, say,

  git show -m <merge_commit>

to output diff to the first parent only, instead of appending
typically large and surprising diff to the second parent at the end of
the output.

Updates in v2:

  * Renamed --diff-merges=default to --diff-merges=on. Junio didn't
    like the "default" here, and I agree. Dunno why I've even called
    it "default" in the first place.

Updates in v1:

  * Renamed abbreviated value "def" to full "default"

  * Fixed tests to use "test_config" instead of "git config"

  * Meld all "git config" changes into single commit that includes
    code, documentation, and tests, as they are mutually
    interdependent.

Signed-off-by: Sergey Organov <sorganov@gmail.com>

Sergey Organov (5):
  diff-merges: introduce --diff-merges=on
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

Interdiff against v1:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 31e2bacf5252..6d968b9012dc 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,7 +34,7 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|default|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
@@ -45,7 +45,7 @@ ifdef::git-log[]
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
---diff-merges=default:::
+--diff-merges=on:::
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
diff --git a/diff-merges.c b/diff-merges.c
index 75630fb8e6b8..f3a9daed7e05 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -67,7 +67,7 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
-	else if (!strcmp(optarg, "m") || !strcmp(optarg, "default"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
 		return set_to_default;
 	return NULL;
 }
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 87cab7867135..87def81699bf 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,10 +452,10 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-test_expect_success 'log --diff-merges=default matches --diff-merges=separate' '
+test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
 	git log -p --diff-merges=separate master >result &&
 	process_diffs result >expected &&
-	git log -p --diff-merges=default master >result &&
+	git log -p --diff-merges=on master >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
@@ -469,7 +469,7 @@ test_expect_success 'git config log.diffMerges first-parent' '
 	git log -p --diff-merges=first-parent master >result &&
 	process_diffs result >expected &&
 	test_config log.diffMerges first-parent &&
-	git log -p --diff-merges=default master >result &&
+	git log -p --diff-merges=on master >result &&
 	process_diffs result >actual &&
 	test_cmp expected actual
 '
-- 
2.25.1

