Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896DC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2021920899
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 14:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1nRQvvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgGBOJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgGBOJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 10:09:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF83C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 07:09:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so26962442wmj.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFUZCwjIiEUm7sqTJjBHydEEDEua4RPhlU5elZP97w4=;
        b=F1nRQvvoiX6ciNaK1YXBgDfx1ER+Rl53EixJsUsPyIx9CZHZtMgxMk4AR7rRaN1K3q
         cxjnPA7ZcTZyfLrIKgjq/gxgAb2YQ1UWZi+rQIfIHutiFQ3yt+uA6BfoHTDtDJmUDZDg
         AJmq3GDVmuXIYT8Ymc9w3oaFqGJnRNVY73yp/L/UxFjBQy+tb+ooyvvZg7N6L6nL78K8
         6e0jcTyXTas6vt229Jb9h2vXakj6TNosoWWfkeEAkmhCXFNkDVi8Jg2sd0S1A8c1S8D3
         H9UPoWUzvww1vFu03cb7cXiyfoKgtj1evQXYIgBIVLm+vGrK8Fsd85Wc3v+mdOsxH9Xc
         V7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFUZCwjIiEUm7sqTJjBHydEEDEua4RPhlU5elZP97w4=;
        b=gdzpxoiOR74GlfI8wGZ57uEuhNGpKu4PRqhRb8YpYLXN58L6OYKZQPf5cBdLMIR9QO
         m79gQoKNAE3uXKdiz7wfIclfWdlk00Gse+NshdX1Hbs4Xv1g6jF8vA5qIkTUwAwFnUvL
         cF2xRt/300MCmE9ceeiNml8+9lPHrb/YWsT056pTv11yIUMMXsSCo9qSLWZ5Q7pCW0xj
         +JeA6jI5p+wmqP9Njai+yvKuZ+bPuyfAExuqkTMmWKdvBuHgJOMO849Ffh2kavkR+6Gs
         t00A3LuKxs4Bctg0OFArhX3U704+FvV+d4nqk1aIaBlEna3cvdMKprvuZpQdgze09RAp
         yTXw==
X-Gm-Message-State: AOAM531FUFyKQrBOQy+QLpS7cwQcWigGaVZpd7FUQoRkV897K8FVn6YJ
        L675izfsQC4WEyt3lndGDhjXYq2ERWU=
X-Google-Smtp-Source: ABdhPJxWMRmJuSieg3CS68vVKS7z826NYdVYogCJUQfGt67JJBNumUdAypwf99/Y8mGIDNivJJE5tw==
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr32859613wmf.151.1593698939591;
        Thu, 02 Jul 2020 07:08:59 -0700 (PDT)
Received: from localhost.localdomain ([193.57.125.121])
        by smtp.gmail.com with ESMTPSA id p17sm10265038wma.47.2020.07.02.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:08:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/2] Add support for %(contents:size) in ref-filter
Date:   Thu,  2 Jul 2020 16:08:43 +0200
Message-Id: <20200702140845.24945-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.221.ga08a83db2b.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is version 2 of a very small patch series to teach ref-filter
about %(contents:size).

Version 1 consisted on a single patch which is available here:

https://lore.kernel.org/git/20200701132308.16691-1-chriscool@tuxfamily.org/

As suggested by Peff, I added a preparatory patch (1/2) to clean up
the documentation about the %(contents:XXXX) format specifiers.

The other difference with V1 is that there are more tests in patch
2/2. These new tests required a small helper function to be
introduced.

Christian Couder (2):
  Documentation: clarify %(contents:XXXX) doc
  ref-filter: add support for %(contents:size)

 Documentation/git-for-each-ref.txt | 27 +++++++++++++++++++++------
 ref-filter.c                       |  7 ++++++-
 t/t6300-for-each-ref.sh            | 17 +++++++++++++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.27.0.221.ga08a83db2b.dirty

