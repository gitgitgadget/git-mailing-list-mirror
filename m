Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86172C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596FA6143D
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhENMPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENMPu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98802C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x15so14500432oic.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmlR5WHdYv8DrLWpghtiMx63a+8hcrziRjbO+SRH7wE=;
        b=rOMqVHH/k69/2vf4dw3Y8/ovYFSiFhfjx8sbN8DqwK5N4aL/aVXdt+lEF/+1bb4iyE
         4pR/pd0mOMG7Uz5W90SQFLG1FBHDFnbe+8lNRuR2ml8mMo+MaCvxxOAp2FDxJcwxBEdt
         Iu57JCZkwCDW7vU/uvKQb9rGjBEelJLBHIiXKl8xPqiKPhXSCoIN0B2+BHeNzMyipGlu
         koVGu6XzqYCnQREEFGkAUV4+wqsckFtHt+Lh9Gee+7F4Ool5V9FG/7l479skxqTlZWGb
         qciIzMjhhwHDe687iaNZ0mKmkw+e8gTsKhoTI9TB6imqXuWIQILLpXQq+Asup5XoJ7iJ
         Vsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmlR5WHdYv8DrLWpghtiMx63a+8hcrziRjbO+SRH7wE=;
        b=Tnn/+u7x22MdjC+P8tvFSmesjXNIxwNCaeHnRqqWm4Br8RTJEfkKhbjg7X0F3H2IsB
         Zdfa26kC37BRMDRC5FKdCtegiR9edTZjL6fbcViYZ41YRdPIzkOe37swXQ6JxryPNC9V
         oKWvg/Eq2qJ9s5NMWnd4/CCRU+mWVun5nyFqWW+K6fh1N0ddox5iNOEA+V7CzrbFmIMl
         aTqwsO5uGMUuANpGKugRCpPcQ9bQEneasjOKwu1jp5WL2QelWa82bUOs5m8LXWShk6uo
         KLuQ1nyngba2fIuzjn6XDVudLDUPlOO0pXKgHy0JTILQDeOrk3RYt+HRStFu9J0tm3Z4
         IzNQ==
X-Gm-Message-State: AOAM531PuzCI777h6cv2J6glMfFh/lM6v83E1BVjpAeNu5eScxiYPu5M
        ieI/q2Sz100y0knJZQ61dBlUNlq9MnveaA==
X-Google-Smtp-Source: ABdhPJwt21gYOU6YTJbgQgu8KUt0nCTO8oIzo8nkjFBYE95lQ6fFaZqZ45bFCPEYvNJSluyVjoTVOA==
X-Received: by 2002:aca:280a:: with SMTP id 10mr6793816oix.13.1620994477096;
        Fri, 14 May 2021 05:14:37 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u24sm1268468otg.73.2021.05.14.05.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/11] doc: asciidoctor: direct man page creation and fixes
Date:   Fri, 14 May 2021 07:14:24 -0500
Message-Id: <20210514121435.504423-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables direct man page creation with asciidoctor, but in addition tries to
minimize the difference with asciidoc+docbook.

I fixed as many issues as I could, and now the doc-diff looks very sensible. I could not find any
major issues, however, some minor issues still remain.

On the other hand the asciidoc method has issues as well, so it's not clear which method is superior
at this point; both have advantages and disadvantages.

At the very least the man pages with pure asciidoctor should be quite usable now.

This series builds on top of my cleanups [1]. It's probably not worth the effort to split the two.

[1] https://lore.kernel.org/git/20210514115631.503276-1-felipe.contreras@gmail.com

Felipe Contreras (11):
  doc: allow the user to provide ASCIIDOC_EXTRA
  doc: doc-diff: allow more than one flag
  doc: doc-diff: set docdate manually
  doc: use asciidoctor to build man pages directly
  doc: asciidoctor: add linkgit macros in man pages
  doc: join mansource and manversion
  doc: add man pages workaround for asciidoctor
  doc: asciidoctor: add hack for xrefs
  doc: asciidoctor: add hack to improve links
  doc: asciidoctor: add support for baseurl
  doc: asciidoctor: cleanup man page hack

 Documentation/Makefile                  | 24 ++++++++-----
 Documentation/asciidoctor-extensions.rb | 46 +++++++++++++++++++++++++
 Documentation/doc-diff                  |  8 ++---
 3 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.31.1

