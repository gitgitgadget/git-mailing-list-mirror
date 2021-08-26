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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B4C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D926103A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbhHZVBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243612AbhHZVBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:01:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219DCC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mf2so9106043ejb.9
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t55I09QR54J0prUQgQGz8Y/0+6hYR7ofIGx06kmBclI=;
        b=l38jHcHTPuzjGzu+0KQ4lK91BFl1ovRGXeHcDgQlJ/QoixsOv7d5XJlnLPCfmj+TKE
         XINdnC+1RIwN76Nx2NMs8l+8CxMo7WlRW+Lses+YT1905Ax5uqAond0+DY5SMj0bzMUt
         S6N+9Cuxt+LZxXVnoO9KHu+YNEgZdbUXPUdomwgJsgZd5ByrJ2j+usM1Itr2r8qCAbMS
         /rrh+OU1z06x3MB+6xnnY3YRuxb9YDacm3J0gwGzKAwbD/DBNopgk1UxYsKg5aBN/xPI
         xRG8qEo1+np6N4BlkqRGT8uoEYSYYqgwaTaC0YqdL30FSQRmL6ny3TJ0bFGuqwrcMpQX
         RuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t55I09QR54J0prUQgQGz8Y/0+6hYR7ofIGx06kmBclI=;
        b=VTyLTetRz1YmDIJfHMX4DR1uW2Xy8110Q/LZO+198ozqXUCahrfwYaFOAHFa/7CAln
         QJuz/6wRH++Gl+3V82/88Cvz8uZZgpfhapoQW9Za/BGtqyVg6N11hCn6dzxLVqN/IAL3
         AjPFiYldkiwyCZoB6B2EAD2Tt78rgrUr6OHyFJcVMMCo8DlMk8m/GFaNuUsBqXDJtF8b
         4Wkji5axm8AZnueuxXWjE0UFRXrq8bmOSzrjP1g+VC4yO40L8vgXKcklqt/Sf6EXyJEO
         xGiJ25oxoY8DmEhrK/+pVlD9qNfagb7AzGziNKiIQoPsaFDdV1WrbBtm/8kftf3ei15/
         np0w==
X-Gm-Message-State: AOAM531iL0SRviMmwc4CcYwJHwxHpDLGjEva1RtlCP90Xi5p/b1ZO4Kd
        ddg3FiH/JtTcZ3Wl9plrQqxott4Fc5g=
X-Google-Smtp-Source: ABdhPJxgARRKWYID5PLzZ42RjGD/ZuAYPmL8hNPAB/js1bEqu7PBUbLMSvk1hX+utDg8ZDwSplhcDA==
X-Received: by 2002:a17:906:5f93:: with SMTP id a19mr6489106eju.126.1630011614667;
        Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q14sm1884779ejc.93.2021.08.26.14.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/6] t1600-index: disable GIT_TEST_SPLIT_INDEX
Date:   Thu, 26 Aug 2021 23:00:01 +0200
Message-Id: <20210826210004.672860-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
In-Reply-To: <20210826210004.672860-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210826210004.672860-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in 't1600-index.sh' check that various bogus index version
values are recognized and an appropriate warning message is issued.
GIT_TEST_SPLIT_INDEX=1 is supposed to trigger index splitting
randomly, and thus might interfere [1] with these tests: splitting the
index means that two index files are written (the shared base index
and the split '.git/index'), and the same warning message is then
issued twice, failing these tests.

Unset GIT_TEST_SPLIT_INDEX in this test script to avoid such
interference.

[1] There is no such interference at the moment, because, alas,
    GIT_TEST_SPLIT_INDEX=1 is broken and never split the index.  There
    was no such interference in the past (before it broke) either,
    because the first index write with GIT_TEST_SPLIT_INDEX=1 never
    split the index, only the second write did.  A subsequent commit
    fixing GIT_TEST_SPLIT_INDEX will have all the details on this.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1600-index.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index aa88fc30ce..46329c488b 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -4,6 +4,8 @@ test_description='index file specific tests'
 
 . ./test-lib.sh
 
+sane_unset GIT_TEST_SPLIT_INDEX
+
 test_expect_success 'setup' '
 	echo 1 >a
 '
-- 
2.33.0.358.g803110d36e

