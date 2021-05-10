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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE9C43617
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451FD61042
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhEJLM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhEJK6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF6C03543B
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l7so18176792edb.1
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xS2d+NE5AU1cto3G/J1HpkIFcCjfHklhZ6SZowtmOD0=;
        b=Z1ih33d1kFOkmU9ZkLttiXEFCYxyUv+LOxMSmzaa2gdNq3aSKaV/xtXyWS/jouOGGW
         1adrqef7v+LQHyt1LoAd1xvXf8h6FDpbiiy62JreFZZvsJQOxQOznS0DY9ro3tCQEMSw
         gtxNVpo00XONTbX/Mlesgx7qav/5GAzlKQVaNLmyhuMckiaJqHSPFtvqkQ+bmgM+ycIb
         4BXjGumCFWJEr+h8Bh/FzS3ldPtZsQPyhh4Kc+k+7NuTpL4odhRtaUZMV+AS3ffKYdxO
         ejVp0SPMLK/RP3s3ZghleJiQQnGqlEj6Vn/RvAmPURKe7VWwBY6F7mhpZNWwlAjunGdb
         FAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xS2d+NE5AU1cto3G/J1HpkIFcCjfHklhZ6SZowtmOD0=;
        b=jx0yy1qBEPRh0HHwsS2IyzDPMpKmpaCs/RFfghfmx8lE25SYXJMHncyfFHWOdboL/y
         RzlCTwFsDK4Hvtj/fNvr7TCFRC+o5TG+YGmwKxZf9Yy2FqYAIiUnBqAizz97dUTCpmtQ
         1ad9iX+FgHnKBc+XQ67HQuPoYO8TyX4GmcqnRhkZVB3ApRtUJQBXmui9Pk2d6FiaDV/T
         AbsqLJOA5zgQHWZngpmHQwi7/3yQuynJklmCoeXqHyAkDjvUM4rpzBfXSFfV0v/U8LTP
         ZzgE4lFbkCxT/5/nLTC9QpHdEdUSHcBVcOMdRQbQPHnDOAMwQJ2y5CBVB0w2MYQ5JTem
         VSwg==
X-Gm-Message-State: AOAM530lA5q+HLtYlxFXKVEpdQ1aWAULD/BvUfQGoldxYkXWf6PItR6v
        Mpca4ZXCFHbtrgykj9Kptgd0Pz0crc1RVg==
X-Google-Smtp-Source: ABdhPJzm+DSUWfANCL6DYWjtZZJSBKPIYIw0YME9QlTG975a9lcrb3GEvhZsdLMI2xH5qLXhbyMrtw==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr28597479edt.92.1620643829478;
        Mon, 10 May 2021 03:50:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] Makefile: don't re-define PERL_DEFINES
Date:   Mon, 10 May 2021 12:50:18 +0200
Message-Id: <patch-2.6-c15887bbc93-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com> <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
2018-04-10) we have been declaring PERL_DEFINES right after assigning
to it, with the effect that the first PERL_DEFINES was ignored.

This didn't matter in practice since the first line had all the same
variables as the second, so we'd correctly re-generate everything. It
just made for confusing reading. Let's remove that first assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index ad618cea33f..ea387b431e1 100644
--- a/Makefile
+++ b/Makefile
@@ -2270,8 +2270,6 @@ perl_localedir_SQ = $(localedir_SQ)
 
 ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
-PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
-
 PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 
-- 
2.31.1.838.g924d365b763

