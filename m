Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D32C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4693723110
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAFLv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFLv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:51:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC4C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:51:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so2133371wrb.12
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5i9AMhzboWEG4EOVN9uhuMSeOcFng5oqg/D3Pe1C/ZQ=;
        b=nhw9pY/j2YP30irV9cN7hfFo0d/zgW7jJe13y5B/R9EtXxH3McPRVnSH4BdJnNwrli
         jQ3j8NkSi7pjW/BfhF/8mCeE3dMOQv2lldw9CAD8u8jah9aalcdzvlLF3+BDAyt7b66Q
         xecbCBkvWo4igY8eAw/htMlp353zoK2UjrInWaXjR+mj1kXVim9bv2Eyn9S7VdLz4b7p
         4VvDOQFjLLXi6mm/A/44U2R8LJuNA2ub+Quf4+RbnOXpPXh9v+gv/UFcR1mWiATF9O1a
         Q2CdW3X7GS5Z6DBrmz5Afnlqi4aAyPCdlhZf4QnqQjPKBkT/cwPGiTJrDjP2uAwFBhup
         zDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5i9AMhzboWEG4EOVN9uhuMSeOcFng5oqg/D3Pe1C/ZQ=;
        b=TnkD4Ug0NeoHkRBNLccppOIjYlUWZrD01XlJGaon46Fllk8U210Vvrp/bzEbNbW3wN
         fvSKSVMkQnINMueuYIds9uG9GJ/2C4eIl4PEtq76NytghKp+AMmuTTdWdGRQsbdCGtkr
         JITwar0bhcW2Z/bomWAxaOXqmT42GBQe37heyiVLZaa8zV34ktSy3z48pAVYyIoXHxdQ
         /aIowGZ8DDxPHI+O1+JtkPW8QCx+OSaznfNJ8zvzxKrjmvnqn64pEBi58YgqOilR+yHe
         oc6p3GbTB3yw6jgnLLcs1u1ihA4XVQ3ZKEny+VrDeqLmrux+pqkKyWx/f5IV/nmWuQnu
         OfCA==
X-Gm-Message-State: AOAM533D/0zRgv1KCuNEnzXR0w2bZ1NZI9X/vnn11sFEtnGDWZoe8rJ0
        ah8R5ykE0PzVFPmuIEC04cGesX/DTu4=
X-Google-Smtp-Source: ABdhPJylYFVvcoYj4enG91RtBLk9bXFj3/5+EczfGSbg3lGDxjnw3HfK1o4nKYPe4kTj7uFna4W4+w==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr3979738wro.216.1609933876837;
        Wed, 06 Jan 2021 03:51:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm2681138wmh.15.2021.01.06.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 03:51:16 -0800 (PST)
Message-Id: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
In-Reply-To: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
References: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 11:51:13 +0000
Subject: [PATCH v2 0/2] builtin/*: update usage format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the "Error Messages" section of Documentation/CodingGuidelines,
we should not end in a full stop or start with a capital letter. Fix old
error and usage messages to match this expectation.

Signed-off-by: adl 1607364851@qq.com

Junio C Hamano (1):
  parse-options: format argh like error messages

ZheNing Hu (1):
  builtin/*: update usage format

 builtin/am.c                |  4 ++--
 builtin/blame.c             | 48 ++++++++++++++++++-------------------
 builtin/commit-graph.c      |  6 ++---
 builtin/fast-export.c       | 22 ++++++++---------
 builtin/log.c               |  8 +++----
 builtin/shortlog.c          | 10 ++++----
 builtin/submodule--helper.c | 24 +++++++++----------
 parse-options.h             |  6 ++---
 8 files changed, 64 insertions(+), 64 deletions(-)


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-822%2Fadlternative%2Fdev-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-822/adlternative/dev-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/822

Range-diff vs v1:

 1:  52f7c8457dd = 1:  52f7c8457dd builtin/*: update usage format
 -:  ----------- > 2:  c5f01b0eab1 parse-options: format argh like error messages

-- 
gitgitgadget
