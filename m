Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE057C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 11:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD9223100
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 11:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAXLwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 06:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbhAXLts (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 06:49:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDDC061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 03:49:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id s24so8969856wmj.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 03:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZZS0YZAyZEuo1prG1ViEnK4ihT1dsIqfTk5Z861KQE=;
        b=XpGREnYzeOg4liPlKLyXZS0qeVkvKQ/ZL/k4jSyBtqrlB/S9/JTDKdJ/44podtJPX7
         nyxLOSI4hq1kJ+V48Q2jjHwC6NBhEu/RAppL/2qIEVpFbYl72L+Z6VqpUythx1I+0Gsc
         hObVDyGqrd6qL5cBHSVvFOYm2QIaaGAtcVU6JotX/hI+29rT0nrz8UHU2uExBwV/Hgh3
         T1bYsUO6YFJz+kuuk2rEB9MW9MT83ma++C6GuIRyy1zCCoL0YOLwgdMQc793vc9e7mRu
         TRaZ5cPLvLRnMI2TmAfB6IWRYVoOxBup3wXcTNKcAyUMjurH2YRjSRfUbBaDu2dP5wJq
         Onlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZZS0YZAyZEuo1prG1ViEnK4ihT1dsIqfTk5Z861KQE=;
        b=TgHSCmenBzXNEhhgRxt4LwGhpRvsRZ1RmCQl0MyjpSEqgd0mO6PPDgXaOn343I1+ki
         1PxgJSTOsKdhU1ThC37wtRuQOM5yNpY3oOndlIC8rBZUe1ModhqvGqu6UqjQqpsPqkQq
         Eh/l42dU+YCautX99zpmRFbPpE/K4RiWjCYsSkwK8869/KUET9wr6CPC34NlXASu1MCc
         oGuhkhLsGSXdLDxZimQ+/VEaMnwRLBdI3dpvtrqMBm4pyH3ys0F0yAprzZcxqHTkAwh9
         +95svyxDdR6ySNXTIzscNMTXBiWroqogGtC02EyazLCR0R3gR10MRQ6qivqGLqkyWhnQ
         87lg==
X-Gm-Message-State: AOAM5317oTezaHkFF4CdoH/USRnlhRNAKMlFDRFDj4bglavJTdK/BUVw
        AMGYc+zgqXKUjCm7OKSINqtxroL0mdxEJg==
X-Google-Smtp-Source: ABdhPJzqYS5NvxeSNaPr107+vREz4dSh6vsdyxcW/zmE7ciVL9g+UNGjL9RMtc3HSgwdBW/5hOuxnQ==
X-Received: by 2002:a1c:2287:: with SMTP id i129mr2055224wmi.109.1611488946255;
        Sun, 24 Jan 2021 03:49:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q18sm10883897wrr.55.2021.01.24.03.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 03:49:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/2] grep: better support invalid UTF-8 haystacks
Date:   Sun, 24 Jan 2021 12:48:53 +0100
Message-Id: <20210124114855.13036-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210124021229.25987-1-avarab@gmail.com>
References: <20210124021229.25987-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2: Dropped mid-series unrelated refactoring. Will leave
it to a future patch series to simplify/move/refactor this code more
generally.

Ævar Arnfjörð Bjarmason (2):
  grep/pcre2 tests: don't rely on invalid UTF-8 data test
  grep/pcre2: better support invalid UTF-8 haystacks

 Makefile                        |  1 +
 grep.c                          |  8 ++++-
 grep.h                          |  4 +++
 t/helper/test-pcre2-config.c    | 12 ++++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 53 ++++++++++++++++++++++++++++-----
 7 files changed, 72 insertions(+), 8 deletions(-)
 create mode 100644 t/helper/test-pcre2-config.c

Range-diff:
-:  ---------- > 1:  699bb6b324 grep/pcre2 tests: don't rely on invalid UTF-8 data test
-:  ---------- > 2:  e4807d6879 grep/pcre2: better support invalid UTF-8 haystacks
-- 
2.29.2.222.g5d2a92d10f8

