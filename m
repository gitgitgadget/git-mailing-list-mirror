Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528BC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CB02222B
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjF8MP4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgJONi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgJONi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:38:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D04C0613D2
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so3499921wrp.10
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ow+AP6QkVF3SaDeNeaXjVuBTnDhi9wPFPl7+V6ytus=;
        b=fjF8MP4GZ4J03lG+guLmt1q4KI3ZlZYj0fio6irTQ4oBhPBqV0pLEwnUJtVRh6C8vv
         VqhjP3gSiryk9dYCvJyzAT7Pq7j7Blrd2uEfiCMxSgwLIl4dcjAnGJf5Lr+5A8+f2MEP
         3NM16Pod9nxefkAj05HIDXcOrzRo/QoxV7MbivXSh/62iUrT8/J9X8tD8O1KBZDuCfaX
         Xmen3SgWNhXi+mlW9XBjkho0y4J5iRM7UcUCAMnA2Dm8B1toZ6SiMWI3r8lmao66ktuv
         3dndAH729cgBZU9WBP8ws33ZSe7sKt9qILDbKceTV4hssBFBBE5c2rVbAqjsl1fSo9AG
         /46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ow+AP6QkVF3SaDeNeaXjVuBTnDhi9wPFPl7+V6ytus=;
        b=DEKQ9rOLc6HTdIYf/zBIA6Kdnvo+Fnk9lfCDuqjnHl+PzurqMcyqtTz2M6Pm+eJFgi
         R1vsQwtGt6cB49j3mNQRIkFUL+mLxRwtSblwb74SewGif1LFkgmN+HGu9M3ntcmO+Mmo
         iDCKImkN/ADyuO312RYn8oysQHd9JB3cnA6rwjFyvVMu0TbrPzi4mBqZeeP20s18ypHJ
         D5WCNJtXjRMJKv5T4pV1P8G7ZniX7jGbkwZBBiq88QuIZvNHqI/od8O5onZQN1q/83KE
         8CZfAtvBtwsj6OOK6zdsZxlwALCnhQrPdkKzdk9LowtZi4KkqS7nHqAQlb7WWjIogv5r
         Pgpg==
X-Gm-Message-State: AOAM5304L62vUGH1qkb66IoPXGfqRjiN4VhHObJk5RFMC0jsnLuYFuKn
        Dl5uZ5U6TWLPUNqVbEjrJGAy5nGmkoY=
X-Google-Smtp-Source: ABdhPJxUqp0NNV1LVxmFWf3m71J4EBMcazu2ai84Q8j07DNMfJT9YmCSC4gFd0zHuAjxNbinGHsmmw==
X-Received: by 2002:a5d:4141:: with SMTP id c1mr4365294wrq.113.1602769136108;
        Thu, 15 Oct 2020 06:38:56 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.38.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:38:55 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 2/7] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Thu, 15 Oct 2020 15:38:33 +0200
Message-Id: <20201015133838.85524-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
References: <20201015133838.85524-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-clean-state` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_clean_state()` is directly called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8adad68268..fbb9046737 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -861,7 +860,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -879,8 +877,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -922,10 +918,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
2.25.0

