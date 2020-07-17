Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDABC433FB
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29FB206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSDKhDG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGQKy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgGQKys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4AC08C5CE
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so10472381wrp.10
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJcYt2mUNpA0cjBUBsvUOSqmydUqTP6lp+S0VQACTDU=;
        b=JSDKhDG8c0LXdYcX073TLKYXeoi7m1VFcZS7fFsPF6MjhWJJxzgm18JC/5SBmN/OMf
         Flt0i/UdBKqX9z+sgZO5aQ4WxmGIbzwmoMBHd6SsbLcqPWq2vZvU9axTVjXD9MILNixd
         lt6e3x/1thR/w6+GQJeGHYnO+lnqH7MCANK0ozA2tkNv5i5/mzponELsKW8oGG0nt0zX
         /fb0BEG9eRXRA2DBzdK0cNwPPTlpItrbsy7nD8FG6mfIN1U50QiJITXi7RCUvnIEW8G6
         AiX9DlWNUmdMfsCAWlcQd3HpIBfI+nePcLzOcYjxVm9u0BYX89RzFgL2/S0lAHqNGFEX
         ymkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJcYt2mUNpA0cjBUBsvUOSqmydUqTP6lp+S0VQACTDU=;
        b=COhj2OT0Re1UeS8eBAg0o3goZ3LUzZyCnOz3HFq+Kd1PNmsPWbV4yGpo3yTPQoEzfm
         QpYTncEj2V5FsB4YBYJJ9/bvSfdS2oijZikqntT0JUiwK7Ww/hn1nCnmmQyV2dwxnXx6
         IUQvrpMLuYMekurokCk2iTq3vA86KlWA+KbPjvR4VF5JS+bMYdleGkH4Jw1rY4TSOgyJ
         Y/F1ZgL8eYkKcI42Qsgvp60G7sghFHy+pd46O0xtNPRsFH0XcmIPCG3Q5qNX3PsY/leY
         ohdwjW3pP0droMslSBfGXRAY4XFBs4Onuflt+z2WTupqobT2jrVB4UP0CJgcF7q9AKrC
         7B/w==
X-Gm-Message-State: AOAM531zX3eq6Dbh513+RMb4v5PVZTOA8FlW6EyxTBOmFiyDhhi+PkTI
        yPdga+q1FgljMiRpNKisrzrGKaR4
X-Google-Smtp-Source: ABdhPJxGYCEDDPp4J0UiO9+k38gVCcJpG1R8dbcnTtFC8yXfSPk1gqC3UqvxWFd8755lHwhgtupv9g==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr9196818wrc.377.1594983286635;
        Fri, 17 Jul 2020 03:54:46 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:46 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 12/13] bisect--helper: retire `--write-terms` subcommand
Date:   Fri, 17 Jul 2020 12:54:05 +0200
Message-Id: <20200717105406.82226-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index 370d344bbd..6f42e968ad 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -904,8 +903,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -918,8 +916,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -956,10 +952,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

