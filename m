Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F27C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378574AbiFPUzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiFPUy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:54:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74C5FF06
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g186so2300887pgc.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgNKs9ktJWgYwM0KUjw0vV0acUjy2x35x0nHxAHccTo=;
        b=ixeYXkEevsdlo/HAY1NFqf2oC/MBMpR4USEJEAIE+EWnX5auErNbccxA1O4HRoBxTK
         GyWv8wIsY1ZEYuVFMUxHHYlXwjvOVTob5ciIfvE52xbsdOFd8iav29YaEm3XHbRmzyvp
         7LbtJTQ+lY0ETPCmAGOQK2VFDw6MlTBRRZ6Ff+iXBWYOx7JZ4btKs6DFJthioQTKiaZa
         FiqJK4lWnIgIOTs6FXnGGMzaRnvSo3O4KCdBVFKttaCIBLHmDWuw99x2UvqmwWV0KMxg
         v8KW6TZ0N9orQmUc85mgioLALcMmVDSZ7A++RuIrPlCV6M0DT/mQOhkDVGSb3SpfayiQ
         KvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgNKs9ktJWgYwM0KUjw0vV0acUjy2x35x0nHxAHccTo=;
        b=PCdI/OqqvCkmxiZfEq3+ArFcmjFvS/pju0zwyV+sSb/LBI8wUaYyxeyB0jjqH1DR9T
         LX1mCAvGym8TuyCJ+Oa/7/GqFDv2YGhPGrIpHXo9cJ3tLamwCjaLewqG14LDJABARYJz
         4Pkr8Zk4AwuYhcS8p8fA/PVqJYVrA5Z12SxSP0uuuPGhr7Lu1TO4gQnhqtkdDBWDlseI
         pZetm8DshMGJC3ZFITndPZPehXbp0hA6h879ZH0/ueXNwOguUeUgQU2Zse81gq6U2yJJ
         Cqj0sLvhH0cmGt7msHfPwa/fuLFSV6tlxkhQ63hYfX0AIzr/bu3lJQ9KD6J1X7Fl9jtg
         dVYw==
X-Gm-Message-State: AJIora/wMB0FG+uiEvQbfRQbnHxRKPx6pJYFQEVgt1H/Ef2YCa1jq4ve
        a2zJXTo6TNBm882vxUo9jR952q+BBSc=
X-Google-Smtp-Source: AGRyM1vRPkUq3pJpxCjYahmbHD62BWwPODxv7wuE3Q2CVKe3Scs4Zv+qhUhsUJa8BIHZjmozCol13Q==
X-Received: by 2002:a63:d008:0:b0:3fc:f8bb:4ed9 with SMTP id z8-20020a63d008000000b003fcf8bb4ed9mr6091757pgf.215.1655412896692;
        Thu, 16 Jun 2022 13:54:56 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0051b9e224623sm2249165pfn.141.2022.06.16.13.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:54:56 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/5] support negative refspecs in git remote show
Date:   Thu, 16 Jun 2022 13:54:51 -0700
Message-Id: <20220616205456.19081-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds support for negative refspecs to git remote show, fixing an
issue reported by Pavel Rappo.

In addition, it includes some cleanup of the t5505-remote.sh test script,
focusing on removing subshells and using test_config more.

To support this, test_config and test_unconfig are extended to take and
handle more options. The test_config_global is removed in favor of just
using test_config --global.

In addition, test_config now passes the value and --fixed-value into
test_unconfig so that only the specific value is removed (rather than all
keys of the name).

The original v1 can be found here:
https://lore.kernel.org/git/20220614003251.16765-1-jacob.e.keller@intel.com/

If the config changes are too controversial, I'm happy to split them out
into a separate series for further discussion, or drop them if they aren't
desirable.

Changes since v1:
* cleanup t5505 subshells
* modify test_config and test_unconfig to handle additional options
  including --add, --global, and --fixed-value
* make test_config only cleanup keys with exact matching values.
* use test_config more in t5505 to avoid lingering configuration in future tests
* Moved the omit_name_by_refspec call into the already existing fetch_map,
  rather than using two loops. We don't really need to remove these values
  from the fetch_map and it significantly simplifies the code. Thanks Junio!

Jacob Keller (5):
  t5505: remove sub shell use in favor of git -C
  tests: handle --global directly in test_config/test_unconfig
  tests: only automatically unset matching values from test_config
  t5505: use test_config where appropriate
  remote: handle negative refspecs in git remote show

 builtin/remote.c                        |   17 +-
 remote.c                                |    2 +-
 remote.h                                |    6 +
 t/lib-parallel-checkout.sh              |    4 +-
 t/lib-proto-disable.sh                  |   12 +-
 t/lib-submodule-update.sh               |    2 +-
 t/t0001-init.sh                         |   14 +-
 t/t0021-conversion.sh                   |   58 +-
 t/t0210-trace2-normal.sh                |   10 +-
 t/t0211-trace2-perf.sh                  |    4 +-
 t/t0212-trace2-event.sh                 |    2 +-
 t/t1309-early-config.sh                 |    2 +-
 t/t2081-parallel-checkout-collisions.sh |    2 +-
 t/t2082-parallel-checkout-attributes.sh |    4 +-
 t/t3431-rebase-fork-point.sh            |    2 +-
 t/t5505-remote.sh                       | 1083 +++++++++--------------
 t/t5544-pack-objects-hook.sh            |    6 +-
 t/t5550-http-fetch-dumb.sh              |    8 +-
 t/t5573-pull-verify-signatures.sh       |    6 +-
 t/t5606-clone-options.sh                |   10 +-
 t/t5617-clone-submodules-remote.sh      |    4 +-
 t/t5702-protocol-v2.sh                  |    2 +-
 t/t7814-grep-recurse-submodules.sh      |   16 +-
 t/test-lib-functions.sh                 |   85 +-
 24 files changed, 602 insertions(+), 759 deletions(-)

-- 
2.36.1

