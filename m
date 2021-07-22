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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC941C6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B260161241
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhGUX2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGUX2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB74C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso3700649otr.13
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIbiQUipN5dWiNDSYBNUUros+PzR38xCI8hqa6nFSCc=;
        b=pmyp/azF6hgT6yuOg3wxWV7TSTtPcll75XH8MGr0mRpL0ZqNDaoaYPCFaBAzVyRulq
         RHbN7nk06p8xhN1+mJbsDHV2bGQRIrMirOk64Bc14gVk7lAk38k1XXzkhXdvIaBYznCJ
         PzIo4gntVItBTbQaaLz2v7zfCrRa/4Py8JlD6KQhsNS6AKU/v/j1yLmPoz1WddyHxV9j
         YTRb6HT/jfEbWRTrugPddizadu6lt6Y/Biy3P3JDrt2CPf/Ry5TjmUEShAxhBQHHtq62
         SSwSKM+7SE+HiUlIed0LO+xmMijnni632H6Wa9zmaYj+77uu2eWL4F4h2oY3qREDooaf
         x9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIbiQUipN5dWiNDSYBNUUros+PzR38xCI8hqa6nFSCc=;
        b=XnpH2nR304GXSa+HK/N0WRgqLneT7fH9AS13x0clezAZkKp1Rr8Sl5mlUj9PNxEIuC
         QUFQKzSkOhEM1lOoF6JZHzN0QkPjK1e/e6o4GDkx/2C1o77klFFEQGbDnZrV1pB4OeUK
         SfXZj4KeUmJupJqQ32VUzUxI+T47PcY3H/tx/Z/pttTqs8tlI/ag3mQfpSHEIKWtc386
         cp3t/8E+GWNBwQGVUjSVYZ4CsBTfoitNbrvuN2DsPm18yf2S+PuBgmIyM3RxJbP80dWS
         FDLOXsl8eHPe4m+Ur6XSEynmKCdI67GhdbZNblNXMH4SDmvwKDqZrsZ5qAjPm8KI2ATx
         eOgg==
X-Gm-Message-State: AOAM531trHoO3PWLCeQ/YY6O8IKaycaeoQU3cGjGft4kB8phMok6RHYr
        ii6xjsSlWnLm5tgkO6jcd8f5onfLPS7hJg==
X-Google-Smtp-Source: ABdhPJwyZ16fmlAcgb00rL8ab18U7P2tLp5xiwyq2PAVpN5r0S9puRbzdO/+utIduDMCfz/yvOF9FA==
X-Received: by 2002:a05:6830:2458:: with SMTP id x24mr9265608otr.312.1626912539823;
        Wed, 21 Jul 2021 17:08:59 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id g66sm4851372oob.27.2021.07.21.17.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:08:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/7] merge: improve fatal fast-forward message
Date:   Wed, 21 Jul 2021 19:08:48 -0500
Message-Id: <20210722000854.1899129-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation of --ff-only says:

  With `--ff-only`, resolve the merge as a fast-forward when possible.
  When not possible, refuse to merge and exit with a non-zero status.

So when the user does --ff-only, and a fast-forward is not possible, the
user wants git to abort, therefore an error message of:

 fatal: Not possible to fast-forward, aborting.

is redundant; no need to say ", aborting".

Additionally, use lowercase and lose the full stop to be consistent with
other die() messages.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..05e631229d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fast_forward == FF_ONLY)
-		die(_("Not possible to fast-forward, aborting."));
+		die(_("unable to fast-forward"));
 
 	if (autostash)
 		create_autostash(the_repository,
-- 
2.32.0.40.gb9b36f9b52

