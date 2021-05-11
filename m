Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0913C43470
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554FE6191C
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhEKSfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhEKSfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924FC061761
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l2so21113427wrm.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4KsZA2I7CfIgjH08T88TsFhRmAHld7iU15QGXlFPnMM=;
        b=KmFgWt3nB4nOPyfMYUdFuVNfSsqd0D3J+O9VdPFZjcQJba1TbPfqDlFVH3xQxgZ6aQ
         TbWL8V1ijVVZ8SIPY3ATEpvfPbBYzQOM6ztCo8YQtnNIkzLOBiWOZy0azn5cCgTyWzB7
         fW1/K4NsbHRhdhJPTj58qhoeoON0EX9tnkooCdljdo9TNOXZijBZdAKoTnt8Muaj9bBH
         CtqOAy7YzACv6k2l8QH06rUdIE982536JGRcl2Yg8g2tk77SzbQAzu4/S2d8WRKsv4K6
         GdeC9ZzH7HtJAWuKL36pRRiSiZCXsTKgT84mw59ITEz8WDE1TDBeFeABUIF9nMmd262u
         2A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4KsZA2I7CfIgjH08T88TsFhRmAHld7iU15QGXlFPnMM=;
        b=a6D8OkypcVfMUGW2KRKrHFa/HVwqaZct4RbkU9Sov/jQsewfjmlw3L46q0vJcCThqn
         fV5n/EAZyzLbudi0AyXK3q8dTtZ/0Fve7Edc4vv8Myrwfgz0BakQwLo4vOYdX5dWiAcx
         ikhj94lOFbH5H8HyMixsO6hNj0KQx641GmtOvFHIfHDWunhW+JpsXL1XESpcJziZdks7
         fURWLridgzb4d872DbwNYt9UlhYrrAxIg0MKTPDoGCREEoMiGpHV9w5IaYhL/Fd9E+a+
         KHPtz9q/OEUJi/utu5CF6lu2eLQ3lBiprogiJcuF75oJTeuREj3lG6Nl2U9PIScNVbzL
         FcLQ==
X-Gm-Message-State: AOAM530gBaq8f2P4e+Ycia8R+OwQFficN4gYmZ5tXjBXIP7sywqjzTbz
        j5VIR5c5kcXtKja/PVvFBtTPmDhp63E=
X-Google-Smtp-Source: ABdhPJxqRXxoCkZ4cXyCJSJL1+JE/e1LgL/PvFELmUoLusW8r5y33wYuJpSPQZwG+UraoQ6SVd33nQ==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr39669694wrd.306.1620758053653;
        Tue, 11 May 2021 11:34:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm28169592wrh.8.2021.05.11.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:13 -0700 (PDT)
Message-Id: <317abab3571e69394cf0a0dbe971440bca16964b.1620758049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:04 +0000
Subject: [PATCH v4 4/8] t7300: add testcase showing unnecessary traversal into
 ignored directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The PNPM package manager is apparently creating deeply nested (but
ignored) directory structures; traversing them is costly
performance-wise, unnecessary, and in some cases is even throwing
warnings/errors because the paths are too long to handle on various
platforms.  Add a testcase that checks for such unnecessary directory
traversal.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a74816ca8b46..07e8ba2d4b85 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -746,4 +746,27 @@ test_expect_success 'clean untracked paths by pathspec' '
 	test_must_be_empty actual
 '
 
+test_expect_failure 'avoid traversing into ignored directories' '
+	test_when_finished rm -f output error trace.* &&
+	test_create_repo avoid-traversing-deep-hierarchy &&
+	(
+		cd avoid-traversing-deep-hierarchy &&
+
+		mkdir -p untracked/subdir/with/a &&
+		>untracked/subdir/with/a/random-file.txt &&
+
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+		git clean -ffdxn -e untracked
+	) &&
+
+	# Make sure we only visited into the top-level directory, and did
+	# not traverse into the "untracked" subdirectory since it was excluded
+	grep data.*read_directo.*directories-visited trace.output |
+		cut -d "|" -f 9 >trace.relevant &&
+	cat >trace.expect <<-EOF &&
+	 ..directories-visited:1
+	EOF
+	test_cmp trace.expect trace.relevant
+'
+
 test_done
-- 
gitgitgadget

