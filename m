Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFAC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E1C61249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbhDLLJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbhDLLJa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30607C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j5so11512099wrn.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlKB3VxtzYmuiiHjO69SAL3E32A11KUd13b58J3ndHU=;
        b=dfdEat6L5/BMCP/CkDSvD3SaDv9Qgwvbx17R242X6JHX1XIVKSjc4UOQ7r1Dti1/v7
         xh0TqVfYwAAx14XH4Nzr23OGhCZgGLPFqswyQ/DJZI48C/TRlvpeWaXnMHRLK01gSf8K
         0y66mWE8Q8tpnyey3Fg9O33ie0O2OoqOS9cB83OQ164HoXTqgMcbGRRi146HGdf6otmd
         CfMaRygYgsTZZ0D0j2tZuv+FEGHZafxlcFJZa8o+jC0WA7vJBevi+bS55jXF4jGmAHeL
         rHRa6D3aEHNMw+ktAMezKBb38Yh6V8XOTUS9D9+plAXOpcxvLxg64T3lUc7F8BVn53lb
         Buxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tlKB3VxtzYmuiiHjO69SAL3E32A11KUd13b58J3ndHU=;
        b=MGFBX9hLx4PtaS9JLRfWQ6VloEZW/G1HvxXt0kwN/LAuUplBVhKpUbNcqSdHfQnMu/
         d4eavi93hbtuYJv8NIFafXpXm9EZ+9E99BpfAXGapvuT69s9OY9UY3rpFDQOKIg3p6Em
         p5QCTNCO8KF3Zbf1ZuW30R7cIrW6eSvGstTULB+3MWjxZ9MLDbi1rSuuZxr+rfl4EMc/
         oQReKB+bFiVsD/OeOQqRS2ZmD1/Ek+iHLpBihHIFcDCBUtKZrifuMmGjNtZu+ysRG/zI
         Vkuv+pru8eqVBLAku7oT8XF+2tkijiRz/WrOn0UbhRwLha+SK83QjwV3rRsUs5HFyT39
         BvtA==
X-Gm-Message-State: AOAM531GG0Yndj0rWKnAQoaHvbvokCbMSyuad6f/grjWCuyjjbBhaPu2
        OBe2fWowuJXG8XtHpRXjVQKTNMW+heLZ3g==
X-Google-Smtp-Source: ABdhPJwAx+yP4qtHiwyRZFkhcgacgKOJS7wi25dBjR1hZ0BW2W72kviLhSrCpMGFG7edj7u/QkD17A==
X-Received: by 2002:adf:e650:: with SMTP id b16mr10797292wrn.273.1618225750600;
        Mon, 12 Apr 2021 04:09:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/16] test-lib.sh: new test_commit args, simplification & fixes
Date:   Mon, 12 Apr 2021 13:08:49 +0200
Message-Id: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a "various small fixes" series to test-lib.sh,
test-lib-functions.sh.

I have a couple of outstanding patch serieses that I've pulled this
from (ab/describe-tests-fix, ab/pickaxe-pcre2), as well as some other
local work I've been having a chicken and egg problem with.

I think the approach of pulling out these various miscellaneous test
fixes into their own topic makes the most sense, I'll then submit
re-rolled versions of other topics that e.g. need these new
test_commit arguments on top of this.

Ævar Arnfjörð Bjarmason (16):
  check-non-portable-shell: complain about "test" a/-o instead of &&/||
  test-lib: bring $remove_trash out of retirement
  test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
  test-lib-functions: reword "test_commit --append" docs
  test-lib-functions: document test_commit --no-tag
  test-lib functions: add an --annotated-tag option to "test_commit"
  describe tests: convert setup to use test_commit
  test-lib functions: add --printf option to test_commit
  submodule tests: use symbolic-ref --short to discover branch name
  test-lib: reformat argument list in test_create_repo()
  test-lib: do not show advice about init.defaultBranch under --verbose
  test-lib: modernize test_create_repo() function
  test-lib-functions: normalize test_path_is_missing() debugging
  test-lib-functions: use "return 1" instead of "false"
  Revert and amend "test-lib-functions: assert correct parameter count"
  test-lib-functions: remove last two parameter count assertions

 t/check-non-portable-shell.pl       |   4 +
 t/lib-submodule-update.sh           |   3 +-
 t/t0000-basic.sh                    |   4 -
 t/t1307-config-blob.sh              |   4 +-
 t/t1403-show-ref.sh                 |   6 +-
 t/t2030-unresolve-info.sh           |   3 +-
 t/t4006-diff-mode.sh                |   6 +-
 t/t4030-diff-textconv.sh            |   8 +-
 t/t5406-remote-rejects.sh           |   1 -
 t/t5407-post-rewrite-hook.sh        |   2 -
 t/t5409-colorize-remote-messages.sh |   1 -
 t/t5520-pull.sh                     |  10 +--
 t/t6120-describe.sh                 |  58 +++----------
 t/test-lib-functions.sh             | 125 ++++++++++++++--------------
 t/test-lib.sh                       |  36 ++++----
 15 files changed, 113 insertions(+), 158 deletions(-)

-- 
2.31.1.634.gb41287a30b0

