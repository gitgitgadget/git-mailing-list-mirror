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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE52C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7EA6100B
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhFHOk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:40:59 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38840 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhFHOk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 10:40:57 -0400
Received: by mail-wr1-f48.google.com with SMTP id c9so13159682wrt.5
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XRfzrOpDntaR1sdIJ+qZGdjGfq4hIKH4AQI8Ecx2m04=;
        b=cl9nGW2rwesar3j6v7VbLWjkwAdobSnSU7tSdiRdV1TUXsLeSTalDOX1ZQo2t8sZK7
         Zb3R0ZEyJVhdkVTYdeRb4rACLmMzHwf4r1na6p8k10K5kiUy4/XXnTtyF6dGbSmsjQlg
         lVRPZUQApCecgh/WbMziNZ15sru3pR52TOPmjX2V7dKGOe/MYnHy9lH8QkrVqZTrkedJ
         u2hR/iPTrv613m+9fWALUjOPDtM5B79LK5Vq0AInf3RWl4lsNvdR0WMCr4jep2m5tvfi
         SUInr7BHJgPaVExoS1ohoYpEcWtCevoCEyfbmPXUNkEZwX7ekYeDAHkZnzcjlqC6WmlA
         W6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XRfzrOpDntaR1sdIJ+qZGdjGfq4hIKH4AQI8Ecx2m04=;
        b=fTbwBMUIdOERfVlD4jJM8grJQTQoJR5jF/Xio3FFYYVxPWY3wEuWsOejq0r+OvJy7a
         wn7ZohaOkJFwl769vSEOglls76DLkx9RFgQnuXcj8ov8QQGvI/qdeJY7BXca6LJgQNXm
         eOS0ArvUFTqNOkn5LrKzwehN75vvXdzU+/kNB00bsJZ4WIbQXyhaY7w6k4F/ClJF9HYw
         VXp3Bb04Fy5Qc6iJIuqvvyT/r365j10EYk6G7mFmuDn2iBWb8StoaRnglsy+hHT1l8uT
         4q75rSHk/j83XXSktQsVajcqNCyJ8lpyIP1WgvgwtgcGZWsg/qmzP+hazLMFtsDXKv//
         Re8g==
X-Gm-Message-State: AOAM530+vQ5hOsdo9HFbPWuI77dhe9MkgutAhSftkwlOv/3PU8YUrZK4
        5Z2/+Y2Zt/sLIknlOCHE+AcHb+cvl6U=
X-Google-Smtp-Source: ABdhPJykDRytj2PJFgVQqJDp75AGOzXXpbe1Lqr7KX6jfc8O+jISBe2X+3hA7jf18jY3IktwnYY6GQ==
X-Received: by 2002:adf:e846:: with SMTP id d6mr23374336wrn.189.1623163084199;
        Tue, 08 Jun 2021 07:38:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm22864323wrg.92.2021.06.08.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:38:03 -0700 (PDT)
Message-Id: <pull.976.git.1623163082.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 14:37:58 +0000
Subject: [PATCH 0/4] [GSOC][RFC] ref-filter: add %(rest) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to let git cat-file --batch reuse ref-filter logic, in this
version, the atom %(rest) is added to ref-filter.

Change from last version:

 1. Deleted two commit about %(raw:textconv) and %(raw:filters), their
    construction will be after letting cat-file --batch uses ref-filter
    logic.
 2. Exchange the order of the definition of "cmp_fn" and the declaration of
    "a_size" and "b_size" in cmp_ref_sorting(), to avoid breaking
    -Wdecl-after-stmt.
 3. Delete --rest option, "git for-each-ref" family will reject %(rest) by
    default.
 4. Add GPG prefix to some %(raw) tests.

ZheNing Hu (4):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom

 Documentation/git-for-each-ref.txt |   9 ++
 builtin/tag.c                      |   2 +-
 ref-filter.c                       | 226 +++++++++++++++++++++--------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 211 +++++++++++++++++++++++++++
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 8 files changed, 408 insertions(+), 61 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-976%2Fadlternative%2Fref-filter-texconv-filters-v2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-976/adlternative/ref-filter-texconv-filters-v2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/976
-- 
gitgitgadget
