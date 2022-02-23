Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC25C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiBWO3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiBWO3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10269B250C
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d17so5086070wrc.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8jYl8gjf0naJJiVvZzP4wht3NW0AgZiyMz69tEpui/o=;
        b=B6KoSt18ewg5RyUJUN5VvZBWysUPHALkWHz3+MyK3TZZpsanz2wsfOHYlmFruklsxz
         yXhnDNQbUpGvnXuThfuU1g8ZZ+DmQsQ29Ay9db+TNUEqfcnPYl8JTcLsqmJuzlBsphmf
         EPvUp1MwwG8telFRt9aEiXtL7oCpLMS+KHPata7xoEwQF+S+Hpkjvi55zLC/MjN9ghy2
         CkvcTzNvP0rTIgbUC0bMbIrbGLW4OnPY4RqxaBhjRt40d8Tjva9Vv81DfmvUoIHWRxKZ
         WCEgDhcUM+um2uTKxscRyHpX86ipou8wXV9HYT8uSbCoFsSLVA90uukkECJBlE/C4/Rm
         YGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8jYl8gjf0naJJiVvZzP4wht3NW0AgZiyMz69tEpui/o=;
        b=RLj87PDIQjirb0BtanPXeRKMaawGA+VrfRz+8+2hN4PHZvL4YqBuHc83WI/ndbsJc3
         UBd5+MB07BQ0xsHTxlC3xg47pVgQ/4CBGkogTAHhoumaTawc0D/F0rCSM2xWPtD5u5RS
         oz4sjFFhc2G0M/r24cRd2GkcplVgA8YONxIp/gfNWsZ6cveFaWpsEOmrQK4G2Y3GQmEb
         WOg64fZdGjeZYfFemJYa4T65EAf3fNBGkS9BygS1v1bH5NkmAMMC1d3P9C2+9dyb95gW
         9bpB4AxrxFgk+LDgcS/VGlNoDShn2YkPffnmP/FNEhX0xGA2YYkl7wvnxAGAEDBSZJUI
         /9dA==
X-Gm-Message-State: AOAM530YW6THz73IyQJML0Uq8WxB7D6laBKnYygK62mktj92HHwicjtg
        YAu4Kt2tq8HtPVGrScBSjp/fpaoOg7Y=
X-Google-Smtp-Source: ABdhPJzbDPa6B/fGm/otlLr0EOMI17RoS06MadNtHz06VyJ6sE26IOKxf5clJMDkPt6OwA8rbmeVqQ==
X-Received: by 2002:a5d:6b0f:0:b0:1e7:9432:ee8c with SMTP id v15-20020a5d6b0f000000b001e79432ee8cmr22226208wrw.216.1645626561440;
        Wed, 23 Feb 2022 06:29:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm3439913wmq.8.2022.02.23.06.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:20 -0800 (PST)
Message-Id: <a113ed9a8449b57e2a88a24244f3e45b24a01862.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:09 +0000
Subject: [PATCH v3 01/11] worktree: combine two translatable messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

These two messages differ only by the config key name, which should not
be translated. Extract those keys so the messages can be translated from
the same string.

Reported-by: Jean-Noël AVILA <jn.avila@free.fr>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c6eb636329a..7c272078dc9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -384,11 +384,13 @@ static int add_worktree(const char *path, const char *refname,
 			    bare &&
 			    git_config_set_multivar_in_file_gently(
 					to_file, "core.bare", NULL, "true", 0))
-				error(_("failed to unset 'core.bare' in '%s'"), to_file);
+				error(_("failed to unset '%s' in '%s'"),
+				      "core.bare", to_file);
 			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
 			    git_config_set_in_file_gently(to_file,
 							  "core.worktree", NULL))
-				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
+				error(_("failed to unset '%s' in '%s'"),
+				      "core.worktree", to_file);
 
 			git_configset_clear(&cs);
 		}
-- 
gitgitgadget

