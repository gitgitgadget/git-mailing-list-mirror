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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E122BC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882802222B
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iADkt44P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgJONjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387734AbgJONjD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:39:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA54C0613D4
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so3539306wrs.5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Y9zws2CNUY57fKoHnYF+f9ypkjcwCKCuwoRSnZPJdU=;
        b=iADkt44PI4rEzoOqdvWQCJnnzhr41BS3l7ibHDzrUNzYhg/hheOCigLeCP4E69gAKZ
         /EdZDk31ewuqqvPHKxFwsd4flik7SBlqHdQxVZ6wgVWL1sAzHNKCTlQuuxmMIIAaS7wT
         bHdReCZT/mEswKTOWkEhUtIePJdXByBbMdLKHWlQExkMzVHvDdRhsPNBhyD/3rka4PH0
         /sb6M2IXE98iABw8uTOlAC+xiaHUL35aoG/JxEle6vE60QpPsIsS3UkVaPQw1WH0Tq/Q
         wzmot+qxumCifbCKJduaOASboBMED2VD+tUVrTgu9d6y8wt/UcRHgr/8owjceCI54fPW
         b1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Y9zws2CNUY57fKoHnYF+f9ypkjcwCKCuwoRSnZPJdU=;
        b=GN955NojOwnnJrosnDbs6C/JpjMSGYGX7S5cKPg9f1Z9g+VqcHjyW7FD1m6Ycqb1ch
         akVcml65FvKDYWNzw/C4WDXgmmyagob/N0T2963pHACPuSnUUVNuXmKDD8Zk2sY5SS7I
         08PFR/Eu8XqNHN1rTBQbnYWr6Pu3Fk6j6B87zVCux1w5qYkPvy8PL0wXr/zf0l1STNGS
         Yry2AplwBSOiyW0/Pzby8afGwhoaoIDEjfbsQBIHlTx9P6z1JVn/6GsprL7gQ6dzV6YS
         1PVDXcw3Lh2lfEvbKwLgsabDZQjl2bUz4V3mTpIFylVs2fp9bx9BCCuiu6Pql9iuoofF
         e2uA==
X-Gm-Message-State: AOAM5322JEB1COVI4+zdP9EI/5LhP+qHeC9Gp1M1s41AeIIp6+YYOvLU
        ceeZz45jZYW5ycPXTX/5M7MsPgzb2Qw=
X-Google-Smtp-Source: ABdhPJyU/st6PYapaHRDgadSDHGVUs0M4VgNqeYQUXhiIMKGvMBT2O2HnC1pDvKgbbkkvHr479baVQ==
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr4383881wro.63.1602769141875;
        Thu, 15 Oct 2020 06:39:01 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id o4sm4709434wrv.8.2020.10.15.06.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:39:01 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v11 7/7] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Thu, 15 Oct 2020 15:38:38 +0200
Message-Id: <20201015133838.85524-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
References: <20201015133838.85524-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-autostart` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_autostart()` is directly called from the C implementation.

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
index 9a7e67a87a..709eb713a3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,7 +29,6 @@ static const char * const git_bisect_helper_usage[] = {
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
@@ -937,8 +936,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -998,12 +995,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart does not accept arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.25.0

