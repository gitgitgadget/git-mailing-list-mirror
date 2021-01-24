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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAA0C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9798923100
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 11:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAXLvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 06:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbhAXLtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 06:49:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D313BC061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 03:49:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y187so8295250wmd.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NB7mhvFvUjEowPusLa+YA1W3DcEB1yfVBnq/lJzfrok=;
        b=P6/t6y1I0lX9U9rC+n5NhWsYJIDkBFoWvHnSnZMNBZYuTXDu1vQ05fFJm7Zs5IWa7E
         OZIZnDLidwTh0k0605ihdtUmgPsisne6eixqIBB3loa17QYPtBPrjqeBY7XluJZQRDyp
         So5I6iyQwkPWwX/iK1pfmsk5xrE/gFQ7vKM+WAgFA1uTp5QH+cONAIuxfdKW1X8xUz0D
         KktVds9j5+er0CyV8/p5OexDpdV7Ou0KIyLPT8jWer3MOpjdXYCuK3EY4slMQqFrL/3V
         0aX5rKrzOQebvJ0M1GMBfA1hqAz5WwK5jHVvsybPHbw2DdQlAMp2RzxHH58c9BAq7cwD
         3NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NB7mhvFvUjEowPusLa+YA1W3DcEB1yfVBnq/lJzfrok=;
        b=HFGYjvVEzSumg7LCLrOnFeW1yc11o3viKxdki/MOS0QHR9CibKrXJfC+CoeEOlnitZ
         Vaf+RY1ATfRNNOJMmgSw0tB/g+l1FOaNx6Bn6Jsf9uM5TIGYcB7nxhRfzlgVSBiBO+h8
         xmvcCbudGaPFL1QMjnDm/smV3jTVILDbikymBquRe8m9q48LjAKRg+HSOSQD4ZSUlepi
         /rtpRQUXdfbKFImD1gCsQZXk8SFyC+gyz6rCFKFom5ICQuoJHPpC09RUbPlsZCFEIGu1
         04TrwAER5HuflMQYs0t+Oj+gR5+a2mUpgnAlVkSzAyhmHFaiP3K+c6esZUYIILLid0w/
         bAMA==
X-Gm-Message-State: AOAM533EQjAQi+rINg7gCXmcFfwe+rS0EZSP7MSfgWKkQzIK1k1gAf2x
        ixhctGPdaCEHPyFZOK7KaJDOQ5jUGW6EBA==
X-Google-Smtp-Source: ABdhPJwqBE8yhkZF1z0p0Dt2bIcy/8GrlfF/FMjSvEwwvYm4Zjmy1ZH3LbR0z7OoRxnif4rC1S/Q5Q==
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr606097wmj.29.1611488947143;
        Sun, 24 Jan 2021 03:49:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q18sm10883897wrr.55.2021.01.24.03.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 03:49:06 -0800 (PST)
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
Subject: [PATCH v4 1/2] grep/pcre2 tests: don't rely on invalid UTF-8 data test
Date:   Sun, 24 Jan 2021 12:48:54 +0100
Message-Id: <20210124114855.13036-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210124021229.25987-1-avarab@gmail.com>
References: <20210124021229.25987-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in [1] when I originally added this test in [2] the test was
completely broken as it lacked a redirect[3]. I now think this whole
thing is overly fragile. Let's only test if we have a segfault here.

Before this the first test's "test_cmp" was pretty meaningless. We
were only testing if PCREv2 was so broken that it would spew out
something completely unrelated on stdout, which isn't very plausible.

In the second test we're relying on PCREv2 forever holding to the
current behavior of the PCRE_UTF8 flag, as opposed to learning some
optimistic graceful fallback to PCRE2_MATCH_INVALID_UTF in the
future. If that happens having this test broken under bisecting would
suck.

A follow-up commit will actually test this case in a meaningful way
under the PCRE2_MATCH_INVALID_UTF flag. Let's run this one
unconditionally, and just make sure we don't segfault.

1. e714b898c6 (t7812: expect failure for grep -i with invalid UTF-8
   data, 2019-11-29)
2. 8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data,
   2019-07-26)
3. c74b3cbb83 (t7812: add missing redirects, 2019-11-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7812-grep-icase-non-ascii.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 03dba6685a..38457c2e4f 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -76,12 +76,7 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invali
 
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
-	if test -s actual
-	then
-	    test_cmp expected actual
-	fi &&
-	test_must_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual &&
-	! test_cmp expected actual
+	test_might_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual
 '
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

