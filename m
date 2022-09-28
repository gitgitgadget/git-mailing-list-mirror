Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055AC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiI1IlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiI1IkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02F71BF9
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso718937wmk.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4q6rDe/uK69mU3zhXOzhJcvmg6kvpn+39SN9Z189YRg=;
        b=esk4izTxV/UTwdzuYDdL/xpEBc3ap56hkrLleTlDRrrJ74HmXMAa2ikY8JVo1HHZBW
         bFUon7SGqGhaXKNmMvQfpqrurfOQLMkhPN8rfXgcRAoSOCtcjlRJzVD66VCDmzwHL9aM
         rqlDxr+qyTalrbwXNfK12L63Rmf2PUNucZCd8uhFbNhlChkZvSNithEhGLQSfSlYxpy1
         rsbkVSBeE23RrmlRg+eR1bxxQNQIsy1BSv1wacNdxouAYD5LaSg4IX1fFUvfLNCvrWzr
         ib95ud7jvbKm7M+L2YLe1BRamqqdOS8BZLxRQrmPd86dBZisnRAwdjY+mMvzis9+w9R4
         73aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4q6rDe/uK69mU3zhXOzhJcvmg6kvpn+39SN9Z189YRg=;
        b=C0BuMobvJTSINq8QXS1khRt5Kcx4tSVD3xGf/gp+1ROYOvqXo23dGA6NwTXq5kHLFA
         FNVnRnZMdih55isWFCOR2h5J0djQhxYJRd0zBO9TpFt/KNaSqjF7Wupj28RhfZtui7+o
         ZBgmqA9EBfCxu4bO8fxJ+dQmfqeaaxvMdYU62++2up4co177/F1WPZKq1ZqvaGbw3aqT
         ynTY9tLvWsqHswvS/S8HrZ9MkAOJT/iJWL1trqKHQh8Br7xD6ATmJfQYL1fqnfZMXNCt
         n0txlxoTktkcXTfydwh3mPxzOpXVKtWK5efjhloIJl5HCq88WuxS0uGS6pWDfG94drp6
         3+Hw==
X-Gm-Message-State: ACrzQf1yuJ3Uhbz/JOpxTr8VHYKrfErxxJO/CDL2hVrQEn4zYooauZXr
        0/tdvSBEyuXctCzLhgIiuEpV2aLjw0lnCQ==
X-Google-Smtp-Source: AMsMyM6texKRvCsMwVLeS4QTfvVHNl04j/Sfc5u7rq4wCzTHkLnyfDnrwYgvwmQJ/NKDfhmCIhVa2A==
X-Received: by 2002:a05:600c:3b12:b0:3b4:a6ea:1399 with SMTP id m18-20020a05600c3b1200b003b4a6ea1399mr5800980wms.49.1664354396135;
        Wed, 28 Sep 2022 01:39:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:55 -0700 (PDT)
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
Subject: [PATCH v2 19/35] doc txt & -h consistency: make output order consistent
Date:   Wed, 28 Sep 2022 10:39:14 +0200
Message-Id: <patch-v2-19.35-1b51906fa07-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix cases where the SYNOPSIS and -h output was presented in a
different order.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a11f8c6e4bb..6f3941f2a49 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -31,8 +31,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a | --all] <commit> <commit>..."),
 	N_("git merge-base [-a | --all] --octopus <commit>..."),
-	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --fork-point <ref> [<commit>]"),
 	NULL
 };
-- 
2.38.0.rc1.925.gb61c5ccd7da

