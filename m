Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8256C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8160207D3
	for <git@archiver.kernel.org>; Mon, 18 May 2020 18:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7x9X3QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgERSoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgERSon (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 14:44:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F034C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:44:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u35so5246514pgk.6
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNJ9lfRBNdwtamZDPlG/tAJLbfOpbREobCNiyk2F0dw=;
        b=O7x9X3QO6cidbHFuEBUYfI+NyDL4NPssYa1sp9rYXUHUyVZrwy5CUb3nNQBsKKiXNR
         dehYKUljaCeZQ2gpOm39fwTsPFYk8veE6Hpcgnny7HyWGGZyhrpoWpGYJMRgIGzwPugu
         ZkVehAcEO5EFJlT2Hvmct7LQL91T9IWaDw5PgcLbGayPdKW2grdzDai9FwN6oJKI9mjg
         y77i9LeBtAUL305ztJAtOtRxl8Iu3zkHIYe0iopNXJdVdQVdYc+ZT8y6qgRWwARPprAt
         XYJyC1yI5P8zMGQi1SBL5Uou6+TSz+T+zrQ+dmoQw8yglvoDRFDfKImML5iK4DFnZRxh
         al1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNJ9lfRBNdwtamZDPlG/tAJLbfOpbREobCNiyk2F0dw=;
        b=eJVPI0Nde5MIdwUB+gqxjfi48Xj/Vfmi+7+6I3w1tAuINDUFhDPVyl1CLlbG6i0IuD
         VYxTZTedZHtPf2bMYLtZpKN7JE18A1OQqcpFdYcggrjPmF+WEp0KtfdBC0tKv3CYiw+u
         M+hEro49HxbMaaGN04+zzIn5jlByRmWiD4QGogIuoi0nLiFAHrlTbp1YXWTdCC/Ei1+v
         Fus24jofKfcjHYeqtspONzEQDnGz453+dS93QQ1UwLbIj62o4yYjKt9/ZZBgPDRTT9XY
         jK4pTclvUD7xQJRIePGUdrzW0PqDNs7ynx3vjsTLFQL8Rfjw20CU7zmeodBi5AXn77WG
         Hq0A==
X-Gm-Message-State: AOAM5337Cv+aRYxIc+66xflXY24jDEgbR0aiUd/Vb1KueCdMFG1o3x8t
        TgsWDuRW6EgsrBquQfKPIOjiMLy4
X-Google-Smtp-Source: ABdhPJxzcv4KiQ/QibO6tWwOCTKE91/XYpdK9jGvnJgTCgzFj71ISKC212uk7cr5oaZyuCFevl5aSw==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr15185318pgj.2.1589827482098;
        Mon, 18 May 2020 11:44:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id f6sm9489113pfd.175.2020.05.18.11.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 11:44:41 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     emaste@freebsd.org, sunshine@sunshineco.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/2] auto detect REG_ILLSEQ
Date:   Mon, 18 May 2020 11:44:14 -0700
Message-Id: <20200518184416.13882-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200515195157.41217-1-carenas@gmail.com>
References: <20200515195157.41217-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll for cb/t4210-illseq-auto-detect that includes all
feedback and split on two steps for easy of reviewing.

While the refactoring in test-regex.c is a little more intrusive that
needed, makes the logic easier to follow and the different use cases
more straightforward.

Note that there is still a leak in the use of regex_t, and had kept
all original assumptions for simplicity (no explicit check on REG_ILLSEQ,
or unlikely differences between BASIC/EXTENDED).

Carlo Marcelo Arenas Belón (2):
  t/helper: teach test-regex to report pattern errors (like REG_ILLSEQ)
  t4210: detect REG_ILLSEQ dynamically and skip affected tests

 t/helper/test-regex.c | 94 ++++++++++++++++++++++++++++++-------------
 t/t4210-log-i18n.sh   | 77 ++++++++++++++++++++++++++---------
 t/test-lib.sh         |  6 ---
 3 files changed, 125 insertions(+), 52 deletions(-)

-- 
2.27.0.rc0.183.gde8f92d652

