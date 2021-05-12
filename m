Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4862EC41602
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1498761413
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhELRoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347756AbhELR3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8FC061761
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i128so13315191wma.5
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MB7H5JuJEysZqOtYGFNJ+Q3PBPxGokFYW3/0nzpVPpQ=;
        b=jKTL7GtI+atUsVXLx6Jgc2T0T9QSymapKWqyhdGWsGxZDulxX71ozFwXshk5Ridf2s
         oqFP4aoW3ZUvjsMsrFQ1dhpqbPe2IZMb5kYUu9Vkb9+6TKjtDoYL6pDa+8XDvOhOf7Gl
         p+B9OEaWrJhY29Qn9Cb1FxfCKDiMsueF4+otwZOM4kV5DRtuHvIKrINkFL3/fBpuVT/s
         4RO4rHRXNaboYBDgRYLR5SybhODtL7jJdDc69roO2llYGd8JlD7xQB/cdXm2S/ciq++h
         VSbitD1YzaowhG/1ygov/SM0QOLmYKCbMkK33LKwM+Ds7FAL3gzVdkDAEOXZ7uUUsPlE
         uMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MB7H5JuJEysZqOtYGFNJ+Q3PBPxGokFYW3/0nzpVPpQ=;
        b=GVrOe/YnMK3WbCTN7Y6Ni3i9701/B1+Boxnf7ZRYpjGmq4BCqhLwXORHIRvrX2WvKh
         3NsNlWjE1xQRcyhKctNgLzHvFkyyhWnhE5MMprO4JUOUUjDaGakQXKFqL7LQwnufuiLC
         r06X5fMxapXJD0JTM/MNfSBGzkkQHEVnZ7TEtXiXLFO59H17BOpZFdeCHtow9WBAT5Mq
         MPtFFqqCH9XNOfa0T/uMNDh/czdBooF5ruiEKax8AbJHSSf7UfGVXPOF5PeWj2H+gF7T
         3cnxZvV+rgeRXeHxXe+vm+7nOCTs/pHfeyHpHOjKPZXheaLZhVwgCtITuUHhulbP3mTv
         Pqcg==
X-Gm-Message-State: AOAM530oi0qZkXpN7qrXUogjCiJFIFRoWWRQxEE8YMWuf7j367Rpe9FJ
        +7EcC450XBF1NtH5/kHTWo+t87l7tb0=
X-Google-Smtp-Source: ABdhPJwHq7n8cfaQYxlMeXkVZcuiRh8mURYkacn6mRY/f6UZHXdEcTiGYCf2gXSFLXxgNzZusBEEAw==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr1504430wmd.145.1620840508088;
        Wed, 12 May 2021 10:28:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm291344wmq.14.2021.05.12.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:27 -0700 (PDT)
Message-Id: <279ef30ffbc2145b0bd8edc377366808bd96ff50.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:16 +0000
Subject: [PATCH v5 3/9] ls-files: error out on -i unless -o or -c are
 specified
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

ls-files --ignored can be used together with either --others or
--cached.  After being perplexed for a bit and digging in to the code, I
assumed that ls-files -i was just broken and not printing anything and
I had a nice patch ready to submit when I finally realized that -i can be
used with --cached to find tracked ignores.

While that was a mistake on my part, and a careful reading of the
documentation could have made this more clear, I suspect this is an
error others are likely to make as well.  In fact, of two uses in our
testsuite, I believe one of the two did make this error.  In t1306.13,
there are NO tracked files, and all the excludes built up and used in
that test and in previous tests thus have to be about untracked files.
However, since they were looking for an empty result, the mistake went
unnoticed as their erroneous command also just happened to give an empty
answer.

-i will most the time be used with -o, which would suggest we could just
make -i imply -o in the absence of either a -o or -c, but that would be
a backward incompatible break.  Instead, let's just flag -i without
either a -o or -c as an error, and update the two relevant testcases to
specify their intent.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/ls-files.c          | 3 +++
 t/t1306-xdg-files.sh        | 2 +-
 t/t3003-ls-files-exclude.sh | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e9..e8e25006c647 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (pathspec.nr && error_unmatch)
 		ps_matched = xcalloc(pathspec.nr, 1);
 
+	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
+		die("ls-files -i must be used with either -o or -c");
+
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index dd87b43be1a6..40d3c42618c0 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -116,7 +116,7 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 test_expect_success 'Checking XDG ignore file when HOME is unset' '
 	(sane_unset HOME &&
 	 git config --unset core.excludesfile &&
-	 git ls-files --exclude-standard --ignored >actual) &&
+	 git ls-files --exclude-standard --ignored --others >actual) &&
 	test_must_be_empty actual
 '
 
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index d5ec333131f9..c41c4f046abf 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -29,11 +29,11 @@ test_expect_success 'add file to gitignore' '
 '
 check_all_output
 
-test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
+test_expect_success 'ls-files -i -c lists only tracked-but-ignored files' '
 	echo content >other-file &&
 	git add other-file &&
 	echo file >expect &&
-	git ls-files -i --exclude-standard >output &&
+	git ls-files -i -c --exclude-standard >output &&
 	test_cmp expect output
 '
 
-- 
gitgitgadget

