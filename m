Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84369C433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5978C613C0
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhDYJMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 05:12:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D09C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:11:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so3459732wmh.0
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUvWph7d8Uo/9104PCgGT7/x+E2IV/ky6+p3NGdxObM=;
        b=U8RogT41zNo72mco1x5tsPCNlVIL2M1RJU3eKzjQO0VANiSVeHCCMY14cW98EB/V7X
         P07l2Pzj29G/DUicxCHjCvdZiaiKmUYvUTKH3UsuWdCn25UkV5PQrnMRnXBDb4mKJG7o
         QXYvHv/n9g6K9G/rOTLP92LEaWnauys4dwcaHNMt8t+QIUaFx9N0ntLRhmh9rU7/7QxO
         Rev4kOMqPqYOfQ6RCPVd1ddPye8OM1FywTf5SiZVltUmXcTSIrYB2eKmjN2GJh5JJUeh
         NWO3rpfwNv7bw63F5448FASEbiwyz3GcHbzPQy2ZMxLwrmjk0qNZxjSBy61JMihbhWRQ
         SBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUvWph7d8Uo/9104PCgGT7/x+E2IV/ky6+p3NGdxObM=;
        b=kbbpVnFi9iMW/wy8LyrvuKT2I9jOZrTt9NXgf/HERViLipqFPuh6EPB36XYYDKWKZH
         c+50Su7IvvCAURwmo8SbJWKOhvCwsUq9KE2ECoYtnbVQG7yeXVckKJ2/TRLY/JpohfCC
         vn8nWUBnisTUnranOJCf/ILoRE5GKtFHupfNGYgvbsLrKTzWPzjbR9Yf5HI/ndkUqCDx
         ZZChpmQhguNYLgJnzNB/ppL0uNsYu/XHFx7xFsxJIu4+iDZHeIP3QGZiFYIG3bffpO2T
         Yn1EqPRn33f2XNSZsSFIH63lJiqxZaH+MQLTqgoa84eiNyYJaUk24niuQKeRx4DVH0yZ
         xbXQ==
X-Gm-Message-State: AOAM5304VjKI8f4jMeFXAFVKWFfo7U9SDGV/OzSSPwJhw/z6jwtV4z95
        rZgcKPSu2m804hUJI3TuV9ibKSU3eWs=
X-Google-Smtp-Source: ABdhPJyTVz08KFC3T39ZNtmV/DsrWtHiVX9xfhMC9qCvHxjpo7A+A5lTHRHUfHfaezOQ10NBABMzqA==
X-Received: by 2002:a05:600c:2247:: with SMTP id a7mr13660085wmm.133.1619341896125;
        Sun, 25 Apr 2021 02:11:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f11sm15693707wmc.6.2021.04.25.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 02:11:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Beat Bolli <bbolli@ewanet.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] pretty tests: --date/format test improvements
Date:   Sun, 25 Apr 2021 11:11:31 +0200
Message-Id: <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.g8d26f61af32
In-Reply-To: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of trivial changes noticed when reviewing the "pretty:
provide human date format" series.

Ævar Arnfjörð Bjarmason (2):
  pretty tests: simplify %aI/%cI date format test
  pretty tests: give --date/format tests a better description

 t/t4205-log-pretty-formats.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.31.1.734.g8d26f61af32

