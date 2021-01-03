Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E95C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDEF2078D
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbhACJiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 04:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbhACJiV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 04:38:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B0EC061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 01:37:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h22so57786483lfu.2
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 01:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kWBbl99mkghkizmxJUx2W2AjyyTK9Fo6HeG7CXj338=;
        b=IZUXv8+32ElxPmXCEseWBqyr/0iHf61iyfLJM1cJOQaDIRhhwVqWrUzWG/CUyHPC0n
         tVBriDA9uVsCUTvDJwMzcLaXAbXWxTejFbH2zym9vrVAH14u1YkKYGBauDXMvgRkT9Bl
         AOz4Ec5NgPL8zx1kxdM2xZ0qjHhrhC4/geR45uoae6K2TnS9XVk7iKl3pqv3J0jew9Xk
         ZJrRPKLC37DcWI7F4RhGk7FyzTeQLHGiTcFMVRpubQDApqw4WKGNMTSPhTkndNUOHG1g
         pzEZQI3V6AQqNJWuE1lOiOudilteZIUGl6qLIZkpaoI4TJgk6bxbeD3bsfRcK75LATlw
         SbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kWBbl99mkghkizmxJUx2W2AjyyTK9Fo6HeG7CXj338=;
        b=l1RdgjHXxzSMnzb5RZiwHMbLbadunjQ1Czj9uQIHhnvcqfeVWPOzdA1RG912iT+3tX
         zM/eMfLCmne5lks7LfwOyuNefLsCY9K/EkOcieO3EUgtJTxRmkvVmhFDsqIIQ2fFxpWf
         fz+559AeWDHjTJl73HNsOuVYEtere2tkJZYeYkekgRcq6R8gk+LH+9qvYdescDe9ddTe
         mHXNFHo0wXwoEa6JncmTk+apGe18GMoSWSLNZ7sXoCQh/K/AKyGeSgFiOawiGhhI61qd
         SZ0pjM2efupwFB3aaM345d2HfXR9fVIaHoKAk7++uBu5ihi68KElRAYHAqrx5+aw30zo
         QZqA==
X-Gm-Message-State: AOAM531l44lls8XUf6yIgqYJhKal8C8NrFhkEU0WWXYeF0g+rEJ1VkAl
        4TsBLrU7VgPaFsv9ptDyfQ8vUOcX2WM=
X-Google-Smtp-Source: ABdhPJxeNS+bu4zbsf3IpQos7oSguESZBT1wg2rSC5FVB0KiGf7Q+JwVv52BgTAZ2sbSafz98S6tPw==
X-Received: by 2002:a2e:2c15:: with SMTP id s21mr31864679ljs.39.1609666659050;
        Sun, 03 Jan 2021 01:37:39 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id h13sm7025202lfj.110.2021.01.03.01.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 01:37:38 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/3] t1300: minor cleanups
Date:   Sun,  3 Jan 2021 10:36:45 +0100
Message-Id: <20210103093649.2221-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was some discussion around t1300 a while back and how it could
need some major cleanup [1]. This patch series is not that. I'll post an
RFC series on that later. These initial cleanups -- or something like
them -- should be useful regardless of the fate of that future RFC, so
I'm posting them early.

[1] https://lore.kernel.org/git/xmqqlfeuqd8d.fsf@gitster.c.googlers.com/

Martin Ågren (3):
  t1300: remove duplicate test for `--file ../foo`
  t1300: remove duplicate test for `--file no-such-file`
  t1300: don't needlessly work with `core.foo` configs

 t/t1300-config.sh | 72 +++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

-- 
2.30.0

