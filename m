Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD7C47259
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CED20735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxPYg/O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbgEEQ0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgEEQ0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:26:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C07C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:26:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so1102524pfn.11
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OWHjPq9dNS0I2CdDwk71JSPcKGEunVXX86G3QoBN5Y=;
        b=MxPYg/O3u2F2ZhNMNeTZ6LPNNvEbJJ08EdT9YowtuPK8JosTw74B0WXl7oD1uO+zgk
         b6Cw6G0NY7yczveJY5Y56+Mjbify3rsTwzsF+A/TNu8fyMP21+IoG6Qiur0TTB5tNbZu
         wiAH3V6G6SFlTyscY8ZodmSJGlQyeVbHo4E0epXDJWGDLcYarJJywhP3UZrVZzLX/HR9
         b7vTnRvxeSKX83sCyA0raIoJFqg8eD0eEwES5DEH9TvcJAGEXGkbty7zPRPkfjv92p7r
         By6GVtTc11eERkkad5Gz4J5xesRhbHupojK03awbuIXRIZK6F8+xmSl7HwJYCvIqXmdi
         OS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OWHjPq9dNS0I2CdDwk71JSPcKGEunVXX86G3QoBN5Y=;
        b=SVIA56X7QqDm9MlgAm3BaAz+W5YtuWhJzqdjW4m5GqnZzX1EPeujGU5C0PCrzxpzy+
         I9DpKxtrl/cXZhpiFG1tPsebPlX2aeAPk6K66t1lyd6pwSIvEIP4qjbz2rrJDu2rew6a
         XMTQ4M8KknEhwPDNWZaogM5nV9+dMZLWSU1fm7sVVXNkGcBX20kbf7R4FfbU/Vxnlhg0
         sxHC5XxhnwT0bLAPureOP+og1BtqNkc0wgQ/QANt3Bnw5Bt075Pj9g1ZZQXvqb4eENO7
         JfM/MMXbpYXFatasvN9Flfo77hRmzmbkl8jdKPHWLHrrAgdjnNj+VcHBuNa09OWlhxzi
         SEXA==
X-Gm-Message-State: AGi0PuZRl7UqTE5QhKvA92i2+113tYuo3MKCD37wYJknmNO28hp2P48Y
        fLtfdVJY088bKKAeflcP54FtskOo
X-Google-Smtp-Source: APiQypIxuD9/L5Gd6r+yymtPJQE8GBNn3r/mJML3LxUo9X/ASSjmKq0hLwNEeHflWIg58E5v3/clNw==
X-Received: by 2002:a63:4f45:: with SMTP id p5mr2067725pgl.41.1588696006868;
        Tue, 05 May 2020 09:26:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id l37sm2508996pje.12.2020.05.05.09.26.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 09:26:46 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] Provide option to opt in/out GitHub Actions
Date:   Tue,  5 May 2020 23:26:38 +0700
Message-Id: <cover.1588695295.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1588607262.git.congdanhqx@gmail.com>
References: <cover.1588607262.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems like there're 2 schools for GitHub Actions,
- Opt-in by using some specific patterns
- Opt-out by using some specific patterns

I tried to help everyone happy, but with my current knowledge, I couldn't.

This series should be 2 patches only.
I provide the [3/3] as a fix-up for [2/3].

Should we conclude that it's over-engineered, please drop [3/3].
Should we think it's OK to go that route, please fix-up [3/3] into [2/3].

Hopefully, we can get into some agreement on this matter.

I'm not include range-diff/inter-diff against v2 since I reorder the patches,
and [3/3] is meant for discussion.


Đoàn Trần Công Danh (3):
  SubmittingPatches: advertise GitHub Actions CI
  CI: limit GitHub Actions to designated branches
  fixup! CI: limit GitHub Actions to designated branches

 .github/workflows/main.yml      | 82 ++++++++++++++++++++++++++++++++-
 Documentation/SubmittingPatches |  6 +++
 2 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.26.2.672.g232c24e857

