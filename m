Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE105C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJDNYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJDNX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:23:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A44DB67
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:23:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t4so8860042wmj.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXDXwSpz/fzamEBJPfnphI4yzZxJE1iiVA11g7zgc+8=;
        b=Q7Hlf2cvPikHJdU1ysn0jo9uDzune58cq0paRYNVS2c5WLXa/AkNbfg9atDZVxN9uF
         N2nw55mNvXzRrZE2d6qcTbGddr1MB6jcLRl6993fSFyeWUyS8xio7gfUaZl5ZFBcUldr
         xF5CXJP4beiZioPBX+E14IQM7QJVDRzye3IVVHzv5ROg6fmL3V0tdCS8KioHPJUwk3r1
         GnAZPag9MxIgfPMNXix8VD43g955sWKDkLftTWfwBNYL6jk9fF4NG5vgCpXfGYuMuFGw
         HoHIqgsagBK/jvm2TDb/C6fY3+028cS6mZS0xUBu35NlYV/kbY2pLWwm5fnDjLcymKzs
         00lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXDXwSpz/fzamEBJPfnphI4yzZxJE1iiVA11g7zgc+8=;
        b=MyTXcJNZrtgnaX56gTrdqHqVy19OA9JlQFV4PGL6SKUGWY7K/qOyl1n2RD3PCeSRVf
         mOk1qtqlQn+0PCDQsZcIj5JoTD8eyTANHVQPi+XJnaUIiQaH2UVpSSK+H8tCcSWXuf05
         0sGpX8YFwLZ4seuzq4BHwaYRNC6TcHTwo0axyFW+Sd9Oner3VIJuD8PYG+ON4OUlSsJY
         5yDbKnQ9tLcpMDxrXKPUYEz9cYz4mMk0xMVVuW7GlxoUOKzoHnSVL2yHhhhHZL7tzs0V
         aDcBvKhmhSqKwhlO38nsmawrZ+/NnGRqxNFdsbgBcuGdFkhspxxqO/n152gPBlye87pr
         ztdw==
X-Gm-Message-State: ACrzQf1/fw2a7RAvXVj15405VtOfzkQ6dgbImRue2raJt1SMU3T804Kk
        KH2f1omErD8AxFDPDoENzbio+fO6miawaw==
X-Google-Smtp-Source: AMsMyM77hnFxQqJdd06TD7+BOtEUZI4v1DT51YFV1DiZ7JTXpp1qcciFRynPNsW5U5AV5cXj6vC5YA==
X-Received: by 2002:a05:600c:474a:b0:3b4:cb3f:2f5f with SMTP id w10-20020a05600c474a00b003b4cb3f2f5fmr10221744wmo.8.1664889836142;
        Tue, 04 Oct 2022 06:23:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/34] bundle: define subcommand -h in terms of command -h
Date:   Tue,  4 Oct 2022 15:23:18 +0200
Message-Id: <patch-v4-04.34-522d7fbb0a3-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid repeating the "-h" output for the "git bundle" command, and
instead define the usage of each subcommand with macros, so that the
"-h" output for the command itself can re-use those definitions. See
[1], [2] and [3] for prior art using the same pattern.

1. b25b727494f (builtin/multi-pack-index.c: define common usage with a
   macro, 2021-03-30)
2. 8757b35d443 (commit-graph: define common usage with a macro,
   2021-08-23)
3. 1e91d3faf6c (reflog: move "usage" variables and use macros,
   2022-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5c78894afd5..1b08700bf9e 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -11,31 +11,40 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char * const builtin_bundle_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
-	N_("git bundle verify [<options>] <file>"),
-	N_("git bundle list-heads <file> [<refname>...]"),
-	N_("git bundle unbundle <file> [<refname>...]"),
-	NULL
+#define BUILTIN_BUNDLE_CREATE_USAGE \
+	N_("git bundle create [<options>] <file> <git-rev-list args>")
+#define BUILTIN_BUNDLE_VERIFY_USAGE \
+	N_("git bundle verify [<options>] <file>")
+#define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
+	N_("git bundle list-heads <file> [<refname>...]")
+#define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
+	N_("git bundle unbundle <file> [<refname>...]")
+
+static char const * const builtin_bundle_usage[] = {
+	BUILTIN_BUNDLE_CREATE_USAGE,
+	BUILTIN_BUNDLE_VERIFY_USAGE,
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
+	NULL,
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	BUILTIN_BUNDLE_CREATE_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-	N_("git bundle verify [<options>] <file>"),
+	BUILTIN_BUNDLE_VERIFY_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-	N_("git bundle list-heads <file> [<refname>...]"),
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-	N_("git bundle unbundle <file> [<refname>...]"),
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

