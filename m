Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21846C433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E990A61A0A
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhJCMbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCMbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 08:31:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17BC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 05:29:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so2488091pjb.2
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1ijsPwl0G+sMyL9GT4PdedUq66Xo9lQdfBonPXdVl0=;
        b=K76UC2i3g1VgFl+LnppTPRr+Z1OtHsC4tLZIfNdxvoJOU9EMuq8/gR6A31r2Eqtrcq
         rAP65fyvD3Zq7zUvcCmsp73tXH1Ah6oc05j+ICzAfpc0FPFs5xR+5yoZzYTThwJHJ/Ex
         PpSI405m/r/w6dXpMPaefGBH00SUhXUbYUZcHHPZQlRpH9pZk6fEez31v2TBSniRx4zM
         QRbVUFIrtngLIVDusDXjIkWvK6zLKyJANvMVxIHvhdUmQVLWMMOz1hONX9RuQk2P3aB7
         ToVCEDGfvz6iN6UlvjAtXOs5Tfps/YAAYwstmKeXx9tL8zqFC3RfQmDN0oinomHRPhhN
         RX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1ijsPwl0G+sMyL9GT4PdedUq66Xo9lQdfBonPXdVl0=;
        b=eqjLGQ6ykdaLU7wlDRVrv/AtxUZ5ly2nuZ8PDaaASlIveUe+cOBx9GvVkALTrjSNi/
         +fDQK/R0JAFwBDQSgf+LFS5Eb/+SyHlDW8KJ5qSk3U2Xa1yuVBCIreGE4+LLghhEDLft
         Ra26Etw91fwZuAUaMAWbCqXgcPUrQZ1Rj3PWvpR8QasXD3Ck9bA7uLtr6cA1bDYYrSM5
         Fs6mTv/vL1WwXZklZ5BV+kxPtkGi22n1rf7cGvsX2ABdPzMerCcur0Qb1HdtVvnur4VR
         IOOnCL6AGEjfJTu5fj/jYRkE8BPnrsgGeEbAAcwuh57/hz2NlREYd8Mqe06U7G6z1ekj
         wpQw==
X-Gm-Message-State: AOAM5323ECjPIUuvCtFUUOs/DlftnwQKy6fULVAd73NgX6cIZztdOljd
        ZUGZOn/wA9GDarjeKBFaGQRxToXv6mc4XQ==
X-Google-Smtp-Source: ABdhPJyMwCzxcBno1c1R28Zows7smjn3MBFl0KNDuQmUoEJm1Hen4b8HB+mHmR9kb6oqvOBUnic0BA==
X-Received: by 2002:a17:902:9b95:b0:13e:c43:2b57 with SMTP id y21-20020a1709029b9500b0013e0c432b57mr18789290plp.42.1633264193303;
        Sun, 03 Oct 2021 05:29:53 -0700 (PDT)
Received: from ubuntu.mate (subs09b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id k17sm8476394pfu.82.2021.10.03.05.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:29:53 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Ryan Anderson <ryan@michonline.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] request-pull: write to file option
Date:   Sun,  3 Oct 2021 19:29:40 +0700
Message-Id: <20211003122943.338199-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `git request-pull` only outputs PR message to stdout. Users
wished to send the message have to use shell redirection to file. Add
the option to write it to user-specified file.

Bagas Sanjaya (3):
  request-pull: introduce display_message() function
  request-pull: add -o/--output option
  request-pull: document -o/--output

 Documentation/git-request-pull.txt | 16 +++++-
 git-request-pull.sh                | 81 +++++++++++++++++++++---------
 t/t5150-request-pull.sh            | 13 +++++
 3 files changed, 83 insertions(+), 27 deletions(-)


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
An old man doll... just what I always wanted! - Clara

