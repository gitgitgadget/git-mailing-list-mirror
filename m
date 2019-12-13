Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CABC7CFC1
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABF8246B3
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPMB1y1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfLMR2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:28:38 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44127 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:28:38 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so46630qvg.11
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Qko5H7vTdvj5HT8N69UjDzgg2vG24QSoFqB/wHp+Qm8=;
        b=GPMB1y1efR/dTnpQ7NAJUkymeYltkcmO6vFAYzejFz/6Em86RY6kJwufRtLd+BHQ9z
         nbwCsGYTpYrjBYT0rzLMHTPjUWSrQkeN7WyhI+dW9pUYi66FHsUm36JfLBODtF+KNOYV
         etD/fWHPyOMzEVqhwcI9N27tVDhPfUJh+8UyfOc2KXUKd7Rzhk3lK3g4DSooNZIy7AWK
         /k465xHwLynzYPcnzfxdOp7/YwMdkF1DvpQBFT8IJ4kYKNEqRvMW1JF24aRrEHIqlhGC
         1ZJgzQZj2i4iw89qYetuBCrMbkL42OGzZqWcCr4pY25d0vQB3QPKG+/1FmgEx3O5FnX+
         WFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Qko5H7vTdvj5HT8N69UjDzgg2vG24QSoFqB/wHp+Qm8=;
        b=VONggW9g9h+yJdVAl8BCbbkjdOgvHy7hfoqToSfOUE8Syy/RcVxOu+n+44BDHdYVDp
         2P2r9Ryhg6R+80XFtD077Kl1SQxWPRdJqWwSemWf0GHcMVtqFALoqepDJX9LjXkcAVzZ
         +kJFcQEDuKnivbmJ1jvSPr2aj/YRPOqPS3quhg8Lln1O5xUK+zch/4cAj0BcrCiaJB8j
         loiidJe1Yr+ozB6FLyEXcfIjJkmRX/dovfcb0u7DmoG47SjRHWRp2Y8MfUifTrby/JYI
         4cX3r5wJeX0QYDV5VM6EtFLTEYkf0fWITgSvoifAP4WlyekxQnD2pesY/h7AVa6FSy+A
         FDaA==
X-Gm-Message-State: APjAAAW5Fel/nf4hTiR2Rbwu45JvMG66Ds4MgJ9WbDF5V3MD3gfIe83j
        7pL3SJbKa4Q9uKBGUVlX/fF3CMr7
X-Google-Smtp-Source: APXvYqwzWgrux85eQSqpJ82IFL8PjVbUfcWn8LW5Ki0iMVsLOwkOkXOlSQk1cKqzj0UICm/hw1Oj6w==
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr14086516qvn.79.1576258116765;
        Fri, 13 Dec 2019 09:28:36 -0800 (PST)
Received: from localhost ([2607:b400:26:0:a433:34a2:e3bd:44b2])
        by smtp.gmail.com with ESMTPSA id r41sm3600319qtc.6.2019.12.13.09.28.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 09:28:36 -0800 (PST)
Date:   Fri, 13 Dec 2019 12:28:35 -0500
From:   Charles Diza <chdiza@gmail.com>
To:     git@vger.kernel.org
Subject: Regression in 2.24.1 wrt progress indication
Message-ID: <20191213172835.GA2315@349209-PHI-GMNO-CLAHS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I reported a bug in progress display in git 2.23.0 earlier this year in August.  This bug got fixed: https://public-inbox.org/git/20191002154734.GC6116@sigill.intra.peff.net/

(See the earlier parts of that thread for the bug report.)

I am sorry to report that this bug has returned in 2.24.1.

Charles

