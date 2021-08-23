Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA83C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106576138E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbhHWMbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbhHWMbM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98661C061760
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so26048635wrn.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lp5unAvY43JpRlq0qN6DDJktOgftnOZWlrRnhbdyXM=;
        b=BqYgqO6vtFTlyyW1uxWLPa0+qj6taK5+p3MY/MHWn9V+y149uooh/3T14zKT676bvR
         2H82gDURw+ZTRTV5dTQ3aKjIJYknGAAR29wKzMCeL9lprXMJWEsyeDF8GiLTmUxc33SC
         tCdLMSeGB7aRMeHPx5MKbUYdEw9WUtkA1InX7Wtyo+4Pwx26UqaGGKcTuUj+VDJcxp9Q
         lFUny5SZWTLVIlUTOyda3khNjc4JO++bFKC4CNey94pfPzQ4HUEiVARw+j5Q48L8OPod
         v69tzvLo5FrXU+ev6vGoQ7zoD/BbFo3cAAGFlLYIrEHqnOOcekycUwIuNWYZz1f+wqgy
         MlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lp5unAvY43JpRlq0qN6DDJktOgftnOZWlrRnhbdyXM=;
        b=HLu3Gl75TQd7MnaoL4p0R83yB+Wx+QvKb9vP42JuRPfJGKhhag06vpr3PpAbLgnzCh
         XTmVCR4BMLvQNvKPn5bY7/IBTE8Q1wr4GY5q1tj5TZeqnXAMRyn5cysLybUvbT51E93v
         9PbEE1edFlg8eJtAHtU+wGKWYA/LZ/YX5yLhXqPsRsncX4d1buPLKlj/qrr8V47ARKhF
         E50UEjk2y7ELkRa2hZAXEYxcdp9AaQ8AqucxayHWIybi7e+qdY060XRrG0UbPZSiYKZF
         a+FfBga0X5nkvj0MV6EZEA7jEuYVK4MokPX3OBKWARWYSHf3XUkCQY0BHojCGKCIWqnA
         nplw==
X-Gm-Message-State: AOAM531tZmQM6QLMywNP1ln6WTIhK5SwW8fPCFhYox+XF6YxWhcZICWg
        Q1styeLRWsj/5YC6kCTCfTtH0eU0URP9UimD
X-Google-Smtp-Source: ABdhPJzREL3URetnba9k0XsqDdNJRt63Bl2L4K8H7pd2jJ5wjbk2fD3hxLoGdbt4Q+bXDkETVkCQWQ==
X-Received: by 2002:adf:fd51:: with SMTP id h17mr10874977wrs.178.1629721828009;
        Mon, 23 Aug 2021 05:30:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/7] multi-pack-index: refactor "goto usage" pattern
Date:   Mon, 23 Aug 2021 14:30:18 +0200
Message-Id: <patch-v4-4.7-087f98bbec6-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the "goto usage" pattern added in
cd57bc41bbc (builtin/multi-pack-index.c: display usage on unrecognized
command, 2021-03-30) and 88617d11f9d (multi-pack-index: fix potential
segfault without sub-command, 2021-07-19) to maintain the same
brevity, but in a form that doesn't run afoul of the recommendation in
CodingGuidelines about braces:

    When there are multiple arms to a conditional and some of them
    require braces, enclose even a single line block in braces for
    consistency[...]

Let's also change "argv == 0" to juts "!argv", per:

    Do not explicitly compare an integral value with constant 0 or
    '\0', or a pointer value with constant NULL[...]

I'm changing this because in a subsequent commit I'll make
builtin/commit-graph.c use the same pattern, having the two similarly
structured commands match aids readability.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/multi-pack-index.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8ff0dee2ecb..649aa5f9ab2 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -164,7 +164,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
 
-	if (argc == 0)
+	if (!argc)
 		goto usage;
 
 	if (!strcmp(argv[0], "repack"))
@@ -175,10 +175,9 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return cmd_multi_pack_index_verify(argc, argv);
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
-	else {
-		error(_("unrecognized subcommand: %s"), argv[0]);
+
+	error(_("unrecognized subcommand: %s"), argv[0]);
 usage:
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
-	}
+	usage_with_options(builtin_multi_pack_index_usage,
+			   builtin_multi_pack_index_options);
 }
-- 
2.33.0.662.gbc81f8cbdca

