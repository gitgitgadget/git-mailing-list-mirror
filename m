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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD9C4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B413960E74
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhHDXvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhHDXvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848AAC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:50:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m19so2189681wms.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NijDzt4f0jF9U0jcfhKtEhBqAIWia7cMpGi5JZ96Rk0=;
        b=rIM5GR4uu8zclvJNssp6S0uM4Us4bDkcmHGPzYf6H1J2NGJKsSBf3Fipf97uU5BwZa
         JE2NRvEgS5JXoVO5pAd69DL65Y4S2ne0fcdVti18CnbyNK0SfxIZ75q/OWAvvDr/4Edm
         XHTYktpyhxGs7H8gX9k+kZAZBTgBytMVIXBhe3c/89GJvGoYvQrfN0CC8C9H1DIex4EC
         cn7ScvKaX6tPMd7fWeTITYjgndXucBAQDI5ktq8M6B074s1J/af2U/6/kMKHVUUDUpwT
         Efa7B3tFBBpfaslhIMibi9gDhdnruQ0bumd6+t86D/AFqBrtbFhm9rs9JETNErTyS8Tw
         7r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NijDzt4f0jF9U0jcfhKtEhBqAIWia7cMpGi5JZ96Rk0=;
        b=QRXZf17hXDVeoQalAa8U3YboPjLWykngq44LzfYEggLF0Ix9VgxLYCiNDActbd4lou
         4t0LBMKCdI7Ax3Bay9qT99urTlZTpBlGDBzzDG+nbVi3prHDN3FeOuCtnN8zuVysAUm2
         5iIKvX01YVDubOmv8bt7flePzlJ8gqGMPbtdB5tfqLbM/VPZIk4aPLKQ3QjgCrzn2LTz
         hXAbvrVFy/dCvHXxSIvFZ5kxaB99dVN1MPPWiyI7ZKiCvVzL4/hEkhsQu5d9SSVijLNs
         ko56cDVLlmbntwT0X8xPZMdERW8JfOjgMgH+k88tiZoYg+btbPrVCfvGq5sPB72xUU89
         /8nA==
X-Gm-Message-State: AOAM531bHJi895MdJ8q4wVvKStHDXtH8371aslV/2/qx2BcXsDZKngxQ
        TCYxQSQlRJXGH2gtucXj5DeJomjtAFo=
X-Google-Smtp-Source: ABdhPJwNKNENQx59qs9MsibW8RgABdM+25RsKX7keUU51QHTzJSqpACSmAPBxS6gyqWd29Ae8PNnvQ==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr1747639wma.111.1628121056110;
        Wed, 04 Aug 2021 16:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r133sm8827805wma.18.2021.08.04.16.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:55 -0700 (PDT)
Message-Id: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:44 +0000
Subject: [PATCH v3 00/10] Documentation updates: merge-strategies
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed while updating my switch-default-merge-strategy-to-ort submission,
that many of the changes were good documentation updates that we might want
for Git v2.33.0. So I pulled those changes out and split them into lots of
little commits so that if any parts need discussion or are objectionable, we
can just drop those from this series and apply the rest for v2.33.0.

The first 9 commits are just small documentation updates, but there is one
commit at the end that updates an error message and a code comment.

Changes since v1:

 * Multiple tweaks suggested by Eric, Dscho, and Junio
 * Removed patch 7 explaining no-renames since that probably belongs in git
   diff --no-renames instead, and this series is about merge-strategies.
 * Inserted a new patch 8 that strikes some misleading or at least
   no-longer-important text from git-rebase.txt (due changes back in late
   2006).

Changes since v2:

 * Removed sentence from commit message of patch 8 referring to a change in
   v1 that was since removed.
 * Added Stolee's and Dscho's Acked-bys.

Elijah Newren (10):
  git-rebase.txt: correct antiquated claims about --rebase-merges
  directory-rename-detection.txt: small updates due to merge-ort
    optimizations
  Documentation: edit awkward references to `git merge-recursive`
  merge-strategies.txt: update wording for the resolve strategy
  merge-strategies.txt: do not imply using copy detection is desired
  merge-strategies.txt: avoid giving special preference to patience
    algorithm
  merge-strategies.txt: fix simple capitalization error
  git-rebase.txt: correct out-of-date and misleading text about renames
  merge-strategies.txt: add coverage of the `ort` merge strategy
  Update error message and code comment

 Documentation/git-rebase.txt                  | 27 ++++++-----
 Documentation/merge-options.txt               |  4 +-
 Documentation/merge-strategies.txt            | 48 +++++++++++--------
 .../technical/directory-rename-detection.txt  | 14 +++---
 builtin/merge.c                               |  2 +-
 sequencer.c                                   |  2 +-
 6 files changed, 55 insertions(+), 42 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1059%2Fnewren%2Fort-doc-updates-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1059/newren/ort-doc-updates-v3
Pull-Request: https://github.com/git/git/pull/1059

Range-diff vs v2:

  1:  34352397168 !  1:  75b81598a80 git-rebase.txt: correct antiquated claims about --rebase-merges
     @@ Commit message
          was not updated.  Update it now.
      
          Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-rebase.txt ##
  2:  3fdd068231a !  2:  69fa233483c directory-rename-detection.txt: small updates due to merge-ort optimizations
     @@ Commit message
          directory-rename-detection.txt had claims that all of that logic was
          found in merge-recursive.  Update the documentation.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/technical/directory-rename-detection.txt ##
  3:  2a38320c2be !  3:  48f72d7e028 Documentation: edit awkward references to `git merge-recursive`
     @@ Commit message
          when rebase was a shell script, but it seems like a rather indirect way
          to refer to the `recursive` strategy.  Simplify the references.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-rebase.txt ##
  4:  e422a1bc7d4 !  4:  81a3092b9b0 merge-strategies.txt: update wording for the resolve strategy
     @@ Commit message
          the same is not true of other strategies.  Rather than adding this text
          to all the strategies, just remove it from this one.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/merge-strategies.txt ##
  5:  b1db5fdebe5 !  5:  1d144757a2e merge-strategies.txt: do not imply using copy detection is desired
     @@ Commit message
          anything else that would make sense either.  Change the wording to
          simply state that we ignore any copies.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/merge-strategies.txt ##
  6:  44101062e0e !  6:  a8381a89065 merge-strategies.txt: avoid giving special preference to patience algorithm
     @@ Commit message
          important than other diff algorithms, so just refer to it as a
          deprecated shorthand for `diff-algorithm=patience`.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/merge-strategies.txt ##
  7:  d1521f98dee !  7:  2c82aacbcbd merge-strategies.txt: fix simple capitalization error
     @@ Metadata
       ## Commit message ##
          merge-strategies.txt: fix simple capitalization error
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-rebase.txt ##
  8:  8978132397e !  8:  032dcf7c18e git-rebase.txt: correct out-of-date and misleading text about renames
     @@ Commit message
          backend).  However, git-am -3 gained that same ability in commit
          579c9bb198 ("Use merge-recursive in git-am -3.", 2006-12-28).  As such,
          the comment about being able to detect renames is not particularly
     -    noteworthy.  Remove it.  While tweaking this description, add a quick
     -    comment about when --merge became the default.
     +    noteworthy.  Remove it.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-rebase.txt ##
  9:  bc92826f7e5 !  9:  9ae77dbc291 merge-strategies.txt: add coverage of the `ort` merge strategy
     @@ Metadata
       ## Commit message ##
          merge-strategies.txt: add coverage of the `ort` merge strategy
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/merge-strategies.txt ##
 10:  4a78ac53424 ! 10:  0b881131b2b Update error message and code comment
     @@ Commit message
          but which were also applicable to 'merge-ort'.  Update them to more
          general wording.
      
     +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/merge.c ##

-- 
gitgitgadget
