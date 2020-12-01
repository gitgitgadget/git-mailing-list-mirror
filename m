Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F04C71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E71B2085B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9kNaIhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgLAArq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbgLAArn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:47:43 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABDC0613D4
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:57 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id z23so44750oti.13
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpDKWpGHKGXx8b7pLO8/lRpGqgffZf2XNHl7r3qXpf4=;
        b=h9kNaIhmy3DDcIZ+NSB0oGn4RTeVm3R1hd8V7cn96T5ATGrDhC7rd1KNf7dUOM7XRA
         IUt6t2qrVb+ptyq2EBTyl11XlDzJ7/LZFgg0PA5rUFsJvQmD69DuWUShWx0dLqPxa3wz
         9tVUCkPZO70sD99bxAveGSz7tbrXWE6+wJih5iLCOqDtnRVWJruAqgBNQCJjdWxi5FJ+
         6CvsqtAstp2oKo9bQH1UEJ9hJOM539YCyv5RJPbiNyQjRb9hUE16xL62uisHoSPN2TOq
         8JY3i1szXmvJ8COYDIc1w43MIQwt3YT4viMjidPJfIfaGKYWVv/GBfb/jynWX0hFXYky
         Y1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpDKWpGHKGXx8b7pLO8/lRpGqgffZf2XNHl7r3qXpf4=;
        b=uMyRedl6/jBTynUhf3xVy4WbAWMCJYQgy7wozbG8v55Be9gnBL0SNRD0L/oAApoiaZ
         PxeryCHsjMB/sJ151lZYhL+n/AwsIk3wvrFEwUKKX6R8OF9SYlPyDZvi8hXHO5fmzhBy
         YFiAKOfOVIKcaPzxLY4ZaSO4yzDMkLHc2BHHOJv3gusXmxIQ0ipQBER51hw4Kr2pf9Os
         RZD20SfatiezfhHrZKv9qvHFMHZGjrKJsVj98puSBMq5Y0MmeSwLclvurvxxgzUdhQCj
         abYc1+HhLc81+s0byYU4MO0mVJ7vEycZ9u0MyiI4sHZKdfrvpE+M9fU7TATgDqDEk9Q2
         V8pA==
X-Gm-Message-State: AOAM533jG51kUnfyFYI8zD8vMwURHF3e0aWyPda4+wStnEDYHqUNkXDj
        jY0OVUyl0zxreNR8Zzsw5MJX0tGS+BLEjw==
X-Google-Smtp-Source: ABdhPJworKnJ1aLB520+THXUvVOardxP9EksAWGIybbPXnAR/ZQgxFPu3w0/WzejhmD4SSvAk23j0A==
X-Received: by 2002:a9d:7a97:: with SMTP id l23mr108531otn.232.1606783616924;
        Mon, 30 Nov 2020 16:46:56 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h17sm52670oor.1.2020.11.30.16.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:46:56 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] test: completion: fix typos
Date:   Mon, 30 Nov 2020 18:46:48 -0600
Message-Id: <20201201004649.57548-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201004649.57548-1-felipe.contreras@gmail.com>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5c01c75d40..81a728c743 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -906,7 +906,7 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__git refs - exluding refs' '
+test_expect_success '__git refs - excluding refs' '
 	cat >expected <<-EOF &&
 	^HEAD
 	^master
@@ -922,7 +922,7 @@ test_expect_success '__git refs - exluding refs' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__git refs - exluding full refs' '
+test_expect_success '__git refs - excluding full refs' '
 	cat >expected <<-EOF &&
 	^refs/heads/master
 	^refs/heads/matching-branch
-- 
2.29.2

