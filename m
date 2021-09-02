Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E40C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9D0610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbhIBNNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbhIBNMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC12C0617AF
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1102349wmh.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GW/Y1V7q0QExsDkiwHKKYGiE4lHKcaBesB56xZbXBW8=;
        b=SGKvN15S5P7wIu38NjLZV+fZ2UFx6kjU3jWBnJwF8XKjA6hNpwziy+KUMDBaldFbtt
         BudLdHlBRSD4RvH27ZoutdNQx6RyN6XfwSwHuYXGMmUBFDwQMItp72fPYrY6I9o3g50v
         0kIUsqFhqcd3ELeCIlS4vNybfgg8jxElbxWI4IhLoXbRf2hTzfab4LXJTin4MrXEEOLj
         Xx5OZJ+dDpa+1+LCoxcpUg+c2dmUaobJPDHA7j6SCigLLGHSpbkG6kiXjFQBrptd6W3v
         yq1pgP18rVvrBHT1Mo3Hr7+xmSYLRydKLnpV7kxRtWblYzbuKyKvq+wJc26TDERPziW+
         CmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GW/Y1V7q0QExsDkiwHKKYGiE4lHKcaBesB56xZbXBW8=;
        b=JeESic8hZwPVjMFQ9xr5+o6Vs/8btt9YjOPX1fZ5YcZZ318gogU24317NNcAfz7/fZ
         AX8m83o7YNNs11aIQTTi3XF4RIpqIpk3JlfdJA0Oq9R99ij4S3jyVMLbUOjSveOcapii
         QPxNECZbETmzpP56HiZyWAUTus5zsrpfAsxudxZpAZf3i++xvWFuYbzPjjtpJJpFXtCq
         kGBfuJ94IOBigpHHmBC2dQHaayPC2LXZAfn35fSmUBDKHvyqUh84EJIycGb8xv7d1eGs
         3SyMNnr5r9UXVe6ZDo+JYlZljNjZtU3li0XEXfviSjM56B1X7KkfhqfE4SPyh83XT2zw
         s9qw==
X-Gm-Message-State: AOAM533nW8b0HZ1DeL16ZmTzFLI5vavkla+HrYAAuZqq6UUdEpaSV6I4
        TYJxwXBROgASJiTQlDC1r2tdfl6VIXgGTg==
X-Google-Smtp-Source: ABdhPJyp9+cqHE37k3rYu1JXbZ1VLmbacVaIFtpZytGN6iVw5fIfKi8YDJpiVaSnLdW8Ig2mufAvkA==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr3167869wmh.2.1630588312510;
        Thu, 02 Sep 2021 06:11:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/36] rebase: convert pre-rebase to use hook.h
Date:   Thu,  2 Sep 2021 15:11:10 +0200
Message-Id: <patch-v5-10.36-d71c90254ea-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-rebase hook away from run-command.h to and over to the
new hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c284a7ace19..ee68a1df492 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1313,6 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2022,9 +2024,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks_oneshot("pre-rebase", &hook_opt))
 		die(_("The pre-rebase hook refused to rebase."));
 
 	if (options.flags & REBASE_DIFFSTAT) {
-- 
2.33.0.816.g1ba32acadee

