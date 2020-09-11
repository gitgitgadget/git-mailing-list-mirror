Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4361C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A5D2075B
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uU3bjdk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgIKSZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIKSZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:25:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B07CC061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so5242714wme.5
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lKnTUaXU42KOdD+nLg+EAN4a8kOc4vtItw71t0XzJ+w=;
        b=uU3bjdk5qbSHimKwKqz7OlIaqFuJzI64EaBTttM4+wjH0qE64T28maHHX/ThQNkbTB
         IHKwZozS7ROjg0J+eDccgTmWqTO/nAATKgj2iM/1DpgyXL7Ynbi9JVB58xthr98ngOYT
         omZ0OyGriypsKGK54Yx/+4XhGI2TgRQ5IZVXRiRwusEDRr/tjWbESl6XBG/R1U21tVw8
         zWvla94qOtTHvJ2lxsLwZXTlsnNsuKM/crMcg1X48X/8OY971FTbFD6jYDWrgLmo5y7w
         qgUyzl2dWihrWgmEyYTOoSzOdH1Jk4TUoW/3N26H2PXom4HhWqSNhX7OpmyJ8deycp1g
         +KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lKnTUaXU42KOdD+nLg+EAN4a8kOc4vtItw71t0XzJ+w=;
        b=FqTj+Hg6BGJlmrEJGRdESsY3KPcqz+GLgYRn7worq2xo1SZsUPgmTz2xjDdvUhdhBb
         RfDff7HgcUCq16JqJpA8SmxKUkfimQyhwLXXXFEuLUl7zXhMU8337UB2OLjcXt6CKmmp
         iGITLoWYTqP8gJ/OWtu698RSAmLP5HkHkDMoM9L+S0jz1Tge9wrG2KegMOg4OqODSH9S
         J5vZ3+aq/NwgE/769+5xX8vAYCMPf2ndJPDHeu9hgtG2JFp8qWrtdHARNBqwNvH4dOTd
         vu2jXt7JxhyD/ZP6i8ITo7uVCMbRZTzpsn/OdlOZdc0WEYSUqnhZvnVF93f9/9uYVs1+
         BHIQ==
X-Gm-Message-State: AOAM532H0zkRVnNzCuZygQrQjdT+aJOsu3e3LCYosvEb+P0H+MSRFmlX
        MlSVYA7I/qplYkkVAgDGnAYwWXmggvc=
X-Google-Smtp-Source: ABdhPJzdbGsJiHTSAQDbYiHpGoFu4eTFron9vwTy9294RMKOWxlKFPRqOOlqDHsgVvUWA3W09Jn4Bg==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr3439260wme.8.1599848729673;
        Fri, 11 Sep 2020 11:25:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm5845973wrv.94.2020.09.11.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:25:29 -0700 (PDT)
Message-Id: <51ef776f8523d29dfe03d15f0d1958f5c456c057.1599848727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 18:25:25 +0000
Subject: [PATCH 2/4] clone: call git_config before parse_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

While Junio's request [1] was to avoids the unusual  "write config then
immediately read it" pattern that exists in `cmd_clone`, Johannes
mentioned that --template can write new config values that aren't
automatically included in the environment [2]. This requires a config
re-read after `init_db` is called.

Moving the initial config up does allow settings from config to be
overwritten by ones provided via CLI options in a more natural way
though, so that part of Junio's suggestion remains.

[1] https://lore.kernel.org/git/pull.710.git.1598456751674.gitgitgadget@gmail.com/
[2] https://github.com/gitgitgadget/git/pull/727#issuecomment-689740195

Signed-off-by: Sean Barag <sean@barag.org>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clone.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b087ee40c2..bf095815f0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -851,8 +851,21 @@ static int checkout(int submodule_progress)
 	return err;
 }
 
+static int git_clone_config(const char *k, const char *v, void *cb)
+{
+	return git_default_config(k, v, cb);
+}
+
 static int write_one_config(const char *key, const char *value, void *data)
 {
+	/*
+	 * give git_config_default a chance to write config values back to the environment, since
+	 * git_config_set_multivar_gently only deals with config-file writes
+	 */
+	int apply_failed = git_default_config(key, value, data);
+	if (apply_failed)
+		return apply_failed;
+
 	return git_config_set_multivar_gently(key,
 					      value ? value : "true",
 					      CONFIG_REGEX_NONE, 0);
@@ -964,6 +977,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct strvec ref_prefixes = STRVEC_INIT;
 
 	packet_trace_identity("clone");
+
+	git_config(git_clone_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
@@ -1125,9 +1141,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (real_git_dir)
 		git_dir = real_git_dir;
 
+	/*
+	 * additional config can be injected with -c, make sure it's included
+	 * after init_db, which clears the entire config environment.
+	 */
 	write_config(&option_config);
 
-	git_config(git_default_config, NULL);
+	/*
+	 * re-read config after init_db and write_config to pick up any config
+	 * injected by --template and --config, respectively
+	 */
+	git_config(git_clone_config, NULL);
 
 	if (option_bare) {
 		if (option_mirror)
-- 
gitgitgadget

