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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C06C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8C2613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhGEMfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhGEMfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:21 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9411C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:44 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso4426306ooh.9
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3nDhOz0tRDLaE4sAr6KDfIcnW3qkms9yGWANOVj9k0=;
        b=k8nNRStoi02YkrauAdhl48YiDUGORzkAOeRAoffIZtnXdFJx9SWm5LdaCV99OC5AG1
         CJb48JGDScVkUJdkny80HuQE44aw5F0aLCvv+VVbVprPlBwxWoXeHav3xLZP3B8Lk+s3
         oexaXufCm37483nwDg471LUJ44DRVYkwhUFW+mv0VE36uFpnOJIYVysq70++i4NBp6ky
         Z7aNBuu56aZss4j7wcs4YP7kP8FIx0Y/rijeOq0urx3xqqOI36LXUBzr4SYmC0jwpUWj
         ZLzzA1+PDkOOlC5g7DOCc3EusPhQp9k/jbFUToSMmfZ3C8LX2ga5mz0bGpg6Goupx3fY
         5+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3nDhOz0tRDLaE4sAr6KDfIcnW3qkms9yGWANOVj9k0=;
        b=OyqOtfaZYFJ/X8pGPg3o/sHyTY29tmmx0YeWke/CzOzlr1hBU8IOVrKNUCBRphew2H
         1L83q4YNLN0a18sWbwDobPDRrMqzEi7mfx3Ryvn8OvIE1V0o8C+oeq6I3x4ZZGet0mEi
         p/VH5P8YtPywZRpS7v+y+Q1szcTrjmE8cN4TdG3K3HwTFR9Fp441JHM7wWtFEtR5/wct
         uS5WpX2E7ZAmMkgFpCTMY5vfjTPwcMMu6FX3XlBSVUwtFUcdvFPnHE6iUT16GEj72TRE
         D8mdtvEaziOgYuFfzJYlLBYWyzzGU1THaA+bxIVZhumN9+JhWGoyHz4qNORz7oXc23aw
         xqBQ==
X-Gm-Message-State: AOAM532S4aecTWbDkSrzvYsx3Ne9AS2HQEsfVpdSCH+c9zZLxsdTGKGq
        Gt7mjjD9YRCRxdfAiyIaDFHAdNi7yrxIyg==
X-Google-Smtp-Source: ABdhPJySQUg6rOSpZXNflHTDbhPvIG/VvHJwn/9d9vcihnQSKcHkXrilXpLRrcaDPC5IKjfnDXnHQA==
X-Received: by 2002:a4a:9fc1:: with SMTP id b1mr9839882oom.51.1625488364030;
        Mon, 05 Jul 2021 05:32:44 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y193sm2694840oia.48.2021.07.05.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 19/35] pull: cleanup autostash check
Date:   Mon,  5 Jul 2021 07:31:53 -0500
Message-Id: <20210705123209.1808663-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "git pull --rebase" takes a shortcut in the case a
fast-forward merge is possible; run_merge() is called with --ff-only.

However, "git merge" didn't have an --autostash option, so, when "git
pull --rebase --autostash" was called *and* the fast-forward merge
shortcut was taken, then the pull failed.

This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
works in dirty repo, 2017-06-01) by simply skipping the fast-forward
merge shortcut.

Later on "git merge" learned the --autostash option [a03b55530a
(merge: teach --autostash option, 2020-04-07)], and so did "git pull"
[d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].

Therefore it's not necessary to skip the fast-forward merge shortcut
anymore when called with --rebase --autostash.

Let's always take the fast-forward merge shortcut by essentially
reverting f15e7cf5cc.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..a22293b7db 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -947,7 +947,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 	int rebase_unspecified = 0;
 	int can_ff;
 
@@ -982,8 +981,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1065,13 +1064,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (can_ff) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+
+		if (can_ff) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&newbase, &upstream);
-- 
2.32.0.36.g70aac2b1aa

