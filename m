Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C6C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjBBJyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjBBJxs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112D2CFCA
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso3273046wms.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKBip05bFRjkGOC9756wRM6dGN3CFpVpqtHGf/xgzkw=;
        b=D6goKpIMPToDCeZfp3BvFRwj+YzLlythei1VswoNNaSQqgyAWrNyUR1VoEvUzFBefm
         zfJIKFKnnIp8Xn80RG60gHAG/0j27QK4yvF+puaEygQ8atAiozXMy0cjGtAem3d0hwNv
         EeJPwNYANu+ri+yzPOmVLINUjMwYyvvlGlEliNxxLKtUXHocDx7yCqbYLSy+5CmOMdtJ
         BtULFCVuh1P2Wnqm116cNaI7SsCjLEfHH+FnEwBT3dnCLATRfYrNCbkEmj5RnL3bXJ12
         PAaK3X4MPCfBRftPeJJhugcKen7n0WFjQZ8+nTqghs5tO7JKakoiJlnScpbNidjAhnJt
         xn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKBip05bFRjkGOC9756wRM6dGN3CFpVpqtHGf/xgzkw=;
        b=IwWDxo6+hgvxps/4CCHzhoJSE8piC+y1PlCBkxpoErYfQZU3KL3Jevrpn0kGTvoUTi
         4aD1TwPzeytHFcND7cO9mniazDC+VypWIgmqD1Tmi542Y0hoRrH5rxVkRyEicJ1F3dUn
         w9VasOgnJBuDymd61+WZyWZpb1erEPD6y3tVGJeqJLxeacIDJdSyaL7HjmtdPZmXUe27
         dcng2eKjcsgw+adJ/Z2EEsHZJ8tAFzvVgo4HXXb2V8AMDFN+uO2KzrHqpedcL4HqpAh8
         WwHIbBIYTmPstGQHD9rPNt2fgLRieRjjUWwlA5i0yfx0J7tFVLGrxAsIBiySpZUYMPtr
         2NoQ==
X-Gm-Message-State: AO0yUKWMso7z+21eExabQa4Z5shsuV2IjLV6OeBdclh0iP8T0eqcfjyh
        83e++pdHPtTz8Lp2zFRFpSihdEYvzwLR2XPx
X-Google-Smtp-Source: AK7set+PI27QOuEofv10D1tNMyIaV/MZYLqPm8YFgFE4e1Zhr/8GJYZPRTnlU2apxu8jQEUxQl057Q==
X-Received: by 2002:a05:600c:4f07:b0:3dc:5ad1:583d with SMTP id l7-20020a05600c4f0700b003dc5ad1583dmr5402984wmq.18.1675331593049;
        Thu, 02 Feb 2023 01:53:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 16/19] grep API: plug memory leaks by freeing "header_list"
Date:   Thu,  2 Feb 2023 10:52:47 +0100
Message-Id: <patch-v6-16.19-0c51ea7fd2d-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1], freeing this
field was neglected. Fix that now, so that commands like

	./git -P log -1 --color=always --author=A origin/master

will run leak-free.

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index f8708e1fd20..92ece4b7fa3 100644
--- a/grep.c
+++ b/grep.c
@@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
 void free_grep_patterns(struct grep_opt *opt)
 {
 	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.1.1392.g63e6d408230

