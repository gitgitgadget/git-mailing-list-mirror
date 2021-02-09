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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68A4C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7664EB8
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBIHa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBIH35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:29:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F487C06178C
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx20so1140149pjb.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5MZdMNbM5AFSKMClKB4E4pNrhzrspPMYiL+ukzcmts=;
        b=oDpDOcxj/d0Hs7qkveYH7TRddBYKkzOfRtzcutlQPC9LQ2cWhCugzFl7c5ko2bZJfY
         AXedsK/UXg8qkb6Cahnrz8fEH0mz+WZ5x5FXRkSvZF+26OEaDkfJFG1adJL0DVD9W1CG
         rN/SMBEBChzvNw4yTmRrAmAJoF0d2ZXVu7f+qfhSil5I7MQNSaFyjtcGJkLsUNY8rnRo
         n1AAqz3NyBV5HsM33LlRE8EShyW83VGE/vhwM+Bd6h0tFxmkAxROFLLJvfyOYhIdgZ11
         seCODSUKvb1aRSpMKpiIFz1n7wiSeW8CpZfVb+AcrBSRgtZrxuHBCQCR7rYoQegH5ltm
         Kw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5MZdMNbM5AFSKMClKB4E4pNrhzrspPMYiL+ukzcmts=;
        b=jaWb1SUHLs0fokC09hCXZ/Y1jIlkm4OA1B1mt6YUD//l4GqwyPnFxcyPBr3l+xb0RU
         U/EZJZppCoX5jHwvvz9mfbLyV+YL5yeVxNYwlUTnYAKCXaM8cZmE2389IgId02eMs6oh
         kMHxZ7BSSrx4DMghsuzfgo2/EHJBke7qs3GCnqnBwaxFrOeFEuR4B7Q+rjrfJOZbFVzS
         FcTF1tvdOySXGQqbBjmi8AFPAhdqZ7V087DclJkYlyjBg3Bsfkcta6QoC4Efvee2/wWr
         g8KmGs0LjHqo68TUfcEaPkMEmPactkeK8ZzNL3JfW6VKf4bZx4eTYOnSf+856esQE/kL
         DSrQ==
X-Gm-Message-State: AOAM532kN1/yX+/1awfu9716q0somLHlB3Xn/fd2ijOaiK14ZSPwWvQu
        qJzRubjkL1OjP6hO/BaRfuFb07PcKT4=
X-Google-Smtp-Source: ABdhPJyQzGr6Rj3oqXdsnDJLHMotdaBfBLIkTINMjYeVYjmUfG0gQflgbTnqGY+S/Fa+XQolmn08JQ==
X-Received: by 2002:a17:90a:7187:: with SMTP id i7mr2835685pjk.216.1612855755945;
        Mon, 08 Feb 2021 23:29:15 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:15 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/9] t3905: remove nested git in command substitution
Date:   Mon,  8 Feb 2021 23:28:50 -0800
Message-Id: <57c21e2461eea8a37456d211f38fb668278cb2ed.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a git command in a nested command substitution fails, it will be
silently ignored since only the return code of the outer command
substitutions is reported. Factor out nested command substitutions so
that the error codes of those commands are reported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 892a2c8057..f008e5d945 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -36,8 +36,10 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
 '
 
 test_expect_success 'stash save --include-untracked stashed the untracked files' '
-	tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin)) &&
-	untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin)) &&
+	one_blob=$(echo 1 | git hash-object --stdin) &&
+	tracked=$(git rev-parse --short "$one_blob") &&
+	untracked_blob=$(echo untracked | git hash-object --stdin) &&
+	untracked=$(git rev-parse --short "$untracked_blob") &&
 	cat >expect.diff <<-EOF &&
 	diff --git a/HEAD b/HEAD
 	new file mode 100644
@@ -117,7 +119,8 @@ test_expect_success 'stash save -u dirty index' '
 '
 
 test_expect_success 'stash save --include-untracked dirty index got stashed' '
-	blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin)) &&
+	four_blob=$(echo 4 | git hash-object --stdin) &&
+	blob=$(git rev-parse --short "$four_blob") &&
 	cat >expect <<-EOF &&
 	diff --git a/file3 b/file3
 	new file mode 100644
-- 
2.30.0.478.g8a0d178c01

