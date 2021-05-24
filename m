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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA1C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CEF610CB
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhEXHym (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhEXHyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40590C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso10889828wmh.4
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMCxiDw4EQgbaIBNco5GEB3n+7Mn1STtu8Yen9X/6Xc=;
        b=bAJ69DW7ukA2k+annVjoMjO3WIUu48KNtklope2VWe/Ru5Bp/GWPWbPRkOSPKgJeJt
         qUy5ZXGxXVcMRI3Mq0HiKuS8jBxf72qUMjRFBdGomlPNPIU1vBmHnbX9/tggYJUk9X5Y
         A41345Ow15Lc9X8KMw9Xx16R21X8uHQNL2kHHN0BmIXtrxDT+1Lx5wEYBjQonojeYEHy
         Bs7tfDwnmZMSD3qYC7hZ6+MOG/uJ9KkG9c3uaJCtQF/6svPpgL1h6/FFJr9WBRUTzfTq
         l5k1k+eBj/ZsPD0LTNYsvgFiXfnqDPwUHTiR870jskv/QqP0Ls2clfExsni2rUZc9bSp
         /SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMCxiDw4EQgbaIBNco5GEB3n+7Mn1STtu8Yen9X/6Xc=;
        b=ZFNaoY1BHx94uS8pinmRbdwe9D0Ywv4BtXz2WDg22JXgqcMbZgI4hHp/ZVd5hXLoej
         /jl5zdk5EXyzj8vmncLEZX2hMDRvF0VYjnWO29G0qw7AiusiywL0856oJ3IM/vXBLm3u
         Adou7Ym19aP0kXfwI+WDOmK0sL0FS95caufymSA7nf5P3PGnL4Fd4uuaHgLmSJbj1rYi
         jhcZH3kBYr7uvoKZQEGz4dgY2z+mk0Wl+pFt5H+YjdsMj7hh833zblDAq+TvtUsgetFn
         RAlSlaIa3i391e3XWHKtvY0hHLl1IiJzAsmzk7YgS2zonQ+dF9E3fGj3+FV5EmfGmtqr
         DeJQ==
X-Gm-Message-State: AOAM530Vj2UwAyRZ3U7+abAFghvHWXRlpp8T36sa50nTbLJjYpvOvJpp
        ZTTjrgyJtqjNkuqcvf4k0uK92AG7phawBv5y
X-Google-Smtp-Source: ABdhPJxj3WhnhUxcnEgLuyzE1ctFtoMnOFQiCWlgLaui8S4k/G/xg/uT4qsTbVqezhin94fB6gK5Rg==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr19209098wmg.165.1621842786577;
        Mon, 24 May 2021 00:53:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/13] send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
Date:   Mon, 24 May 2021 09:52:50 +0200
Message-Id: <patch-01.13-7140847367c-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for the "GIT_TEST_PERL_FATAL_WARNINGS=true" test mode to
"send-email". This was added to e.g. git-svn in 5338ed2b26 (perl:
check for perl warnings while running tests, 2020-10-21), but not
"send-email". Let's rectify that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d946..cffdfdacfb9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -18,7 +18,7 @@
 
 use 5.008;
 use strict;
-use warnings;
+use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use POSIX qw/strftime/;
 use Term::ReadLine;
 use Getopt::Long;
-- 
2.32.0.rc1.385.g46e826f1e55

