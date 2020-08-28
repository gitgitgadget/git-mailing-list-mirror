Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA9C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F6D20872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVEyuz9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgH1Mte (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgH1Mrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAECC06123B
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so1194049wrl.4
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjplHTeHYlf81AEWP3juSrt5cTHxoQA2uRp6OIai7kc=;
        b=lVEyuz9auZIQQ4PCVY/5w4vF09V0gNR6lVJV4ZyK+3n98ntyIrqF9fW1sHOD0CKAqA
         ZrhA+oj8VBJYDjAeO8EwlBo87ZAt/iG+RmWn26Rd4NYTLmQhbJw3xIooYrxtqvof5C+c
         a7FDb9FAbyrjASGYxWPaNjxTd8/nl4neUVx5w9hDDilj4ezugPPVY+K/pA89heJeg/2f
         el0uzb2KFaIm7a1+LgmlB/D09Y4pA+kM9u3RniMqblRD2znBt1T8JAGIsoD3al7z73/t
         Al++ujJl3NWW8EKI5UEU4WWnQ0KO27DLoP5tXGCn5GNsbfHASUbS9QqqqtgnOHGW88fF
         j3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjplHTeHYlf81AEWP3juSrt5cTHxoQA2uRp6OIai7kc=;
        b=ZPeUQLDesg8sOA7PxM5ADElDzYeoWa2FAS+tZ+ttF/4OrEYIfuIIhcfQ8IqsfaKyfW
         gn9LwkIcGbGY04LUNYdO8/xidVVeO2GgmPgM1AwtKGN3VIhDCPAVMgzI8sdCvnaZIy87
         YQkUbCqH9Qpp14c1IZRx9jibF9Fm/Ujxz5AQ4eS107D3WDnkwQtVvBbgfgaYbXX0J/e/
         QQmzL9z512DWz/fUHj9CrCAHPARsQYQgWttAa3nigFybjE9mLAkQyMoKObWpc2Hj2rU9
         NIe79lNRpz8I0ZKQ0THeOW9pnHMZsFSlMNskG+aVwVv76e7XUZDpghuePql+tUUjsTUJ
         6Hsg==
X-Gm-Message-State: AOAM530HdSvragOaCLgyy9h18wmz+NAxiy/0L1j3CBwkOGE/u/wAd5p7
        D0TRA4QQQYmH0qZSBoe66iMKYkbrWTc=
X-Google-Smtp-Source: ABdhPJzEA1z0M8L8hmWqamC1VTnWIdyarehLu5tjxGn1vmkJGE+4NF1hxyZaDXvxWzfZBfFkIqOgFQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr1270034wrm.285.1598618844923;
        Fri, 28 Aug 2020 05:47:24 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:24 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 12/13] bisect--helper: retire `--write-terms` subcommand
Date:   Fri, 28 Aug 2020 14:46:16 +0200
Message-Id: <20200828124617.60618-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
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
index d795f2e5c7..a6282d54a2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -912,8 +911,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -926,8 +924,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -962,10 +958,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

