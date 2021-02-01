Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A08C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D4D64EC8
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBAUal (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBAUaj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:30:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF11C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 12:29:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id rv9so26397755ejb.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYYmGOuuKlbD8dA9lMsrzIUoDsbXRFYjhwYQUv5A/Qg=;
        b=eC3gFs/LbgKywm2T7oZIrSz+OYjeKj4K+pnEmveT8V7KvIGi4qeU0HFO0/6F/y/ykW
         R9KLe60GDcGNhZVI81agEQcTZznNuVHQPczTBF6wBQ5g/PW6x5E2y83W8HYsCAYjpPt9
         ARhrw6EY7tnRtCCQPJMu9Xcv0L96o+S93y5xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYYmGOuuKlbD8dA9lMsrzIUoDsbXRFYjhwYQUv5A/Qg=;
        b=e13CnMjhOX7cjHGJqN5HvNvQcVeb09SiWFD1p05xiYHFNH2aYGfJzxCOWZUs/V9TII
         1SQ/UY8eRP4jfDZM2Je5osmZTPEeUIOp5yOCNtpk/QkavZxdvyRPOXmQkaakTtoAUKTJ
         XCuBfXjqQQObY2aAp1jalM6/G/2PyOH4voaMNkzFbZbYQYSfYHdt6xCOlvTBLebKroyp
         1CT9X6Mq+soKMXEQ9QMtrsyToSsgf96Cjslo721nfPGUKfwNj66olM2TjDFcahVXmnFw
         wcmG77LwPJkCkJSdgklglPKl6AnqNlgca7F7yMgUoMh2hzqNZ5EqiP6HUOxRyNGygSvk
         Ohug==
X-Gm-Message-State: AOAM533lkgMy+bXSAiKugtItADeH2eUEWU4fsk5pykmkqD6wJf/3T87N
        TWQ/Kj0kGOuNn6Q19wm2dSMsTA==
X-Google-Smtp-Source: ABdhPJzDv9TclvryVyG8Su/9QSejP7FkC68FkyGOiongip6lndZ0ok0HoVnl4M7a2QExZhG2Cc4FdQ==
X-Received: by 2002:a17:906:7f98:: with SMTP id f24mr19363563ejr.75.1612211398213;
        Mon, 01 Feb 2021 12:29:58 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id n16sm4247521ejd.116.2021.02.01.12.29.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 12:29:57 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v5 0/1] upload-pack.c: fix filter spec quoting bug
Date:   Mon,  1 Feb 2021 21:29:37 +0100
Message-Id: <20210201202938.39576-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <xmqqpn1ovi4j.fsf@gitster.c.googlers.com>
References: <xmqqpn1ovi4j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I updated the test based on the latest round of feedback.

Jacob Vosmaer (1):
  upload-pack.c: fix filter spec quoting bug

 t/t5544-pack-objects-hook.sh | 10 ++++++++++
 upload-pack.c                |  9 +--------
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.30.0

