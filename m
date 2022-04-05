Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382BC433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiDEFXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiDEFW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481BF2A8
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s21so2476357pgs.4
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZ6q/DOY90CmlaMMMxljCTC8+k2CO8Dd5wMud2DZ1Fw=;
        b=MXUswwdvfoT6ybjxZHcxGgUW8DtFRZ/3J/IK+QzNOUZ2G3WhWCHkzmX31iiHm8Fv3n
         k/gbVtn5c2zZtt7G40uw+yf5dKekY+mfHUztix4GqMGSH7QvHTKfK1BfaMHYRisevJeN
         RoJ7taGh6ilCkLeQjhjCwNO6DhuZ5B10a4HmeJnypFW5qKMKwTw9VJtuDbesBCBzaIqE
         oR/2zxuIsCKer/ZPJ3PUVhejW9VdqEnjlZH83cZ3DOF9lSQqoD+QWWIuHxuC85i+Twa3
         +ApeMg+GtLaWpOGEN+wAbTohvxoz4yVEOE1KGc7DlwAd4tTDcQymKnmZ82ym6N7NOSq8
         fvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZ6q/DOY90CmlaMMMxljCTC8+k2CO8Dd5wMud2DZ1Fw=;
        b=TEl68UOE9KZdNevJimMD8EQnP89tYk11GiaMlNovedfDLyWiliPWinlWmP3fmDZdEv
         sO+7Fh5oJBrZTOV7/L45YPm4Ztv7ukRkzD9zjcERrqK7GstGiuk3G5baw2b7cEwrRYQK
         4qK47CLavFuZfX2cXsPQO9WWJIrryiz0hVUjpboFd84zB0paEKSHLQ/ALH7Tz4sOXxcV
         C2mbUbPdkB+6B0OVboiI584px1r6Cow0yvY8WFsTd/p+slkBLVqt1qpq90/LZuq1W4yf
         YSmUCBUKOfBCUvVs7nYKlh9bZkXTJXe69rQjPBEf4HFzqNgIk8BtF027iqw9aNZFgNSH
         I1HA==
X-Gm-Message-State: AOAM530uiy5zd13+0Mj4pPmbAS1Rdcq5YWbfxszk1vNeP/55v9ZJLIpR
        SFwzxq/qshWm+cQ+4fpef7I=
X-Google-Smtp-Source: ABdhPJw6ZniVkIIJsf2SDyMG65YSlTWiHwJIG12jT49k4vS7zXUir87H6hqwhUlW2QYyP95IVrweNA==
X-Received: by 2002:a63:6a41:0:b0:386:5d6f:a643 with SMTP id f62-20020a636a41000000b003865d6fa643mr1438939pgc.169.1649136030736;
        Mon, 04 Apr 2022 22:20:30 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:30 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 06/12] update-index: use the bulk-checkin infrastructure
Date:   Mon,  4 Apr 2022 22:20:12 -0700
Message-Id: <20220405052018.11247-7-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables odb-transactions for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
batch fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will be in a tmp-objdir until update-index is complete, so callers
using the --stdin option will not see them until update-index is done.
This risk is mitigated by flushing the ODB transaction prior to
reporting any verbose output so that objects will be visible to callers
that are synchronizing with update-index by snooping its output.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 876112abb21..43c713c0873 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -57,6 +58,14 @@ static void report(const char *fmt, ...)
 	if (!verbose)
 		return;
 
+	/*
+	 * It is possible, though unlikely, that a caller could use the verbose
+	 * output to synchronize with addition of objects to the object
+	 * database. The current implementation of ODB transactions leaves
+	 * objects invisible while a transaction is active, so flush the
+	 * transaction here before reporting a change made by update-index.
+	 */
+	flush_odb_transaction();
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
@@ -1116,6 +1125,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	 */
 	parse_options_start(&ctx, argc, argv, prefix,
 			    options, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/*
+	 * Allow the object layer to optimize adding multiple objects in
+	 * a batch.
+	 */
+	begin_odb_transaction();
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
@@ -1190,6 +1205,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * By now we have added all of the new objects
+	 */
+	end_odb_transaction();
+
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
2.34.1.78.g86e39b8f8d

