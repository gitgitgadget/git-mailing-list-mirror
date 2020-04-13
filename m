Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C69C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6017020735
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT5JFZW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgDMP2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbgDMP2n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 11:28:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCAC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:28:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z65so12524182ede.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2Gnpy3FGBsOlAmddiSttkJ0gDVD1NzA/5NeQK4mctVU=;
        b=DT5JFZW3fizcTtUiQTGY/aQ1izSz+1pdt8c9spg70QSCZGwubfmFwfp43cJxNu4DCm
         7Jh4+5gRfvW87u3KN7LMa7J5SMhZIe7uJrp1c7PB4aZ0+s7NZYmrWRXuFZ4hr7cQpOLy
         GhdJ9r4zzGYrpFOnlyteeAORjAXa62QXT9C0zOyBhYTzxHOeiwPehppG3VQgr3p2zcB/
         E0VPp6RUfuiHLaxSqa2qenmmCgMPrZf/FRldNbmaioFoUqJSGF48rMkJ3j9d7/GWniRX
         DRUJT6mUcs0V4F99ibHjp2iI3z7EqYSKHcIoHTSlO+QhruLRNwWeHHmlWLDEk6Nya7tP
         wJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Gnpy3FGBsOlAmddiSttkJ0gDVD1NzA/5NeQK4mctVU=;
        b=CGFcqFnbYfxmpYY/VwZzFRaKhSCgSR7hNGmc1rx9dKBp/H81lz92HFbQpx2jMjJauZ
         q9oOu/jRxePfsRgkzH3fE2lt0R06sFVa0w8u6PwaiqheEf+NrI+bu3kNDjSuLreWaKlJ
         5IAKP0DjU44gQv4rscokzzk+2Or+p43dykcsBtMoWztQTRU9xUyIhpyTlSOCKqES/FjD
         TtIbgkLwOFXHrahdBUAhVO2XC36VpJEbfPYNsHECplxmd+xfKWMEbK0wsxzEzx3F0Gr7
         Am1hlLeafJ43Oq/CAWc2ong6wmrriOA41VMzQMaRA5gjR0Xp/2SNB9w0qD5xYIKjQAMh
         p9ow==
X-Gm-Message-State: AGi0Puafvo5nLlXZVkmg3L50GN68p6M3/K55PWRCy0QRPWoQTyQpkHi0
        jxPJdsPTC8NxR5b9Yp9hHgiXI+tL
X-Google-Smtp-Source: APiQypJUxmpkHIy7PsaUavtAoJa2MEH9igjKZexiCr5vzj/eNtS3FMAySq6hkf1wJu6sTWQEAbhuuw==
X-Received: by 2002:a50:af02:: with SMTP id g2mr17024523edd.69.1586791720949;
        Mon, 13 Apr 2020 08:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm41819ejf.49.2020.04.13.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:28:40 -0700 (PDT)
Message-Id: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 15:28:39 +0000
Subject: [PATCH] log: add log.excludeDecoration config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sluongng@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In 'git log', the --decorate-refs-exclude option appends a pattern
to a string_list. This list is used to prevent showing some refs
in the decoration output, or even by --simplify-by-decoration.

Users may want to use their refs space to store utility refs that
should not appear in the decoration output. For example, Scalar [1]
runs a background fetch but places the "new" refs inside the
refs/scalar/hidden/<remote>/* refspace instead of refs/<remote>/*
to avoid updating remote refs when the user is not looking. However,
these "hidden" refs appear during regular 'git log' queries.

A similar idea to use "hidden" refs is under consideration for core
Git [2].

Add the 'log.excludeDecoration' config option so users can exclude
some refs from decorations by default instead of needing to use
--decorate-refs-exclude manually. The config value is multi-valued
much like the command-line option.

There are several tests in t4202-log.sh that test the
--decorate-refs-(include|exclude) options, so these are extended.
Since the expected output is already stored as a file, simply add
new calls that replace a "--decorate-refs-exclude" option with an
in-line config setting.

[1] https://github.com/microsoft/scalar
[2] https://lore.kernel.org/git/77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com/

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    log: add log.excludeDecoration config option
    
    This was something hinted at in the "fetch" step of the background
    maintenance RFC. Should be a relatively minor addition to our config
    options.
    
    We definitely want this feature for microsoft/git (we would set
    log.excludeDecoration=refs/scalar/* in all Scalar repos), but we will
    wait for feedback from the community.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-610%2Fderrickstolee%2Flog-exclude-decoration-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-610/derrickstolee/log-exclude-decoration-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/610

 Documentation/config/log.txt |  5 +++++
 builtin/log.c                | 14 ++++++++++++++
 t/t4202-log.sh               | 22 ++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index e9e1e397f3f..1a158324f79 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -18,6 +18,11 @@ log.decorate::
 	names are shown. This is the same as the `--decorate` option
 	of the `git log`.
 
+log.excludeDecoration::
+	Exclude the specified patterns from the log decorations. This multi-
+	valued config option is the same as the `--decorate-refs-exclude`
+	option of `git log`.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/builtin/log.c b/builtin/log.c
index 83a4a6188e2..d7d1d5b7143 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -236,7 +236,21 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	}
 
 	if (decoration_style) {
+		const struct string_list *config_exclude =
+			repo_config_get_value_multi(the_repository,
+						    "log.excludeDecoration");
+
+		if (config_exclude) {
+			struct string_list_item *item;
+			for (item = config_exclude->items;
+			     item && item < config_exclude->items + config_exclude->nr;
+			     item++)
+				string_list_append(&decorate_refs_exclude,
+						item->string);
+		}
+
 		rev->show_decorations = 1;
+
 		load_ref_decorations(&decoration_filter, decoration_style);
 	}
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 0f766ba65f5..b5de449e510 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -787,6 +787,9 @@ test_expect_success 'decorate-refs-exclude with glob' '
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="heads/octopus*" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -801,6 +804,9 @@ test_expect_success 'decorate-refs-exclude without globs' '
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="tags/reach" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="tags/reach" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -816,6 +822,14 @@ test_expect_success 'multiple decorate-refs-exclude' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="heads/octopus*" \
 		--decorate-refs-exclude="tags/reach" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" \
+		-c log.excludeDecoration="tags/reach" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" log \
+		--decorate-refs-exclude="tags/reach" \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -831,6 +845,10 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs="heads/*" \
 		--decorate-refs-exclude="heads/oc*" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/oc*" log \
+		--decorate-refs="heads/*" \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -846,6 +864,10 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="*octopus*" \
 		--simplify-by-decoration >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="*octopus*" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" \
+		--simplify-by-decoration >actual &&
 	test_cmp expect.decorate actual
 '
 

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
