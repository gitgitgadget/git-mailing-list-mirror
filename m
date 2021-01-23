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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246AC433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474F523340
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbhAWPnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbhAWPnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:43:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EBCC061797
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d16so7281569wro.11
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InwhpkEI0WqZil2a/LbOllLSCSMbd7WLpAL7F57X3qI=;
        b=OWhekC0BIUAmZjGSUXt0KDQVIoWcoq7CQ2h5Gv7rYzJ4QJybM9jsfzmRt6NtGLP7Fe
         2n6ZZ3QzZp6UOFhOroxh7puI2tbzYfxTiwPXmemqsQcr+8lSABStpzxuEcdW9EvY4HbM
         2K4hCAlgMJHiggIgqOCN9olLG4ShJiX7QeNar5IlgCwnKqVgzUCGIm7USqODv0Yx4t1Q
         yUuXG6BihFxFYwU2sHhjZKhtBPMTbDd2c0VZqmogxMNdg03Vok0NETibMMnaWjXqjUvZ
         CNDx/paHc1FHWaRnnhRfzBaCjLtfql0TyJobMunLY+4EPPT7l7+Iv4DDlj9avl4+F7CR
         LZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InwhpkEI0WqZil2a/LbOllLSCSMbd7WLpAL7F57X3qI=;
        b=HeTyPQfuD/VYSaILRlnhUk22nPpkCScDL/ynF9JzaNAyU/X02MqRuzjePY7WMj94iQ
         xDLqXDDQKOM27bcZAYtWCqFLma8MVATVw8Q9GRvclNqSNIrZTVWcJwsh2oSb+zCUhPTO
         GlMGr6BDSKgBqKubO91WvVmR5Xj1qQ/LdLc7rlLFlwQpqaHUpntv+DJoafequTjAQBX4
         R7gMLVuLy6+ifOEsDDVqtI1mst/WXA33vt1f0qFg1uW1oNVMcKev7vTo16N4NEqcGo/1
         Ai3akazVyV5cjbKDu6dqE65/WyZSqY5ww5rlALxVkO9R8RTpImnLl7REiWkA6tFD1GjK
         uDOQ==
X-Gm-Message-State: AOAM530M+7PxMOotOIbAgg2Kro4m2IRvz2uNCY3FAip/7U5oGuszP3kc
        nkR0YVEgLZ7Xa3r2f4ZWvRZSmUdMNMk=
X-Google-Smtp-Source: ABdhPJyZJoYg5fAHczsRCWbzX8C9IjKiXMYu9Ddtzkq6hRCRgtx8SrYY7FvzjQ7IpJtVu2hxCb8e8w==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr342338wrx.139.1611416515111;
        Sat, 23 Jan 2021 07:41:55 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:54 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 7/7] bisect--helper: retire `--check-and-set-terms` subcommand
Date:   Sat, 23 Jan 2021 16:40:56 +0100
Message-Id: <20210123154056.48234-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--check-and-set-terms` subcommand is no longer from the
git-bisect.sh shell script. Instead the function
`check_and_set_terms()` is called from the C implementation.

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
index 61ddaa6b9c..3b0a6a7d0c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
@@ -1027,7 +1026,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -1042,8 +1040,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1079,12 +1075,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_AND_SET_TERMS:
-		if (argc != 3)
-			return error(_("--check-and-set-terms requires 3 arguments"));
-		set_terms(&terms, argv[2], argv[1]);
-		res = check_and_set_terms(&terms, argv[0]);
-		break;
 	case BISECT_NEXT_CHECK:
 		if (argc != 2 && argc != 3)
 			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-- 
2.29.2

