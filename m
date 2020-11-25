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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA5BC63798
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86CF20872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfER16YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgKYD3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:44 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7BC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:44 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so975977otc.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Op5vJWDDN2Q3cMBDBTBcU4vctNwMOESdbcvnV8xMkeo=;
        b=IfER16YDNWK6OAFKyKaRua1bhMAy0syVW6/gDpG0kjHdXK6njMa9i1rOvIgJ59nbqX
         3w2qf9PCF/j6+bLL3lP50o6HivX2pZO3Z+7pL3C+TIquTpcpJ+jvEnJ/pDOOGivIh7qz
         qmV4RlFJVkQ9OUGzfKp0IXNeQq0WRqfoYLTcPF7L0clicL3KArTmfIVlOlAf/D88gc9y
         lm4cVZlzwYzac/w/ozcAXvpeJjl/eNj3Jqh2pcQBRPJ3a9vo+GkYRsPUwwMe8fF8DY1B
         h5+omQk1VErFUehS8E/0WkpFWsQeSO+UDh4l2kzJhJBeflHcqI3/JSvHPQVaDE6nsu2N
         niJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Op5vJWDDN2Q3cMBDBTBcU4vctNwMOESdbcvnV8xMkeo=;
        b=OJts3owPJ1UGu8yYp5WqwmPr9UVpIKXK2sGUWjeqcZ/Y0nZpuvwOUC262Eyfg/A2GJ
         XTELFeht4v4IsVjVtmzmncXIHw+mvTCQ+v0OI5AeccayMXVv49pj/2ji9/haw/b8Wywt
         dv53TDL2iwpoQSWynRanpIgZAZ+44T5KVfay2oQMLEY6U8RwidgDRXXfaZs/yO4TPTPR
         ZC1BMHkx/HuXUyBGNGEuFNCMs3xZMUjt9Z8OrEbCZMOq0BVgAp97/TCiKfJkbi8N7WP9
         +BFZZnAKp3BKJr/f2Iox/2SDQR83rHaaow8pzwFAK1RKwTV6Tn7x5k++Hs9e0roRxQYz
         MZxg==
X-Gm-Message-State: AOAM532FeIWoAb0cpCmLH10dVclJnia64DUmLOzUWCCKiNbt1twFdH5q
        mVH5gd3sJS1EwaeM6Lbd0qiyX3z4MHw1lg==
X-Google-Smtp-Source: ABdhPJxoQTQMCiZ4cwJ7owhA8a23NS9PwFqUWwqT3kHCKocZWF3oy1pw3nTZ8i24W33IqvBvXp9fsQ==
X-Received: by 2002:a05:6830:3099:: with SMTP id f25mr1402732ots.77.1606274983852;
        Tue, 24 Nov 2020 19:29:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s28sm574817otd.2.2020.11.24.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:43 -0800 (PST)
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
Subject: [PATCH v8 02/10] pull: cleanup autostash check
Date:   Tue, 24 Nov 2020 21:29:30 -0600
Message-Id: <20201125032938.786393-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This essentially reverts commit f15e7cf5cc.

Once commit d9f15d37f1 introduced the autostash option for the merge
mode, it's not necessary to skip the fast-forward run_merge() when
autostash is set.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e2de0d4c91..eaa268c559 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -926,7 +926,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -959,8 +958,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1029,13 +1028,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
-- 
2.29.2

