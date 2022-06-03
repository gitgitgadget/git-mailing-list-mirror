Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01025C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347573AbiFCSja (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiFCSjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ECF13F1A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n185so4503102wmn.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+vCK8o7px1kCstZ5ngL34U5AbL7VdjT8ve8LuDQXrI=;
        b=faK4nYfv2Jd/dKTVFhNyqYxqcPG+7cAJMvgRhyjsEYIdM+KA5N0lzF0tVulvEj6jHZ
         82zAr69Ctexq7kCYhm8nKOFLluV2aJY2xEdtq3pa1+1pD6tErsMsJXl7abF95P6UamIp
         DBLaoFFDdghR02VvpF7taXRvbfgjmrmFieLA3aoFvKdv9vdVHx85SkwK3q8s377o9Vbg
         Ojxba6C2Z9vMIqOgRvXHd2a0LllW9WQPlghC+aFKzJxFSKM7DOHD5j+RGhE7HdQYtRmV
         9arHgDPXc6rWJlEWzbUkgOJK/XWGzA9slponZ50DpSsXsKZXbUrbr0eJfmTXhFBL4TpP
         dfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+vCK8o7px1kCstZ5ngL34U5AbL7VdjT8ve8LuDQXrI=;
        b=sTAredZQaNx4/aAvV6Taoyli9JPiEvjHWWu4C7u7yWIyXewSS+gbp9/cSr/9phgUks
         68LhFmOadkw7fhJjSzGynj4NeUS3XiCC/3RdjyjIRm9ByMqCWrV0K9PzQGjY2giHOZDD
         hGs624Hd4Un59r21Z2URiXSJRm/wKwyv4Cl57dBZMbJQz969ctehwQXQ2pg3/59a/D8a
         xUojkbmAzftsGIz0aIYaUtNc5sG1A/P0XwPGdWUFtnKzEKuiyCWutzYizFcgIkvBgooI
         gfb7omCI46S/MHFhHLEVEoCe04xLGlgAeEfBjLJPqS7dLOI7/oDHUOJ5NLnBnByqVIKL
         WKNA==
X-Gm-Message-State: AOAM533uJARzRX2zXwYAXsaebynePWtn890c9UP9jGu2Udb2OlDAaiBA
        UhoT/R+y/PcHsf7tSfRO7HYuHr/mf8ONdQ==
X-Google-Smtp-Source: ABdhPJyA+dnqMupAvnl3T0r4s1ydecthJCmBEosIFOeDD6q5A7jD/pGX2UU5GuDEZmoLAAetTKvFpg==
X-Received: by 2002:a05:600c:3843:b0:397:476f:ceb8 with SMTP id s3-20020a05600c384300b00397476fceb8mr38913776wmr.200.1654281486044;
        Fri, 03 Jun 2022 11:38:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 06/15] ref-filter.c: BUG() out on show_ref() with NULL refname
Date:   Fri,  3 Jun 2022 20:37:43 +0200
Message-Id: <RFC-patch-06.15-2d04035d7aa-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code originally added in 5339bdad96a (ref-filter: introduce
remote_ref_atom_parser(), 2016-02-17) to BUG() out rather than
potentially segfault if we get a NULL refname here.

As noted by GCC v12's -fanalyzer that will happen if this follows the
"refname = NULL" branch added in cc72385fe35 (for-each-ref: let
upstream/push optionally report the remote name, 2017-10-05).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2413f889f48..91aa8e89268 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1644,7 +1644,9 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.option == RR_REF)
+	if (atom->u.remote_ref.option == RR_REF && !refname)
+		BUG("must get refname with [...]remote_ref.option == RR_REF");
+	else if (atom->u.remote_ref.option == RR_REF)
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-- 
2.36.1.1124.g577fa9c2ebd

