Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E5C43381
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC7B23340
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbhAWPml (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbhAWPme (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:42:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DDC06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r9so1313356wro.9
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFYa0euJy6W/rRv68hk7qePiLgkQVOOBw3w1miWkKTI=;
        b=D4r5cWbx8JlozzubYWXAaYeg9qBgQFiZ2Kzom8zaVcED4d7G/KTZcX6qV2nZFMzVg/
         Jzez798HJpzGip7DvJiDBiRg4h282OlDmUaVm1GEEy8HgutTJEd5aPvH1VPjgdc8DbOI
         N/kqHAof8G/MAFahwza6NQ2BDSJCv8/yUvN02HMSADorftYSTqS1By+YLbeDcC76+qNt
         y4QRaSuUaL4dAMMRj1O6fYwv7TqOscFoWY8cFqzImjweQoEDWRZmFuGOPC4ftPSzoWtx
         GQYGGc2uDtQARUw1CmpaP9B5IDE2bkR92Av+YVrWOSlh2O3ANkhC7bTbtSfJ4rwgzdh9
         IqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFYa0euJy6W/rRv68hk7qePiLgkQVOOBw3w1miWkKTI=;
        b=VinlH5Wik9gzNIAO3QvKNFCK33FdgiZW4Zya8kxuKHkQm52rPeuNcOA7r+f11KeOvv
         i62QI73lDGohGRSn7lK118ELpRM0DMC3SXT+wgdEoeUUqqJts5wH1Jk6fneEfQ5DO0fk
         u5D3BGIE0DttgkUbax30c8rp+I4DDs4sZPLP2qUHkFoEgMVS+BG6FCRGIJrLkGJCULYv
         gJmM+dqlLFbCAsDfbON92asJBNlqJ9A6QDNW39Xf1YBB2u20LVEZAuKB5AxaOZ5UYcNN
         krOYLvSyoZr6zJmAuYm2aEeAXdst0WSrgjnU4WK6WfCuitBFyTNW71t2eOaVDgpdm7+R
         cylw==
X-Gm-Message-State: AOAM530M128HLZ1bY/nejpUGWmgJ0/+Yp9KxsW0LSdL9yKhMvD4Y34f1
        LYy+ABgyj0pYxx/0bGT/Ym+5GmiYQHE=
X-Google-Smtp-Source: ABdhPJxwpE9BMo5KOUNZ8ZwOPQNIpFYqU7YDie7tys/f+07cLevzpz8SUelxGSbeAvSeV6qtm+f6TQ==
X-Received: by 2002:a5d:55c3:: with SMTP id i3mr9477772wrw.190.1611416512307;
        Sat, 23 Jan 2021 07:41:52 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:51 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 5/7] bisect--helper: retire `--bisect-auto-next` subcommand
Date:   Sat, 23 Jan 2021 16:40:54 +0100
Message-Id: <20210123154056.48234-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The --bisect-auto-next subcommand is no longer used from the
git-bisect.sh shell script. Instead the function bisect_auto_next()
is directly called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1ce0399ad4..1e53845e69 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,6 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -998,7 +997,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1017,8 +1015,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1071,12 +1067,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_AUTO_NEXT:
-		if (argc)
-			return error(_("--bisect-auto-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_auto_next(&terms, prefix);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.29.2

