Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54C3C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE6E6108B
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDBLfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 07:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBLe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 07:34:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FBAC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 04:34:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r14-20020a05600c35ceb029010fe0f81519so735127wmq.0
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBRfUufaZbbtTXY9zXNJ/mNoNYs1ME5AysezHbUtNi4=;
        b=lLfPRTTzgKBD60/jDSAOqeMLatUpRWU4zqswEcn8nfkYt7m+9BtGzD4EMAOLpgyfoo
         9jIH5TXkCTykQ8ytvZokVFFdGxmfCTVgVwuTzOVYJo6FbEPwSSAMwMOke0d1DEjapswA
         1AtyFP7X3Dcgx61LneXjyjfhOG58bF6UvMnRjEzBS95aJR2hPanZkkyAyB4YuRQAY+um
         cWckS2eY1swcd0SpzeXM99PQbCGAHb/RIcxIythJIUM8X2HKs5Vm6VngmBi5oolHvDtg
         BIFiYYxRl3+76hA1PWaCUBLckAH+5q+kIVHjxYL4C8grasotuYtkG87MfkVY9dzGLY3U
         owSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBRfUufaZbbtTXY9zXNJ/mNoNYs1ME5AysezHbUtNi4=;
        b=L540d9geuCc+bKUitSwI/dYcfb1QtHxElH4/vmeQo2QgS4Bno8204na19fYgh8dyYF
         6N3fEW8y+7tT8anqaS7EMSs563Rj9QFJOaha780kbd6ClEcTWbGnB0MOzdUALJK2OCKQ
         ZtO0t+xQkqOnRNRgYelMz6haDDseEWRdwTJtNlBDS9YWEhnqli28cgpuO32FcWUyiy6o
         Z+uz2WawbnNitECgd6bLZw1NYds+geUewie6OBM1PsxSZvixI7ewE19cVWgc4eevlrAT
         1U54N4vZ9Ri6cLHqVuCiRGc+S6ys8JIRjIn+SJli9+NOhwXMIK0tjQsw5cTRMc2qo5r8
         /Dqw==
X-Gm-Message-State: AOAM531kVAoIIKdiX5Scaz5p+WCLMnvaT3JjZakrMm+4iz5ysPcTJz6B
        nkh5xcQDsYw1yD7dRpuEzV06LZqRnFtyLg==
X-Google-Smtp-Source: ABdhPJxGYF50VI9kNDqSok+FI1dpBV5UIVaXZUqbAKmP0In9SXj4HIfwuCZZnKmzkj1keIyHBepH1g==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr12486866wml.7.1617363288098;
        Fri, 02 Apr 2021 04:34:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 12sm11535818wmw.43.2021.04.02.04.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 04:34:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] git-send-email: refactor duplicate $? checks into a function
Date:   Fri,  2 Apr 2021 13:34:32 +0200
Message-Id: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <YGTt2cNwq3BlpB7n@google.com>
References: <YGTt2cNwq3BlpB7n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A tiny series to help along the config-based hooks series[1]. Its
patch dealing with git-send-email.perl can now trivially be based on
top of this instead of adding another system() wrapper to
git-send-email.perl.

As alluded to in the TODO comment in 2/2 it's probably best to fix
things while we're at it to call validate_patch_error() instead of
just emitting the more brief "rejected by sendemail-validate hook".

But for now this series is just aiming for bug-for-bug compatibility
with the existing code, and to just reduce code duplication.

http://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com

Ævar Arnfjörð Bjarmason (2):
  git-send-email: replace "map" in void context with "for"
  git-send-email: refactor duplicate $? checks into a function

 git-send-email.perl | 49 +++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

-- 
2.31.1.482.g6691c1be520

