Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC09EC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A617C6113C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhGTLBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbhGTK7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C9C061768
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f9so25630720wrq.11
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFtkIu6h9h/31fzI/EXMc0altkrixdwUaXJuhNdbORs=;
        b=IC/Xw1fC9zJRK9UsRs0ye+kjSF07kvv+mLTG8+j7VldEOJa0RXN5VQFMdDJ5baErkf
         W3Ncowh2H5S6vfjqpZYEXDIwS9h1o0GBJ7kUyVvwTE0dlHXn8rnhB9Dm9EvSoHFUpOUB
         TZydcd4fiGkg1eWs0nG+PpJ2Q9WPmMj+z/IjJELfpxBdA+NhxLJoWYi0qd+e5rl5lJ2g
         Ir5otUivQJElhW1sqvEAE4DVtHdAiXwHyH5X6C7MGEb1W/Z5kuhv60SStm65hz4Y0OQS
         tSeasnMj1Eo1GRp58w4ANoIkdoQVlyTd8PL5sNLDz4uXnc6mycCGW9gkVQ5l8uMe6p/m
         DGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFtkIu6h9h/31fzI/EXMc0altkrixdwUaXJuhNdbORs=;
        b=Q+BEfIYv9edzF2MqlKfrm02J75lS6+1ce13NwmKT5vaRpvdecAhaaZH/G3jFxxAUY8
         +ntL+M+maF3W3WX8n5p8GNlTmLKPPwpb+vNtCe81lis0fpAnekuVqQ2ZbNVlo+HqEifx
         Lc0OAR4JpO78OaIq0rFabA3EDrKn7FPFBYduaZbe8rnCnT1jdHcx1HPR82fR9YWqYbh7
         hEVjjqJF6PBW0Am0RCQjxqmcrCDX7X+5UsiUt/bJ8xJe3UqoXtduP3DYJzPK8gAgyUvu
         ragfKJzVih92XDXEKHa5N0RWz6BJwMGxIrUNGEnBjg1VhXlcpUQoCspeYqsB+WjtJHYo
         +v+w==
X-Gm-Message-State: AOAM530MjVXKAFlJAZG2ZCS/uVWSBod4mbdLDx/K5pZRObsk27rrZJHh
        gMhYZMdbD7VKs+Rp0wNdT/sW4Hu+5VnH9A==
X-Google-Smtp-Source: ABdhPJyBu+s80qR1eAf1ydU8zL+I/cnoPRRP/OBAsYa9Yk9/ZhGeFSQuuu8vyz1PIrhK73xnqB9nig==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr34956668wrq.410.1626781205933;
        Tue, 20 Jul 2021 04:40:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:40:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] multi-pack-index: refactor "goto usage" pattern
Date:   Tue, 20 Jul 2021 13:39:43 +0200
Message-Id: <patch-4.6-6e9bd877866-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the "goto usage" pattern added in
cd57bc41bbc (builtin/multi-pack-index.c: display usage on unrecognized
command, 2021-03-30) to maintain the same brevity, but doesn't run
afoul of the recommendation in CodingGuidelines about braces:

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
index 5d3ea445fdb..2952388a8eb 100644
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
+
 usage:
-		error(_("unrecognized subcommand: %s"), argv[0]);
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
-	}
+	error(_("unrecognized subcommand: %s"), argv[0]);
+	usage_with_options(builtin_multi_pack_index_usage,
+			   builtin_multi_pack_index_options);
 }
-- 
2.32.0.874.ge7a9d58bfcf

