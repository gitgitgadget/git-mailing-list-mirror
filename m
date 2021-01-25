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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD59EC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8288022573
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbhAZFDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbhAYTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7EFC06178A
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f16so397454wmq.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rboGbPio/8esdvVcKT7zrjr6ldwqgY+uOQD8iI9ui0E=;
        b=jXMgmP4225HafldqH5kHUl3YmozKxedqV2NrGfrFxECC81VtHLzTKfCpPaf0vcOuNb
         +gWfa4in+ivPJQG68EzlOK719x8luE4RQSAsLsDhQNMPafSnJUdo4rmiFieDYqLVEDCR
         qlyasOQbFNblxu9qMq3bs3Yk/ZD0oV2DJNjigkkYRtzEVYYNv9tJxdGNOX38xhVuH6x8
         LZS9dXKIOhdEtMu5jus7U30KragZEgE/xxSD5te3l2Kjwj2v15nBpH+6mJgJaZJ9dsMS
         n6zVRhOrFcsLiHX0422D2xa4y+OzOBCRh5abY8yk0MD7nIatHFYprqtJOdJ1mIID8SpQ
         PvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rboGbPio/8esdvVcKT7zrjr6ldwqgY+uOQD8iI9ui0E=;
        b=uXBlNP+b9sZtMC5TZ53O3tuDKLMPQsmYhskNimq5tViJvt/qeCT4hEAQ6tKlkX0OGD
         3A798Cm0m9Y+9rAWusVTz0pxstnGJH5TxjwDdLo8m9TUNO6N6eAKVMZ+26k2jorvNn3D
         Lq3LX5TV88C2Z63UuvPgpE+QD6cf+tZCn00onT2XSNMo2U8YWHXfVq/U4/+n7ebNdqij
         mlArx38QAkjC8gpXic5FwjEK7Q0IDxMyFvGAn8BXctLudpTu0WecbY33zX64hZg8/DqI
         VtSnelXOOEvmn7oEdGKdidBb/jJcsgZbRqBn12m1THqwi/7miblEt3P+oJuf4NYz4d3+
         tmAw==
X-Gm-Message-State: AOAM530blAA2Yefc8/ajwtjjzdjkZkv4QvaAt9fhvy/TtOPsvmgnCuxr
        2e13qY+syiJTJcjTfuz0GDpgZcgUPq0=
X-Google-Smtp-Source: ABdhPJyViJBiaNRBLpJ7atNhqEoXN7IAlBJz7hcr000J9rd0uewpvB5HVHJd0b3WZXx/vgxi5Uj/YQ==
X-Received: by 2002:a7b:c20b:: with SMTP id x11mr1421590wmi.107.1611602247203;
        Mon, 25 Jan 2021 11:17:27 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:26 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 3/7] bisect--helper: retire `--bisect-write` subcommand
Date:   Mon, 25 Jan 2021 20:17:06 +0100
Message-Id: <20210125191710.45161-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-write` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `bisect_write()`
is directly called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d65b2f44c6..0b16653f13 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -994,7 +993,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1010,8 +1008,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1048,11 +1044,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return !!bisect_reset(argc ? argv[0] : NULL);
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			return error(_("--bisect-write requires either 4 or 5 arguments"));
-		set_terms(&terms, argv[3], argv[2]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.29.2

