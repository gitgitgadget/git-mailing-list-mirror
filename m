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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26603C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED496023E
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhEJPOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhEJPNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1077C0515EA
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so9018707wmb.3
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKhsHn+fWvX4Kusc534/1i+XDRcY4HqI/VgF9jk5zRo=;
        b=s08ettH/Ej1+Y6rvArq+3GtmiIHV2pB6WGkux7hMX6B+FDtuJdzV7yQvA8NnUquJkD
         GBPgucxXLc0RatQWF/tUcZdjf7e7m5deRMj1FtDn6Z3aAbrsX6jdtKMLBeMO0GxtvDEd
         yjyIiypF8hzfMUw25xSS8EM1gFYjhrVy/lMqv7PnRUOrxT6ZVV3AqjdqIDemitxXjTbf
         ijcLm6oqpTzsUQk2RjgorNAQPIw/1MFGOPooij7R9o/25J8KdDBT/icwpUAT2JHM2tP9
         9fd464CPB5lM2mWrMHhtUqxDuU/GM/QLEs+hS9u3dCWa8S4Z0wmdeYaaSepqa/ymUpSn
         2lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKhsHn+fWvX4Kusc534/1i+XDRcY4HqI/VgF9jk5zRo=;
        b=CUMpi5KigTUD+v4gXNcUt3PIhFjY8flUXmBcCunAqSrbneQw82YDxClmZIigY4bmE/
         98sF6L+QHDjtnpexztfSf4LM9i31hSbtUCa2+oFRnAWBVdo9Oa4aGDm8/Je/o8BNuqP1
         PeOjJxAWtzafBBKVkpfmZdNVtObB1RtaI/KCISjQMnI2ZBurmZOAlJFRpgdtPibgmr5j
         uFipXlZMtbKATNvI7gaRFc2K4Os7+VOZ5Ata8xFa59R7tSx1WF38UMPdcd2kEMV2F1tX
         lS6ChS3/4HU0A8Uud49wIqsJjW+nDwwD5XarNH9yOOlit0Fmw1e0kaZlFsHeO2ypkGpg
         2N1A==
X-Gm-Message-State: AOAM5313sP2+Ns1PoGj9hll+G6D4Dc37se58jOzbeVPE5ccGOIReQFHc
        mrp6Jf1fbLGvArroxp5fbK7wVHxqDEHSKA==
X-Google-Smtp-Source: ABdhPJzRUAVTAMjyHJS8Fh7pYQUWrF6iT/5rIV+Vhlwlroa7Lfoyw6Bl6d+i/okEQKjyeSNPtVgftg==
X-Received: by 2002:a1c:988f:: with SMTP id a137mr26706955wme.81.1620657137418;
        Mon, 10 May 2021 07:32:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/11] test-lib-functions: document test_commit --no-tag
Date:   Mon, 10 May 2021 16:19:03 +0200
Message-Id: <patch-04.11-1a675a6cfe5-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 76b8b8d05c (test-lib functions: document arguments to test_commit,
2021-01-12) I added missing documentation to test_commit, but in less
than a month later in 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09) we got another undocumented option. Let's fix
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1f787ff0726..c6d07f4ce32 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -177,6 +177,8 @@ debug () {
 #	Invoke "git commit" with --signoff
 #   --author <author>
 #	Invoke "git commit" with --author <author>
+#   --no-tag
+#	Do not tag the resulting commit
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.31.1.838.g924d365b763

