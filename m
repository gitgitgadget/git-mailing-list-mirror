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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79692C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325692310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbhAFKCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAFKCn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:02:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6DC06134D
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 02:02:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v14so1946106wml.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+M4spw2HtQW0G3xDt3pKtcVHGoEglbn/YYd9BHjj6pg=;
        b=n7W37YzoyFeYGgBc3imL4zmLfAGhsby3nwBIecTG2ay3t7Cd7VGsaoOQEiP9dwXzIM
         SgDibFG9o4W3F/e+CatqKb0BnRFEcEVrVZ7aFesMfErEvaNrGKkTZ8DHniXU0nShBquq
         vHxtGk9dA7I38AAj5k3xV6C5qsWn+dmI0HF78eNAGXPReCqex8lcBiIeDJAsZ8A6Voxi
         faaOgTyMp5zvcQSZavx7+OzdAbIP1qdGBu1jo9TJEvA5kFxeFeTfsGywwhQ9fxPMy4bo
         IebA8WOLRKzkqEF7jSRIFtclolAll79oVhSDRKjJ+zNn04gjVNluVEKl/u/zV0cTSRJ6
         w2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+M4spw2HtQW0G3xDt3pKtcVHGoEglbn/YYd9BHjj6pg=;
        b=YGb+bL0b3887aLQoS1+R2F/CNalfvArOuWiS9ZnAqKad3A+6nNsQYnlfMMJhDpe45B
         cPxoUI1BEcQxCaxaSUXVULEvJQHqYkd+dKy3KQCcelfWCjcDSuR/53kDJ1Fj4MX0t0JZ
         GqVmJiW+VydAN8iakLzMycM1I83m8GNY4hIBJ5fOheUc6bCAIi34u0ii9OmYjll39KOg
         vVC2v4uuIRYo+ig/mc5ZfqShl4q8GkQBLb3ynPDnXYRsnBB5h14IRgpK0I/dQgHWj7hL
         awfa6vcCAHN8YNXar8zzldmR9EzQ3U/PHR3VZU4yyR0dUnJ7hiy7iGDLVhfAWrVWZVtK
         LFjQ==
X-Gm-Message-State: AOAM5327wGAxyLfihR7NUOFGw5+4yEEEahD1H/9+A7K/y0rMmWDlmL8b
        6wYxtIp//pMPaF948gOqrx2a+hNlR8SlQg==
X-Google-Smtp-Source: ABdhPJzK1GStuuGYyYU2/m5+JaYLdrwpeFsDREulYm98XdzgrAA8WX8WD01/Fd18pULHVh/Vxd9z+A==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr2885520wmj.117.1609927321932;
        Wed, 06 Jan 2021 02:02:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13sm2538637wrs.6.2021.01.06.02.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:02:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] branch: change "--local" to "--list" in comment
Date:   Wed,  6 Jan 2021 11:01:35 +0100
Message-Id: <20210106100139.14651-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has never been a "git branch --local", this is just a typo for
"--list". Fixes a comment added in 23e714df91c (branch: roll
show_detached HEAD into regular ref_list, 2015-09-23).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9b68591addf..045866a51ae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -726,7 +726,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_current_branch_name();
 		return 0;
 	} else if (list) {
-		/*  git branch --local also shows HEAD when it is detached */
+		/*  git branch --list also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
-- 
2.29.2.222.g5d2a92d10f8

