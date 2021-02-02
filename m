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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B7FC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA25164F79
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhBBJgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhBBJfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:35:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E78C061356
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:34:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q72so504011pjq.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B5MZdMNbM5AFSKMClKB4E4pNrhzrspPMYiL+ukzcmts=;
        b=p0eEJaXN2P+XsuTR4MCj6ZLZYRk/j7SNFR3TCc3+EzYH1wqDRgEX+urVpkGi48EACc
         /4pOJPhh6tj04C+/3tK2JWYUjGLMwcDSFe4nrsAwKHrp41elm3gQImFFGFHtka5fL8F7
         Vdy/jRLmTTfZ0nnTqXz9wXPc+n+UOfT61pqmREjqrpYxRmuWzS/keeqv2UvxQM5DC39N
         rcUv8nC9jk2/wU//psIaj9uKUhghV2Nr2Z5ToaQhtLcKEadQ35g/DWSOFo1aMRo/eWL1
         NyOyBtgkUx+1b+W+BCEU2mQ3T92w4Z+KyJBG1JzSgS1Kfd7H0TIu9giSKzQFdvb0kraG
         dq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5MZdMNbM5AFSKMClKB4E4pNrhzrspPMYiL+ukzcmts=;
        b=YvR1hzqxKwufosDEjEblxj6D/TYWcdpvNQHfFeVhDtWzmFSW82BoZtpnJ9npzhLpFN
         rR4MHuGEUwXocFiLW7OLJpKKnAoJJSi5tV4twSP4Im8L8VbcJPUnYehq29BayVDKPZ/Y
         kgrc8KC59OIo6F+8pWIapu5fTnZLgIdUuT6GSKoCOscaHwSkYQyLltsMImFQdCargBmO
         Ap8pNw5keGjNeRK2ELLSdSpiGlTFdalR8GlsRAF/z5urq7N2nta3fvCXIwCIvf6/ye5A
         HcYuAAl6QEo354c1LSFsFhXJKp3wcZ40BUlUu3ady1a+LcDkYwuZaqZo4PXqLYOd7xJm
         4DVg==
X-Gm-Message-State: AOAM533ofLG0xgiBgwzRe8RB2I0mhml90N+3k1UxjqabyNG+Wre0Uaxy
        PLJDqRYCwuqg/1CTeoOJcO5Q3l8SQXI=
X-Google-Smtp-Source: ABdhPJyFcRfgm/XjX+eprei/p5WjYPzzDh25Qhg/4a/+TEd4tNmXkcsEF3jOVpHBbZBVv14Zb7V4nQ==
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id l6-20020a170902f686b02900de18c741f8mr21805648plg.65.1612258448409;
        Tue, 02 Feb 2021 01:34:08 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.34.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:34:04 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/9] t3905: remove nested git in command substitution
Date:   Tue,  2 Feb 2021 01:33:21 -0800
Message-Id: <4b72d39e01ab674cd6c9a15332021950b4e35b23.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
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

