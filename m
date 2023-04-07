Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0536C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 13:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbjDGN5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjDGN4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 09:56:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27825B76D
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 06:56:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so21640780wms.5
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680875761;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7vsjyyN2BWSmmBvlUTXLSy5o3ilOZIxwgRDe6PnfOg=;
        b=Yzi/y1wanaeX8yBcUYqiKyd5wjL8X9wBk3MHz/uICTBB9YgktxAa67MLugidDArOyR
         qfijEQ6UWCI4sSWfVtfsHnUtUwPSMKKIWH7NMJn/bHvGR+SIBB3LiTygbuMc4jw188tl
         mPLmsvsGFE37ZlzrEqObFgY1YW6pPX2K26OF2g6otgCBAkUQ4Dtjccr0UZTjM1+WjHwz
         efKFEU3GIXbD9iTnBAqVgkjJ6o7EIsUPX6c+GkJt77EC/+UOTgsy03TRCDHGgdZ27hPh
         TKk8XiJ+ucr+dFMyP7xcGAqAZ1J0YO/VogQ807CBYMAMTRIK6wf459RKg2jNXkp3CUNG
         qR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875761;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7vsjyyN2BWSmmBvlUTXLSy5o3ilOZIxwgRDe6PnfOg=;
        b=AMMUE18rq893KPMLMxFD+i6O2sXUTV+Y8q4XR5xKdKpqhOoSBgcsWSiRaLUIC5zRFH
         JJsjp1e5wzUk5mo1SSqaRNfLFiI5EAv2YrWZSX5drN9ayluwOGGvDUWQq8ebpkrTr6Wu
         KNOX7W0i6R5xNawkLptnbeGvsHqyKffQX/i6L4JGTmAfCJZYejacmkkmUWkwMiu0X+KH
         0bAa/tAg+7j1m+IJ5hNKxRBSNB/orLAJzF0qUwmJBONGdhHwnBmSy0t9WjeEZIzpgDQ/
         77bzirqyRz0lsc9ZFN7p0KZNwXyhLrFZuurfCJYAx3U5f11UjAWTqfCQo6MgUHIrqtYT
         cJCw==
X-Gm-Message-State: AAQBX9d4+YgU/tBN12LLH90CTLXVt8xe4BmsgJFpOYDOGtVMI4EwBJDA
        OFxOQqW/p5M7MsbKNl2awyUlLqeCafo=
X-Google-Smtp-Source: AKy350YllIWwkU0TNGQAIaYq32KrwL8KuJCCf9z/XhdDvb7ePqDcXUoihGxEdx3MXMkTr+1nVQiaJA==
X-Received: by 2002:a1c:790c:0:b0:3ed:2352:eebd with SMTP id l12-20020a1c790c000000b003ed2352eebdmr1475067wme.11.1680875761335;
        Fri, 07 Apr 2023 06:56:01 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm4742003wmc.4.2023.04.07.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:56:00 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 0/5] rebase: cleanup merge strategy option handling
Date:   Fri,  7 Apr 2023 14:55:30 +0100
Message-Id: <cover.1680875701.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Cleanup the handling of --strategy-option now that we no longer need to
support "--preserve-merges" and properly quote the argument when saving
it to disc.

Thanks to Elijah for his comments.

Changes since V2:

 - Added Elijah's Reviewed-by: trailer.
 - Fixed a typo in patch 4 spotted by Elijah.

Changes since V1:

I've rebased these patches onto 'master' to avoid conflicts with
'sg/parse-options-h-initializers' in the new patch 2 (this series
depends on 'ab/fix-strategy-opts-parsing' but that has now been merged
to master).

Patch 1 - Unchanged.

Patch 2 - New patch to store the merge strategy options in an "struct
          strvec". This patch also introduces a new macro OPT_STRVEC()
          to collect options into an "struct strvec".

Patch 3 - Small simplification due to the changes in patch 2.

Patch 4 - Moved the code to quote a list so it can split by
          split_cmdline() into a new function quote_cmdline() as
	  suggested by Elijah.

Patch 5 - Reworded the commit message as suggested by Elijah.


Base-Commit: 140b9478dad5d19543c1cb4fd293ccec228f1240
Published-As: https://github.com/phillipwood/git/releases/tag/sequencer-merge-strategy-options%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/140b9478d...2d1d32811
Fetch-It-Via: git fetch https://github.com/phillipwood/git sequencer-merge-strategy-options/v3

Phillip Wood (5):
  rebase: stop reading and writing unnecessary strategy state
  sequencer: use struct strvec to store merge strategy options
  rebase -m: cleanup --strategy-option handling
  rebase -m: fix serialization of strategy options
  rebase: remove a couple of redundant strategy tests

 alias.c                        | 18 +++++++
 alias.h                        |  3 ++
 builtin/rebase.c               | 54 ++++-----------------
 builtin/revert.c               | 20 ++------
 parse-options-cb.c             | 16 +++++++
 parse-options.h                | 10 ++++
 sequencer.c                    | 57 ++++++++++------------
 sequencer.h                    | 12 +++--
 t/t3402-rebase-merge.sh        | 21 --------
 t/t3418-rebase-continue.sh     | 88 +++++++++++++---------------------
 t/t3436-rebase-more-options.sh | 18 -------
 11 files changed, 126 insertions(+), 191 deletions(-)

Range-diff against v2:
1:  2353c753f5 ! 1:  882b403423 rebase: stop reading and writing unnecessary strategy state
    @@ Commit message
         writing of state files between builtin/rebase.c and sequencer.c but that
         is left for a follow up series.
     
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/rebase.c ##
2:  dd7b82cdd5 ! 2:  1d8e59aa16 sequencer: use struct strvec to store merge strategy options
    @@ Commit message
         revert" as passing “--no-strategy-option” will now clear any previous
         strategy options whereas before this change it did nothing.
     
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/revert.c ##
3:  ccef0e6f4b ! 3:  e98ef5ce8c rebase -m: cleanup --strategy-option handling
    @@ Commit message
         mixed blessing but the next commit will fix the root cause of the
         parsing problem so lets not worry about that here.
     
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/rebase.c ##
4:  9a90212ef2 ! 4:  a5e940e2d0 rebase -m: fix serialization of strategy options
    @@ Commit message
         they are stored as that was an artifact of the scripted rebase.
     
         These changes are backwards compatible so the files written by an older
    -    version of git can be still be read. They are also forwards compatible,
    +    version of git can still be read. They are also forwards compatible,
         the file can still be parsed by recent versions of git as they treat the
         "--" prefix as optional.
     
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## alias.c ##
5:  3515c31b40 ! 5:  2d1d328110 rebase: remove a couple of redundant strategy tests
    @@ Commit message
         preceding test.
     
         Helped-by: Elijah Newren <newren@gmail.com>
    +    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## t/t3402-rebase-merge.sh ##
-- 
2.40.0.670.g64ef305212.dirty

