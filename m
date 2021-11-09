Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F9C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE9B61178
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbhKILHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhKILHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 06:07:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9CC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 03:04:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d24so32291835wra.0
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HitILjzNlZoXg3yW8yzzO++6g0L67TgeCxqaPrl1I8k=;
        b=CeIIllg9Ztw+Vrhwh+ZrZXkCzx2ytyOymgkDpR5IEClc5XAaWF0c4f1w8fAJCJRfSl
         Wa2s0m8+WQnjlzFMLnIsgze07xrlsL94I4kATTr606y17X8MOzeyyglg6MhAjb80cCTf
         jhN9s8zJFn0VIvcFLgV9yReTb+kSfHwHaBgbMW9vnZRWTMOC5n+q2z3tN7nrkCJnoye4
         AKZypKCgYy4BHr7CatVpG+RHze/NYhyF1r4sV1W4ZVOt+a3q4q9czkpH9tSMhl4jGXKL
         yeHHdMsFxp146vDaLyarURPRHvu+I0x9iUbW7PV0PiPUQknXpUXQpFT6EroPEs1P3OBS
         kxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HitILjzNlZoXg3yW8yzzO++6g0L67TgeCxqaPrl1I8k=;
        b=72LqACHvbniXW1ENYNEVxRSn3z7fQNPtG93fB1zhU6b72kuP7p3OCbKQFE70Sy5Rda
         TkxPLLDyPxnxDJGI6HB1A3mbPOqn3fAGkFw20DWcbU4ZOXCOO6deI9krlbofBvtCDmRf
         1l+SoVqaUuR7SUNrTUTRnhWrZDmV08b5wrrFnfsAzifqIGadTFPLpS/kwh8yb/Xxs7DT
         aD7agw81+Pj1tPrYooy668OSpZ37/muf0rh+n9KzjWkbIMCWJ3VZjJhZPS5BW5jc1kRg
         IlAkzs66F1KkOx6Sa8HTDYLMf7h2hwDbW+GZHQKDSq9rof5mqrsBJxxRbOn3CzZu+WH7
         lrmA==
X-Gm-Message-State: AOAM531FO7j8Dwu07XKnUgVUyOF8389Fcsk23/vuKbPeDCuqFcuvjiUO
        OgRd9oq94ZV76tXrZ/9oHSbX5vBVThw=
X-Google-Smtp-Source: ABdhPJxABS2ijOcTqDtY1cY0J9Dj1rowzpe1e0Z+LrpHtAmW4ZKHfXQHoTBw3XJ1y1F0oCmG0vkJPg==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr8173550wrm.288.1636455887630;
        Tue, 09 Nov 2021 03:04:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm2480755wmq.12.2021.11.09.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:04:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] parse-options.[ch]: enum fixup & enum nit
Date:   Tue,  9 Nov 2021 12:04:42 +0100
Message-Id: <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tiny series fixes an issue new in v2.34.0-rc* where a recent
patch of mine incorrectly changed a return type to an enum that wasn't
applicable to that function. That fix is in 1/2. Thanks to SZEDER for
spotting it!

Junio: As noted in [1] I don't think this needs to be integrated
before the release, but if you wanted to pick it up anyway I think
it's safe. Maybe someone's compiler will complain about the pre-image.

2/2 then marks a static function I missed with an enum, which it was
already always returning except in an error case.

1. https://lore.kernel.org/git/211106.86lf21ezqx.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (2):
  parse-options.[ch]: revert use of "enum" for parse_options()
  parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()

 parse-options.c | 17 +++++++++--------
 parse-options.h |  9 ++++-----
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.34.0.rc1.741.gab7bfd97031

