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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BDCC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D266164EA5
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBHIdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhBHIdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 03:33:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C4C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 00:32:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so16104795wrz.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 00:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lRoQs4xkVWEKe0AkkoeoaOtzID/MXR0jS35+fQlfzq4=;
        b=LVJzdEwl1araoautPvld9cFqmkn5JVXLr7VGxvd8DL2zaZ2t93RAVghm4Jt1cl8WKL
         HZITpCP0ov9VLrCqFxZ5BUN+4LUloVQnrPS13gv/bpINuPduNWrEP/vGuTdRUkmPYdLc
         y/ehqStv3V6NJEjrYgh224GnFZkwweauE4dET15v4guOmjsKbsnQBZY4Hbf8jb+sJjfa
         pjxy3g3gnNnbhBc3nSYIV2Zh44y70Bq+diG+25+U/cSFUXqaGnsPlMxxMGLIDNVnkWot
         qe3cz+AaTD/U/L9Knt+hlZsFaywAdGjEzD/zHWwYAoOCqQ288GqFT0WMJBag6aG7iKIS
         DFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lRoQs4xkVWEKe0AkkoeoaOtzID/MXR0jS35+fQlfzq4=;
        b=H2kDGSU84kE1r4gHbN6YyiNp+TUdY4E4PfKbsIGoKEUSxyqMEbMGeJWMoqJ6i6Mgr7
         URE/IZdJ/B4zxSIhGm60P54Tpk6afGVsBRWkbEC1k1kRFgImVFTIXRsf3fn3yRNEQs9M
         x9NeKSbhbtNRA+35kiRs9mBw8UXW4wf1w7N1LpYvv5T/HIZzdMZ625rZSF6ufthtsZNc
         Fcp7Bqr1DQygF+1oig94ExrdEN+TeSPBUfM9vXtra5q/wdhF1lcKTxhmgy6qbWszdThW
         tbFo9Z0WNxikkMM7opl1NQTBwqyp0g/pgFo+FLPSBlGjhZibrhMOMRGm/RehxoI5vg9c
         fMjQ==
X-Gm-Message-State: AOAM530jLZpkpjenCEIaneK9galtkMneM53L/uCDVvlnR2c1QNAlJwPV
        WvxArFUsnuYn/Zk7S/ByTfDzjFlbuVg=
X-Google-Smtp-Source: ABdhPJxWqDBEuQuMPHLOLDKELJvXX9X4Go/5fToyES7W2VsSLwC99fC6v4dQHc6eovu2O+2i8LTM7Q==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr18454406wrs.420.1612773121908;
        Mon, 08 Feb 2021 00:32:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm27446497wrm.52.2021.02.08.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 00:32:00 -0800 (PST)
Message-Id: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 08:31:57 +0000
Subject: [PATCH v2 0/2] builtin/clone.c: add --no-shallow option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change since v1:

 * Rename --no-shallow to --reject-shallow
 * Enable to reject a non-local clone
 * Enable --[no-]reject-shallow from CLI override configuration.
 * Add more testcases.
 * Reword commit messages and relative documentation.

Signed-off-by: lilinchao lilinchao@oschina.cn

lilinchao (2):
  builtin/clone.c: add --no-shallow option
  builtin/clone.c: add --reject-shallow option

 Documentation/config/clone.txt |  4 ++++
 Documentation/git-clone.txt    | 20 ++++++++++++++++++-
 builtin/clone.c                | 35 ++++++++++++++++++++++++++++++++-
 t/t5606-clone-options.sh       | 36 ++++++++++++++++++++++++++++++++++
 t/t5611-clone-config.sh        | 32 ++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 2 deletions(-)


base-commit: fb7fa4a1fd273f22efcafdd13c7f897814fd1eb9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v1:

 1:  594323684af0 = 1:  2f9602495eb5 builtin/clone.c: add --no-shallow option
 -:  ------------ > 2:  cfcfc3ec6b37 builtin/clone.c: add --reject-shallow option

-- 
gitgitgadget
