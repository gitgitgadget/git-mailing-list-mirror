Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B8C3279D
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D5F2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gglXI6eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbgJJW41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgJJTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:51:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E1C05BD19
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p15so12450522wmi.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2odWCcl+peeWRLiAEIKMZhirbEEEvODwaGttKMWIFr4=;
        b=gglXI6ebySWcvh4w3E7uyRVWALPV/JeBejrx39Z+roUDJlOpk6iT2mTXIY9OKfJvtL
         WPpsCouylEhZzuz7iqp4pMKAjvGHKFb8NtUx1k068ETinWhnK9AmQ66qKezIER3oUGvM
         kVYDHMTjJWZBVlMlJw8nN0RpGJr/vqv4qkdwa8GQO3yF1r4qRO5z20ZSu+B1V/quPSXt
         8r8x481oWTNITQVYke+gVsfsuIpiQArfZMW2fVyNyXoKAB/J85vKyl2P2vWh2DYVnB5s
         OGstycAq1GM0dRaKzsh38OC4teUUTOCnhWfqUikxsoZdjC1m7hEThu0JsPcDmb6qe6vf
         lc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2odWCcl+peeWRLiAEIKMZhirbEEEvODwaGttKMWIFr4=;
        b=tIC2sm5aSrVql3wQBaMCoA4mhkHGFJVaSOgEJnuKIyd+3ATXgw/uWpcQB/HLSKFG7X
         mGglaL6lm+4nUZ7B0J6Uve+0qGVKClK+Sa2H9xncQ7H/LYe/B65E23ov89xOEbX6v5x7
         8O0G0t4pU0zFLd3kVPc+lrP7GNbFC381DmGXMV54XWuXsIP6veFvcoNiBV6pGHYCLsSK
         1hwgxE40gpJOnKCmsWQDE/NyByO1W/i+hHK/x05dVHKiOnhVVjszD03/X0KOzA2pyjd9
         b2YoJgyV5VnaAv46nGUntbWg9nRhwMY+cqu1nSEKj80uPe2wQh9bT+ufknG082P0vgHW
         qqyg==
X-Gm-Message-State: AOAM533YeOUClCkCS1lrOR2jHIlL2Hip8gpLV148Utkb9QTfPCdMOuDM
        BhxgSA3TrcMVX3dWtv71B4RBSzlYF3g=
X-Google-Smtp-Source: ABdhPJy6LraP9nHMss+2Dv86CjhViAlvCmTiEb6jN6mNOrrt4UTIN+XZPUj2sA2qqzTGPOaBdEQwDw==
X-Received: by 2002:a1c:87:: with SMTP id 129mr2847075wma.103.1602338936841;
        Sat, 10 Oct 2020 07:08:56 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:08:56 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 3/7] bisect--helper: retire `--next-all` subcommand
Date:   Sat, 10 Oct 2020 16:07:39 +0200
Message-Id: <20201010140743.580-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
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

