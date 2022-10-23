Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4BEC433FE
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 01:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJWB2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 21:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJWB2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 21:28:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898CC7E326
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:28:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w18so10410490wro.7
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DNRB3Kmx0b7oyqPrpogYF0KooHh5uRD4gSJwmQpa1Gs=;
        b=qWvH1Lq9HCaEfpkOW+Mc3zosxDhQDgCP0DV7w68U0GJL1qPp6ZxkCVifYl/xCHFWRn
         tVFFEL+3YR07EkEkaam6gCPInk//R58k4fwwp9Ddw144sx5G/D7iiVCIVN+iJCDMQo62
         62FsIhZHk0MiXkoWB4oxIb/utPh8Ecq+iLunTdzcB0VU3FJxDC9syoPX2FyM5FwIOMPw
         mgPZIOdT8F0hQ89ZdEoCC1w99KWBpCT2GlJor7cPg6Zc4AVPCAqr0KAoiBQxJarIqASU
         y5xvizSvShndoWq0pIdcs4rMxuwOITvGFuuhwNix/5oQxnAAnMqYFoHmd9paPSCOVc72
         wtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNRB3Kmx0b7oyqPrpogYF0KooHh5uRD4gSJwmQpa1Gs=;
        b=FHa9jgFKvr2NibvAYV/hcRMPgjqECybCpOmoGd6E/yZ4Zy1eZiZauVknntjLeV3bad
         +LcasTFv94sJmS/qsSfcIUNkTjh2OQSKn+kAh4iM6gBPGLyFAnb9lrZvjv+rQbnv6JmI
         a/KeB6AtlNj9AKfkUlX38T2Y93K9fjF20aViobIjgp2zU/zzULT5oQDJ6dIJi3Mlulhq
         lct9JgRlCLp3HK90J+350h8hbLIiD0X60IYeh5UJFpo45zkLdCVbE6Jh4b6kqC91mwsh
         xQebNcviaH23qA8gjvfV8OY3PTweki0GWC1eLAz+Kn3+msVAiJNFFKE3OeJz+peG2nak
         qDCA==
X-Gm-Message-State: ACrzQf0HLFC4EOWwsU0+8RsmoOvRs66uXapMWpp9rRSbnA77g2ihLB4d
        PH9mec/YrxRp+WBDRjvkvHAxrjeYXY8=
X-Google-Smtp-Source: AMsMyM5X6x/v/NsnyAgo8wWhNy1xud4+VVzPW8psfI2ysabRqarJMMpn/KGYcga5l1pU5zR6D6uiAw==
X-Received: by 2002:adf:dbc7:0:b0:236:4edb:d7c5 with SMTP id e7-20020adfdbc7000000b002364edbd7c5mr8293635wrj.197.1666488486747;
        Sat, 22 Oct 2022 18:28:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c502000b003c6d0f8c377sm7504596wmr.7.2022.10.22.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 18:28:06 -0700 (PDT)
Message-Id: <pull.1361.git.1666488485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 Oct 2022 01:28:03 +0000
Subject: [PATCH 0/2] merge-tree: batched merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a branch is updated, a Git hosting provider may want to check all open
code reviews targetting the given branch to determine if those code reviews
can still merge cleanly into the target branch. Provide a new --stdin option
to git-merge-tree to enable this capability, with each line of input
providing the branches for the next merge.

Note: this still requires all the merges to be in the same repository. There
is some code I noticed a while back in merge-ort that implicitly uses
the_repository (indirectly), and there may be more uses that I am unaware
of.

Elijah Newren (2):
  merge-tree: update documentation for differences in -z output
  merge-tree: support multiple batched merges with --stdin

 Documentation/git-merge-tree.txt | 76 ++++++++++++++++++++++++++++----
 builtin/merge-tree.c             | 42 ++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 41 +++++++++++++++++
 3 files changed, 148 insertions(+), 11 deletions(-)


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1361%2Fnewren%2Fbatched-merges-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1361/newren/batched-merges-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1361
-- 
gitgitgadget
