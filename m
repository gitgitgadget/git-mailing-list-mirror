Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5F0C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D8661051
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhILUa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhILUa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 16:30:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F6C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id x10-20020a056830408a00b004f26cead745so10476140ott.10
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlFfx408IPM+3ydBbelf9ru/HIFGJUfuslxJ20KJWLo=;
        b=gBseeKiitl/fa2twspTyiPW0ku3gf7kWFvi9CFSkMOS6Q4rJhMxtA5ITxCxmYa1njp
         +NHhXj0S7zvofRsiK6rX6IIX4OKjqCKKRdrOtyyWcoseMXwoEvOjSw8W96EtpwcZE6M0
         SgOBZV2QE1LrFPB96XtCi/r/72AyCRNkK/+o1lmK6h3kW9dWdLuTCyS/5JRdmSekezTK
         AvtH5iSS1K5xKf21kKNh1Nn9kYEu46FZSTAX8MLoHsRZkJPL6qT/sTG6sx1Fq2ta+N6K
         8HhYT7kozp8xZB2gd6qpJAFnAzOyV70KAScP8E7VjTn0w9K9rN9GvBK0dC3PqmMhdtNe
         +JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlFfx408IPM+3ydBbelf9ru/HIFGJUfuslxJ20KJWLo=;
        b=kN/ek043W9dY43jTb9p0UUdd88LyeGDXZpyIHVDxvdUR+aCtm2q9pl2h+ehpFy9QrE
         xz4ItXj/31hXu4UyclpG3JcLJMTcopZP0dINY9gGtKi+RqrpzJjQ2gbCNNITs5Nvp1P0
         NaqbLXk6i0NipSWKBVZjlxKOMOAwz9HRZ2xOz2UXzCQc9X1TO0T6wYtmtrx65GXEDKTp
         Qp+3P+M/il5MqZv2A7iGvvzhw7bBuRuFDO5GMfbAlIRCfWTUhtJpx8qQTrdqVKLeTSP6
         cE/DQwtknpWy3vU1mirGIYfcw3Nf5yPTMAkxSN2vHdM8+Iliof2RLuAkvpG0dCC1PByX
         9iAQ==
X-Gm-Message-State: AOAM532nOzg4Lmiy+p7liIZoDAFq8OjDg6iyWc39l23gBZo+UNq5lYxO
        cp9QRW1sK8ulH1Fbzk98ftg7DMqgoOQ=
X-Google-Smtp-Source: ABdhPJysGnurXVNb3hp1MBjmKUYy7ycAGnXuCR8N4B+m3zIKMHqPC+xbWbY4Rfwf218WcAxqoSY5Ag==
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr7181448oto.296.1631478551654;
        Sun, 12 Sep 2021 13:29:11 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w9sm1345162oti.35.2021.09.12.13.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 13:29:11 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     lehmacdj@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] windows: allow building without NO_UNIX_SOCKETS
Date:   Sun, 12 Sep 2021 13:28:27 -0700
Message-Id: <20210912202830.25720-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventhough NO_UNIX_SOCKETS was specifically added to support Windows,
it might not be necessary in the future, because Windows added support
for Unix Sockets in late 2017.

The first patch is messy, specially considering how little was needed
to build and run `git credential-cache` and its daemon, nothing broke
on the trace2 code or tests, but additional testing to make sure will
be recommended.

Carlo Marcelo Arenas Belón (3):
  t0301: fixes for windows compatibility
  credential-cache: check for windows specific errors
  git-compat-util: include declaration for unix sockets

 builtin/credential-cache.c  |  5 +++--
 git-compat-util.h           |  3 +++
 t/t0301-credential-cache.sh | 28 ++++++++++++++++++++--------
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.33.0.481.g26d3bed244

