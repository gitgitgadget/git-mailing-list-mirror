Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257FBC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjEJWz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjEJWzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:55:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D843A8E
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30639daee76so5131016f8f.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683759340; x=1686351340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=30h8G0vNWauFVPuLQLLMaK97qwMQu01Wv6dQYCKTAaM=;
        b=bzYv0f5I8nUXQ+CZTMEKHYkBU9RWAOXXsG4arPuaaii9Vjey7SRy8G8DEsfo2Eb8ty
         5jB/DlQKdqq1iaE8DBPrv0Vb32enWmN8+J69PBG02O003BBMI5SbSpEovrAV5GF3HCn/
         xtKBlon0fEtnbFJkQlsgju9+yJ9ZCDzANmx0eaURB8Np4BL38oNE1wYzMxjq3DbiOc6a
         JQBQlBnfesaJ6llZaslTcDpqRhGy4Ng7pMl45ZaEgyCTiFDsTscKo+lEXjG+6ykokY6g
         MjdXXunC+uBQFhuzcoKRlUkVe9dUJKXY6NTHMsf+2Nndic+cCAnQq0MjzW+hYHNrHrC6
         reZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759340; x=1686351340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30h8G0vNWauFVPuLQLLMaK97qwMQu01Wv6dQYCKTAaM=;
        b=abazeLYlU89koaYQLT2rM43DKjs9mhTQ+fWNLWC2ajO9q4QIFxf1K9sMt1O3R0Jjfc
         8ZChcNZc6lzwYQxWqdwgDi/4WdrrY/rBFRaAqHi8QJZ8m6n1u+yWeqxp42BxMR3K1Bh3
         rSr4RRVXSAKZHEh8P4ElzqRhF5mkaxYgpXQQF+HU53Z1D6LDkiNXQt80481He9IusH5a
         qULn9razzsHsGeeYIyiE10YdnP/phfcTinsd9QU3JQoV4jVrbg8R9tVEGCi9e3GAhzEQ
         3Is9d/ZJZ7D/2ktSyxLvYgtbZl1puyXW+78vKrPJmKAV4iu1vDLf5AQVNl5wlRniWfZ7
         qn3Q==
X-Gm-Message-State: AC+VfDz49uK1E4GzpuFDcd3/ANYu5AS54Zauz4eusov3UlmyP7vhiCwP
        d0/rkbwttYN1DeSFtlQyvJBneixPhe0=
X-Google-Smtp-Source: ACHHUZ7c+2sSP8EbK7sypxtdh8AbdropUCGoxRcJ/oh3fJIWrlRqGLr3UzxWMxLgUIw3hs92+5PVjw==
X-Received: by 2002:adf:f291:0:b0:306:3bf0:f1ec with SMTP id k17-20020adff291000000b003063bf0f1ecmr14088076wro.7.1683759339926;
        Wed, 10 May 2023 15:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11-20020adfeecb000000b003048477729asm18447755wrp.81.2023.05.10.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:55:39 -0700 (PDT)
Message-Id: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 22:55:36 +0000
Subject: [PATCH 0/2] Fix two rebase bugs related to total_nr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently picked up work where I regularly rebase large branch thickets
consisting of thousands of commits. During those rebases, I could not fail
to notice that the progress initially showed a total number around 2,100,
when the actual number of commands was more like 1,850. And indeed, when
resuming the rebase after being interrupted due to a break command or due to
a merge conflict, the progress showed the correct number!

So I set out to fix this, stumbling over an incorrect use of total_nr in the
--update-refs code, so I fixed that, too.

Note: These patches apply cleanly on top of ds/rebase-update-ref as well as
on top of the current main branch.

Johannes Schindelin (2):
  rebase --update-refs: fix loops
  rebase -r: fix the total number shown in the progress

 sequencer.c              | 16 ++++++++++------
 t/t3430-rebase-merges.sh |  7 +++++++
 2 files changed, 17 insertions(+), 6 deletions(-)


base-commit: 4611884ea883908a9638cafbd824c401c41cf7f6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1531%2Fdscho%2Ffix-rebase-i-progress-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1531/dscho/fix-rebase-i-progress-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1531
-- 
gitgitgadget
