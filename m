Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D8C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E868961377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGOCnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOCnp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:43:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2EC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so5683298wrq.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mtufaugh7m+/p9cvqVM0o/7MiWtP8oR0QK5W3YwVa60=;
        b=FeRtGeSk0FQ2gFd7k6AVGREWjpsOnNoemuSdBkJ++HqoA/PgEy8kjb0n5W23Xq1nmK
         +FJHRNM7JS1aR7FB2pzhPG2YGsNFs/LE09FVRqsdANjKbsWvPLc+iBY4F0/4+S00z54c
         5H56MHwCFfl64XPCYEWP71eKMV3FHRme/YXUbVXtTEYYdlzVZfLuhEO6oQ9CIQ0Rz+3j
         ecfeTJ+YOwEcOfbM4Azr5w+1kZLmVo6ckAsAc8ZyRCTmi42MjhM+JlITe2wXYbYKqVgl
         +i11hM9YkCmyoefjIFRKag22ChtFpwY9yPvHD6005FjwvZcgetBcJZPpX/4k/a3SqXIX
         +dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mtufaugh7m+/p9cvqVM0o/7MiWtP8oR0QK5W3YwVa60=;
        b=Sav96wOkQrcIeqjvd75jvuNcPmInu4mg/A6GykprGM0plLBIKUlBvWzv7jveK1d6kb
         WE/PCt8UZQDfR4pDiAzG37FK4ZFRUJirEPwCGawS03hi/davlIm9oFDHgC7G+xf39Oyd
         fRbAXtmnlQSR6LkLu/wSnw5WRYbge6IPmqaSsKuR1EBBGluEyTRDZHl8R8HNouqFW+Y0
         ijJYfyGe617yU0d7n2MVDOxiOVD/Fnw4R2LGXUxiUSbN/NalVdy8NDJRiOm7RC1sRFRD
         wGKrerCedxru0BJiEdg7G9KAlxGh+R2+waLsFt0Sfx/AtfyJVdY8aJYEHF0frWvYkP4u
         6kTw==
X-Gm-Message-State: AOAM532joIxckKIO4GkGrGctRadYtyUf+nGZlkfE3jVij3gs3NvzsA8x
        zfjPN66eGyhyfPvTko1jkPwDCxx2IGI=
X-Google-Smtp-Source: ABdhPJydJwFxqUMVYqaz8HZFTmriT0nnr/65gCLd+jK/0hamoV4oGPBoR+edICP0oCs+IhryXFSV7g==
X-Received: by 2002:adf:fe0d:: with SMTP id n13mr1737412wrr.73.1626316850825;
        Wed, 14 Jul 2021 19:40:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm4724663wrt.50.2021.07.14.19.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:40:50 -0700 (PDT)
Message-Id: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:40:44 +0000
Subject: [PATCH 0/5] Handle conflicting pull options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've recently discussed how to handle conflicting configuration and command
line options in git pull, including at least a few different
proposals[1][2][3] to handle different subsets of the possibilities. We also
have a user report from someone who had conflicting configuration and got
surprised when one of the options overruled the other -- with no warning
from the command or the documentation that such would happen. Here's my
attempt to impose clear and simple rules, which can be seen in the commit
message of the third patch.

(The first two patches are just preparatory changes to make patch 3 easier
to read.)

Since the handling of conflicting options was holding up two of Alex's
patches[4][5], I also include those two patches at the end of my series,
though I've made quite a few changes and additions to the latter of those.

Possible areas of concern:

 * Documentation/git-pull.txt includes merge-options.txt. While git-rebase
   supports many of those "merge" options, I suspect there are others that
   it does not support. We are probably silently ignoring those unsupported
   options whenever one of those is specified at the same time a rebase is
   requested; we should instead likely error out and report the
   incompatibility. I have not yet addressed that, as I was focused on the
   main rebase vs. merge incompatibility and default warning/error
   associated with it.

[1]
https://lore.kernel.org/git/00e246b1-c712-e6a5-5c27-89127d796098@gmail.com/
[2] https://lore.kernel.org/git/xmqq8s2b489p.fsf@gitster.g/ [3]
https://lore.kernel.org/git/CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com/
[4]
https://lore.kernel.org/git/20210711012604.947321-1-alexhenrie24@gmail.com/
[5]
https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

Alex Henrie (1):
  pull: abort if --ff-only is given and fast-forwarding is impossible

Elijah Newren (4):
  pull: move definitions of parse_config_rebase and parse_opt_rebase
  pull: convert OPT_PASSTHRU for fast-forward options to OPT_CALLBACK
  pull: handle conflicting rebase/merge options via last option wins
  pull: abort by default when fast-forwarding is not possible

 Documentation/config/pull.txt |   3 +-
 Documentation/git-pull.txt    |  19 +++--
 advice.c                      |   5 ++
 advice.h                      |   1 +
 builtin/merge.c               |   2 +-
 builtin/pull.c                | 144 ++++++++++++++++++++--------------
 t/t4013-diff-various.sh       |   2 +-
 t/t5520-pull.sh               |  20 ++---
 t/t5521-pull-options.sh       |   4 +-
 t/t5524-pull-msg.sh           |   4 +-
 t/t5553-set-upstream.sh       |  14 ++--
 t/t5604-clone-reference.sh    |   4 +-
 t/t6402-merge-rename.sh       |  18 ++---
 t/t6409-merge-subtree.sh      |   6 +-
 t/t6417-merge-ours-theirs.sh  |  10 +--
 t/t7601-merge-pull-config.sh  |  97 ++++++++++++++++++++++-
 t/t7603-merge-reduce-heads.sh |   2 +-
 17 files changed, 242 insertions(+), 113 deletions(-)


base-commit: 75ae10bc75336db031ee58d13c5037b929235912
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1047%2Fnewren%2Fhandle-conflicting-pull-options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1047/newren/handle-conflicting-pull-options-v1
Pull-Request: https://github.com/git/git/pull/1047
-- 
gitgitgadget
