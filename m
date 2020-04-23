Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE73C55191
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A84821569
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbt0FJM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgDWHJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgDWHJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A439C03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so5498260wrw.7
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMQYmzL6CcZW6Tyz4lAKQTH5zrrLc29qKEjy3wnk4GI=;
        b=nbt0FJM6C1Lv1jJ7U8c0KOXFbDb+zrWPylTDyzK54hgIM1cC2qQ13ERd3+BdzNHWRf
         l/ZYRHrOxdn+l0hUkCLYSSltIcBkHQXd6bnrWTOB6pkeIIcocaqqfG8IGdvBGL5o3cr8
         AnHrJ5HROn1dcfCIdVRcqkzqPQx9OXIwwr7wz+jGFBhWasYByXSDBqzcOLGasgc8QiYB
         QPpA1z7btPbC1WO/w0Vl7Wx3Ofh6wuhGm4HDaXEJD/gISq3cDOmOHPEzyiRdHrx6y5PB
         To/XxY+4h+z5zaH8JEVmis7slfiQ3M/7z14m4vHsscjuMEZQx0/9W67v2zWJPtZofxX2
         TT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMQYmzL6CcZW6Tyz4lAKQTH5zrrLc29qKEjy3wnk4GI=;
        b=OUUrvtozGNaL/SrIazNSqCefiUSKYu9afhwVLBGLHLYoPn77pb2CShEiwBGL0FJO5B
         j8qr43bdMwQDkqOra78/1xicsHLkmeHcCJGyqktquBN8LLQClhE2/oWFcdKDupkbPnN1
         OVlLQqIVbj7CQDqzKBoElu1zKTI4IWu+s//FdKfoqO0NpgeFFhJyuAGsZ/C3rOpAOJIM
         y/D0+8h1APDdMx4+bHUYSZY9UQNR39obIlP3K9eYAbdYYk32mqQjjY5KMyOTnUdO+B5o
         7saH14lfB8MLeY/Mhht8Lf5YqFOkBnfXL0M79nMMSMzvad7vKXmamTo7VlgWC942RU+c
         G2KA==
X-Gm-Message-State: AGi0PuYWyU68sm4MtdAUPJZMz72e9WwQJuUxceNODKAExR+TlahbyIvY
        N4L7/MUD9QJNsT3dz+x3Z0PVqNj7asM=
X-Google-Smtp-Source: APiQypKGbqkmXMgevdsuNJ6UL99tw50NXghBeUxmFUVgeEugnS56tmRD4UsEqXxwSc8pzqbYvsgJhA==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr3101878wrm.375.1587625784799;
        Thu, 23 Apr 2020 00:09:44 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:44 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 08/12] bisect--helper: retire `--next-all` subcommand
Date:   Thu, 23 Apr 2020 09:07:00 +0200
Message-Id: <20200423070704.39872-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--next-all` subcommand is no longer used from the git-bisect.sh
shell script. Instead the function `bisect_next_all()` is called from
the C implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1b4d0a0f87..2d8660c79f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -838,8 +837,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -853,8 +851,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -893,9 +889,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix, no_checkout);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.25.0

