Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE6C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AD12070B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSowmb6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgG1WZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgG1WZH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:25:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E26C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v11so19513203ybm.22
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OiBaCt7vuG0WQAD5GyO1mUctvePuwfQ1pCAke1H+Vng=;
        b=QSowmb6W3rMxz+pOofEovoMFS7zoXDZpn3xv3Num05zLSXRm+AJXjk5b2P2bctlepY
         9Ks3yuYrkyBn00T96l5cxU/V8NVuRaPCKCzPCtrkAGWNj7EV3rYTS9K+E/j6TlQloUMX
         NBq3Fz1NBZg/+WNCWx+9qCPshpft5McKMs0YFj4Q73783Jp3F+FgHPeR67NnmszTmCQE
         hf8olQPT1IsSsHKs4+140b1G2jKpVXPC3wO+hQ0pleVVIIk2rNUANrpMKmc3Ll1oyg1n
         pKMXRIgkeQBYJbWB9HIhDLiOwJ1jDWOxvhdgcJdZnV7rGhEcdO37pLXNBi6cPumD2ZGc
         k9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OiBaCt7vuG0WQAD5GyO1mUctvePuwfQ1pCAke1H+Vng=;
        b=DqNFZhp6AKrbsNVuLlN1ap00hmR/YoEvTcEzcbHlX3UzEOKt1LrDt6Uxyt1FloUwyA
         YS7k0LuXu9SrUDa2SftZTED4N5l3YwrU67c1ppe0I7WSpHcnqPAhKLFKbAJgDNb0tWAd
         23IHyeJ//C4gogTjHM8XTjXBhnPdV0XfLUVTadVY9Tn5lUKsuQqEyd+OmpXxsINrf3GB
         +XkzOK4rg0xi94FnvQhds9Hd0u3Szik2Ba8QXYV7TxbK4CX5vrr11cm80KPVCvSmKiJt
         /6J7i0Nx5o5PR0FA6ZQpsjZd7On3FEb7cqebRt71/VGyHHBwru2Qx9rh3D7fJx5rrKyG
         Z0Uw==
X-Gm-Message-State: AOAM533QQDVIoVH+PF9fBQK420x2u/yuTFO+7umEr89T4rFB+CCUlRg7
        QPEpJlfuuxiw9sO1pQzR4S0GDINJ0dr11wwpdfEbTNGgkuogOYPzXM5PWpzqxSZ9reYWESQJVE9
        MZV3/LwvonbDB7cAU6eNbllVii7JHvCg1ZHINCgdxiSui2cHFHIMLP1G6U2Bc+oGKzpb0FthbbA
        ==
X-Google-Smtp-Source: ABdhPJzIxd6vkOZ2CAjpRfYeOmzAOlVZrY+7rGodynVjCoHpfWR6lpI2C60EDPSYCIvcM+A9rvslxVZU8yy2/lhNEK4=
X-Received: by 2002:a5b:28c:: with SMTP id x12mr26106756ybl.112.1595975106178;
 Tue, 28 Jul 2020 15:25:06 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:24:51 -0700
In-Reply-To: <20200728222455.3023400-1-emilyshaffer@google.com>
Message-Id: <20200728222455.3023400-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200728222455.3023400-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v3 2/6] hook: scaffolding for git-hook subcommand
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce infrastructure for a new subcommand, git-hook, which will be
used to ease config-based hook management. This command will handle
parsing configs to compose a list of hooks to run for a given event, as
well as adding or modifying hook configs in an interactive fashion.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 19 +++++++++++++++++++
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/hook.c                | 21 +++++++++++++++++++++
 git.c                         |  1 +
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 7 files changed, 55 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index ee509a2ad2..0694a34884 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-hook
 /git-http-backend
 /git-http-fetch
 /git-http-push
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
new file mode 100644
index 0000000000..2d50c414cc
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,19 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - Manage configured hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook'
+
+DESCRIPTION
+-----------
+You can list, add, and modify hooks with this command.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 372139f1f2..e13e58e23f 100644
--- a/Makefile
+++ b/Makefile
@@ -1077,6 +1077,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index a5ae15bfe5..4e736499c0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -157,6 +157,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
 int cmd_hash_object(int argc, const char **argv, const char *prefix);
 int cmd_help(int argc, const char **argv, const char *prefix);
+int cmd_hook(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
diff --git a/builtin/hook.c b/builtin/hook.c
new file mode 100644
index 0000000000..b2bbc84d4d
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const builtin_hook_usage[] = {
+	N_("git hook"),
+	NULL
+};
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+			     builtin_hook_usage, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 2f021b97f3..7f3328c63f 100644
--- a/git.c
+++ b/git.c
@@ -517,6 +517,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
new file mode 100755
index 0000000000..34b0df5216
--- /dev/null
+++ b/t/t1360-config-based-hooks.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+test_description='config-managed multihooks, including git-hook command'
+
+. ./test-lib.sh
+
+test_expect_success 'git hook command does not crash' '
+	git hook
+'
+
+test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

