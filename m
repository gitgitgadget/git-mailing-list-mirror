Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC165C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996762075B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnVPnM/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGGOVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOVl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A1C08C5E1
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so46739450wml.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8rF7VriGuQh3vLuIzYQ/wDRgJkYx/x6MvYr3WCpyaU0=;
        b=BnVPnM/IIKhrTwxvB7FrodRw9FH0aoLAP9nlaFG2Dg8yQsjKRZuOS3gurMUs8Jz1Tb
         iyFDKbIANBv5KknAGwSUK04RbxN9zvBYt8ZNeVp+RBTMiW9cZ8P/aIaS+mMPTVyb7MoD
         HDIZysYQh8YBeYoPoil4mlD5ghz9Wlsbs6jOLKj6WUY4hJZruMFpRFfacHjJ5EdjuDH1
         R2Ii0kCRkt5ETst4HZuOAG4+Er7yW6+7n0oWBhZ0YzVm6g9IpBKDvLJgrYmd0y54k26C
         EWziCBnC/as+weUVrH1+OdwPVJjzWesXMuQWkP/xvHtwiX8FJ9HKPrJlJuZgi2qwzkD5
         TBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8rF7VriGuQh3vLuIzYQ/wDRgJkYx/x6MvYr3WCpyaU0=;
        b=sIENz5eiSeiS50HZxvj6QKnFJBqhhjj9TdriDWbjU7qseEhI2fUvLW+qFU6s3x90k9
         C75od2WJUuAC/0ZMUgh4RxrI98r0YWoKCxP2i71oR0q6JUNwGwoDmo1hIJ32RzGnZWIU
         H6Kul2ufv2WtZDnfyieUL3lqtLK/WmRQUPIkkhYyZL66CCzMsHbAsdl198yH/d4Oytzd
         4JeyUsV97yBRnqddeCFvoYeHwP8aYrAm675vAjgPxHLh+MmMrH8IrZedxBs+OtHYeuQ4
         RYxTGFNBfa5ne9VKGWgwQwJgG5nspK47pd8jErKtHoYiPt9rr0BF7kffYQROLNzApNHM
         dqWA==
X-Gm-Message-State: AOAM533kBofI2G1aphR3lKeQmVldxSoG1Fd47Vz9unZTEMcu7rsarVpT
        P/x1JQT8DT7OPb1IaaKc/JMOwSi/
X-Google-Smtp-Source: ABdhPJwu0IQRO0Bw6MXhXqCYTsGWfJeMvsx2syIgZtY1vv9kg3yo3APZ0RsiRfBL3wcobICuMcnPXQ==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr4251865wmm.136.1594131699439;
        Tue, 07 Jul 2020 07:21:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12sm1198024wrm.79.2020.07.07.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:38 -0700 (PDT)
Message-Id: <9dfa9e8f6f3df73880464afe120ce912436416b2.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:17 +0000
Subject: [PATCH 03/21] gc: use repo config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The gc builtin is working towards using a repository pointer instead of
relying on the_repository everywhere. Some of the instances of
the_repository are hidden underneath git_config...() methods. Expose
them by using repo_config...() instead.

One method did not previously have a repo equivalent:
git_config_get_expiry().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 37 +++++++++++++++++++------------------
 config.c     | 24 +++++++++++++++---------
 config.h     |  2 ++
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6d8267cecb..888b6444d6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -116,12 +116,13 @@ static void process_log_file_on_signal(int signo)
 	raise(signo);
 }
 
-static int gc_config_is_timestamp_never(const char *var)
+static int gc_config_is_timestamp_never(struct repository *r,
+					const char *var)
 {
 	const char *value;
 	timestamp_t expire;
 
-	if (!git_config_get_value(var, &value) && value) {
+	if (!repo_config_get_value(r, var, &value) && value) {
 		if (parse_expiry_date(value, &expire))
 			die(_("failed to parse '%s' value '%s'"), var, value);
 		return expire == 0;
@@ -129,34 +130,34 @@ static int gc_config_is_timestamp_never(const char *var)
 	return 0;
 }
 
-static void gc_config(void)
+static void gc_config(struct repository *r)
 {
 	const char *value;
 
-	if (!git_config_get_value("gc.packrefs", &value)) {
+	if (!repo_config_get_value(r, "gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
 			pack_refs = -1;
 		else
 			pack_refs = git_config_bool("gc.packrefs", value);
 	}
 
-	if (gc_config_is_timestamp_never("gc.reflogexpire") &&
-	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
+	if (gc_config_is_timestamp_never(r, "gc.reflogexpire") &&
+	    gc_config_is_timestamp_never(r, "gc.reflogexpireunreachable"))
 		prune_reflogs = 0;
 
-	git_config_get_int("gc.aggressivewindow", &aggressive_window);
-	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
-	git_config_get_int("gc.auto", &gc_auto_threshold);
-	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
-	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_get_expiry("gc.pruneexpire", &prune_expire);
-	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
-	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
+	repo_config_get_int(r, "gc.aggressivewindow", &aggressive_window);
+	repo_config_get_int(r, "gc.aggressivedepth", &aggressive_depth);
+	repo_config_get_int(r, "gc.auto", &gc_auto_threshold);
+	repo_config_get_int(r, "gc.autopacklimit", &gc_auto_pack_limit);
+	repo_config_get_bool(r, "gc.autodetach", &detach_auto);
+	repo_config_get_expiry(r, "gc.pruneexpire", &prune_expire);
+	repo_config_get_expiry(r, "gc.worktreepruneexpire", &prune_worktrees_expire);
+	repo_config_get_expiry(r, "gc.logexpiry", &gc_log_expire);
 
-	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
-	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
+	repo_config_get_ulong(r, "gc.bigpackthreshold", &big_pack_threshold);
+	repo_config_get_ulong(r, "pack.deltacachesize", &max_delta_cache_size);
 
-	git_config(git_default_config, NULL);
+	repo_config(r, git_default_config, NULL);
 }
 
 static int too_many_loose_objects(struct repository *r)
@@ -562,7 +563,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
 
 	/* default expiry time, overwritten in gc_config */
-	gc_config();
+	gc_config(r);
 	if (parse_expiry_date(gc_log_expire, &gc_log_expire_time))
 		die(_("failed to parse gc.logexpiry value %s"), gc_log_expire);
 
diff --git a/config.c b/config.c
index 8db9c77098..fe83f8b67c 100644
--- a/config.c
+++ b/config.c
@@ -2211,6 +2211,20 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+int repo_config_get_expiry(struct repository *repo,
+			   const char *key, const char **output)
+{
+	int ret = repo_config_get_string_const(repo, key, output);
+	if (ret)
+		return ret;
+	if (strcmp(*output, "now")) {
+		timestamp_t now = approxidate("now");
+		if (approxidate(*output) >= now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+	}
+	return ret;
+}
+
 /* Functions used historically to read configuration from 'the_repository' */
 void git_config(config_fn_t fn, void *data)
 {
@@ -2274,15 +2288,7 @@ int git_config_get_pathname(const char *key, const char **dest)
 
 int git_config_get_expiry(const char *key, const char **output)
 {
-	int ret = git_config_get_string_const(key, output);
-	if (ret)
-		return ret;
-	if (strcmp(*output, "now")) {
-		timestamp_t now = approxidate("now");
-		if (approxidate(*output) >= now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
-	}
-	return ret;
+	return repo_config_get_expiry(the_repository, key, output);
 }
 
 int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestamp_t now)
diff --git a/config.h b/config.h
index 060874488f..085bcf6917 100644
--- a/config.h
+++ b/config.h
@@ -490,6 +490,8 @@ int repo_config_get_maybe_bool(struct repository *repo,
 			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
+int repo_config_get_expiry(struct repository *repo,
+			   const char *key, const char **output);
 
 /**
  * Querying For Specific Variables
-- 
gitgitgadget

