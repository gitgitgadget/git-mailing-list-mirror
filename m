Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980D5C11F66
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B36135B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGKAta (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGKAt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:49:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1147C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w13so8715106wmc.3
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LLYxQ1hNNAaLMdRYltg84eutLTgANii1/BY1O0mQSaU=;
        b=lhGHcXD/nUtPkZKWL1bi2YipISifhDcL1YBP+16ujEA90GqC31+7FqmUgQqQ9SF6ZL
         RqinM+nXZUf00+X8Dacu8kn6pxl3g7OoKgtADaGklnH9S7XYzQwne4IgZaEorEpF7lbX
         AXiOMfELV1RE8Am1ErtqoyrtVp1k/CNNoiaTE2/XjsKsoeWCuqDcG6sUbovxPm3ZZ/YE
         FcjjQu4+a+9ql6RZ6z3OTRZrKrwL6QDCXkFGUm4w0M6/1Uel/ezP7YhPhp52/72hu8Ia
         GtZ59GwFRNPsRSiwhx+S3hPvhlnnXBrCTyV17L/OqnoZkHTdGqfeDkYJNtBp+ZZ/G11z
         Z8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LLYxQ1hNNAaLMdRYltg84eutLTgANii1/BY1O0mQSaU=;
        b=qZzECxBroZ+BLdTXIg/fZQ1+nQ/LbtubGtSHy33b9ew+W8M+O8K2a6l/a2j4ZYmX1w
         HN2PtDvdauIU7RbyPWD66YAFIaH8+apIjDXlNa4FNNtfW8ZtmbiB8YezCR8EqIFfBImz
         6AXlk1v269leMcuRonqRMlUjVKTH1EVe87qd211C/fZpOolgFnjhAQc3xsW69+Wo3I4o
         v4R7yREPzglXKkwZKqaktTQeBzTvu5gyoSDcUvrhJxLSj6Bvk90ficmWt0aUUzvyTA5e
         oBEsxbIhDifwLbPbQbRASQywrLwoN6a7zkN10fLnfWztpeZn7hIWoPNgkzwzUI1EpCC0
         StPw==
X-Gm-Message-State: AOAM533SMP1vyY/H59YSowHYp5q54/CyqiaqL7pJw7UObxQLvOElV46P
        PIcdLczah4YdwxhM1rmD23Zc8+9Vq8o=
X-Google-Smtp-Source: ABdhPJyzMM9YtHLbl6nSDHiDBp/KP0g1FswVB4V31D+pl8o4S6p4KSWA0yGsPxIBEwMGapEU/hQc1w==
X-Received: by 2002:a05:600c:20b:: with SMTP id 11mr6982000wmi.112.1625964400124;
        Sat, 10 Jul 2021 17:46:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm9493616wrs.39.2021.07.10.17.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 17:46:39 -0700 (PDT)
Message-Id: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jul 2021 00:46:35 +0000
Subject: [PATCH 0/3] Improve the documentation and warnings dealing with rename/copy limits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few small issues with documentation and warnings around the limits for
the quadratic portion of rename (&copy) detection.

I also sent out a separate RFC about how and whether to bump
{diff,merge}.renameLimit [1]. If there's a quick consensus there, I may add
a patch to this series that bumps the limits, but that could also just be
done separately afterward.

[1]
https://lore.kernel.org/git/CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com/T/#u

Elijah Newren (3):
  doc: clarify documentation for rename/copy limits
  doc: document the special handling of -l0
  diff: correct warning message when renameLimit exceeded

 Documentation/config/diff.txt  |  7 ++++---
 Documentation/config/merge.txt | 10 ++++++----
 Documentation/diff-options.txt | 14 +++++++++-----
 diff.c                         |  2 +-
 4 files changed, 20 insertions(+), 13 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1044%2Fnewren%2Frename-limit-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1044/newren/rename-limit-documentation-v1
Pull-Request: https://github.com/git/git/pull/1044
-- 
gitgitgadget
