Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15877C636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBBJcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBBJcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE270986
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so864365wms.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNN083NT/OPQSIBpBbCdga9bcnGj4pF4fQn4m39t7Xk=;
        b=Fspw4fA5Pwj6I1Xhilr+wnxk0YOeXeiv/yzCdc3HdPL391/I1fGzJlwxnx30FPtc8T
         YW1waQc9nHdpmv06FP6bQR+m+cqdOdAQJhrCRpcVLjIiFLI+V4+04oKBV70P8zhsRUf/
         Vqbb1AojsKKAYlKzgVxbaAjWrQJ3GlVyBC0K9y/2Fg+6CI5j4AnYU6U09geDmM6daqKb
         CaHRiU4i0qidqATgd3rbJZ/zuxm1/xWKdKwwT4VV7qFM5rE0n1lXA3O/KqROtiZnWc1O
         NoixStHm9DYceW2glT/0WuLtMYqMTk7buRjS/fZPoGIpfOvEbr6v6V/hsZCYLxnLoZ2T
         z4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNN083NT/OPQSIBpBbCdga9bcnGj4pF4fQn4m39t7Xk=;
        b=M2M33Ai6aCZSq6qDYEDNd2YnjoXduVsphHZoy48Fg866YtjGsIasLYc0jfcSu1RrSv
         pce1syPn4wd6Yp29qtws4w11h89MtBl4l7dnsoE5hrjGgaZoTRPWecaRuuAiqGlj5Zq7
         n2o1brHOguU0dArginMHHREtFZXzNMsKOmenvyFjVL1w5a/DMz4+vQKUinbnDPBY7ezY
         8Vl85fA1ecQXXkFHY5bWkpw5X/H7145zTxVKRozrVCa0nAtTd5YeAbuPb0Lz9+1q4HZA
         e20d7b81kUpMwE3GAM9ybLqYRTSxIogGCSAt5OfwzlXHkrhRI9NJM01lnJRfKZpossMh
         l7yQ==
X-Gm-Message-State: AO0yUKVt8GAzBFmjkhDCdR0W/w8YPnZyABNAG2iurDHdeEp4oTlEr892
        VNKbTM2pjwdSzwyf54q7uUNbdcEJd3gK+vl4
X-Google-Smtp-Source: AK7set+BumkwGhT4BCORCTQ/gIO+uuqBeac7/I83ADzWafR8uBNQPThNW69d5FwNYbxbQYXe7Fezgw==
X-Received: by 2002:a7b:ca54:0:b0:3dc:2b62:ee9f with SMTP id m20-20020a7bca54000000b003dc2b62ee9fmr5170554wml.3.1675330363409;
        Thu, 02 Feb 2023 01:32:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/9] archive: omit the shell for built-in "command" filters
Date:   Thu,  2 Feb 2023 10:32:24 +0100
Message-Id: <patch-4.9-8bc1bfd1fe2-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "tar.<format.command" interface was added in [1] we've
promised to invoke the shell to run if e.g. "gzip -cn" is
configured. That common format was then added as a default in [2].

But if we have no such configuration we can safely assume that the
user isn't expecting the "gzip" to be invoked via a shell, and we can
skip the "sh" process.

We are intentionally not treating a configured
"tar.<format>.command=<cmd>" where "<cmd>" is equivalent to our
hardcoded "<cmd>" the same as when the same "<cmd>" is specified in
the config. If the user has configured e.g. "gzip -cn" they may be
relying on what the shell gives them over a direct execve() of "gzip".

This makes us marginally faster, but the real point is to make the
error handling easier to deal with. When we're using the shell we
don't know if e.g. the "gzip" we spawned fails as easily,
i.e. "start_command()" won't fail, because we can find the "sh".

A subsequent commit will tweak the default that [3] introduced to be a
fallback instead, at which point we'll need this for correctness.

1. 767cf4579f0 (archive: implement configurable tar filters, 2011-06-21)
2. 0e804e09938 (archive: provide builtin .tar.gz filter, 2011-06-21)
3. 4f4be00d302 (archive-tar: use internal gzip by default, 2022-06-15)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/tar.txt |  3 +++
 archive-tar.c                | 17 +++++++++++++----
 archive.h                    |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/tar.txt b/Documentation/config/tar.txt
index 894c1163bb9..5456fc617a2 100644
--- a/Documentation/config/tar.txt
+++ b/Documentation/config/tar.txt
@@ -18,6 +18,9 @@ tar.<format>.command::
 The `tar.gz` and `tgz` formats are defined automatically and use the
 magic command `git archive gzip` by default, which invokes an internal
 implementation of gzip.
++
+The automatically defined commands do not invoke the shell, avoiding
+the minor overhead of an extra sh(1) process.
 
 tar.<format>.remote::
 	If true, enable the format for use by remote clients via
diff --git a/archive-tar.c b/archive-tar.c
index f8fad2946ef..8c5de949c64 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -367,12 +367,13 @@ static struct archiver *find_tar_filter(const char *name, size_t len)
 }
 
 static int tar_filter_config(const char *var, const char *value,
-			     void *data UNUSED)
+			     void *data)
 {
 	struct archiver *ar;
 	const char *name;
 	const char *type;
 	size_t namelen;
+	int *configured = data;
 
 	if (parse_config_key(var, "tar", &name, &namelen, &type) < 0 || !name)
 		return 0;
@@ -388,6 +389,9 @@ static int tar_filter_config(const char *var, const char *value,
 		tar_filters[nr_tar_filters++] = ar;
 	}
 
+	if (configured && *configured)
+		ar->flags |= ARCHIVER_COMMAND_FROM_CONFIG;
+
 	if (!strcmp(type, "command")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -495,8 +499,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (args->compression_level >= 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
 
-	strvec_push(&filter.args, cmd.buf);
-	filter.use_shell = 1;
+	if (ar->flags & ARCHIVER_COMMAND_FROM_CONFIG) {
+		strvec_push(&filter.args, cmd.buf);
+		filter.use_shell = 1;
+	} else {
+		strvec_split(&filter.args, cmd.buf);
+	}
 	filter.in = -1;
 	filter.silent_exec_failure = 1;
 
@@ -526,13 +534,14 @@ static struct archiver tar_archiver = {
 void init_tar_archiver(void)
 {
 	int i;
+	int configured = 1;
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
-	git_config(git_tar_config, NULL);
+	git_config(git_tar_config, &configured);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)
diff --git a/archive.h b/archive.h
index 6b51288c2ed..9686b3b5cc1 100644
--- a/archive.h
+++ b/archive.h
@@ -40,6 +40,7 @@ enum archiver_flags {
 	ARCHIVER_WANT_COMPRESSION_LEVELS = 1<<0,
 	ARCHIVER_REMOTE = 1<<1,
 	ARCHIVER_HIGH_COMPRESSION_LEVELS = 1<<2,
+	ARCHIVER_COMMAND_FROM_CONFIG = 1<<3,
 };
 struct archiver {
 	const char *name;
-- 
2.39.1.1392.g63e6d408230

