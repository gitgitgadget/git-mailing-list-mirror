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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A53C63777
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E642F2087C
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbeven52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKYD3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:46 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42179C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:46 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so1004504otk.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+qUZvG5cVmpBLeKyUiG5isfp33kmjrbi203XrgYD3U=;
        b=nbeven52iW0K6SuBCSgZdso3eTcrAkM+FlkIP0qBs/67IopcYRrGINJMvQNBn1dpCJ
         rSqlJShUCh/d2o3gS+B9YkRVofnf1/C7uXgEngboPGOf164lJGvYQSfX7sdk9sgU4jwZ
         LMvmdrtbuWM8i+D4QDhvQYjb6lf7j77tqIX9wcH3UpFIp+7fCRVpMZkuJhQxhibVNOE+
         p6NSsK8Z0VMWZF0bv2wsPVzQuhdi3DNfD/lF9Q6LeeOvXjNsZ/tHPY/qxLTY+C+XQmqY
         oPPt1isgxlX8UmyrHjLrpVCUxWCpzaIfCU7l/pKnwSgdFrPk9rEa+VxptuIxxLIwu0Rg
         BKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+qUZvG5cVmpBLeKyUiG5isfp33kmjrbi203XrgYD3U=;
        b=tPi94Of3Nid3UZqXV470/E2m/k5BIl7KLRLfQVzoU5bQ7/8rRC59KAwBd4zkw3XXHw
         HXoA1M1g4suJDtS7IUw9/NCp6um1jw4DRW8qQSffZJbQY/9lQRS8paEKCAMTwQ0hyPG2
         kPIc5kTzUl34Vg5SBGkxiUI8Q6TPivIJeqmSWI8YnDFooT8aFCXr/pRZudYKM7+dLMgG
         o9rKRvQLRWg0t9jHO8btmor7lmmQ2UHeUecSeCPeT19tguuGLkHngIlzT0b7CpBzIgr6
         jJ1UP2v5VpeuxBmW5UvQE3mhkQqCwTYdfG+3sXHE6U8/lmwYPipED7yHosRjRyIOnBBF
         NqRw==
X-Gm-Message-State: AOAM53167/VmamDntY3abZC/Z2J0Ongmh49+bbcvLeoJJfC3aZRKNNv4
        ybXCKmG7bwlHQaJe3etFkqy2sMFjEHLcqw==
X-Google-Smtp-Source: ABdhPJxRdIjD94zNjA5RkntE+3KmpdfX3XqoNgRTbjDWjv/NO8FKn0OvT8OIZg5DTX/DT/OnuMLqfg==
X-Received: by 2002:a05:6830:19f4:: with SMTP id t20mr1357745ott.239.1606274985473;
        Tue, 24 Nov 2020 19:29:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b23sm622495ooa.13.2020.11.24.19.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 03/10] pull: trivial cleanup
Date:   Tue, 24 Nov 2020 21:29:31 -0600
Message-Id: <20201125032938.786393-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
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
index eaa268c559..121b9fb0e1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1023,19 +1023,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
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
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.29.2

