Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC1C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4768F6135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhETVsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhETVst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660CC061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m11so26667606lfg.3
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f3yQniBLYFzvcTla8gyHtZ4LDvnEKoUHzoGyV6tYY8=;
        b=ZIZiSfLtbpWJnznMYYY+ryruh6Nr7HK8tB/SCX+sc3FgtZ/ZWVg50quiIKKhRptKbW
         QwIwH9ZbIByvWZkQS7d9TrusO9t+YlUi9C2vSSNHexP3LvxQW6PvC83CQJR+IdygoE/Z
         PPT5kZzT8NKZWtn/3AiV1YcvdSIwh5N2B/MpXVSlei7Zur06SyTW7B3XnDaRlhgeS78z
         iIBR9zMJgyC/CZkve+LJG7mXIE3QSYpzDterLGEOJ+GmSIWHrn+tgxuZOxJwXeIF04b1
         TwQmYkzAt6ITVLDp+x9OtPKkT1QHWbByoEElHNqVoq4E0wyEhUkAA5K/AUKSDvqUwuzK
         +8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6f3yQniBLYFzvcTla8gyHtZ4LDvnEKoUHzoGyV6tYY8=;
        b=PYVviiz3rfz64eHi9Qx8Lg9awE78PJ18N80yZh0twOMMRPPqJVOQ4X+s4KCow+HJiZ
         xFRowEfSi2kDlZ8wnOOdqQjum4eNO2ZBNrTXGtXWjUEeta0Q4KI0Ug7durV5/4IvfJFq
         5M8LT9akDc+eUN4Dih2fZyfILL69rbRScgqPqipGyuyB9TAeVmdmCn2EDtQQUTmB3Tl2
         QAfng3b9ZOmbE4qDq1FZ+1XpMd0F1VqGAsCHNDy3zXAveESb6syIWSQtUVoUoOMuVcCH
         dCzI4TqhmTLss8aLiyjvQRRFYZcWLaR1oXl1+wAw2nU6Ym1P4WaUce6qN+7jlmq7pMq4
         vqlg==
X-Gm-Message-State: AOAM533shHGYzw5PYDCCGyqfIFfZTFkQ02DO3m+IRI6FB0B3DwN5FilM
        dX9byjq6SvyKUEBKVd98ztVGTV5G3Ng=
X-Google-Smtp-Source: ABdhPJxC8w6u4r9E1NoBds5IxQKOeQEcdVSrzlFYtxVrkaZkZoA7OqteQm6aC5Y6HxTqQrLHS+8xdA==
X-Received: by 2002:a05:6512:2253:: with SMTP id i19mr4432851lfu.92.1621547246052;
        Thu, 20 May 2021 14:47:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 10/10] diff-merges: let "-m" imply "-p"
Date:   Fri, 21 May 2021 00:47:03 +0300
Message-Id: <20210520214703.27323-11-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
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

are not affected, nor does it change commands where specific diff
format is active by default, such as:

  git diff-tree -m

It's also worth to be noticed that exact historical semantics of -m is
still provided by --diff-merges=separate.

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
index e561a8e48521..7fadc985cccd 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -455,8 +455,8 @@ diff-tree --stat --compact-summary initial mode
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

