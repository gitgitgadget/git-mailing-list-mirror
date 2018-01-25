Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0810B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 19:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeAYTIW (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 14:08:22 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36307 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAYTIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 14:08:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id k68so5655060pga.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 11:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JCOV5Cf+1o3jTqdFTHRi7zAB/w1aXPPvgAe8NmmqKj8=;
        b=Oup+i8gXZ9dR/McBHUYWzz2z/3J5cG8thT4qldSAp+NH1fKxTjaQLdCRkLOQ8WEYNK
         5KMg0+vS/M3lPhR1LFON4BQDH5gTmzHttboFhYOw3/pnIpI1QbNnkX/PucdmnRJJdGxV
         /py0kjhMC0zTVXvrS+/nFnJf5MPze9Mpig/tl5YgZZN8PX3FD0bjildMJ5QfxiQfPN5+
         2S+2fhLsW/7mIdGacwFoslxxXURru1BFGLbStCP4qt8F8uXnhUIXx1JE2y0Vi50ym9Cz
         2wu5WPH2XFByX8R9fwkKjwlVIAh/+10JIodxdEV+4eeNo3clWM84PVSyQ+YA92K92CNY
         QOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JCOV5Cf+1o3jTqdFTHRi7zAB/w1aXPPvgAe8NmmqKj8=;
        b=c9HYBrXUthDrkXsda2MPXtYMSdXS+gv9mFCYlOMRPI6dx8ZcV+YSJPRM4KWbmV4It2
         mWHzXyFBmG7Q4in8fD4pNt+G1AWOxFv4ai5jZ5yZgbEgxTjLzbZddUM7baRxBhRWhYAl
         WUVKYf0aOIkL/DL6xz3+Ssx4oGeatcSabZqnxmwgJTtkKtqpdZ9douiwU+/VQUKbuenO
         x58nc4XgvioLJA4X51wtFn8+/01DjX3MNt6R6yl7G7refQiO7PMXGVJHj+8s4KtbtaUi
         lVPtcE6icQ8JNtSJffazCrDeI1zEHS5jkgl7edNvaxdCa7s/HZphhU6sleJ8fef81Ovk
         IhIQ==
X-Gm-Message-State: AKwxyte9l1vWnAGwZtdW3xS0i2iKVUfNHzIYpSCx8o2xVx4GvGsxbTLq
        +MXCKxzbv9XTKANkwS0KglAyvx5FrvM=
X-Google-Smtp-Source: AH8x227TgjxvcR/2QIn0ZL1vyDtUdYZZ746qaSJBqBkXr0FkNSM9Ob23eQMDSQgnZZYKnfhnAyMJHg==
X-Received: by 2002:a17:902:67c5:: with SMTP id g5-v6mr8270623pln.106.1516907300637;
        Thu, 25 Jan 2018 11:08:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u26sm18013092pfk.126.2018.01.25.11.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jan 2018 11:08:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     robbat2@gentoo.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] builtin/pull: respect verbosity settings in submodules
Date:   Thu, 25 Jan 2018 11:08:17 -0800
Message-Id: <20180125190817.145041-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a6d7eb2c7a (pull: optionally rebase submodules (remote submodule
changes only), 2017-06-23), we taught Git how to rebase submodules in
a pull. However we missed to pass on the verbosity settings.

Reported-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pull.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 511dbbe0f6..1876271af9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -574,6 +574,7 @@ static int rebase_submodules(void)
 	cp.no_stdin = 1;
 	argv_array_pushl(&cp.args, "submodule", "update",
 				   "--recursive", "--rebase", NULL);
+	argv_push_verbosity(&cp.args);
 
 	return run_command(&cp);
 }
@@ -586,6 +587,7 @@ static int update_submodules(void)
 	cp.no_stdin = 1;
 	argv_array_pushl(&cp.args, "submodule", "update",
 				   "--recursive", "--checkout", NULL);
+	argv_push_verbosity(&cp.args);
 
 	return run_command(&cp);
 }
-- 
2.16.0.rc1.238.g530d649a79-goog

