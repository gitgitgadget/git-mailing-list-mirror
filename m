Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9062E20958
	for <e@80x24.org>; Thu, 30 Mar 2017 03:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbdC3Dc1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 23:32:27 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35449 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdC3Dc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 23:32:26 -0400
Received: by mail-qk0-f195.google.com with SMTP id f11so4733421qkb.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nwZmXyvidUAV5mjU5zad7iuVlmVq4i1cSvUvc/Fu5Nk=;
        b=Y+GyriRUNRK9RcbxIB0rCz05tsgGMXH+5YbkjD5JIRxZsyRP9h18+vMVDzlM6s+rNB
         SZXNCRrMhKDpDe/Kvl3PoQSoACr6R2ati7YUO29ut7hhzntnSXDRr2Xs6nvtxSagf6R+
         4FQxVnkhTqa3r2PzUlnpLvkkE8tm6vLUh7B2eZEhTxDk9CA1X+62gOBxoYgmJLaYucXU
         7C5NaRtjC8wm4yvwIPoj1v95Bgyn+RidWghCFNFYKREfAlxmnC8hIROTFTVyX+yzBxpZ
         I57k/VIenvyGIPc2i3ApBl3/M4kA6IRK26ro/lFh/jssETBqM12WLKZfLBXur/6wHiQ8
         M6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nwZmXyvidUAV5mjU5zad7iuVlmVq4i1cSvUvc/Fu5Nk=;
        b=hZSiqNVyroji5IUcdgJ80HGxIrKq0Mc2bHMI/wvxF22eS6POeuSjqFXphKnGHbmz2g
         Vz/UF7ZH31+qEpXlHL+sjbzwyq3DwyIa485T+utciUNo1uJOUkhuofsVV6FdvmcOylm1
         XobTJIK+4z6DHlZK/hwTp30UxaVvBA0ag3gI2iG7+xKjsFxXGFiIsFGDqPQSC5/CJOA5
         sdXIQC95fT3CTtaE7/ULM2uqAfTsq1LynS+B+6VKMVgzTK7r/SLKHuvEq7iGJHKKUKot
         kKr1SVQ7WHGU2/Nr4aeyA345bx4FbvZosF88jrJsOqfJReIbRvoyO5SSyyRUm1Kj2M7E
         1Asw==
X-Gm-Message-State: AFeK/H0yo6cgVtyOMrRBF0sPyCulN/USpL7bgzOweSXAfswnSSh3wzW6D2/MbN8mUGiZeA==
X-Received: by 10.55.102.146 with SMTP id a140mr4366878qkc.28.1490844745357;
        Wed, 29 Mar 2017 20:32:25 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id d136sm624095qke.32.2017.03.29.20.32.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 20:32:23 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v5 0/6] [GSoC] remove_subtree(): reimplement using iterators
Date:   Thu, 30 Mar 2017 00:32:04 -0300
Message-Id: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifth version of a patch series that implements the GSoC
microproject of converting a recursive call to readdir() to use dir_iterator.

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#t
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t
v3: https://public-inbox.org/git/CAGZ79kYtpmURSQWPumobA=e3JBFjKhWCdv_LPhKCd71ZRwMovA@mail.gmail.com/T/#t
v4: https://public-inbox.org/git/1490747533-89143-1-git-send-email-bnmvco@gmail.com/T/#e437a63e0c22c00c69b5d92977c9b438ed2b9fd3a

I would like to really thank Michael for the incredibly thorough review of
the last version of this series. I never expected anyone to give that
level of attention to this change, and it's really, really appreciated.

All of the points he addressed are fixed in this version. As always, more
feedback is greatly appreciated.

Thanks,
Daniel.

Daniel Ferreira (6):
  dir_iterator: add helpers to dir_iterator_advance
  dir_iterator: refactor state machine model
  dir_iterator: iterate over dir after its contents
  dir_iterator: add tests for dir_iterator API
  remove_subtree(): reimplement using iterators
  remove_subtree(): test removing nested directories

 Makefile                        |   1 +
 dir-iterator.c                  | 123 ++++++++++++++++++++++++++++++----------
 dir-iterator.h                  |  17 ++++--
 entry.c                         |  41 +++++---------
 refs/files-backend.c            |   2 +-
 t/helper/test-dir-iterator.c    |  32 +++++++++++
 t/t0065-dir-iterator.sh         |  45 +++++++++++++++
 t/t2000-checkout-cache-clash.sh |  11 ++++
 8 files changed, 210 insertions(+), 62 deletions(-)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

--
2.7.4 (Apple Git-66)

