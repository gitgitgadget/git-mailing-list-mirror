Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0FC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A2A64E57
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhBXEGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBXEGF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:06:05 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1636C06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:24 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v64so558253qtd.5
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhWCLUjjLMe4U+aNbyi9OJzyWyl8sCHrFM886rJ473s=;
        b=HBuVBjAJ0Z53fyvHszN0LxHOA8zp7tViJMIXu0F/85+tKQv2Ca4TZK1taAOq5XUQfp
         1BiR8YqMZQQUOvBxjl4rg39L5KQM6Y62TVHfCrpdK/U7HcpSXDaUvTRkPc0itmX4GNA8
         5tdcdcttAdQLlLA/lHzy/HWxSq8aKrk4YLknTMtMSi/pBEEIM2LzOLCBEZdMjbHpEYxU
         H6MFCza6k0n1eslWAQYGRYBCdqHsEltZxJaa6XjpLS+j1jhbZ2nj27e/ANSFXDYg0TeN
         l1TXZ+LmS6EXYUFnkwNrffgqXL5KypQI7f4vtwzbIPHCs9rd2fDXynZSbkN9BpmWB4Z8
         +yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhWCLUjjLMe4U+aNbyi9OJzyWyl8sCHrFM886rJ473s=;
        b=LB6YW8q7r7x+hxry/cif3oOva1qrrCwvCvDEMd6SDqXEXSLjsQ7wNNjfG+woUDpfZb
         2NA+9q9aolUE0ULn0nO5OSoijYUXFrsQwprtDEOH6JIW0VmfkIXPms16FOqnSmYnbn9x
         Cmy24jm/wHxzwN8lnDyB+Eot3yJjjObdJkE0IR8fclHP/GZoFnynOR9SX3UOVVL3XQPq
         vft9HcQv37NjhppRzOKnfrF5dvtCL4D07yYlpDqe00uBM5HhQSfs74zgOVdecyIznN6L
         pYMFjwSuFIvO4C6+6dN/woAa8dUE+FvBCXDIWCrJTOsrRTaeEG+AHYc3D2ABWqZK3bYj
         jlJQ==
X-Gm-Message-State: AOAM531E0YBww7lUYXElIoUYBTtYa7w5xbLgUEKnC0J6gXNpMov67tR+
        S7ROmV4vToB5hqnZbx+Iz3byP+ApcG4WHQ==
X-Google-Smtp-Source: ABdhPJyti9D+LcgwmJfrdJzTbfvXAeAN95lcKuy5fn9q+409fctTyX9NqzETOWmoSQ+whCbCV9b6qA==
X-Received: by 2002:ac8:5357:: with SMTP id d23mr27031799qto.253.1614139523621;
        Tue, 23 Feb 2021 20:05:23 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z65sm547878qtd.15.2021.02.23.20.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:05:22 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v2 1/7] add: include magic part of pathspec on --refresh error
Date:   Wed, 24 Feb 2021 01:05:06 -0300
Message-Id: <2831fd5744d44fd696e73913bf6e8bc2f03c6c52.1614138107.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git add --refresh <pathspec>` doesn't find any matches for the
given pathspec, it prints an error message using the `match` field of
the `struct pathspec_item`. However, this field doesn't contain the
magic part of the pathspec. Instead, let's use the `original` field.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  | 2 +-
 t/t3700-add.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3..24ed7e25f3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -187,7 +187,7 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"),
-			    pathspec->items[i].match);
+			    pathspec->items[i].original);
 	}
 	free(seen);
 }
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index d402c775c0..15ede17804 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -196,6 +196,12 @@ test_expect_success 'git add --refresh with pathspec' '
 	grep baz actual
 '
 
+test_expect_success 'git add --refresh correctly reports no match error' "
+	echo \"fatal: pathspec ':(icase)nonexistent' did not match any files\" >expect &&
+	test_must_fail git add --refresh ':(icase)nonexistent' 2>actual &&
+	test_i18ncmp expect actual
+"
+
 test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
-- 
2.30.1

