Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE59C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659AB60FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbhHQImR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbhHQImQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:42:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D03DC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r6so27421998wrt.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3Nz3ETXbMj3nZYqqBIgQkCa+SQV6lEF/ohwNOTFW+r4=;
        b=CEvhNYWJDz4M2QFnU+61rb4o75a4tR3b39FO7PLHQRXkBFtsJzv5+rHQkTES9NtItF
         RlmJ1VsSYYpibXH4Ko7mQrbwfN31TOtviHgniBGyDCUnRydgEpOfGSpEG/wadRFZ5Z7e
         gXrO8r02uAUfb1l5VmFCZtwKDBXiurQAIBM+kiEJpYp4/IoJAqsc2Tv7YbooRCDglJIT
         1R/JBiTBoglRsV8q1ZJALZjDkUooRDkR4FNLcBVLF5rtugOKgQ5OLWSNIhDRfXgbzwvG
         u8k0o/WACmwX2HaQMIzKQQRwB2ZKSJ/e5yqYTgQ04VXs06gq7juZBX0L2UmABLVQ8aUu
         YxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Nz3ETXbMj3nZYqqBIgQkCa+SQV6lEF/ohwNOTFW+r4=;
        b=bDbowY/DQh8VU49ASCJXGiyzECB049eTlO6rDJaKSOef/lhwmqZcWdD/PtXyvCFifm
         FVHPcEWGDzxoxCzGBMsCG/NXX2J4oRhwjVmDBEA7aRPN0/ZRrFvj9DjSv2EOIkEsV7ww
         bONZDZB9cmkuuwPysO4d6unWXQqg5a+QpC+VElIeYpPPP5CPb4ZAVTWSUkjFbW5RsrGf
         Ad/RAz+QCBNakB7LVaE6edQrHnCXkgITM124DXGaT2szXBfk0qlTAfxOVfwhj3R7LzjJ
         XOOSm6lZDEgpVF3kJ7QROucM8Chn5YxMM0x+Q62fF8gyjgB5g9Kc8kBSGJq9TYBaW4HS
         6uAw==
X-Gm-Message-State: AOAM531Btp4bMLqS26W2qMALntt7aY8PiWb0Qmezm8mtcDeqhWyLkuI1
        88mWgg0FxoSc8DCx39Ppjf5hOGRdHWk=
X-Google-Smtp-Source: ABdhPJyWnmEmbZrE4xNgiqkarC9DXIPRyUMt80gCEXJZrAhzxJIlne+BGSEvy8+U+e9J2bJZCIN/5w==
X-Received: by 2002:a5d:6483:: with SMTP id o3mr2581444wri.197.1629189702292;
        Tue, 17 Aug 2021 01:41:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm1920586wrn.9.2021.08.17.01.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:41:41 -0700 (PDT)
Message-Id: <pull.1021.git.1629189701.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 08:41:33 +0000
Subject: [PATCH 0/8] [GSOC] [RFC] ref-filter: code logic optimization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last time I submitted a very long patch series:
https://lore.kernel.org/git/pull.1016.git.1628842990.gitgitgadget@gmail.com/
My mentor Christian suggested to split the performance optimization part
out, so this patch series used to optimize code logic in ref-filter.

Changes in this patch series:

 1. Remove grab_oid to reduce unnecessary string comparison.
 2. Use atom_type in grab_person() and merge the two for loops.
 3. Remove strlen() and introducing xstrvfmt_len() and xstrfmt_len() to
    reduce strlen() overhead.
 4. Introduction ref_filter_slopbuf[1] to reduce memory allocation.
 5. Add deref to struct used_atom to increase the readability of the code.
 6. Introduction symref_atom_parser() to increase the readability of the
    code.
 7. Use switch/case instread of if/else to increase the readability of the
    code.

ZheNing Hu (8):
  [GSOC] ref-filter: remove grab_oid() function
  [GSOC] ref-filter: merge two for loop in grab_person
  [GSOC] ref-filter: remove strlen from find_subpos
  [GSOC] ref-filter: introducing xstrvfmt_len() and xstrfmt_len()
  [GSOC] ref-filter: introduction ref_filter_slopbuf[1]
  [GSOC] ref-filter: add deref member to struct used_atom
  [GSOC] ref-filter: introduce symref_atom_parser()
  [GSOC] ref-filter: use switch/case instead of if/else

 ref-filter.c | 432 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 237 insertions(+), 195 deletions(-)


base-commit: f000ecbed922c727382651490e75014f003c89ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1021%2Fadlternative%2Fref-filter-opt-code-logic-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1021/adlternative/ref-filter-opt-code-logic-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1021
-- 
gitgitgadget
