Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A5C4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA2623A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgLHA2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgLHA2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:13 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F2DC06138C
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:26:59 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b62so14358790otc.5
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vykQSok/eZns+ORGhIYQlK+pzsgI831hsB1aSrSXMWg=;
        b=BKQchG0MvuEA9WhHcjWqyLTugml/HxKKw8a2PynC5fJmo6rhCTwwLLkKVU57jEkuQE
         FbI/L4KLhpzAL0ZjwME0MgFw37mqH7TtaFKPUdGc4HZJWxgC/whk5I3bwQUQdysXiiFq
         MQxa2d8RQrinh2sPZemjtmadBpQjsRWqE0FpNM9uIkiTZBZ5jksgPRUi/YpCqJk0Y/3C
         xdePlO6lSZjVgkd1MhO0/pWe1uEQ6yu6WU+eVwrB9EnQ4gOONYPyWV8Q7xwx7e+g4aLt
         5xOpMojsjCvOtoymk3OgrX5U+rp978sPSz4y2ay7Jl5PZP6h+iQ8YV4/j0cXUS5VoDmF
         3Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vykQSok/eZns+ORGhIYQlK+pzsgI831hsB1aSrSXMWg=;
        b=BWE5LhRu+vd7ePkoZH5unGvLp09YyW85f8g8BxKegRllNpnvrU6pBDRH5XOpehH5Rw
         21JTdQHwertU74obFoqs5tkHVcDTwvSRwKwSPT7rK/U0iK3eh5SpMQsb2Guu91WmodV1
         jiqSGblWtT4FnTGGU9o8a8hE6HRCDcQBtU40QSASK/gw1/DyrD5tDq7xJRkvWX//lpyd
         ku3mNY3CXePhEsKF3vUAh1gZDE9B/QAL72S9O9ROQyK6PFnPYqpyga6qFXd97f+dpwtQ
         LfJF+JBTRO3bfvQcYhmINwh7V1C+Dd2rm1ikCNCWefPTLZlUXJ2UC+Z4pl/0pw97m7+L
         U2Ag==
X-Gm-Message-State: AOAM530ovl9ibp+2LAFFaqLs/T6O07Ve7ZZBhOaMRTJw3B/cwUAHPGJt
        RUXk0G3wdvFXrrgwQXXeHMvYluHDkAGSi/ej
X-Google-Smtp-Source: ABdhPJw3Ih2hrp94dvYTydJDugLvRIy0HOuhR0LucKHynZ9vfTENld9ko7cEivgzZq0sYz2Onuf8VQ==
X-Received: by 2002:a9d:4d05:: with SMTP id n5mr14940646otf.99.1607387218851;
        Mon, 07 Dec 2020 16:26:58 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n190sm2981533oob.11.2020.12.07.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:58 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/19] pull: trivial cleanup
Date:   Mon,  7 Dec 2020 18:26:34 -0600
Message-Id: <20201208002648.1370414-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d44ca2ffde..6aeca4aeae 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1041,7 +1041,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 
 		struct object_id newbase;
 		struct object_id upstream;
@@ -1052,14 +1051,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
+
 		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&newbase, &upstream);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.29.2

