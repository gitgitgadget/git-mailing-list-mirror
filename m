Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC41ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiIEOef (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiIEOe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 10:34:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC619B8E
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 07:34:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bp20so11154892wrb.9
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=sIbrxNB+hQ8ofZXzSvxKBttqv2RUbck0nYm2EQcrhoU=;
        b=jmsBnUj1xOpevUNh+X482KpOEavRJjL/QdcAQ5/Vgp4Oai3TuLoOGDYW/4jOFeqsLB
         e6UNHOnosah8mKqLIJnbNjXIb/8UR96g91HfPE/DO/TSEFKWyGYpDe4Ox6dXDAfjXe9k
         ytY+sVZF46KY02yL5Iffrx25GUcdG3WT5qWLbNq4Xi/tKGyEw6Xr+En7Svv3GCGZ1+D0
         xWDD9WmgJ3tRy7LZwsoYLsqRQ+Uaw1byzBFnLKqJRhYlPena1JMRkAGODKNTb1caXNjX
         CImsY5DJdDk+Z9+ju3g0LSikDAKoxf11bcUNKrEP3Oq9Udwd41YKxYewEGDKKf8LHjL0
         6oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=sIbrxNB+hQ8ofZXzSvxKBttqv2RUbck0nYm2EQcrhoU=;
        b=NWGMi/6bGdbKXZbk5i0TpiB4i8Ke1rnmJg3nNCahwBYg/VMYHgu+JMTbknsOjS1FKg
         kRtKvRGASTSf0wtU/oVlN5idDcne7xAPK4MS3gSm878X+z/CfHRvCOfAexrOGtrLyXJF
         JOO3jeDh89qhFhBfirg17TNJ1E1Cua4CcHzN8TONYL5cEUsnmXP7gvqqLObnOdqvW+cl
         sRP8YY1C/Yy4k7rxi1uZKpXXSx9+1j3GiyH6iyRVsJhsazki3djutGhKdiafTbye0uxc
         hflCaXT+JLQMzCLCMPFOOVWGkJeT8gRE1Y4yUl34R6EFQtiv4n0+9n8+5B/u55boMBRm
         2pMQ==
X-Gm-Message-State: ACgBeo3Dnhtm1lf5ttVXZ3JeyV22CMJzadtkgmKUoKbsy9cCecfQN9BD
        EidBbgGxcFtH46CazVj/LCb9GlKTwIU=
X-Google-Smtp-Source: AA6agR46+evSWsqySgHi5/8r5iYM7hCHgX8fHgwuT2y92lC2gZb3YGbFLaL7AIFthJe1lst4HGExCg==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr25509221wrz.371.1662388461037;
        Mon, 05 Sep 2022 07:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6-20020adff586000000b00228c375d81bsm1812379wro.2.2022.09.05.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:34:20 -0700 (PDT)
Message-Id: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Rub=C3=A9n?= Justo via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 05 Sep 2022 14:34:18 +0000
Subject: [PATCH 0/2] branch: support for at-refs like @{-1} in --edit-description,
 --set-upstream-to and --unset-upstream
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch command with --edit-description, --set-upstream-to and
--unset-upstream options expects a branch name. A branch can be specified
using at-refs like @{-1}, so those references need to be resolved.

We can modify the description of the previously checked out branch with:

$ git branch --edit--description @{-1}

We can modify the upstream of the previously checked out branch with:

$ git branch --set-upstream-to upstream @{-1} $ git branch --unset-upstream
@{-1}

Rubén Justo (2):
  branch: refactor edit_description command switch case
  branch: support for at-refs like @{-1}

 builtin/branch.c                      | 49 +++++++++++++++++++--------
 t/t3204-branch-name-interpretation.sh | 36 ++++++++++++++++++++
 2 files changed, 70 insertions(+), 15 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1346%2Frjusto%2Fbranch-support-at-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1346/rjusto/branch-support-at-refs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1346
-- 
gitgitgadget
