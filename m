Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C19C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbiFJA0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiFJA02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA55952B34
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i64-20020a1c3b43000000b0039c6fd897b4so43866wma.4
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=R9+JUVg51xhNlgrCzvt2l0f6p4VRz4GDXiB9bSmtSAM=;
        b=WS/t3PbRNcMPc+3kgIetj/A4jr54AmFy89iPfhNc+6CHitRx/4W6KDE/PsQpaK5ajP
         BVxqtP9X+B0wjFI3pirPCyfbSmCpJ0AWGdHKqhBLrOv3L8H8OZutQSYZ+FM7Hhz8TwW0
         gMUMOvAyEFR77Ghi13UQ3NBPot5i79oIzZ+nAGdn+0NENjTY3nckEHX63e9x7UF6qKIR
         uw8EKk7gC59ns3Q16Xlx++h4rWhZYdHtGSUVxCOpKbd8rhOzKIAsooN/tQ9xAOcfKcnD
         dc91v1YaGars4o4sbcB4tNtJkTBVUdrf2egOBdv1Es7+nBocsjoiHDnhgW3T01mciSps
         cQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R9+JUVg51xhNlgrCzvt2l0f6p4VRz4GDXiB9bSmtSAM=;
        b=1rvUWVT1qFJTfDgkLCXHsmg6NMHWTS2pfhLSHh2dmOnPLD7TX5bTKl8eHoA3oS8LWD
         X/JIGImBc2uhwRGhwC6xrxTnzvgi6Yds34Vzy/OA82b6rkJuRsIFrr57Frt37eVogZWH
         qGJJ0cu+mOyn3ZARYttN2bXm63ebbfSLTrjsvjKwId5qx+QwNuXe0Zy2ChPcFbQDsu1R
         A4mFwcMqLsdETkvYdzNS+rj3QZDQn2KK9PIrBvfC9c1FS7p7LfC9EsT5d/rB/0uVLEdl
         JW5JmpbrMM/+Q49Atyxoc+kpR2xJwUwOzfrIy9jbjEai3PfpuQiUAbW0lnu//hapnCeW
         RF5A==
X-Gm-Message-State: AOAM533+Iuz368xEu8VvQNpfT7mXYET7jPr3aI7G+e5dcr2kfopmV8hz
        qlsW+HHWhHPU3BTKGbjfDjreJ1I1s0/A7xMU
X-Google-Smtp-Source: ABdhPJyDKw0AzY7mKIi3zS6rVKuhTQ74ayWC3cW4+BNRUc11TU1cD9F/hTw6eLvirT9VvGJetG6eBw==
X-Received: by 2002:a1c:4c13:0:b0:39c:5a6b:8540 with SMTP id z19-20020a1c4c13000000b0039c5a6b8540mr5731843wmf.106.1654820782655;
        Thu, 09 Jun 2022 17:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b0039c5645c60fsm5653613wms.3.2022.06.09.17.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:21 -0700 (PDT)
Message-Id: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:13 +0000
Subject: [PATCH 0/8] [RFC] submodule update: parse all options in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow up to ar/submodule-update [1] and its successors
gc/submodule-update-part* [2] [3], this series converts the last remaining
piece of "git submodule update" into C, namely, the option parsing in
git-submodule.sh.

As a result, git-submodule.sh::cmd_update() is now an (almost) one-liner:

cmd_update() { git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update
${wt_prefix:+--prefix "$wt_prefix"}
"$@" }

and best of all, "git submodule update" now shows a usage string for its own
subcommand instead of a giant usage string for all of "git submodule" :)

Given how many options "git submodule update" accepts, this series takes a
gradual approach:

 1. Create a variable opts, which holds the literal options we want to pass
    to "git submodule--helper update". Then, for each option...
 2. If "git submodule--helper update" already understands the string option,
    append it to opts and remove any special handling (1-3/8).
 3. Otherwise, if the option makes sense, teach "git submodule--helper
    update" to understand the option. Goto 2. (4-5/8).
 4. Otherwise, if the option makes no sense, drop it (6/8).
 5. When we've processed all options, delete all the option parsing code
    (7/8) and clean up (8/8).

I read over the other "git submodule" subcommands very briefly to see how
much work this would be if we were to repeat the process for all
subcommands. It should be relatively simple - most "git submodule--helper"
commands already understand every CLI option that they need to, so we can
skip step 3 (i.e. the tedious one).

I'm sending this as an RFC because even though this series is pretty
low-risk, the previous topics [1] [2] [3] had their fair share of
regressions (even when the conversions seemed 'obviously correct') and
showed that the test coverage of "git submodule "update" is quite poor. I'd
like to get feedback on the general approach before I invest more time into
improving the test coverage and/or checking the before/after output for
regressions [4].

[1] https://lore.kernel.org/git/20210907115932.36068-1-raykar.ath@gmail.com/
[2] Part 1
https://lore.kernel.org/git/20220305001401.20888-1-chooglen@google.com/ [3]
Part 2
https://lore.kernel.org/git/20220315210925.79289-1-chooglen@google.com/ [4]
Ævar suggested a way to do this using the test suite and "--tee" in
https://lore.kernel.org/git/220214.86h791xsza.gmgdl@evledraar.gmail.com/

Glen Choo (8):
  submodule update: remove intermediate parsing
  submodule update: pass options containing "[no-]"
  submodule update: pass options with stuck forms
  submodule update: pass --require-init and --init
  submodule--helper update: use one param per type
  submodule update: remove -v, pass --quiet
  submodule update: stop parsing options in .sh
  submodule update: remove never-used expansion

 builtin/submodule--helper.c |  41 +++++++----
 git-submodule.sh            | 131 ------------------------------------
 t/t7406-submodule-update.sh |   2 +-
 3 files changed, 29 insertions(+), 145 deletions(-)


base-commit: 1e59178e3f65880188caedb965e70db5ceeb2d64
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1275%2Fchooglen%2Fsubmodule%2Fparse-update-opts-in-c-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1275/chooglen/submodule/parse-update-opts-in-c-v1
Pull-Request: https://github.com/git/git/pull/1275
-- 
gitgitgadget
