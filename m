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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E3C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB21206FB
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgLv6BZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgJONjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbgJONjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:39:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C7C0613D3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n6so3482873wrm.13
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuE95BCqomNquhxZDflK3d51oTwTRc/eh+AAKZaOgTA=;
        b=tgLv6BZvwGpV5uYSOj1/O25cT52W7KWuhPSeosOkXjgwMu532UJfY/10+H4HPMoh1I
         Y5XxRVjb51NHPsL0vYhFlDd1Ttt/WhyQsQIngtPn54eY00k8uoIVRXKav1/DIfLXX1wh
         XWiP6D4gMJ5gwRTsIy7f3dx884tLDmq/d4BLcEJ5NdZBmLFlmfwXk8pWlT5QK9Bypn7k
         x5sI52yU0fxLsrAUHtu+Wla1cVn/jsxm2l6otnwm0l0E9hYJTZTuYB21Dgta4E4tYMmE
         OOlC9Ve7+xt6zdVymh75hW74Evj4XMAlIfKZVxgCWjeOrWzrIQMtMh+WDjKq6azYUqxm
         PT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuE95BCqomNquhxZDflK3d51oTwTRc/eh+AAKZaOgTA=;
        b=bjPQ6DVGfXOSNZdravJgOrW8KTSJkX/2ndIHGHSvNJ2mKF96dcte/XZxx70eGgIvps
         HSG+D6ZUUb0HH7R/1ky6uu8451BemGxUn/X6Fu2MxGbW6mlHlf5SY9QJx/IVPwM4Q4+j
         bXfP5BvsZVzWDgiEulBX3F47Q0Kn3ABTX4FVmw7xVls4BdOecOSjO5lqeH4toGXE0OQq
         uoSpEo9s3bzyHgulFl1IuwZiUSVHfmT356OFoRgd7nxSmCya3pBrQ9+6Zh6hgmflSoev
         66MR76vBF9XvVi+2C4N2ZdqY6u91vpbzfW75gb/3LZPnQEHwtYEeQV855ORLlSyffbI7
         c7ug==
X-Gm-Message-State: AOAM533OTz5V/WQpMjBAmWbGxHljE3aL2nV0LJZIzedl3l1QBmnPVwKK
        MI55E8KzyfWaDz9brIoQioAYp3EY4PE=
X-Google-Smtp-Source: ABdhPJxuy836c9Vtp/fkc3aWyxen0WozvjpEDE/X9QzVJdxa3X51oesoVf3qaX/gC75wGRg54b91Tg==
X-Received: by 2002:adf:e744:: with SMTP id c4mr4420755wrn.222.1602769140642;
        Thu, 15 Oct 2020 06:39:00 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:39:00 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 6/7] bisect--helper: retire `--write-terms` subcommand
Date:   Thu, 15 Oct 2020 15:38:37 +0200
Message-Id: <20201015133838.85524-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
References: <20201015133838.85524-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--write-terms` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `write_terms()`
is called from the C implementation of `set_terms()` and
`bisect_start()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 64a5752ce0..9a7e67a87a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -909,8 +908,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -923,8 +921,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -959,10 +955,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case WRITE_TERMS:
-		if (argc != 2)
-			return error(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.25.0

