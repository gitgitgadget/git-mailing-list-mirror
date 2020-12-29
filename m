Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6155C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C22B21D94
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgL2UGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgL2UGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E8C0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so15589452wrm.11
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F5SVzOSa7YooSgoAyJ3jPz/gt2LMOCI8T0RucTS9g7Y=;
        b=F895IuxxOctSY7EPhVCmXFeMn4SFZdtGXaUO++ACoZLpF3T3t1LCobEU0pPVhDmuwk
         7CJV78lv/Su6LI50xQ09xDrHGOHyUxZ7W+V0J0NHNjROobpKfv98vfCcdHlD0yNbu8me
         wg9RNr0rb5LiW8ix1b8PMQvL95b7hb2G8BaBtWqfbvKXWjRAuWlV9eq49Fo66goQ5hkL
         iPjjZgiyund5h43xUc2g1C9bsmwdbcoNl+p0UoMrfMtmaTquJHW6bjSO3N/qgCZ6+JSY
         jjchiH1ioYPyiLYQgKFWmW9bIfryCVKob1pH2lXrvURoB5FFGp8eXBiofVUfL46G8ibe
         e67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F5SVzOSa7YooSgoAyJ3jPz/gt2LMOCI8T0RucTS9g7Y=;
        b=REEIR5fUhwjVu0T0N/uwAizFArgBWwaCL3BNPLA24s1EV0kOhhPH8oTWAKQaEwG9lZ
         EvkDm26XXp1xMfKcFF7MEI+3tUgMB/WNMpUJeM5gHBobr8d7xAiRLX74NYvd5/IliZU7
         WFlbNEMtAcHBcUo2zuhx+WT0XLtFebwUBOcnWS20WvxPE9w7kckZjdiPKHw/rsfSLQa9
         RNN1oS+d7gpMj2KhAfuQI45ynrvVTYfOGeO8Z8uo50Qas3plkzo4EEh2q/qpEZb0IZAn
         5GjtWNrHpxdlgbDYTCj7uTyE/s7AsXETeFgnMKRojqQA4NR5mxRLJNBv2VxIL9wfdpsU
         pGKQ==
X-Gm-Message-State: AOAM533gjw+R1jIq7OetRAKm8Lu8oIKjUL1L43L0eIgl9zEClWQw2pbL
        FSdFDytd6da/GKhKXt9TB6Bl64LujEs=
X-Google-Smtp-Source: ABdhPJwZPh/Ld9Y1T0E6IHVE9/q0dBH1y1lvplaBdFt80GHrslh5XTcf9GJYdad0xYx43Zn8J318Pg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr57548425wrv.304.1609272330246;
        Tue, 29 Dec 2020 12:05:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm4609147wmg.30.2020.12.29.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:29 -0800 (PST)
Message-Id: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:19 +0000
Subject: [PATCH v3 0/9] diffcore-rename improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series includes 3 small code cleanups, 1 small bug fix (or
perhaps just a UI improvement -- it's a very minor issue either way), more
testcases, and 3 performance improvements. The first 7 patches are
relatively easy to review, while the second to last one...is a bit more
involved (but provided the biggest performance boost).

Changes since v2:

 * Fixed spelling error: remove unnecessary double c in 'unneccessary'
   (thanks to Christian for spotting)

Elijah Newren (9):
  diffcore-rename: rename num_create to num_destinations
  diffcore-rename: avoid usage of global in too_many_rename_candidates()
  diffcore-rename: simplify limit check
  diffcore-rename: reduce jumpiness in progress counters
  t4058: add more tests and documentation for duplicate tree entry
    handling
  t4058: explore duplicate tree entry handling in a bit more detail
  diffcore-rename: simplify and accelerate register_rename_src()
  diffcore-rename: accelerate rename_dst setup
  diffcore-rename: remove unnecessary duplicate entry checks

 diffcore-rename.c          | 209 ++++++++++++++-----------------------
 t/t4058-diff-duplicates.sh | 114 +++++++++++++++++++-
 2 files changed, 192 insertions(+), 131 deletions(-)


base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-929%2Fnewren%2Fdiffcore-rename-improvements-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-929/newren/diffcore-rename-improvements-v3
Pull-Request: https://github.com/git/git/pull/929

Range-diff vs v2:

  1:  428d8204894 =  1:  428d8204894 diffcore-rename: rename num_create to num_destinations
  2:  fc62f4c4f89 =  2:  fc62f4c4f89 diffcore-rename: avoid usage of global in too_many_rename_candidates()
  3:  7214fa73fdd =  3:  7214fa73fdd diffcore-rename: simplify limit check
  4:  bf3581b1ac1 =  4:  bf3581b1ac1 diffcore-rename: reduce jumpiness in progress counters
  5:  9a4a3159acf =  5:  9a4a3159acf t4058: add more tests and documentation for duplicate tree entry handling
  6:  8db27892c59 =  6:  8db27892c59 t4058: explore duplicate tree entry handling in a bit more detail
  7:  a58639b2927 =  7:  a58639b2927 diffcore-rename: simplify and accelerate register_rename_src()
  8:  85714e1583d =  8:  85714e1583d diffcore-rename: accelerate rename_dst setup
  9:  af256b1c534 !  9:  723b0e55e75 diffcore-rename: remove unneccessary duplicate entry checks
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: remove unneccessary duplicate entry checks
     +    diffcore-rename: remove unnecessary duplicate entry checks
      
          Commit 25d5ea410f ("[PATCH] Redo rename/copy detection logic.",
          2005-05-24) added a duplicate entry check on rename_src in order to

-- 
gitgitgadget
