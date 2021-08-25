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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7214C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B551F61183
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhHYJJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhHYJJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34836C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i6so11535265wrv.2
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=M3tRCH15DMlkqU2DZTZVCs3tdt+/56dDGY+f/+nC//Y=;
        b=f1ODS6LvQKTTskYPmnkHI+oxs9MG6eYxjY+4jqSrbxBtH+Y/LeQ94EFNPQ6SKTTQOj
         f7+MEtxibdym3pRw8goFgEf7meHaU1C8LAxZ0T+tj+Qo00Q4OvsVY3ZsDXOARcI8SLXH
         RB4PoXO7WjV2/lPe3Ak1dxded2nk6HikzJBU1lPv5nNRJfX4JsEr59DNpKaZvCSAMlYF
         zwqq5urMl1Rds4KWElrqK+6g3tyVrBXwNMPzxyw/jyV7vwrUxcPDxE+v1MCCwLR6vCzv
         6lk40rQWcOZRSsec7hyJYOCYJf5jactljuNM94e4VbVxrrWZ89p0S7+J+yQx4eSZeY3h
         fzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M3tRCH15DMlkqU2DZTZVCs3tdt+/56dDGY+f/+nC//Y=;
        b=p+je7rYUA8y4n8TV+J9qjVhiWvB8PjyJhY6eeV3pu4s2RmAf2CCBNlqjNIMTv4u6UZ
         QYRKxyS4kWOuf5ilbBivZo2S/vyveHZX/mrFmaNu7xbA1Rd9xCZ2lAo1qPbIbGnq+T/s
         uFj8UKlt8HcxQyzabbvqd6FP9ZQ/IlPFFrjaWjKxnJaYGVYazArM73xy9IZm9nODPJXf
         M5HGCfydKDWSYLX8P2PD3IQ1BOaqFp+yUsB/t1WVA1KuZCkQA93q/bMjp5OlD8rEI9z6
         CimOQYlTS4m0vDpPsp6ESLFBQgR0oRE+drkZfSPDnSvVNEAk2sN8BsN055YCw3decuRj
         sQ1Q==
X-Gm-Message-State: AOAM530sPSThZ4Pqy9Qrjgdn08ZOxcEvyFPfte4EpaotNkpEOvs9CENG
        bDZraIF4T8Mfg6hNdu6Br4Yfg4ITLnY=
X-Google-Smtp-Source: ABdhPJyujaqEmswKIBg75dtHGjIrsysijUXbPf7WpRV0jEnO6YMvwzw3pvOFvhqaHTyUqoJDd9EKvg==
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr24160533wro.405.1629882533325;
        Wed, 25 Aug 2021 02:08:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q195sm1433675wme.37.2021.08.25.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:52 -0700 (PDT)
Message-Id: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:44 +0000
Subject: [PATCH 0/8] [GSOC] ref-filter: eliminate dummy ref_format to make the code cleaner
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

Note that there are these disadvantages in the ref-filter code:

 1. Scattered state variables: need_tagged, need_symref are placed globally,
    need_color_reset_at_eol is placed inside ref_format.
 2. parse_sorting_atom() uses a dummy ref_format, which causes us to need a
    lot of extra logic to check in verify_ref_format(), because dummy
    ref_format records some state, while truly ref_format does not.
 3. struct ref_sorting uses a very strange singly linked list
    implementation, and there is a memory leak with it.

Therefore, the following modifications are made to make the logic of
ref-filter cleaner:

 1. Let ref_sorting use list api.
 2. Eliminate dummy ref_format.
 3. Add ref_format to ref_array_item.
 4. Move the check in verify_ref_format() to atom parsing function.
 5. Add deref member to used_atom.
 6. Move need_symref, need_tagged to ref_format.

ZheNing Hu (8):
  [GSOC] ref-filter: use list api to replace ref_sorting linked list
  [GSOC] ref-filter: let parse_sorting_atom() use real ref_format
  [GSOC] ref-filter: add ref_format to ref_array_item
  [GSOC] ref-filter: clean up verify_ref_format()
  [GSOC] ref-filter: introduce symref_atom_parser()
  [GSOC] ref-filter: remove grab_oid() function
  [GSOC] ref-filter: add deref member to struct used_atom
  [GSOC] ref-filter: move need_symref, need_tagged into ref_format

 builtin/branch.c       |  26 +++--
 builtin/for-each-ref.c |  20 ++--
 builtin/ls-remote.c    |  18 ++--
 builtin/tag.c          |  24 +++--
 ref-filter.c           | 236 +++++++++++++++++++++--------------------
 ref-filter.h           |  20 ++--
 6 files changed, 185 insertions(+), 159 deletions(-)


base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1025%2Fadlternative%2Fref-filter-code-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1025/adlternative/ref-filter-code-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1025
-- 
gitgitgadget
