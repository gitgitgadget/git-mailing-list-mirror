Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E21C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFED610FF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbhIGMBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343712AbhIGMBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87268C06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mj9-20020a17090b368900b001965618d019so1365047pjb.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3cERjcbNlnJbwifK6FD7iB5NoU82EVBvapVDhs1eLg=;
        b=hq+vcSjtErxJ6n05u+FsbsMij90drE+z/zBLg4JjSOSxFluPdBxUpvioOLZ8LexZgG
         izDnmLarXTNkdmLgnIfvnQwoQce1c3S3GyVorRcaQYUOxQUW4OBZ5yCwlTdR+NUmvyd/
         1a7K3xm36prLy5F+bu5FoijHXZ3Owp9bngWO8oY1QRmXq2GZ2mD9oGTBQxVlcswVvWVi
         2ENS07SjdXONDsu7uF4SeoAb75zEtRTl45RHelqZ7FE+9XD+OqfQY6FhaZYNiUXx3UQD
         aKo4Wbc23HUrMFl8LXWpS5z209VMqZA+hYXRIkU02jUqdxS4KSTm/eLpouoehHbR9XUe
         Z9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3cERjcbNlnJbwifK6FD7iB5NoU82EVBvapVDhs1eLg=;
        b=T1xueApTxQtePzFHr2sTx1QYoskzEGWDZI8a+9JQepiP+YWgz7Z4A9XtOeSuszbrSV
         WsgkYmR2SifSRQ/N3Sh8jiwtKPI2KF+YdNTy5vfDDTtzKjH9+86sx3CayZGOfrrVl9Xi
         8NG2tsYTt1Vh3/SVimsD6CFZPzbkBIFCoQPTidopMnuD5hxgdiUXR6HWQSlLnuW7YfIF
         2NEqJDKSWpEha6svhnmM0taCsI1MbQYdt/QDSf02lfgoOgCZU9AuMNivLdMpq2EpzJGZ
         cJALzKy1amUtSGNI71oixtqfvBU4dHCgH3YJx54Y8Wd0Tp3aoJN5J+rIQTzOD8vPVMIS
         woLw==
X-Gm-Message-State: AOAM5319+dl3ILoTCXvXwdGvq2cDCYih8rFTd8HTh7H6RYVk1teDuuzw
        ZkIr3epTMnEeaWVId+/t9nkKul+bbVo=
X-Google-Smtp-Source: ABdhPJzRNUdfXJbR5uCoAe/Eg0Mpu0eI7ti7Dw0F9i1aNU0r9N26to+bgGhennBekostvuP6GuUiTA==
X-Received: by 2002:a17:902:e543:b0:134:1c02:285e with SMTP id n3-20020a170902e54300b001341c02285emr14365227plf.43.1631016034930;
        Tue, 07 Sep 2021 05:00:34 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:34 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 12/13] submodule--helper: remove relative-path subcommand
Date:   Tue,  7 Sep 2021 17:29:31 +0530
Message-Id: <20210907115932.36068-13-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This subcommand was once used extensively for submodule functionality
when it was written in shell, but now that we have converted the shell
code to C, it is no longer used.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9470ff3de0..7622d6bd24 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2582,17 +2582,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 	return 3;
 }
 
-static int resolve_relative_path(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 3)
-		die("submodule--helper relative-path takes exactly 2 arguments, got %d", argc);
-
-	printf("%s", relative_path(argv[1], argv[2], &sb));
-	strbuf_release(&sb);
-	return 0;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -3413,7 +3402,6 @@ static struct cmd_struct commands[] = {
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

