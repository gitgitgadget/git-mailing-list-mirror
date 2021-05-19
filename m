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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE702C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4F9611AE
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352505AbhESLuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352396AbhESLuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:50:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15EFC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i22so18500723lfl.10
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+U6jX7XPraaLLXcDgAFCztBcR0yTeez5iSqNC5PCEQQ=;
        b=j4jmjxl0BjGWTrsO0144TkaJGQvwty4eNfreJaBn2Buh3/VnBnRE3dwghRtwRSyhmX
         v19feYNF1tIwAA1gLbOlnA+tp9WaZJYzHWkfrr3bygWH/EjKob0WupixFbo6EUVaPzLq
         JF+qsx4QKGySKvaeo9XjTh+00BPxrMLWsUHpDaRK68F43n7A3KVERRp4lPY30iN3V7Jd
         xtLoTwtyzTgILZn4rfViQmFPeVlxMHvSnUlHvi6+Dt653X/WA+FL6CuRSBQ59mPT7zXB
         Wf0bUWoY1TwGaEceOqAUA/elMyUSMnR6ZWMEFjrAV5Jw/CiBJFFbQCCEXvQqJDyZ/J6z
         enqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+U6jX7XPraaLLXcDgAFCztBcR0yTeez5iSqNC5PCEQQ=;
        b=kogKkE2v+6sVmU7rrDZJJR1+DecfRoti0aZPHclNcICnhIUnKzOduhM3JTDAvUvp45
         3+Yl4KGIoE+NYSQtNT8LabH29lNsxF6BPdYWuYHyo17/A2h7fNLq0MxE3ZhAWq2x5GJl
         QvYk3vhYher7FM3o4q3UpNMxveEYPQgaVd0Hja9lVfz6qpoOzWNKSda5z+gX81FKEo1O
         pKUA2myEuC/qHEnrjeiHBfUJS/wbqmotFfWYpb3HO6kcxNh8DRRc0QulFu/quibcN4/7
         vsS3YHL43ZpnJYZEZnx6fEDPFrtDWN+1KuOKuLbGSOp7YgmzwDhS1jQYcARq096gxWxN
         QOPA==
X-Gm-Message-State: AOAM5333WeMEzKaiFhIjOdAT+vEBuRN8TThKPV1TJCWY9BBq21EzKgXH
        0+TTwe2QFco49AoEBbthcJc=
X-Google-Smtp-Source: ABdhPJzVsP5Bz3KbyGLtTpC6rWPW6oRIqgA7dh47CZlgj/+hSf2kDNBeVsGO59VQGuuapCC4pPjntQ==
X-Received: by 2002:a19:c747:: with SMTP id x68mr8197127lff.516.1621424920995;
        Wed, 19 May 2021 04:48:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 9/9] diff-merges: let "-m" imply "-p"
Date:   Wed, 19 May 2021 14:45:52 +0300
Message-Id: <20210519114552.4180-10-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p on
one side, and -m that did not imply -p on the other side.

Change corresponding test accordingly, as "log -m" output should now
match one from "log -m -p", rather than from just "log".

Change documentation accordingly.

NOTES:

After this patch

  git log -m

produces diffs without need to provide -p as well, that improves both
consistency and usability. It gets even more useful if one sets
"log.diffMerges" configuration variable to "first-parent" to force -m
produce usual diff with respect to first parent only.

This patch, however, does not change behavior when specific diff
format is explicitly provided on the command-line, so that commands
like

  git log -m --raw
  git log -m --stat

are not affected.

Exact historical semantics of -m is still provided by
--diff-merges=separate.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++----
 diff-merges.c                  | 1 +
 t/t4013-diff-various.sh        | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 530d1159141f..32e6dee5ac3b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -49,10 +49,9 @@ ifdef::git-log[]
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
-	the default format. `-m` will produce the output only if `-p`
-	is given as well. The default format could be changed using
+	the default format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
-	is `separate`.
+	is `separate`. `-m` implies `-p`.
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
@@ -62,7 +61,8 @@ ifdef::git-log[]
 --diff-merges=separate:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent.
+	for each parent. This is the format that `-m` produced
+	historically.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
diff --git a/diff-merges.c b/diff-merges.c
index d897fd8a2933..0dfcaa1b11b0 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -107,6 +107,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!strcmp(arg, "-m")) {
 		set_to_default(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index c35cc73d08bd..15ca3c75bff7 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -454,8 +454,8 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-test_expect_success 'log -m matches pure log' '
-	git log master >result &&
+test_expect_success 'log -m matches log -m -p' '
+	git log -m -p master >result &&
 	process_diffs result >expected &&
 	git log -m >result &&
 	process_diffs result >actual &&
-- 
2.25.1

