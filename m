Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E823CC4332F
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FC26103B
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhIFHGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbhIFHG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF8C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d6so7580216wrc.11
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvxWsq9Ij75kesK3JfLrznYSk6YmzPbCIp/Gyy2mrSc=;
        b=CEvm6A87ed+qnsS7KD3aGQD7Ev/o56xQ+aYZprAO8Sb+ZqEJDbJO8ILwwkDXoNDnT1
         59RUu8L0zW4nNGyM8eimyyQjYQeyXJI+AgSmw0ToInd+S7HNUzEU7pxcFu44nB+opJFx
         t90dGNOvhLJT3nmSDBj9zcGKuqbX/TbpkyE3on0SL1hlkP27zDRQVFLx7m2QuheLCVC9
         9E44e47x8tK9IxEoItVru3c+IRGapWb4qkZIVXB5677PwmeS82lWil9/JYBmm+ej1Ieo
         AG5UGoCE8a4sS9tR5dr7ShYnCkZcugVEe6Yu/H9FWudh3YOgE6hXM+hPWGWm7Ho6Ky3r
         c2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvxWsq9Ij75kesK3JfLrznYSk6YmzPbCIp/Gyy2mrSc=;
        b=d4IK4DCuN2GdrrHLS5gbbHEBoK3mm92lyWvZKIMHQ338EEY24Btnz+HipGNDmm8Ahh
         7NLDtsOrqjY6POyTmrmLPhxCsh7fBCNQ6URcV0FrTgg5hHM2S525zbppGD1lOwxs1GJd
         1WGUp+/D5ilScMftLbaJ1agV0RYQG71Taya634J+X3AO5KC9QrdRP/FS0cwpyGYtlXge
         qQQ1uQhWB2w85xmjd4Meb2BQGoe9uza1EWpQHeV9UkMt7cWeOTh1EPpoG1d7ZbS7qSDO
         ATPZKTBVwa1XZDqCLmSDYphlrGFGAzmEMwZhSbZRGlkc+rTX7HCXHfl1V0ayaSVmcDWu
         Qh0w==
X-Gm-Message-State: AOAM533uf5uK8RP8APxPBcKLPxBkPpsVDtDu7wzzVkq76SQ6bAGF+FwW
        SbTJDEJSePBWaXmKM1ANuS3MdwX8imAk/g==
X-Google-Smtp-Source: ABdhPJwMed2r/V17ARlDc4cN2FqQ5ple8N2yZ5YXA2Y/yOH4yFBE7WRlkd8Q/nx7gYnpQ2jgkm0hng==
X-Received: by 2002:adf:c442:: with SMTP id a2mr11528875wrg.228.1630911921106;
        Mon, 06 Sep 2021 00:05:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] remove dead & undocumented shell code
Date:   Mon,  6 Sep 2021 09:05:11 +0200
Message-Id: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This re-roll should address all the comments on the v1, in particular
all of the changes that removed in-tree unused functions that are
documented in our manpages were ejected. This series is now only
removals of code that should always have been in-tree-only.

The minor change in 4/7 is new, and so is 5/7.

Ævar Arnfjörð Bjarmason (7):
  git-sh-setup: remove unused git_pager() function
  git-sh-setup: remove unused sane_egrep() function
  git-sh-setup: move peel_committish() function to git-subtree.sh
  git-sh-setup: clear_local_git_env() function to git-submodule.sh
  git-sh-setup: remove unused "pull with rebase" message
  git-bisect: remove unused SHA-1 $x40 shell variable
  test-lib: remove unused $_x40 and $_z40 variables

 contrib/subtree/git-subtree.sh | 12 +++++++++
 git-bisect.sh                  |  2 --
 git-sh-setup.sh                | 45 ----------------------------------
 git-submodule.sh               |  7 +-----
 t/t7006-pager.sh               | 13 ----------
 t/test-lib.sh                  |  6 ++---
 6 files changed, 15 insertions(+), 70 deletions(-)

Range-diff against v1:
 1:  2e3ed8061d5 <  -:  ----------- git-sh-setup: remove unused set_reflog_action() function
 2:  7d3ea928099 <  -:  ----------- git-sh-setup: remove unused git_editor() function
 3:  73e540896fc !  1:  8eb1dfbff5d git-sh-setup: remove unused git_pager() function
    @@ Metadata
      ## Commit message ##
         git-sh-setup: remove unused git_pager() function
     
    -    Remove the git_editor() function last referenced by non-test code code
    -    in 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
    +    Remove the git_pager() function last referenced by non-test code in
    +    49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
     
         We can also remove the test for this added in 995bc22d7f8 (pager: move
         pager-specific setup into the build, 2016-08-04), the test that
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-sh-setup.sh ##
    -@@ git-sh-setup.sh: $LONG_USAGE")"
    - 	esac
    - fi
    +@@ git-sh-setup.sh: git_editor() {
    + 	eval "$GIT_EDITOR" '"$@"'
    + }
      
     -git_pager() {
     -	if test -t 1
 4:  73f0676db7a =  2:  e7f3115797c git-sh-setup: remove unused sane_egrep() function
 5:  dc4dd7d1399 <  -:  ----------- git-sh-setup: remove unused require_work_tree_exists() function
 6:  d2d65f3d77f <  -:  ----------- git-sh-setup: move create_virtual_base() to mergetools/p4merge
 7:  a3047b93f7d =  3:  d92e880fcfa git-sh-setup: move peel_committish() function to git-subtree.sh
 -:  ----------- >  4:  46c018aa860 git-sh-setup: clear_local_git_env() function to git-submodule.sh
 -:  ----------- >  5:  45c1369e958 git-sh-setup: remove unused "pull with rebase" message
 8:  88dffac9088 =  6:  bcae7884bb0 git-bisect: remove unused SHA-1 $x40 shell variable
 9:  0fd1516af85 =  7:  479e94f22f4 test-lib: remove unused $_x40 and $_z40 variables
-- 
2.33.0.821.gfd4106eadbd

