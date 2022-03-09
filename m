Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA6C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiCINTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiCINTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D711786BA
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3387349wmj.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3S0ojiebBMwCpZTKJY1ZmaM4fC8TUNSrdE0GRrOjXc=;
        b=PcyrplH3u4bjDfXg2ql91bhJTBTQY4Hh/V0x7HyScmPofDAXp7171lU5TXsnLMXlrp
         XW04yGcm5XY66nsHdpGyMEmpDpfXTEmt64/DI9pT4kZaYJRiJ7RV4fvWYOLDo2zgqz8e
         qufbQMXkqxgg/K+3geXuYf+h7ogZUhHh1owC877DEweOM/86IEB1y3FWjkvk0FGocO3e
         ples8+zwBMaYEo3RyLbNR33wa45ghCSrdrTtAuG42r5X0Uub6RzokqbSjHVXlSV0L96z
         piTAuaAlDCGK2oHtqAQbaQhyvLw086wySey2N2q//oc/YJ3wvQh1rGH0ZmEiUy06Ffqi
         8QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3S0ojiebBMwCpZTKJY1ZmaM4fC8TUNSrdE0GRrOjXc=;
        b=0NBJj4h780ptuafFEuau/YtrN/Uf7B6WUoiHk2u4+R7HIV4/X/J4li0Su1Pk6lTwTd
         E5bGLcXjTqQwCqsniQwCq9AGxUXcc+UvP/y/9EiRv0ef5/k+UQ/c2H4P4mu4Rc/TkmWH
         +0Siz0tQFT6f6LGDvVHlYYHfC5bXKhcnGVk4pvS4ldfyUMA7X5fCg8Rex/nA8fULjRTI
         9K2ba9lns2fLX6Nz1aATtaL74bjkDSOOe3qj9+mSPc2cUCf6d/3HvKIA3p4ZsI2NEjkl
         encuw3WzolhAQWI9cRa7n4EC7b721xHcuVHDaSwswHbtqxXhMOIB7vgAOZjVuOgKl2zE
         ryxw==
X-Gm-Message-State: AOAM531hyBvl3ZIcCnnNG77Q5v2M8p5sP2uDBIupx1QQdTWx15xBpepT
        RdEtmuLU6fob0R8/z6l5Wm85NysLpxh+qQ==
X-Google-Smtp-Source: ABdhPJwWb0Ndf8PWgX3Fe1HJC9n5TojnSugAp93SOz6LA51EGNYii929LDbM4YBuAJbgtbgNdnthrQ==
X-Received: by 2002:a05:600c:27cb:b0:381:400d:3bba with SMTP id l11-20020a05600c27cb00b00381400d3bbamr7644315wmb.60.1646831874489;
        Wed, 09 Mar 2022 05:17:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/24] revisions API users: use release_revisions() in submodule.c edge case
Date:   Wed,  9 Mar 2022 14:16:42 +0100
Message-Id: <patch-12.24-8811a5ca840-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() on the the "struct rev_info" in
show_submodule_diff_summary() where we need to pre-initialize with "{
0 }" to make sure that we won't segfault when calling
release_revisions().

Most functions that use "struct rev_info" will call
repo_init_revisions() early, which will do an equivalent memset(). In
this case we might "goto out" before doing the equivalent of that
operation, see the "goto" on "(!left || !right || !sub)" added in
8e6df65015f (submodule: refactor show_submodule_summary with helper
function, 2016-08-31).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0510cb193b6..285c1896c9e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -638,7 +638,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	struct rev_info rev;
+	struct rev_info rev = { 0 };
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct repository *sub;
@@ -664,6 +664,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	print_submodule_diff_summary(sub, &rev, o);
 
 out:
+	release_revisions(&rev);
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
-- 
2.35.1.1295.g6b025d3e231

