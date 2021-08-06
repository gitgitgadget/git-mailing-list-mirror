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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1861EC432BE
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3B661159
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhHFTNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbhHFTNk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:13:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB759C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 12:13:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so12310921wrv.11
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peg3ZPXYkCJGBaOgvVUJux6hfwPgOElIvCFEzVBIQJ8=;
        b=tw7NhhMxtZMHtI6Fp3YJexqpTsFNII3bqOr8dQvzJQoCzHnS1/ldVXKgNE1RrxQ1K6
         h7s2AUsw5ZAyzi6qiK727KqhMhUpKkkGWm+hqoFVDWZ0CHTslVJ9Z9RBHQn8U7nBUmIq
         GsXilFtnFoBHpu3xT4YSwAgwePG7XENN4p0lV+9rTfGSnrGQ+kHLgYBkhn+E6fCVqnQf
         SHSvzPregTj8Y4OU5iTWy0l6yZDkGNcqHCuhI2vMl8V6F1un1CrdW+vnvYiYmXHuzAbs
         jXNHgI8ZkOfmUtEOD2mWkSUPc0nt//mVzWIMF35aL2jGXFGwIhlJk3aCnZa/mYPsMueR
         z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peg3ZPXYkCJGBaOgvVUJux6hfwPgOElIvCFEzVBIQJ8=;
        b=FSdq4ziV1l00/ev6TZ/QL5lI/5zJUR5p/LUL6T7YdJxLKc0YmNrSIGRo1WaRO/QbS8
         OWn9KOdqkfn+TZRYVvurzEiEvYMYNSuCf3jKfjQKL+AcDLTGGveDimQR6CxSHOgkY9u0
         kqTituJ63c55UC2ZXBkNrnoAeTgMG+Ev+9DqCY0F8o7kce2scDArOB0BAAmh9/dEe6mB
         KtNiNN1Bg2sqEZOLd52obT+E0FxoTIngJq7qfLHvdZjkvo5PM0MQ1v33+9VfYDwjxLCL
         5tWOp7MX7nz+GIYJJzh5Ly9tSC+0etHMhFXpV/CA86xVQxBnmnBJ/Y2h0aX5Wh75DR77
         Nyfg==
X-Gm-Message-State: AOAM533jAEkaSP+Yvm3KLvpdI6lRl//IMKuMJtv9hmJzRPMQctjPLmFL
        YVQlY5eOM84Zt6cZcxnfYLQnX1y5oiA=
X-Google-Smtp-Source: ABdhPJwsTrw2oMUPf5khX0aU5x0kQLvvu2vtWuysTvpZubskKYLuZhDBfYb0mvPfDpjBhqf10zQoVQ==
X-Received: by 2002:adf:ffd1:: with SMTP id x17mr12307580wrs.391.1628277201015;
        Fri, 06 Aug 2021 12:13:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12sm11039849wrn.31.2021.08.06.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 12:13:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 1/4] advice: add enum variants for missing advice variables
Date:   Fri,  6 Aug 2021 21:13:15 +0200
Message-Id: <RFC-patch-v3-1.4-5f934bb083-20210806T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.680.gf07173a897a
In-Reply-To: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
References: <20210805230321.532218-1-mathstuf@gmail.com> <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

In daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14), two
advice settings were introduced into the `advice_config` array.

Subsequently, c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25)
started to deprecate `advice_config` in favor of a new array,
`advice_setting`.

However, the latter branch did not include the former branch, and
therefore `advice_setting` is missing the two entries added by the
`hw/advice-add-nothing` branch.

These are currently the only entries in `advice_config` missing from
`advice_setting`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c | 2 ++
 advice.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/advice.c b/advice.c
index 0b9c89c48a..6da51be63c 100644
--- a/advice.c
+++ b/advice.c
@@ -106,6 +106,8 @@ static struct {
 	int enabled;
 } advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
+	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
+	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
diff --git a/advice.h b/advice.h
index 9f8ffc7354..68629b5ba1 100644
--- a/advice.h
+++ b/advice.h
@@ -45,6 +45,8 @@ extern int advice_add_empty_pathspec;
  */
  enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
+	ADVICE_ADD_EMPTY_PATHSPEC,
+	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
-- 
2.33.0.rc0.680.gf07173a897a

