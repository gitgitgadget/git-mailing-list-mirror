Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B8C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3076820B80
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlifGIvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKQXgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQXgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 18:36:13 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2C4C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 15:36:12 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id n5so274627ile.7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=komeBoEYbmhn1NNG5gkMR+3B6GxbykTFoNbjaMtNl48=;
        b=dlifGIvdRV0dzY+FIteKmeNTOy5A4398cki7uifRktKrYnmdVatbLfChZ3ixWCvCc8
         2Lrraik/Vx4PsjSc7S8/EfcVKigqImg5L5mPk0cKfvKvLZvHFGXQRHPabo8oN+e7lr9V
         uTMo9n0BVgv8H4tDuqbkjBW0Dk1PG3dacKP9LwTSAxdGL5lPCZtW+QeX3ezfpKPEQXDy
         +uBY9ecR0Vvx3W5hTRH4GQxPOWmmCd01QX6LZJHoqX2WXD51n7jT+1ZKiBi81GnFH1tI
         URsWqtZm3qe1HR0yVfepWmk0VIRhc7Hu2dhPLVEK4uL6XGxO+P+GUWYaE3N9m46aXo26
         uq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=komeBoEYbmhn1NNG5gkMR+3B6GxbykTFoNbjaMtNl48=;
        b=AyGaWRx8l5ZWg97o+a71afBL0hf1uMygMiS2Ldn5+5uewLT9XY+WMqeeFpnnt0AS1o
         evkzLnIFRCn44Kea7jljxT1tp8DBCDrhzJsNYMRPgmACODP98xy5eolUezKkW27oGJBf
         3nCQop6W0u7H5p87EkDyoQE+PptsIWyzuDiTkZUfpp8kFK2O1Zg5pA9rGA4hgS2CSZV8
         tbSwAegyoEjT0JU65tB0xyY0WErl4a9JW60f0G+flUlP4snTIs3u6DWa8Q1huGaWLtXA
         rCjEcohCNTL6+5USKt7nLtKHedmcsi1swf8zvWOAtZgqLLT1PZP9tDNTgV5ar5B8CVjG
         9ZUw==
X-Gm-Message-State: AOAM532G6JsS0oRJJ7Qfbep3zhBqW4bSk4kIIgRQoIaJo/bEMg/nOnD6
        JmNOTKJobFJu5uhIU5JdtxYYuIQRJco=
X-Google-Smtp-Source: ABdhPJzyc4BjZT1q7TtvDKPNAboYZHg0spmrhI/IcW42VoqFEWe3ZGZj8hZ3rpoNP1FNayIj52Muzg==
X-Received: by 2002:a92:35d7:: with SMTP id c84mr7203185ilf.251.1605656172220;
        Tue, 17 Nov 2020 15:36:12 -0800 (PST)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 192sm15251506ilc.31.2020.11.17.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:36:11 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Tue, 17 Nov 2020 18:36:05 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/4] Maintenance IV: Platform-specific background
 maintenance
Message-ID: <X7ReZXuwAaAZzMSU@flurp.local>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 09:13:14PM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in V4
> =============
>  * Eric did an excellent job providing a patch that cleans up several parts
>    of my series. The most impressive is his mechanism for testing the
>    platform-specific Git logic in a way that is (mostly) platform-agnostic.
>    
>  * Windows doesn't have the 'id' command, so we cannot run the macOS
>    platform test on Windows.

This is easy to resolve. Drop in the following patch and then replace
the `$(id -u)` invocation in the test with `$(test-tool getuid)`.
This way, the test should work on any platform since both
launchctl_get_uid() and `test-tool` will retrieve identical values for
UID.

--- >8 ---
From 84f623bcaec156082c0e7151f40aef18575e6f86 Mon Sep 17 00:00:00 2001
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 17 Nov 2020 18:30:10 -0500
Subject: [PATCH] test-helper: add `getuid` subcommand

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile               | 1 +
 t/helper/test-getuid.c | 7 +++++++
 t/helper/test-tool.c   | 1 +
 t/helper/test-tool.h   | 1 +
 4 files changed, 10 insertions(+)
 create mode 100644 t/helper/test-getuid.c

diff --git a/Makefile b/Makefile
index 790a883932..230aff5e5c 100644
--- a/Makefile
+++ b/Makefile
@@ -706,6 +706,7 @@ TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
+TEST_BUILTINS_OBJS += test-getuid.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
diff --git a/t/helper/test-getuid.c b/t/helper/test-getuid.c
new file mode 100644
index 0000000000..d741302461
--- /dev/null
+++ b/t/helper/test-getuid.c
@@ -0,0 +1,7 @@
+#include "test-tool.h"
+
+int cmd__getuid(int argc, const char **argv)
+{
+	printf("%d\n", getuid());
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a0d3966b29..ab206541df 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -30,6 +30,7 @@ static struct test_cmd cmds[] = {
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
+	{ "getuid", cmd__getuid },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
 	{ "index-version", cmd__index_version },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 07034d3f38..caee0a3667 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -20,6 +20,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
+int cmd__getuid(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
-- 
2.29.2.454.gaff20da3a2

