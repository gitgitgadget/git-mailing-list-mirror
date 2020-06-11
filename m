Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500B0C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B6E2072F
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIdzB/hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFKG7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFKG7j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 02:59:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86503C08C5C2
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so4925147wru.6
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2BI2zOKCYnv4HUooTIQLIlweJ3GRgVhA10HSsWAgCYs=;
        b=oIdzB/hTK9AfT7nNGEQPqVmoJugpHxn0jo4PXWEdcPNdPdo9EBsn88BmnMCo3bTkDO
         jvba+uWhbk1UX6kETBHNaUrkGqwoVOVuXTWqicw+o0aE0bM0muHyR7PqQLe4EOPafdog
         N7xO1VbRcEmu56bCcoAR+BCHE9dwTrKtc2tZMVe+23TEhNcL2v8hXJqd9v8Ly6zWeh9I
         h1DN301DFAiNo/rPBSIum/aKC+sNdSZ4bEhvLDAiNi1on+/e2sA0v/AVUFaGP+2cAXZU
         137TWoVNTghHd16QCfGSycYAGZUjZt2zYB0lk86AAuZq9cm3lRDHJRJ8ml6sPnCdBjzv
         iGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2BI2zOKCYnv4HUooTIQLIlweJ3GRgVhA10HSsWAgCYs=;
        b=QQxOa2qW+sildNm4pzlaw2+IwgnhFFeL4O2OqvBPePUEiwHJMpg0afAZqcIQV7+Zfr
         BN+CPOoZogGCEPBKtObKtS+Znmdzo2ktx18zXfLxds3R6RC72JHDcnzPU/45/1a7tF8T
         2fs1XgcXtH2eCiwr9ZcAG9Gumf5nZ+U/FsYyw+3o0Dg+Vk2YBKjVDnZp2ac9cq8dRVxS
         QQV+nXxyui7Fiw0g/OEA8+yM1ErMqZtc50iHYKfcS+/PXlyzu2XzhcYivtqaBIibapiZ
         +nAqBDUyY0HaFQfuYaPqDuHQj3Z/r5Z7yw4LgJeOnMxr2KOp1uzd9lRr1rZttfCBFBwz
         +PRw==
X-Gm-Message-State: AOAM532Zh1B+xKJMj3jZqcRf2HKu8GbdnwJkzRsFSBab9HzsZYoY8LHA
        Xcnn1Bd/y9X0+f8zLKIGvIikwnjM
X-Google-Smtp-Source: ABdhPJw0y4IIBaw+wG9TRh0pfJjM7Bw9JLSgF2vmy5C1Cb6foEp2dbEDHEx464h6ZbIgOG+StVeHwA==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr8043796wrm.142.1591858778079;
        Wed, 10 Jun 2020 23:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm2714035wmc.0.2020.06.10.23.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 23:59:37 -0700 (PDT)
Message-Id: <e6c700b3b4fa064c6a78e6d3ab262cf105b0e1e4.1591858774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
References: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 06:59:32 +0000
Subject: [PATCH 3/4] clean: consolidate handling of ignored parameters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bmalehorn@gmail.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

I spent a long time trying to figure out how and whether the code worked
with different values of ignore, ignore_only, and remove_directories.
After lots of time setting up lots of testcases, sifting through lots of
print statements, and walking through the debugger, I finally realized
that one piece of code related to how it was all setup was found in
clean.c rather than dir.c.  Make a change that would have made it easier
for me to do the extra testing by putting this handling in one spot.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3ca940f83a2..1be437bd5a3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -924,12 +924,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			     0);
 
 	memset(&dir, 0, sizeof(dir));
-	if (ignored_only)
-		dir.flags |= DIR_SHOW_IGNORED;
-
-	if (ignored && ignored_only)
-		die(_("-x and -X cannot be used together"));
-
 	if (!interactive && !dry_run && !force) {
 		if (config_set)
 			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
@@ -946,6 +940,13 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
+	if (ignored && ignored_only)
+		die(_("-x and -X cannot be used together"));
+	if (!ignored)
+		setup_standard_excludes(&dir);
+	if (ignored_only)
+		dir.flags |= DIR_SHOW_IGNORED;
+
 	if (argc) {
 		/*
 		 * Remaining args implies pathspecs specified, and we should
@@ -960,9 +961,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	if (!ignored)
-		setup_standard_excludes(&dir);
-
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
 		add_pattern(exclude_list.items[i].string, "", 0, pl, -(i+1));
-- 
gitgitgadget

