Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA3C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5255061181
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhE0OpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhE0OpA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:45:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB113C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:43:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso2756998wmm.3
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PZDjUicWiuvRSmIVEB0N+E1X6o90yj6C7xMcTUFHnpU=;
        b=AbCFVybX1pmKC3o+8mhc63pq8niGwH7XBItp2w2+hZIGXGwtSnp/jlJXuSl+9FUueQ
         /mz8Ue6pPs83b7WOLG4XyI5nEzna0i7tkeN+HiTCOJRrRK6PMBOPoGxDfvFYNJltT4RG
         dNDc6gydmKqqeTBiMs51023jpUiLfbp7PG5aCIVMBX2m9FZSKpqJj5H3uT2gssxBQZjm
         k++ei7bXYqROlQFwUdmdOK1jn87B6ve7V83kVwvhRN7o9/VjAgpZt0f0Up9kG6wzztu9
         E26LLMBnFf7w1bKc4ih+/ocZm1J0J6N0ymrtbkR56Du28/2ztpBhzp8XfSyCYduPiva9
         aSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PZDjUicWiuvRSmIVEB0N+E1X6o90yj6C7xMcTUFHnpU=;
        b=lbO34JlysMr0LEr3wWG0lwDJL+WS/vTcOJrx6gujqxTek97rvciDI5C8rVarAz95RM
         z2ATZ0O8JW5n4aPA6q4LJKTKWE/oZbzIcmJRrZnpiC6IFltBfLVYzntY3R+mM/M1XVB0
         eTUj99yxOsNd2p9nY1tywTGfMckNRm/Ity+AR6lLXfQKRWtl7+uxahZEXe6j+fe1gd34
         hnw0sB1fk6+SiTGzjpb+y3TjSIqNAacSSXe+4T+FNm7vrgbJQW3Jw8F41dIigRnheyka
         fWirkUrHST0J90RkYkp+2GoauJv3AofiK1e2ZHJL3SIvz+7FNwP+Ml3sUQxQQTcmqIjc
         RsiQ==
X-Gm-Message-State: AOAM531BHO+lKKS8gVlnzKhejnC0+zUhL5zcTGnYX/01CesZfoO/V2ga
        glfKjccd9nprUrC0tgr73NXmDfTbu38=
X-Google-Smtp-Source: ABdhPJz6Wxo7tkiMuwQF12OgEsIrww2HvQRP7VdATnwKFSdLi8/q6KtJynGO7t8liosgyIDQJe+q4Q==
X-Received: by 2002:a05:600c:4282:: with SMTP id v2mr8845983wmc.104.1622126604431;
        Thu, 27 May 2021 07:43:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm3985003wrs.36.2021.05.27.07.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:43:23 -0700 (PDT)
Message-Id: <pull.963.git.1622126603.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 14:43:20 +0000
Subject: [PATCH 0/2] [GSOC] ref-filter: add %(raw) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make git cat-file --batch use ref-filter logic, I add %(raw)
atom to ref-filter.

Change from last version:

 1. In my discussion with Junio, I came to the conclusion that
    --format="%(raw)" should not be used with --python, --perl, --shell,
    --tcl. Therefore, die if both --format="%(raw)" and

--language are given in parse_ref_filter_atom(). The reason I don't move
this part to raw_atom_parser() is if I move it to raw_atom_parser(), when we
use:

git --format=%raw --sort=raw --python`

Git will continue to run instead of die because parse_sorting_atom() will
use a dummy ref_format and don't remember --language details, next time
format_ref_array_item() will reuse the used_atom entry of sorting atom in
parse_ref_filter_atom(), This will skip the check in raw_atom_parser(). 2.
Give atom_value.s_size a init value ATOM_VALUE_S_SIZE_INIT (-1), which can
help us distinguish an object whose length is 0 and an object whose s_size
has not been modified after initialization. 3. Add %(header) atom.

ZheNing Hu (2):
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: add %(header) atom

 Documentation/git-for-each-ref.txt |  21 +++
 ref-filter.c                       | 182 ++++++++++++++++++----
 t/t6300-for-each-ref.sh            | 236 +++++++++++++++++++++++++++++
 3 files changed, 412 insertions(+), 27 deletions(-)


base-commit: 5d5b1473453400224ebb126bf3947e0a3276bdf5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-963%2Fadlternative%2Fref-filter-raw-atom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-963/adlternative/ref-filter-raw-atom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/963
-- 
gitgitgadget
