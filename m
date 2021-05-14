Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115DC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A696145A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhENL5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhENL5p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 07:57:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA621C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:33 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso26227376otg.9
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uc4fWdM3+Jj/RzCUHKA/3tdsoYVrC7OPY4CX7zbw18=;
        b=UDBkGb8eNkQH9JZbhnpXrJJ9DFvPqRZNuYZYyTtSJsHaANFFNqHBRONN0Y74jBEIQB
         has+op0Xw3RGUrm4Ytok1V147yCZK2YCpaCOp87mp7iNNq4k6okW+sPGm4LxFLQSiT08
         ptzJCCIVAdvrEPpN51jIJ0g1eICNAEu23pxBOw12kIxq8ix/yWAV/IXKfu+AtI1NQteg
         Bt3icfSXqDP731rMlTiQe2S4xbJyOpi0YwtCiHrpZ+A1jKC+/qdriVXAm+7f+WgLdAqR
         EvXatGv90MX2HBwc7ohBCFbxvVY6dopfBYlovwWg9SNl/Zp6UtFfq/BwQsysOrQrwMDG
         Bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uc4fWdM3+Jj/RzCUHKA/3tdsoYVrC7OPY4CX7zbw18=;
        b=UCAQiAlttg5b4+bg40snTkyZspSsFULqJWMxtTfC+i9v3K9XjUdZBfvkdOfHCmWCtZ
         chlXjIywvuVW35L+blJlPWZEPmspqfInKlbsFK+FY6AxZcYINvZhUXQIyq+buO1pn5nF
         2TwPLwXuqEAEoGwY117XcNHSfW5z+qVtvuoUdHjRkLXLA6TorzSJ7G9OPd7DqYN6NdSC
         2wjLwYz03Vm2czr25sPZ/sD31mLJqXYMPwqujjoeGMPG+5vAfudOOuKdOn4eB14QCZKz
         3fGh5xKbv8xsuEY1qrFyeZYv9wjXeXW4ndTwxoh3quFWFBhpX/B/ppYGS2vmyNFShC0J
         FwDw==
X-Gm-Message-State: AOAM5323FgzLkO0R7IgqnhEQm0TXMdZMi9Pfe0X6j+NOHsCDULQh9CzG
        u33G3OEK9SH/Yw/ognp/nKbwioBbGKxCuw==
X-Google-Smtp-Source: ABdhPJwCnSIfh3XAcS370zGf3D3F4Eyt015ypasMQh16JN4vFbJuRLKxUzdOzmYKMJvjHlFcT2xB3g==
X-Received: by 2002:a05:6830:248d:: with SMTP id u13mr38750481ots.121.1620993392902;
        Fri, 14 May 2021 04:56:32 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a11sm1138843oif.52.2021.05.14.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:56:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/5] doc: asciidoc cleanups
Date:   Fri, 14 May 2021 06:56:26 -0500
Message-Id: <20210514115631.503276-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is an attempt to cleanup the Makefile of the documentation.

It's quie different from v1 mainly because now the .DELETE_ON_ERROR approach is being used as Aevar
suggested, however it tries to do the same thing.

It does not enable asciidoctor direct man page creation, that's in a separate patch.

Felipe Contreras (5):
  doc: refactor common asciidoc dependencies
  doc: improve asciidoc dependencies
  doc: remove unnecessary rm instances
  doc: simplify Makefile using .DELETE_ON_ERROR
  doc: avoid using rm directly

 Documentation/Makefile | 77 ++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 48 deletions(-)

Range-diff against v1:
1:  62d76c126a < -:  ---------- doc: standardize asciidoc calls
2:  0677725926 < -:  ---------- doc: add an asciidoc helper
3:  ca69c75596 < -:  ---------- doc: disable asciidoc-helper for asciidoctor
4:  f379515577 < -:  ---------- doc: simplify the handling of interruptions
5:  d2d10b34f3 < -:  ---------- doc: remove redundant rm
6:  d78e08aa2a < -:  ---------- doc: refactor common dependencies
7:  450a79d36f < -:  ---------- doc: improve asciidoc dependencies
8:  5be9efaa11 < -:  ---------- doc: join xml and man rules
-:  ---------- > 1:  55b188c8ad doc: refactor common asciidoc dependencies
-:  ---------- > 2:  e69d0a5b89 doc: improve asciidoc dependencies
-:  ---------- > 3:  4f18675ce9 doc: remove unnecessary rm instances
-:  ---------- > 4:  935675e070 doc: simplify Makefile using .DELETE_ON_ERROR
-:  ---------- > 5:  b621f3b8e9 doc: avoid using rm directly
-- 
2.31.1

