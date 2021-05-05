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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C72C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06DB613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhEEMWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhEEMWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:22:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531EC06138D
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:21:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so1619298wrr.2
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MijQWzB8/gN5fDGEK8cjygEaofFJBc9IoUDsbft3Wtw=;
        b=EzfU2dvtdiahmNQTGbHjXy2djBcbNyBi8NNI6/NTHSbh71m24puzT1fTOChxFG8sgS
         6CSLu9EgCfuLy71GLI9Cr92pZmCE2ZbwWY/GemgmDWUwXhR0mhB8duakbv1BySzZjN96
         mrgwyEw+RVJ76ixtn9zsBSkr4aObAKKGXte3rw+qnIGswvJ1hfeINEE97yHLuLuVO8Cb
         CQAPyzOu4qlHHLc8aHOT9bmxV4FJyZQspOhes3FUt9oE/j5qEdI7CrT3G7i2Fhy+FuUC
         BWRdgaCdu79TA6UbP/fSPLaC8ynBi7cqgAVwYzYvXIAPNVa8XylxRX1sueZNFe+KEib0
         dmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MijQWzB8/gN5fDGEK8cjygEaofFJBc9IoUDsbft3Wtw=;
        b=EFImWz28jtAUHVpqnC0fmZJbWKz4ZFmHerE6Ztm2tivTDegAVRe7ON3LglHW61xeeM
         ywWBpqfI4p3xU0EZP0BF8tMyliixkKahDSjdPjnTpoi1QHU9xJFx7jjGwlnsjJPcnfje
         FL91H0y4lfr+d3RnoUvS/hDgCguUMf6SZcum+YV5hBfp362edUy7cuf4pSvNRS/7Se8L
         vhZopZQbLG9Tndg9E+qr/HqmNaatxtuINrhTNjvGGZe67Jsscp8e1+sbNjdEWY3G/VP9
         8kdG2klwIjDGKLz+ISPXhax4UZ0OeO3j0pcQaeeRWtPvH+FvhnxHFT9VcY/jZvxyQjrK
         s/EA==
X-Gm-Message-State: AOAM532SjlRGyc139TTMkLwYxiDk33JtQi9OdCc42U70bDEU0hB+GI4q
        28N70KnY9DDwBPXUgQXFo7zEa/Toa3OANw==
X-Google-Smtp-Source: ABdhPJwAQ/HDUZDq7d7EIsEdUggB8280rhGBYiQ1poApTy6buX4yjcAFtHb0fXDsT/QhPcy3IuSxyA==
X-Received: by 2002:a5d:6daa:: with SMTP id u10mr37241611wrs.119.1620217306375;
        Wed, 05 May 2021 05:21:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k15sm19886643wro.87.2021.05.05.05.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:21:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
Date:   Wed,  5 May 2021 14:21:40 +0200
Message-Id: <patch-3.4-06e25bc1db3-20210505T121857Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regenerate the *.pm files in perl/build/* if the
NO_PERL_CPAN_FALLBACKS flag added to the *.pm files in
1aca69c0195 (perl Git::LoadCPAN: emit better errors under
NO_PERL_CPAN_FALLBACKS, 2018-03-03) is changed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a15f39e40ff..574b25512e7 100644
--- a/Makefile
+++ b/Makefile
@@ -2275,6 +2275,7 @@ PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
+PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
 # into Perl scripts.
-- 
2.31.1.838.g7ac6e98bb53

