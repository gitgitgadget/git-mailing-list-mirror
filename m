Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6CDC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A463613A5
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhDENEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhDENE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:04:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77326C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:04:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso7563923wmq.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dgxbgZ3JD4kz/dT2QjNMWsE7PkGCQ3gDNPPSXyQTMlQ=;
        b=LHOepwBL83mE7PqjEBMoRNqS8CnJW3KSCC7HhodnKeoWCB2g78P1aE6+CsjxzaJ6TT
         yYi2/lt0NCniK1SIP0AC/m6XsOd66LvHY4NMVrZ7NCcH+N/aI1/dmhVUphj0esjHvNuv
         PCbxftHG0ljDKmOHbncMyQfItmhjwapE47ju5MRQR8xuH15d+Eg+HNzE6OgUX7WHM9zg
         zOin3UQRJY09LYlt/Kz3GBNejpEgbvLiqMPpra7DxtGeNyjlCtW3/U2Pd4bHK1hJoHbu
         TsrH9hUwUO26uAVbx2PEhQS0kRoLDUOadvDHDFRSOqjaIaq6NmxROo1QJ7NUiUAMhGTt
         i6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dgxbgZ3JD4kz/dT2QjNMWsE7PkGCQ3gDNPPSXyQTMlQ=;
        b=fI+ng9q/FT29lUZwPYVYaDnN2DSVXGtvHC56jbt3B6YVONXv/nfZUldVBfbd1vyYtS
         QhvOJT9D2IRZRwcAGXffDayoMRGDSyISVFu1d9q5YwBm72cxaN27J0ekrpZyD5XsUEgq
         dZDRJcwTAQQaebfYjbY0KTdQLFXC9De3qRIhEiF3txeBs5u4UwCUnJ0N2Fy1IRfhD5ec
         eVsgY0LXYLYQMmCmjFCJH2rc/f2MIedVjo1sNCbVnAgAiPbFsoXHH9OJKlwWd7lbCSX7
         IMhTUmf85prRgT5/+zyZ1hvpWs3VGO6tKvfP8DTi1RJknpTGEYMUY7IXVHDtiUkXjpwE
         /GaQ==
X-Gm-Message-State: AOAM531NzYHRGLL4HJ5TlBYsrYdoLoeGpiq7K3S2xwbxo01+hB6TbI+p
        bf2BoNc/xHxgmR9wcbxqL4y5xP7EkYg=
X-Google-Smtp-Source: ABdhPJzQ9CiwCsuLr1SeFpQ9zg54QmbQvJtXmctQ/puJFmLhyiTL0Bumwh59qyLcILFV3ymBqD5c0A==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr25444519wmd.180.1617627858021;
        Mon, 05 Apr 2021 06:04:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm27420477wrr.78.2021.04.05.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 06:04:17 -0700 (PDT)
Message-Id: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 13:04:10 +0000
Subject: [PATCH 0/5] Maintenance: adapt custom refspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Saeger rightly pointed out [1] that the prefetch task ignores custom
refspecs. This can lead to downloading more data than requested, and it
doesn't even help the future foreground fetches that use that custom
refspec.

[1]
https://lore.kernel.org/git/20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com/

This series fixes this problem by carefully replacing the start of each
refspec's destination with "refs/prefetch/". If the destination already
starts with "refs/", then that is replaced. Otherwise "refs/prefetch/" is
just prepended.

In order to accomplish this safely, a new refspec_item_format() method is
created and tested.

Patch 1 is just a preparation patch that makes the code simpler (and in
hindsight it should have been written this way from the start).

Patch 2 is a simplification of test_subcommand that removes the need for
escaping glob characters. Thanks, Eric Sunshine, for the tip of why my tests
were failing on FreeBSD.

Patches 3-4 add refspec_item_format().

Patch 5 finally modifies the logic in the prefetch task to translate these
refspecs.

Thanks, -Stolee

Derrick Stolee (5):
  maintenance: simplify prefetch logic
  test-lib: use exact match for test_subcommand
  refspec: output a refspec item
  test-tool: test refspec input/output
  maintenance: allow custom refspecs during prefetch

 Documentation/git-maintenance.txt |  3 +-
 Makefile                          |  1 +
 builtin/gc.c                      | 63 +++++++++++++++++++------------
 refspec.c                         | 25 ++++++++++++
 refspec.h                         |  5 +++
 t/helper/test-refspec.c           | 39 +++++++++++++++++++
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/t5511-refspec.sh                | 41 ++++++++++++++++++++
 t/t7900-maintenance.sh            | 43 ++++++++++++++++++---
 t/test-lib-functions.sh           |  4 +-
 11 files changed, 192 insertions(+), 34 deletions(-)
 create mode 100644 t/helper/test-refspec.c


base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-924%2Fderrickstolee%2Fmaintenance%2Frefspec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-924/derrickstolee/maintenance/refspec-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/924
-- 
gitgitgadget
