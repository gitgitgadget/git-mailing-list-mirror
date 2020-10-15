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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72759C43467
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229452222B
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWJk9nWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbgJONjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbgJONi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:38:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422BC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e23so3226532wme.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2odWCcl+peeWRLiAEIKMZhirbEEEvODwaGttKMWIFr4=;
        b=qWJk9nWbKnm3818QX0gr4fTaTcy3U5uXY2Bk5JQ6JFKLlzBYjlxP9syUZJW3+ZXuAO
         M5tjiVYi0k/bBNP0eFPuHxgJj6ZOZT3JO4ttk0przcO2o70DYKXuBMsCKbCwPC9+PCc3
         H50kPl0pJbKF8AUr9TNSDx8FHBUKNw8Kz2R2MlHeBZbCxhUkgbf9sEhYSwAmJauBo453
         vkL56GAiqG6W+p4ljkPWl1b0DN1nEngItclRHlFFEA+9uTz3O3ptS+SnN9DqeCVSkXTe
         /C0wzsGmPZyt31hJWIAsDN55fMxFMFx7+VA84KKXUxXahkUyjb/hONFKIAhigu3b57E6
         GEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2odWCcl+peeWRLiAEIKMZhirbEEEvODwaGttKMWIFr4=;
        b=ZLkwCbbX/tX/kH42sPAt7EN3y1A+3aQVcd6Io6ORRAnhuEYv4CwrabCHoYCOMwatHJ
         Kt4rW8FheOPYWntnZqL9HfE/S8GiVWPZOLjALiJroo6MWHyZTkquPOdzB8Wf1FUbhxN2
         PhguSo+Y7dBiXDJNs0fYAl2G643syo0WsxtGIJXtif/OiIrP2UDycaamVtgCEtUIavET
         9zt9pgezqIb01Do5ZX5cAJ/SpWI/YgiGwIu1TgI9wlfDn87Ccwi7NOqNdXYoYj4fSIjW
         b0O05JI8hzVnynoZKngd+1amGd1LbH+RbNUjd4iuVIGrQ7eZLOX43Zr4ralQyQNy2vYo
         pT+w==
X-Gm-Message-State: AOAM530qm5D+KVeHSdahkbjg+T0Zlzs7dgqzzJpkBU1uoW0vQulHd416
        rtSYwkG/Y2AsfDPrqjc9AtyOtpnGRBU=
X-Google-Smtp-Source: ABdhPJwTmtQsmCj8aisquNAjnGxi3Qoq94Mg24T1iorR7AXnEsNrQO+lAvkM+AX8fLXShukCPbJcpA==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr4024976wmc.76.1602769137202;
        Thu, 15 Oct 2020 06:38:57 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.38.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:38:56 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 3/7] bisect--helper: retire `--next-all` subcommand
Date:   Thu, 15 Oct 2020 15:38:34 +0200
Message-Id: <20201015133838.85524-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
References: <20201015133838.85524-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fbb9046737..f1a7cfbfaf 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -858,8 +857,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -873,8 +871,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -911,9 +907,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

