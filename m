Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA09FC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKBHyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKBHyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4515252AF
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so43125511ejc.4
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/tkfnNznG6MqEQMCdKJ/aQggfu4lqvjg892Rl3tKwg=;
        b=gS92Guk0WNaps1LPFli3KJ5mjBzcz3lmP7GsRd5KhgxQo2VvgMJyq4im8de4Rvfm1w
         wmJQ/j+f4XI2w2DuKeSCmAotQv6U2lzSHfGL/rU+kz4yBkQc/8FLsyOU7R3uhElzxQpu
         WP5VSM4geZrAqbiMI8iAZtFZdRGBIjAK4VKG/2f48fTCEIigQusht27+pJiSktEgUj62
         P03rL6QTY4WgpF9bvxBfD2ooEcEh2cLKylYAMW9VOPHX3dQfbj0oLOS1snky6fjrYlu/
         VjmeS0NRuc8jH0ehFK5Vp0ClB/8G6hqbaHVs0gJkBkqP9BjXbaHrF9twVRC+GeSmNqNl
         uzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/tkfnNznG6MqEQMCdKJ/aQggfu4lqvjg892Rl3tKwg=;
        b=QR6omAU4S5bJnlzpBcnZ/6w/MOAGvkaOo/aeIdblF7zhh59cdiQ1M3wTO36DFgCCZv
         LkAHa/h7c/lDlDrs6ZIFh2db83s2Mv1EtIQNLZWcf2NPVZ+Wz/a9e4rP8Q4XlytMYjwA
         /ZvIJLBtChpuSdIiy7JxMlNSVLEEQnD/BJRxYFzQg3pCCrgdOMjHr/Pcw0C8H6FgvYNe
         UFcJyf+L7qYN0xeALUX7bM1NJGEhJsuH4hda1yhCUYYP2jQvwpp2ZqMiQvi8qRSVwNqY
         v7kj0Y9648rC6BKHqn/cuuedYNiOJeNzgI/rgORQE8M7gw46RYrZhErcMDMFdEDqToNb
         NfIw==
X-Gm-Message-State: ACrzQf0Oq5FG2Kx23iv08bcu4pKTOeNwOiRfWy4Bz+nNBkMc6A/5fnWf
        /eoeIcN9NFQcUimhMbGBdPJwoRvKraffrg==
X-Google-Smtp-Source: AMsMyM742uZJ4BmT0RUnNKX/NjEBsQMTexPdPMEdUD9eQHFLQq4Hn7jkbI+uj3a41Ubn1W6sV2x4Cg==
X-Received: by 2002:a17:906:8a6c:b0:7a8:2f09:d88d with SMTP id hy12-20020a1709068a6c00b007a82f09d88dmr21965046ejc.49.1667375651115;
        Wed, 02 Nov 2022 00:54:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] submodule tests: test for a "foreach" blind-spot
Date:   Wed,  2 Nov 2022 08:54:00 +0100
Message-Id: <patch-3.8-0ed1fc7fdf8-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We tested for "--" followed by command names, but not for "--"
followed by an argument that looks like an option, let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7407-submodule-foreach.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 59bd1501667..8d7b234beb8 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -154,6 +154,11 @@ test_expect_success 'use "submodule foreach" to checkout 2nd level submodule' '
 	)
 '
 
+test_expect_success 'usage: foreach -- --not-an-option' '
+	test_expect_code 1 git submodule foreach -- --not-an-option &&
+	test_expect_code 1 git -C clone2 submodule foreach -- --not-an-option
+'
+
 test_expect_success 'use "foreach --recursive" to checkout all submodules' '
 	(
 		cd clone2 &&
-- 
2.38.0.1280.g8136eb6fab2

