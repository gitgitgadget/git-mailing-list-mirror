Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBABC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AC561131
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhIUW4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhIUW4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:56:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7398C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w29so1161977wra.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zt7uTMCotB8gysPBigCgr5TaJ8piWwDAgmGbKPUZvkU=;
        b=R9ZOE25EK5qWiYeeQ8+f0ut8HX9w5nwXB1ryqv2BxmrlOI3wJmavl6J0wQqk7mrRyQ
         qUBYduV0qao/sdkuC1rfvbdG7PJcDoJ/VH/mQBz5fbdMkihWlreFJFfCFPuOfB3UQwRH
         TW2u0Yz7rq+nyG1imBb2GW95c8TH3j6GXQvsjPbamxcFUMTfixJnJg+QdT/0U9clai23
         qYcnwh65mjH7W7cTDMbHm9LZRoT6NogGFl0Ot49L9VkJvb6j0RebX3PnaZMZFmtF/VHX
         9F9fsyBgNHT8rIF7WvOd8t/lvq1aGFdkp7Yc3xplEsR652B1RD9oJCxgLOQx2fqiX0qa
         jQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zt7uTMCotB8gysPBigCgr5TaJ8piWwDAgmGbKPUZvkU=;
        b=PMA5EuEL3h/aCAQus920I/RceIJhpt6VNdvUWIgeMNDoLr3J7Hjkc+PdUYNVvuW8Az
         bElCFkPLDtryBZr6A9AuSAwsovOY19OcCoozvAScr1jUSjTUHsRPqK9xxKgNA5Vu+GDh
         8nMEIywIt0isye5Mg7v/o18+kFJkwM02w7Q5Nuon/PPnQ9ycXbrzNUSMaxEg5IMAnAzS
         iT9Fmm2Z+xRwOIkZSV6VTRCrAJOC+Rt7BArbMVrdLCsWmsjKvZqTyr7e+DExJFURznJT
         vfAEjlPduk3O/kTzPRtuyz4tBEceRn6yjzdSPLPPSKfML10ZY3fEBaeUfSlKAUTjW2ck
         LoRQ==
X-Gm-Message-State: AOAM530k8P4c6+hq3ngXeewNpS2TItL6quvicHCGLXxEzYxP8t2BqsIw
        4avXcDq8i/slv9k56EXkSALnAcO//Eudkg==
X-Google-Smtp-Source: ABdhPJxbp2jR9JClHgeAUIzv4lApDfD25q4GN0HbqixUvrW6L2UqDA9Jn0/Vmw0u4fE1aqDIIWOGaA==
X-Received: by 2002:a1c:20c5:: with SMTP id g188mr7055789wmg.182.1632264917960;
        Tue, 21 Sep 2021 15:55:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s3sm399474wra.72.2021.09.21.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:55:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
Date:   Wed, 22 Sep 2021 00:55:12 +0200
Message-Id: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that my series to only build "TAGS" when we strictly need to has
landed in 1b8bd2243e7 (Merge branch 'ab/make-tags-cleanup',
2021-09-20), let's do the same for the "sparse" and "hdr-check"
targets.

For *.c files we'll now generate corresponding empty *.sp and *.hco
files when "sparse" and "hdr-check" are run, respectively. If either
of those errored on the *.c file we'd fail to refresh the
corresponding generated file.

Put together a:

    make -j8 all TAGS sparse hdr-check

Takes around 15s on "master" when there's nothing new to do (we re-do
all of "sparse hdr-check"), now it'll take <100ms if there's nothing
to do, and say ~2s if I do a "touch ref*.[ch]".

Ævar Arnfjörð Bjarmason (3):
  Makefile: make the "sparse" target non-.PHONY
  Makefile: do one append in %.hcc rule
  Makefile: make the "hdr-check" target non-.PHONY

 .gitignore |  2 ++
 Makefile   | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.33.0.1098.gf02a64c1a2d

