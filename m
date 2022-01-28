Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688AC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiA1MCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiA1MCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:02:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7026C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so8024029wms.3
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6tiqZfoUbHVk5rK9nNoDjAtXGc54RSpfR9RI3MKfwrk=;
        b=gWaGt3tJASsruhZq8lRHlxWREOb0EDKNMjS5O1cqV92GF96+5uQGREM+y+2ZRL4UNG
         rL9m11AsT1BrBkOpqyrArwMTEy1Mp1JnPVRhtnprhl/YC5J6xbkA01sbxstufFHWFktZ
         0faKoKWADaJE1tSjvuBY5LlJF9vZkyqyHqDwk+jgLhTNJeB5XatO4fXWOjVagZw271BP
         xTVcG2MWx2jUF8ynrmX7rtPA9ZvhaPEV2X2c4NwlQJ9x1DmATdyCFm+9Sk8U//MLoW+d
         +78S3DLgsiD743fDR+11UmhmE7qcXYdKeW6XA9aE4Ui+XBQ0pGVL2b+JtFWnTW+0laOf
         ocoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6tiqZfoUbHVk5rK9nNoDjAtXGc54RSpfR9RI3MKfwrk=;
        b=bZvcyu1P38iACzY+nXzeU74fkl2FlY67NWNAZd1wABWwxOSOWTIsLTHupyt5dSVIM8
         2uu1QEI7z9tuBUtqYRdBaM4UJd7TT0Xvh5herXiNJFCL7yygVqDIqbRGFU6WiM1hGoIG
         HMpJ1A1JqUbqF/BqiyCjKwr7C1RgTDUoaq0Ge1x38637Xmfy1rW8ZBTPqOOnCh0NBnO2
         BqFsDr6oeNRJxXb7qv3Dlf9UjiR+vQA9ECXNBo3FOSKAHweubzBCyww/U0S6zbYQWoG1
         pQ4wm/8gnNC1cr8lVQwFiz6+Eu2IGVrG88yAN8g07LfJh6KiWFaDT+rTl6YNndHLSIDj
         xrwA==
X-Gm-Message-State: AOAM533SspJml5e0ez5l/nOLfOi27Hz6jn/fjSR/dODfL7sOrQyh8E0B
        XVaCgjPjHVEtJaGGru77bt7yYpH5EmA=
X-Google-Smtp-Source: ABdhPJzFGQuWCHpDOuvCUVISL5EfjBLxI3zZPliTPbIF3wMDCQspya4OU4CSSnSWTq4IMq9Rm2DFvg==
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr15811423wmb.14.1643371372087;
        Fri, 28 Jan 2022 04:02:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm1804586wmc.33.2022.01.28.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:02:50 -0800 (PST)
Message-Id: <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
References: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 12:02:47 +0000
Subject: [PATCH v3 0/3] Fix two --diff-filter bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A colleague noticed that git diff --diff-filter=Dr behaved in an unexpected
way. The expectation was that the command shows only deleted files, but not
renamed ones.

Turns out that Git's code is incorrect and turns on all diff-filter flags
because the argument contains a lower-case letter. But since it starts with
an upper-case letter, we should actually not turn all those flags on.

While working on the fix, I realized that the documentation of the
--diff-filter flag was not updated when intent-to-add files were no longer
shown as modified by git diff, but as added.

Changes since v2:

 * Augmented the commit message to explain why we do not need to be careful
   about setting only the used bits of options->filter.

Changes since v1:

 * Now even the case of multiple --diff-filter options is handled.

Johannes Schindelin (3):
  docs(diff): lose incorrect claim about `diff-files --diff-filter=A`
  diff.c: move the diff filter bits definitions up a bit
  diff-filter: be more careful when looking for negative bits

 Documentation/diff-options.txt |  7 +--
 diff.c                         | 97 +++++++++++++++-------------------
 diff.h                         |  2 +-
 t/t4202-log.sh                 | 13 +++++
 4 files changed, 60 insertions(+), 59 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1127%2Fdscho%2Fdiff-filter-buglets-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1127/dscho/diff-filter-buglets-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1127

Range-diff vs v2:

 1:  704bb2ba18e = 1:  704bb2ba18e docs(diff): lose incorrect claim about `diff-files --diff-filter=A`
 2:  19c7223e265 = 2:  19c7223e265 diff.c: move the diff filter bits definitions up a bit
 3:  b041d2b7a3b ! 3:  f1f027ad61b diff-filter: be more careful when looking for negative bits
     @@ Commit message
          special-case the "only exclude filters were specified" case after
          parsing the options altogether.
      
     +    Note: The code replaced by this commit took pains to avoid setting any
     +    unused bits of `options->filter`. That was unnecessary, though, as all
     +    accesses happen via the `filter_bit_tst()` function using specific bits,
     +    and setting the unused bits has no effect. Therefore, we can simplify
     +    the code by using `~0` (or in this instance, `~<unwanted-bit>`).
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## diff.c ##

-- 
gitgitgadget
