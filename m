Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD36BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F88561139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhI1NQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbhI1NQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83616C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so58034249wrg.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyUn92d1LXZ3Bv8zLr/XNUuY3CjZEtM1egoQIQbOeWk=;
        b=HKzvbwpIaMKAejQ1w2pYRcRzIgB0tOCzJy2ZHdpCqhGb7G+xW3sSy0J8FNLCr2rtqp
         lftMU7LsAd2TpWV61NVgIaTFrRRRQX5+yNiEYpo/NcHLaRNM75byAGuFLpKmhmti2gb6
         cmPrZitAJCqd/fGRw8Ig/HRCyj2klrlen8oj2PwKlOkKe9NMidfv9J5SOX49h/UxE3w6
         WkrsIQDIqQPwpBC97/qNQ5odJPHF79UUfKV1UQnumRotSil008LvpmkUbvoCTtGPxIWQ
         V4UXdp33nSSNfJzTLMu/JsJUknKm1pCPoIkB16WrR3+OxOh4Njs7n7VWO/m1Z+7PV6lx
         24xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyUn92d1LXZ3Bv8zLr/XNUuY3CjZEtM1egoQIQbOeWk=;
        b=OObLCmQ1ooJO8nZeKt7sjcWeDbdHxTctZ1TUa0IHg8yJR1mHCnd3cXy915enviP7yo
         muxCIQ7mMJs8+Lr25/GIekMiol5COodMsGVb1GowreerwuR7oI+3w29SgVgNt6L10EyE
         a2dpOsvV9BWxHKZZnGYAOjAGEr/hQeg4gpjMc7kZ9dcaclEHueC+Z1uABUrzuvHS7BjD
         tUa9SFiEGFRzzpIA5dfL2q8JrjvSl4YTTLmEMwaP74f5z2UBWhV2l3sms9X9T8j7u5p2
         ZhFbH286CRNeksjYYmm5HnXPtxHcopFzb05UBuUSn2xDu+sasYIc1Hgm8vXxiodTU9Be
         5PYg==
X-Gm-Message-State: AOAM5339vIVlLLK1O1Q7jJgauqwAac8CEzH1aDSb6h3KyaipgMxN6s70
        5rAKfNoMwx5P40RZcWyf7hn1zgFmqaP53A==
X-Google-Smtp-Source: ABdhPJxzu0Kdqt3Q6g8Kx9kfYUU66CSml71HmGVxOAp+taVEGpPKljl7wAYyCjez3oailsvuhTi8jw==
X-Received: by 2002:adf:fb89:: with SMTP id a9mr6481580wrr.164.1632834874825;
        Tue, 28 Sep 2021 06:14:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] fix bug, use existing enums
Date:   Tue, 28 Sep 2021 15:14:21 +0200
Message-Id: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some feature changes planned for parse-options.[ch], including
ones that allow us to delete some boilerplate (and sometimes buggy)
code in built-ins by having the API do heavier lifting.

In adding anything to the API I've found it hard to deal with it using
its own enums inconsistently, sometimes it's an "int", sometimes it's
the "enum", and having the "default" cases makes it hard to assert
that you've added things to all the right places.

2-6,7-10/10 is that rather straightforward conversion. 1,7/10 also
have fixes to existing bugs that happened due to mixing up the enum
fields in one way or the other.

Ævar Arnfjörð Bjarmason (10):
  parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
  parse-options.[ch]: consistently use "enum parse_opt_flags"
  parse-options.[ch]: consistently use "enum parse_opt_result"
  parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
  parse-options.h: make the "flags" in "struct option" an enum
  parse-options.c: move optname() earlier in the file
  commit-graph: stop using optname()
  parse-options.[ch]: make opt{bug,name}() "static"
  parse-options tests: test optname() output
  parse-options: change OPT_{SHORT,UNSET} to an enum

 builtin/blame.c          |   3 +
 builtin/commit-graph.c   |   3 +-
 builtin/shortlog.c       |   3 +
 parse-options.c          | 116 ++++++++++++++++++++++++++-------------
 parse-options.h          |  26 ++++-----
 t/t0040-parse-options.sh |  42 +++++++++++++-
 6 files changed, 138 insertions(+), 55 deletions(-)

-- 
2.33.0.1340.ge9f77250f2b

