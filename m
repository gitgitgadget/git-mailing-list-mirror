Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E0C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D572761221
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhKQLqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhKQLqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:46:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BEC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:43:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u18so4080157wrg.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Si022jmlQIj7ksjqwpSTSLY8gDxJz8wx5JQ7Wh9rfGM=;
        b=ByhDJcFIoajG8qOsFL0tb/lLYH6NK2MYYRzeqLZ3vMpnEsi603h3suczCFuGvSIs9t
         rk9CE0c56HNLA/TL16uQ5SOqOIDecl5GTO2T4R6RIZ64QS+fifiGGlj11xCjghzWvKZD
         hnDPtmePdOmkJVcihKVQrYQ/456jAu4qIRkN4Fnc3YlAJn4czFW3R7PttgNr59vYrm3/
         sc6kP/dXXBXmH1TmGEElPvSr8Omx0xqCauuOMbUIPDDtLKyOuU1N40s2Hd4tIMEzSg9Z
         pUI7E3dAXf7Kp86njBXf2k6u8tgG7MTd3xSNgL/4eglGSbMvcgHuqtQEZa1gIlu6uemo
         p7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Si022jmlQIj7ksjqwpSTSLY8gDxJz8wx5JQ7Wh9rfGM=;
        b=3zGizOP9EZNkKd3yySGPAqTQ5HgeUo5+voYiO1EGRntFTPwtPn7dIa2F2xu45s/Kxq
         90NvQEG5SqtaOy131jdEsFnkzRn4qQfeF4e64ij3KQcpLYcvQo4rELZhL7f9MK7nhQbG
         +vOoaEqZ7mx/+AKn2/oJczSCEWY5TObBb1j1Z+OmJiJ3TobdBOLAYjQTfbOszPQyBnHN
         D8rFbzp1XrH4fdldLYBTFrR+Wf6x0RVCSvxISVWrwtacNzCs/BLj0vtxz+9ox9MaMn53
         dvZvBUrRfetDkpOzVx0/u84xMnsqif/CMaxYYU81BEN46SXwUpSICkWGarSpljPtYZ+U
         o6ag==
X-Gm-Message-State: AOAM533AcMEUmmquE/rMpYyIPHIvdNiZjKHbjiUpCjFJxQOwxc1Yn4Pp
        Bn+JW04MXsO7T5gANw2LBJI1NsNHZtMYWA==
X-Google-Smtp-Source: ABdhPJxu5eb6oYzl+D6QmoSuNm5MsSfuU3QibrMRuaNwgWgS32gfn6YG6egdXw3EGWg+RYUPhX76OQ==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr18791205wrn.135.1637149423603;
        Wed, 17 Nov 2021 03:43:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e18sm20398678wrs.48.2021.11.17.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:43:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] submodule tests: fix potentially broken "config .. --unset"
Date:   Wed, 17 Nov 2021 12:43:39 +0100
Message-Id: <RFC-patch-1.2-a8e31e35392-20211117T113134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
References: <20211117005701.371808-1-emilyshaffer@google.com> <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These "config ... --unset" at the start must be guarded by something
like a test_might_fail, or we'll fail if a previous test didn't run,
e.g. due to the --run option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7406-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index b42a339982b..01e1acaf300 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1063,7 +1063,7 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 
 test_expect_success 'submodule update adds superproject gitdir to older repos' '
 	(cd super &&
-	 git -C submodule config --unset submodule.superprojectGitdir &&
+	 test_might_fail git -C submodule config --unset submodule.superprojectGitdir &&
 	 git submodule update &&
 	 test-tool path-utils relative_path \
 		"$(git rev-parse --absolute-git-dir)" \
@@ -1075,7 +1075,7 @@ test_expect_success 'submodule update adds superproject gitdir to older repos' '
 
 test_expect_success 'submodule update uses config.worktree if applicable' '
 	(cd super &&
-	 git -C submodule config --unset submodule.superprojectGitDir &&
+	 test_might_fail git -C submodule config --unset submodule.superprojectGitDir &&
 	 git -C submodule config extensions.worktreeConfig true &&
 	 git submodule update &&
 	 test-tool path-utils relative_path \
-- 
2.34.0.796.g2c87ed6146a

