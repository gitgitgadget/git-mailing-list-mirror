Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F39C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5DA22B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAXCNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbhAXCNd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:13:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6313FC0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so8805242wrx.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6axhlXH922hCo5Pq1m/u7hoCmdoDvyf2xscmQEH4/vU=;
        b=Ysla3owBHIy2WA0g7HpYpYrNYArIqlIV0ASwdGGH4d6r9NsFpWODT5U+fhBrK3/Im0
         CT0RjF977qHVA/uOIQjdcJ00u/Hmb1jtqh57DfH7KcPzigvJjRpnVmFIp5CzDJJuzfan
         VmRTmP2Dy939VIMWvRryiZRXz11F+1shqMrPWc6LTVb4DSf8Asq8/HM4X13/No2md+jc
         weQ8ZfP9wRFtEmtdG7HZNQ+q7n26SHCAOQB+tW9O7l21PtDjRyZB5VW0F7D+huOutLL5
         Oq1UZqflw/rN2gkhPHkfMPEaMVv0HgwixmXlapo5NaUzuKBygLcC7BPPBhy8wkB0P6Cy
         N5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6axhlXH922hCo5Pq1m/u7hoCmdoDvyf2xscmQEH4/vU=;
        b=dcQDveAuQIwwDoKpy5CgXxK8LrlrUjNzn9DQ+FgCTRHKgt7BwbZNxhqCdnESzzsH/d
         2SEdvxsP4RSBq/vDqIXGh+Ie8f7C0HqpNWrdDTzJR86Ca6FftwkVL44MP29wQ4Fa46ne
         Tk/Am7Z6G9vUTF5O7SQuzSlvrkCLUo6uBA2PMzzRjnCsINnp7w3i3Ie9vYGW98oQTzqZ
         4O56vqB6vnnCzigfD0QlO3VgUTEsEeze4JAgc764xwDIXmXCCVjv8csuUWweOxgcm8we
         k3XyU6TZVEGbw+QV9AbrGf5OFYntdQ+FO5ktEFKKAUD2FR8kNM1o/P65hLPd3ALFJHcy
         Hatg==
X-Gm-Message-State: AOAM531GmYlvTG0ydlY4mrSY7EqJVknCf4XJZXsVF8n8JjFiBAQzcrO1
        5lNiohrJJgV0lX0kUB7Xyn2ZkDblYNEauw==
X-Google-Smtp-Source: ABdhPJwrufGdw5d0oNBPLOaQeW+RhIaTWhALpMa1sUuuHy0m6fFUJP8W2Byx4HSotuVmdTb8xafiRw==
X-Received: by 2002:adf:d206:: with SMTP id j6mr10826264wrh.427.1611454370822;
        Sat, 23 Jan 2021 18:12:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z184sm17380129wmg.7.2021.01.23.18.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 18:12:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] grep: better support invalid UTF-8 haystacks
Date:   Sun, 24 Jan 2021 03:12:25 +0100
Message-Id: <20210124021229.25987-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20190726150818.6373-9-avarab@gmail.com>
References: <20190726150818.6373-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3 of a patch I originally sent in mid-2019:
https://lore.kernel.org/git/20190726150818.6373-9-avarab@gmail.com/

Back then we were near a release and the PCREv2 feature I'm using in
4/4 wasn't in any released version. Now it's in widely used releases,
so we can use it and fix some long-standing TODOs in invalid UTF-8
grep matching edge cases.

Ævar Arnfjörð Bjarmason (4):
  grep/pcre2 tests: don't rely on invalid UTF-8 data test
  grep/pcre2: simplify boolean spaghetti
  grep/pcre2: further simplify boolean spaghetti
  grep/pcre2: better support invalid UTF-8 haystacks

 Makefile                        |  1 +
 grep.c                          | 11 +++++--
 grep.h                          |  4 +++
 t/helper/test-pcre2-config.c    | 12 ++++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 53 ++++++++++++++++++++++++++++-----
 7 files changed, 74 insertions(+), 9 deletions(-)
 create mode 100644 t/helper/test-pcre2-config.c

-- 
2.29.2.222.g5d2a92d10f8

