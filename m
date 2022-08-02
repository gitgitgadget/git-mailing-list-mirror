Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B2C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiHBM6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiHBM6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91601D114
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so6928235wmj.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y3Rdy4quEAoENxHzcnWU0FjgMhu8xb2BrcxkhBgDtSM=;
        b=jFW8M2dQazMjNIgJvs+TQJYE/1eqPjz6fA5hXd2N2rdaB81V0JXATE5ebKEWevKahA
         FC6/PNQIj+xNeStyDD1k0av0+o8DH8u/8TMSFsZr5eiUzWBWCuWWXQ5tK+if9tJenMEG
         2Qv8zHs/q1Pd9FiErjjslQ4a/G4TiGC+4I6c5ZnXFmpmv/U3Os5WXbsZ42OLHbvehFkZ
         oFmFaGtsDYDrUjAYxPzEwV3cFNUhmkZWBqOeXdpt/uMEhijCeP+a4fuOw4Rx1aqrnAoN
         qg71Yz4DVydHwxdUbsq7wI8vss/86wlL+xYryoSDxgyOFMVjkZi6K5YUPvPeZKZVxWJo
         kv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y3Rdy4quEAoENxHzcnWU0FjgMhu8xb2BrcxkhBgDtSM=;
        b=oqVlm5hoqSDEyz8m2z/WGAClyqHSVTmmnRhQm3lAjwgMO7KzTjRzFwtaAkhyUgL7Xk
         HA8yN0fiDYWAucau6MEp5TXrQ8L5GL5dACxrsFXP9HJA85/j8gMOKPilAiIpFxnKWjXg
         XoAevWsOet9do2ICJ2rIFwjvxbLWmxBFVK3qS6Xwni3vD+32phcmS8G/bzeOXeIKtQvw
         bBKvuKMREwNYZPQpXJbOQPpHmezH7lGF06AtM5fGfYqZFwF/G/hzFcTLY+lU9PZLRafZ
         /qa9rBa39thktjVeUyYrOxn0iqf0fW1Tk6sgx72jG5XkjWapDiIQELY9u314Ms/dEM5x
         UUIg==
X-Gm-Message-State: ACgBeo1w1don3JVz/aa8rP2S26PQwUTbf0GFV/oXpzhpHJg60WL6VuMv
        MuxtZUIhFjJs2OLYr4FtwtLYKo/rxycoNw==
X-Google-Smtp-Source: AA6agR59d1Vcx9UQlLW3ypyUO8bohVVAXLGw+sj6Eneo7y4A/3pT00UV6L9F2XhEE1OudUaJ3DtKSQ==
X-Received: by 2002:a05:600c:1d81:b0:3a4:f189:8052 with SMTP id p1-20020a05600c1d8100b003a4f1898052mr370503wms.136.1659445080661;
        Tue, 02 Aug 2022 05:58:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:58:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 02/10] help.c: remove common category behavior from drop_prefix() behavior
Date:   Tue,  2 Aug 2022 14:56:51 +0200
Message-Id: <patch-v7-02.10-56429194634-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of the "git" prefix stripping for CAT_guide so
that we don't try to strip the "git-" prefix in that case. We should
be stripping either "git" or "git-" depending on the category. This
change makes it easier to add extra "category" conditions in
subsequent commits.

Before this we'd in principle strip a "git-" prefix from a "guide" in
command-list.txt, in practice we have no such entry there. As we don't
have any entry that looks like "git-gitfoo" in command-list.txt this
changes nothing in practice, but it makes the intent of the code
clearer.

When this code was added in cfb22a02ab5 (help: use command-list.h for
common command list, 2018-05-10) the only entries in command-list.txt
that didn't begin with "git-" were "gitweb" and "gitk".

Then when the "guides" special-case was added in 1b81d8cb19d (help:
use command-list.txt for the source of guides, 2018-05-20) we had the
various "git" (not "git-") prefixed "guide" entries, which the
"CAT_guide" case handles.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/help.c b/help.c
index 7e594d291b0..8a09f18a3d9 100644
--- a/help.c
+++ b/help.c
@@ -44,16 +44,17 @@ static struct category_description main_categories[] = {
 static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
-	const char *prefix = NULL;
+	const char *prefix;
 
-	if (skip_prefix(name, "git-", &new_name))
-		return new_name;
 	switch (category) {
 	case CAT_guide:
 		prefix = "git";
 		break;
+	default:
+		prefix = "git-";
+		break;
 	}
-	if (prefix && skip_prefix(name, prefix, &new_name))
+	if (skip_prefix(name, prefix, &new_name))
 		return new_name;
 
 	return name;
-- 
2.37.1.1232.gc0cde427aa7

