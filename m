Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF201C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbjELID6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbjELIDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:51 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D8910E4D
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:47 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-18f4a6d2822so55982429fac.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878627; x=1686470627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iskKttoJoPOXmYyPXxtFS/pQk5D3EW8uml4F8kNG64=;
        b=B11Ad6qTXR7iyQOf8UJ/K3uCBp+qyJAizEzH/v5zUoePVjQHKwCqfc4S4P/K83TPnF
         ToeuDuwSltphUrjJasqvncR11lV958HFJAlY9oaNgp2T1f0etxiq7j7vOsYIuLWqo8dJ
         VdVqzRC28+lwTYUEa9fx7zfSqgbB1oa3QsUYQXKa2LroS0gkK5cXNAqn4SjHiJlEaZCC
         NPDGobH0dFZlf0k5qn8QovYPM8JtexoE9zoKxqdOSkf4TUAPxE/HwM5aw6beEEVxOoMF
         Ni/vzxG/K13WSyhaUx0JDoI0UtYOFYLhZ5pmdTfZIfbiA1xZkva1Gkw7+7Ues3mvlcYd
         TDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878627; x=1686470627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iskKttoJoPOXmYyPXxtFS/pQk5D3EW8uml4F8kNG64=;
        b=jMcEEwLXa9SaCbv7FUrAUaOpn86+XkU0hL3T6Hk6z3TO2++9CjGqsw8bY70PDCQBhQ
         TWfPm2XeJmz7bDVaNIt1EasSZ40kSmBUv0ZqWyVPM4D238vMow/lMr+E89eTkMJLuPaK
         a5Glju/U0rbLIUNN7aDsyqob7Pxra+fWuAOTuJeHz2RKB2U88lyQzU+WTLgs25JwHi2v
         olcfBIaHK7e+eWNnDH6OcVVy8Jfnyq6ZKK9IUVYbh0kOXSZSKWT2/ID9MzHcNkmW02DI
         Z3O3WskMNMbU6d/pNVeIesXuWRtY680L2Ujv6p82rZxnYyktgRz+jtNL9Wh0/9BOebbV
         lDrQ==
X-Gm-Message-State: AC+VfDwe4G+B0Hn+FvvHIFhWxSvpkUjE0xCdtVOxZ1rFC9f2ay1A7jnp
        QrBc0Hi4COdO5fe/nthQ9+fBTipTYNc=
X-Google-Smtp-Source: ACHHUZ4qjx6w0HrnllIsN63RS6bR5pBpOcrxJNJp8lMCXPCvF0Jrijpz7oYvmQbesnD3Rr96IKK8Zw==
X-Received: by 2002:a9d:19aa:0:b0:6ab:2d66:6b92 with SMTP id k39-20020a9d19aa000000b006ab2d666b92mr3615436otk.11.1683878627001;
        Fri, 12 May 2023 01:03:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q24-20020a9d7c98000000b006a43519523fsm886813otn.1.2023.05.12.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 5/7] diff: split --no-patch from -s
Date:   Fri, 12 May 2023 02:03:37 -0600
Message-Id: <20230512080339.2186324-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It should silence only the --patch output, not all output.

When --no-patch was introduced in d09cd15d19 (diff: allow --no-patch as
synonym for -s, 2013-07-16), the idea was to have a more accessible
shortcut to silence the output of `git show`.

However, the interaction with other options was not considered, for
example `--raw --no-patch`.

The original intention remains, as `git show --no-patch` still produces
the same: no output.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/diff-options.txt | 5 ++---
 diff.c                         | 5 ++++-
 t/t4000-diff-format.sh         | 7 ++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 08ab86189a..ba04b8292a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -21,7 +21,7 @@ endif::git-format-patch[]
 ifndef::git-format-patch[]
 -p::
 -u::
---patch::
+--[no-]patch::
 	Generate patch (see section titled
 ifdef::git-log[]
 <<generate_patch_text_with_p, "Generating patch text with -p">>).
@@ -34,9 +34,8 @@ ifdef::git-diff[]
 endif::git-diff[]
 
 -s::
---no-patch::
 	Suppress diff output. Useful for commands like `git show` that
-	show the patch by default, or to cancel the effect of `--patch`.
+	show output by default.
 endif::git-format-patch[]
 
 ifdef::git-log[]
diff --git a/diff.c b/diff.c
index 4f4b1d7e13..45c860496f 100644
--- a/diff.c
+++ b/diff.c
@@ -5493,9 +5493,12 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
-		OPT_SET_INT_F('s', "no-patch", &options->output_format,
+		OPT_SET_INT_F('s', NULL, &options->output_format,
 			  N_("suppress diff output"),
 			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
+		OPT_BITOP(0, "no-patch", &options->output_format,
+			  N_("negate --patch"),
+			  DIFF_FORMAT_NO_OUTPUT, DIFF_FORMAT_PATCH | DIFF_FORMAT_DEFAULT),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 7829cc810d..d7b9a2dab8 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -67,9 +67,10 @@ test_expect_success 'git diff-files -s after editing work tree' '
 	test_must_be_empty err
 '
 
-test_expect_success 'git diff-files --no-patch as synonym for -s' '
-	git diff-files --no-patch >actual 2>err &&
-	test_must_be_empty actual &&
+test_expect_success 'git diff-files --no-patch negates --patch' '
+	git diff-files >expected_raw &&
+	git diff-files --raw --patch --no-patch >actual 2>err &&
+	test_cmp expected_raw actual &&
 	test_must_be_empty err
 '
 
-- 
2.40.0+fc1

