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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAECEC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A16208C9
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh0fxJOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgH1Msx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgH1Mr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29FC061239
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so779479wmi.5
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKnZ+drwbqtabpSBbsR1ki49dxB2yuxXqAP0x8+0NXk=;
        b=Eh0fxJOQX4dvzzWEz4JAbZbtbfSfiEQ0K2xKrRQujQKRZGZU5yEqny0mV4jl4xqq5K
         6WI9Hg3ArglftG8kLhzxOInG63C2+Et/tIFGkPeQOikwuln+ZRWCUmdEs5PN/RopOgCT
         4Gj4neDXwdHAGFAgcufxztNZWA+c5FNg+WaIuakvIgdePU7Wjwjye7hEUBaxJx6QfTdR
         Z+woygtl69rKwaQx8FHYt7St8+ClpfaEsUX7PaN19oaJUavMGnkpldIyt7HMHHLffnJG
         Am2NEZi9cWpY3D8u6P9kANDkYsIrJY79xEvDYyep+zlVrnGvsQHOHvBo9q8SRo+J5698
         Knxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKnZ+drwbqtabpSBbsR1ki49dxB2yuxXqAP0x8+0NXk=;
        b=F3AtIP49VT+pJ6kTtfF8iOaAaHmT/A1lw0F9tOQ0axg2IO1ZaSgUw2b6PGI2wv7LGv
         cS5cai+oILfW6bWopvDqGkzh6I/bTeK2Pc0hVrhsRGhMbyj8Bo6FwwT753btXWrcys7G
         0tvt98o5hEt7eUoSSVFwdakDlFg7joMgMAuficnWavgpzEOvzkfRYldgHeqgj5Kb0s7+
         sp5nd+jnVAQoVoI0IhFnRdYsLqv+ZfANCW7yxil9PVny0/oJBTRjRq/pUQ/k9rI4Uuwq
         g8vP55yJ31SDTyZi5nYPJ1IKHuf2Tm5nm5BCOFxuv7xVxtm33JCOK+GrJHZPdGiz2U9Z
         x4AQ==
X-Gm-Message-State: AOAM531vKv6PQ4zw+c/zslt1MR7S+HlTjS2EZizaDbklEXqErDj2LHi1
        nxT/VEmvCq6zfSJ46gMueEq9yppVgJ8=
X-Google-Smtp-Source: ABdhPJyEInW/k/4Ai7w04dGhlC9q0rJivng6DZVGJvZn2l8yTRItFEYxLQn6YhpxTmQt8MiOY4OVQQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr1437375wmi.101.1598618840803;
        Fri, 28 Aug 2020 05:47:20 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:20 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 09/13] bisect--helper: retire `--next-all` subcommand
Date:   Fri, 28 Aug 2020 14:46:13 +0200
Message-Id: <20200828124617.60618-10-mirucam@gmail.com>
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
index 106e5b788e..0a32dbb68f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -869,8 +868,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -884,8 +882,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -922,9 +918,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.25.0

