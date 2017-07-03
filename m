Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5D0201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 21:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdGCVTA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 17:19:00 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35196 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdGCVS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 17:18:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id w126so178891981wme.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BSh6l1yvP9fHFWpn599UOcHVOBhR7Or+vz7v4ae1Tp4=;
        b=Z7fOKLfKoJwsvj1jtSYjCSsFyd5gLxBeofdim3OyQvm++JBAclfAi9wZPwBAXlcq6a
         s4bjW+bzwpwIYpyFeLfU1zalaA/Ou8IOCZspAaWi1TBYa3FgP12oQt+Pa4cATvGEa72k
         hL1bfQbGog/20Pn/mZhGQrqhECyjcFKzNV9RkieUg2+WJRjI46IgvILGo9s2bTjnXXKB
         d6Ob8RjxmGNhJfWKJ+MaMjGxIZz1WTUdDD19TKnafFGMNzouyMelQb69I//bXF15ECT2
         qJEsqqBmVQxclsFiQau67B/VLsx4ZBHOTBU32luZjcF+6WcE40nWAVQpJGdv7vw+Iq1X
         EYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BSh6l1yvP9fHFWpn599UOcHVOBhR7Or+vz7v4ae1Tp4=;
        b=GS79MWkxhq8EG95OgHHdRfOiw4wMSeG7v+WRYvVIV5NhbIqIlnF5zNUrbYTGc7d2QU
         9Pf1PIuwvMBET2CP9MVU3M0FpkE3RaYnLKMtAgh9o9hxs/3J24FZkC4IgXmm2t+IDcjO
         iSusiBWTx0IBBEUfTBFP9kE32ZAUtRSVFeVJL2DNxa/DWL9eYagD242fsAiC5Rw1J+9e
         DR+EuffD3obOCAdJsloRYe88OXnPHPDlwDj2IODPUIYAWlbiUUWP0oEoZkWu6ket7yPC
         ruLDXXk1PhHH1XnZDcMJ+a1u09eYEbIU07ny0kXnpifjCBesrt3ahE6Co1Lw/s+O5z3h
         Yqew==
X-Gm-Message-State: AIVw112fCPhyNGoQFInJFzfm//SDK7KMiGbPqxoS5E6h5iG3l9jC0d0N
        G+JpLLpn6yw3sGC1D1SoNw==
X-Received: by 10.28.87.209 with SMTP id l200mr16944075wmb.3.1499116737191;
        Mon, 03 Jul 2017 14:18:57 -0700 (PDT)
Received: from spiros.lan ([2.227.248.226])
        by smtp.gmail.com with ESMTPSA id 15sm14982919wmx.18.2017.07.03.14.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 14:18:56 -0700 (PDT)
From:   Francesco Mazzoli <f@mazzo.li>
To:     git@vger.kernel.org
Cc:     Francesco Mazzoli <f@mazzo.li>
Subject: [PATCH] push: add config option to --force-with-lease by default.
Date:   Mon,  3 Jul 2017 23:18:47 +0200
Message-Id: <1499116727-757-1-git-send-email-f@mazzo.li>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flag can be overridden with `--no-force-with-lease`, or by
passing the config via the command line.

Signed-off-by: Francesco Mazzoli <f@mazzo.li>
---
 Documentation/config.txt | 5 +++++
 builtin/push.c           | 3 +++
 cache.h                  | 1 +
 config.c                 | 4 ++++
 environment.c            | 1 +
 5 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06898a7..36fe882 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2537,6 +2537,11 @@ push.default::
 	specific workflows; for instance, in a purely central workflow
 	(i.e. the fetch source is equal to the push destination),
 	`upstream` is probably what you want.  Possible values are:
+
+push.alwaysforcewithlease::
+	When true, `--force-with-lease` is the default behavior when
+	using `push --force`. Explicit invocations of `--force-with-lease`
+	or `--no-force-with-lease` if present, take precedence.
 +
 --
 
diff --git a/builtin/push.c b/builtin/push.c
index 03846e8..96fc4b2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -561,6 +561,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("push");
 	git_config(git_push_config, &flags);
+	if (push_always_force_with_lease) {
+		cas.use_tracking_for_rest = 1;
+	}
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
 
diff --git a/cache.h b/cache.h
index 96055c2..d31c972 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,7 @@ enum push_default_type {
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern int push_always_force_with_lease;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index 1cd40a5..2a0dbe4 100644
--- a/config.c
+++ b/config.c
@@ -1317,6 +1317,10 @@ static int git_default_push_config(const char *var, const char *value)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "push.alwaysforcewithlease")) {
+		push_always_force_with_lease = git_config_bool(var, value);
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index d40b21f..79186c7 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,7 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+int push_always_force_with_lease = 0;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
2.7.4

