Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056631F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 20:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbdAUUH6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 15:07:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34165 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAUUH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 15:07:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so15525775wmi.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 12:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zjmFT7FPw4w741r82nFR/ckkJbU2V+Denpuo+8XBF0E=;
        b=J6dPOMkLRn00SCiXRg20kWiLlu2aGnMPLEfCkc7IDtWR+TcKc4A477OcmufgvYB2oA
         iGQmsQq3hRcVbbuZQw8DaGSqAncVobhn9cSo4MyPdB5CrBAw+pqeFvsewR5fsYl1Y9Ru
         X5xrMjGlEeExc075lG3ob91CPfBJk/vSi+G87sECgBwX1r8gLBN9QOy5qhqn05OK/evx
         0aTr1dswTyaWJTiqEuaNf2vmwo5STjJMY0xLz9dU6JfkznaFuNUS8ngUsvmPIYUjmUxn
         IWqNBhZwyOFkgtJHwdIzRSohU8RbGdn0Vaf5nHxcFIwQGkeM+M6nzCwOv1gbXmpP2czJ
         N/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zjmFT7FPw4w741r82nFR/ckkJbU2V+Denpuo+8XBF0E=;
        b=NrsjE/IM8H3xZZiQZ9KLGVI+bMNz/jpLy9pgAncxRQtC/EeqpBTeI7oj4RtXIR3AW3
         GoJ1BJjCReUaR4U7RTxrMF2exywr/K+hcQEjQa79tRPI8w2b8ssma044lGK5ZIKdmtTx
         46MP0mVpWghDINjyQZ73f+PYisEbTqK361VM1kdNHOA3S873OOjsmZ/JT8uL09mFD11I
         0uf/8b1QFxME1+TkRc+ZdvECvD6y+FjVobIfcuX6TR1igGPtlQLwml4fKTvOcdunIxJH
         l4hIYRPbO+uNPDcji2GpsP5FoRU81MXOnNY8+RA08JAdDyQuamfJ2XoyzNQjp2t2Y+Ie
         QEHw==
X-Gm-Message-State: AIkVDXI6aEZpNNDZPdjpYbx5C07GWdxWJRstsIPKx7TKFTjqbOip+CTMSvjhz15Jg3vh/A==
X-Received: by 10.223.168.87 with SMTP id l81mr20884880wrc.194.1485029275327;
        Sat, 21 Jan 2017 12:07:55 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id c132sm12411761wme.21.2017.01.21.12.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 12:07:54 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] stash: support filename argument
Date:   Sat, 21 Jan 2017 20:08:01 +0000
Message-Id: <20170121200804.19009-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first try to implement the RFC I posted a week ago [1].  It
introduces a new push verb for git stash.  I couldn't come up with
any better name that wasn't already taken.  If anyone has ideas I'd be
very happy to hear them.

Thanks everyone for your input in the previous thread.

[1]: https://public-inbox.org/git/20170115142542.11999-1-t.gummerer@gmail.com/T/

Thomas Gummerer (3):
  Documentation/stash: remove mention of git reset --hard
  stash: introduce push verb
  stash: support filename argument

 Documentation/git-stash.txt |  13 ++++-
 git-stash.sh                | 123 ++++++++++++++++++++++++++++++++++++++++----
 t/t3903-stash.sh            |  36 +++++++++++++
 3 files changed, 159 insertions(+), 13 deletions(-)

-- 
2.11.0.483.g087da7b7c

