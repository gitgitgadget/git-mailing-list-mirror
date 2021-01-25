Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BB8C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6637229EF
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbhAYXMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbhAYXK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:10:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C4C061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:10:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so17598663ede.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKXqQ3yE4CNaI8vrq5cupb6bB8meWVmGPGG1Abn3cos=;
        b=cH9AXT45Fw/mL+x5vAc/lzHvP1HEvBG1H96mq3zNsQ5Qsnn3jo41nQtKA6UVOu+cP7
         +Gpm+0TjVzc5oQB6EJlIT3L3Yp2hUAOr0kuvtTk6xSGNZ4OMGYqrelaFRO7+YWJrBFun
         ZQJu+W1C8rmd2fUJ4NYDkwv+SIdtEGxLG43Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKXqQ3yE4CNaI8vrq5cupb6bB8meWVmGPGG1Abn3cos=;
        b=BvzWCosZx8bkn87bLau1dn8/5YUSuizkljG8TQ3+bhMqE/gGemClbYAbQSL7gyxv8C
         4kp8OG5hgkj/cmlUbzBNL8PdeptLUlgdS1PmxboJ2IKYKKqmmhxDuAP7IrXWm6i68q4o
         D43mlt+lVnNnUx6Y3BGBuUwVfkBcvu1iOGkDJdX7Ykn+7PIlFD27E+CsV+4+K3MhlCXs
         biw2BQged74hXzY39MINmPTVi8ePf24eQYpAzwOja8K9gy2NATT+QzbVTawg7z5giP3L
         6mZqBz3jMOQUuSq1hqpumrV/GYglIf+8FeNTqGWycx3WU52RozmqHbD7zF+iRVqX1ZAU
         MjCw==
X-Gm-Message-State: AOAM531NYgpBZgdfAI+qeMC9u5CL42Bphz9EYU4awwVChydoXveifhgJ
        hbbgU7rSJa2HtSUX9mBzbF6K4Q==
X-Google-Smtp-Source: ABdhPJx1HxqoGzpKvx3MzBco8Jez9VIrbIutlRWN5QbIWQ1qqEP+EIN/BYrkcjrI18tHtfJFTE9QTA==
X-Received: by 2002:a05:6402:3088:: with SMTP id de8mr2305595edb.221.1611616214671;
        Mon, 25 Jan 2021 15:10:14 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id g14sm8946245ejr.105.2021.01.25.15.10.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 15:10:13 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, gitster@pobox.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v3 0/1] upload-pack.c: fix filter spec quoting bug
Date:   Tue, 26 Jan 2021 00:09:51 +0100
Message-Id: <20210125230952.15468-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now with sign-off. Thanks for the reviews and comments!

Jacob

Jacob Vosmaer (1):
  upload-pack.c: fix filter spec quoting bug

 t/t5544-pack-objects-hook.sh | 9 +++++++++
 upload-pack.c                | 9 +--------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.30.0

