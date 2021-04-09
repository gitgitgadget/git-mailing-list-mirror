Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FBAC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87334610FB
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhDIIHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhDIIHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:07:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01654C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:07:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a6so4682028wrw.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXyEwRdCBFEoXOEqzXTi7cCVTnP0Hpu7s/G0V0MnAek=;
        b=gZGffnqBZWbNlLMu7Rd+qtKJcvk+6YTI5IeMsN20vyYwwjMnfplYU7afKL2uWmrH32
         bk56Gv5lU9KjyV2gyc1nYsVOen70/M+236G8sSOznsB9tFXmusxqQPfCCPyNZD9/ds4n
         aCzA5TdP32+bbBOk3TazywlaA/H0q2vCka55BtIHhSEIsCJSK+Qvh2Ty4LVUXtGqDuhQ
         t/kv03ksd+Qxzex3/VNabOfR/8fU/6Vt/IzOyShEx8mQpCjkiM74BxLpF9K7Mln2ju5D
         67JRY7rJEe2wJAWn1OgNU/3Ft0RlELQuzGvriyiTamIQgBd/GmyAeiEGLMY0H2ufgVkT
         ugcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXyEwRdCBFEoXOEqzXTi7cCVTnP0Hpu7s/G0V0MnAek=;
        b=ekqHqSGjE91TFXhMVyraq6vSozLSsG9NTfwvBaECSg+nqnlcccpFKsTP8Xs/kY+aWa
         VTerxza1akF5XbBLZSpnTDG9PVEXGXOdeBRjMCpW43qdnwsGLAyjCe4fjavFwhcZkiPk
         p2wnXLBiX2kZbNlEIeHHxs0Nvx77NzQJGoqwtsj3xSUBLuIB106ehOEZ6OZ1PKryjRof
         /b1BZriY8qoOwJf2oOfVovPjFK+FH87Khbd2ZQCFtUiTrbBliGZAaVP3MV2gYBJA5aok
         TynpqAHpRt/3Q84Xc9mKt/mk0kFHpmFzFCyVSZx36ykVGppxuxNnMUqv9BH1NC0pGkFK
         kjqw==
X-Gm-Message-State: AOAM5335p76IXGh8nBSaVgEOz+nUSd5lE6PuMAe0FwbWEfbCmm/ZtnIf
        9JTm7FufNP8lGWoO4WZ7ALiXRzyVHzIZQw==
X-Google-Smtp-Source: ABdhPJzGWkR8dteQl1N+amJtLzAwwQdzZxIWsjFaYn1lmdD5CIwTaH3uLah6mj9ghasCBgbcplhWUQ==
X-Received: by 2002:a5d:548c:: with SMTP id h12mr16426423wrv.46.1617955658561;
        Fri, 09 Apr 2021 01:07:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15sm3105988wrx.73.2021.04.09.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:07:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] blob/object.c: trivial readability improvements
Date:   Fri,  9 Apr 2021 10:07:26 +0200
Message-Id: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.584.gf4baedee75
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the initial and very trivil part of a re-starting the
ab/unexpected-object-type topic by splitting it up into more managable
pieces, see a note about the split in [1].

1. https://lore.kernel.org/git/87r1jkgvoc.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (2):
  blob.c: remove buffer & size arguments to parse_blob_buffer()
  object.c: initialize automatic variable in lookup_object()

 blob.c   | 2 +-
 blob.h   | 3 +--
 object.c | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.31.1.584.gf4baedee75

