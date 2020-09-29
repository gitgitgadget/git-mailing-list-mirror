Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0FC47420
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D376208D5
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+YMXe+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgI2DhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgI2DhA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:37:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E91C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:36:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so3674427wrr.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uu/wCSr6KcnM5nnbEG8y3u2NoqHZnzZ5apgvN3yTBbw=;
        b=t+YMXe+R7+BOcsdaezWISpsJ3ey3DqWI8i5WRyYVF2ffvE/4tO1pxrupyhmzKOLAZt
         nKx+DwdGycrcAKpwGmR9dkKFLAmaSZ5wQVREQIARuLoCwQ6maHWprNKHgWGLr2h5+eHd
         UqR84EVORS/DDzsfKv4PP5sQPZ5q1c8Di8DMNXEB4NsUVdcqq7w/vSGbCh1zIKe4boQQ
         LKaZDJXU90KZyZtJQdMWTayJgY0DldOrNF5jY6fI1ok2GW88A/rs0aMM6ApzJhjCX0gr
         RuHrrfDvFaADV8P6ahgELagyvvTAnyMGUhwOhQwCrOVYslD5o4ALXPQFZM9v+dujVq28
         /ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uu/wCSr6KcnM5nnbEG8y3u2NoqHZnzZ5apgvN3yTBbw=;
        b=CFEQaCG2gYnnh8kuJ2Ln7ovtFAOfYeZhNa99VEZeJ/Qqkvv+n/3z4i0Ci1ArBV7RTt
         fa1B0LTtyBp5wyAR9+yNiCbKHM0MaGRn/todkkN1+Qv6Cce11V1LchH16IHUxeTStfQF
         ZF1cfgYIoe62DrYP+imOU0LJ5DgJ7I84R6aDwb0dIS6IItfYEQdcpR7osLkiJf2rigYM
         yQhlL9RIv9Zf+NUDpt5m28lgLQ5kz1Au70ZhyrhSCCGqfzFOfupftAaak2enPz7fKYYn
         gtamxRvior8X87KyZ9wEXrLnOZuSjAP7J7RuAL0cyXDrnPoGDDsZvKhEA4ly7AlZ92jA
         81Yw==
X-Gm-Message-State: AOAM530tBKhSPTMMi9iT9m5JViAQ5B+oYFGC5T9ycxGfSTHwpI5nqSwq
        IYtky/BTgKCDT0enYz4YxgIcWxDmwL8=
X-Google-Smtp-Source: ABdhPJy+Tuof2fos/G1fl2zQUhLZIWg01sUcLKR7t8EmV94+mR1rlUsYUvyeJH6vVmm0TccWF3wnVg==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr1552658wrn.238.1601350618259;
        Mon, 28 Sep 2020 20:36:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm3769083wmf.32.2020.09.28.20.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:36:57 -0700 (PDT)
Message-Id: <e3479e7b351361a4aa0c6aa4d98f91cd30ea14dc.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:50 +0000
Subject: [PATCH v2 2/7] clone: use more conventional config/option layering
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Parsing command-line options before reading from config required careful
handling to ensure CLI options were treated with higher priority.  Read
config first to let parsed CLI naively overwrite matching config values.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sean Barag <sean@barag.org>
---
 builtin/clone.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fbfd6568cd..93ccd05b5d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -851,8 +851,22 @@ static int checkout(int submodule_progress)
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
+	 * give git_clone_config a chance to write config values back to the
+	 * environment, since git_config_set_multivar_gently only deals with
+	 * config-file writes
+	 */
+	int apply_failed = git_clone_config(key, value, data);
+	if (apply_failed)
+		return apply_failed;
+
 	return git_config_set_multivar_gently(key,
 					      value ? value : "true",
 					      CONFIG_REGEX_NONE, 0);
@@ -963,6 +977,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct strvec ref_prefixes = STRVEC_INIT;
 
 	packet_trace_identity("clone");
+
+	git_config(git_clone_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
@@ -1124,9 +1141,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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

