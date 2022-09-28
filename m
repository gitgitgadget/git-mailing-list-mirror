Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9466C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiI1IkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiI1Ijo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911036431
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so708075wml.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y7LuQ6aibnFLwbSStNL/0sS53QsT/u52LLs4zoKBhtQ=;
        b=FyyRVSYIrb++QsFhSeRyTEyqykV2eDr+JAPDQfWDuyCXoJYw2CNqeNQao1VVkUz1Hy
         dMzBzQgLsdE+Vik9MKN7JxYJBbFaSHjfHUqfQ3ELSUqY+wv19UAnpMN70NZ0gb/dUOrg
         VctG/nn3kDgWwgDHUkAr7IY4vQCVHbBojtSx9J/QILKx6YfRxs9K6bdzitvtSR/M6K+M
         lMRQUu5JrpV3OsFx5cRfzZ55eFha0ohV3UNW3uFOtZ1+ycLyki8J3Ek3F6gPLCv0zMSH
         njqN/iiLNdX8WN72oVWuD7NrycG8+udTh5BZSCd5/d3j3JeUeRsFYzgMbI63n9wopkHt
         831Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y7LuQ6aibnFLwbSStNL/0sS53QsT/u52LLs4zoKBhtQ=;
        b=luVODVhH3us7brWwSpQwERn8s3fI06nCaIiKNBtbZiJ4lj/Kq5sCPs4UCoRP6Z2rXM
         6fm9aw8ydXiZHQ18HABrFAbgrfwM1qvAz9OheC/JNRuAF5LRlEbC6ch2WM9Hoc5kDmWu
         uuBAp2LjYPTc7xCqAlKFSPtdTpbkiQzILhDjCi/K1XAmLL9TgqMf9WCzgDlwWzKlvwBs
         MzpIFNBog3X+fOwOdFvHeczTy8Go1r45JBl+WWhEtsx6NsV5yvbbrKmRwTbbQ2xG8DIe
         iMF2WuwuLuHheAOYsAeKfCwU4KxYiIoWnfYvv8kD/5dDrHHgvUexqVfEnrG0EAxnViHJ
         UwFQ==
X-Gm-Message-State: ACrzQf3kHScr0aNBSaT1XOHSHUE0CWeEzfATR7o0f1FbmMT67CaMHg+J
        CSoa5Q6mOiPCYnQmfNn8M88SHRvNoo12xg==
X-Google-Smtp-Source: AMsMyM6jXwf6uLk8YqXtQ1SlNH80lGAzjBD8MZidCcrWeD7NUWu6YotJgzC0VeLsWMbo75Cw5KHi+w==
X-Received: by 2002:a7b:c4c7:0:b0:3b4:62b6:b54c with SMTP id g7-20020a7bc4c7000000b003b462b6b54cmr6035454wmk.89.1664354382180;
        Wed, 28 Sep 2022 01:39:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/35] doc SYNOPSIS: consistently use ' for commands
Date:   Wed, 28 Sep 2022 10:39:01 +0200
Message-Id: <patch-v2-06.35-adc18d392b5-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our commands use ''-quotation only for the name of the command
itself, and not its (optional) arguments. Let's do the same for these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-export.txt     | 2 +-
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6ad..4643ddbe68f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -9,7 +9,7 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export [<options>]' | 'git fast-import'
+'git fast-export' [<options>] | 'git fast-import'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3776705bf53..872436d7426 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [<options>]'
+'git sparse-checkout' <subcommand> [<options>]
 
 
 DESCRIPTION
-- 
2.38.0.rc1.925.gb61c5ccd7da

