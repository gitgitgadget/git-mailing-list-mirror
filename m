Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDDFC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BC2610A1
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbhIBQCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346051AbhIBQCW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C67C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t15so3759106wrg.7
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05eAGoYOl9+EJnQbfOXhTdWd87c0Zp8VLh714ifhWVg=;
        b=InKudz6J5/1PpyFR+EnWN80NqzTSzbibTAhvxFVok9QdcqNmTENXz1DcYcH3T/QWzX
         QOrV0WAOj7QYDtQqlDivwyEib7LVBhgUHnaJoT48rxkRrjbNk3L2amdTZ677jHBz4aKV
         aOwNc11/vrRYWZZC5bzu85f5N6GRdKqjRJyiB7Yabq5kG31uPwDn1j66H90xR8870LVU
         Nmk9Cywyf3r9iQiYfAQLoqUyZ+YR13/v7MbpSybyj8YXjO2hkZBePKabvFQhI8O2DUv+
         G/mGBBo11jUqn7XIe3TXiY89UX26NOfYTNAla1LK/62MldageR9HcyKr5u3c9C4tfBZg
         1T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05eAGoYOl9+EJnQbfOXhTdWd87c0Zp8VLh714ifhWVg=;
        b=TTWd3JZeNE1NEPfys4cXvBptIgnSGtNuKZfoyDUeUXccoyshaKZQqubyhj4nT7euQX
         dVVvqsrgvhVojSveVgseXzdZv1BOMzkwsamDGN5iTJ7Tz9jBgvN8D5dchKddgCp5qJzh
         B6PL0VFK3Q7VMvy5mwrZSUVitVKa+IpMB1MWKq0s9jhMFkRl0wDd+Ohv5a/K5nFXajZa
         oyIwyRd4RtsexPiZx+nY9JsKRxxArk1kTT/Uwd8Er1iZCy+jy/1ETwCUNkJz1qyOHo8Q
         qU/hu1LrBOmVsoQ1DnBmPv9aniQfaCwee4jTO9jGx/VRMfSrApwMXJHjlp2/Vqt9G1wV
         OjEg==
X-Gm-Message-State: AOAM530nyoBuOaWlvKo4235JnNxm/wrdwxhjWHfYxCOPAiJ1Nrhc14Ds
        F64guBTBh9YfCoeuOa1IJr5ozics+PUNZA==
X-Google-Smtp-Source: ABdhPJwnvyx+HLIPHHriXr0lvOzVhrHABIEDl0BGQ88W5lH1Y32lvcmh/wJvgqwxLJzNgt3v4LmNrQ==
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr3285971wrx.276.1630598481977;
        Thu, 02 Sep 2021 09:01:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/9] remove dead shell code
Date:   Thu,  2 Sep 2021 18:01:07 +0200
Message-Id: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove dead shell code in git-sh-setup, inspired by parallel
discussion on another topic (but the two don't conflict):
https://lore.kernel.org/git/87lf4f9gre.fsf@evledraar.gmail.com/

The last two patches were picked from a dropped series of mine
submitted earlier this year, it was dropped because of other more
complex patches that I haven't included here:
https://lore.kernel.org/git/20210311001447.28254-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  git-sh-setup: remove unused set_reflog_action() function
  git-sh-setup: remove unused git_editor() function
  git-sh-setup: remove unused git_pager() function
  git-sh-setup: remove unused sane_egrep() function
  git-sh-setup: remove unused require_work_tree_exists() function
  git-sh-setup: move create_virtual_base() to mergetools/p4merge
  git-sh-setup: move peel_committish() function to git-subtree.sh
  git-bisect: remove unused SHA-1 $x40 shell variable
  test-lib: remove unused $_x40 and $_z40 variables

 Documentation/git-sh-setup.txt |  24 --------
 Documentation/git.txt          |   4 --
 contrib/subtree/git-subtree.sh |  12 ++++
 git-bisect.sh                  |   2 -
 git-sh-setup.sh                | 103 ---------------------------------
 git-submodule.sh               |   5 --
 mergetools/p4merge             |  12 ++++
 t/t7006-pager.sh               |  13 -----
 t/test-lib.sh                  |   6 +-
 9 files changed, 26 insertions(+), 155 deletions(-)

-- 
2.33.0.814.gb82868f05f3

