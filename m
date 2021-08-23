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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF7C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614E36138E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhHWMbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhHWMbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588FC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i6so2277741wrv.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4nqLyUylM18RJa+zZi69IYzBmvhRXYaK1BbNK2tJus=;
        b=NDeQgKCKVhOehS2B59pPfx2y5KlFAkHrHAdtiQoLvAYyrPDtm5kUELr7Wbu3YzHqo1
         RLURTXOMkPgf+Ldtmw8srY1oPaBot11H+W/3bm23DI7Sgp415LYqp7fwEmtx/nH6hcoy
         ++ea4v6KztEmoIkdWoPeNKwcuoqekRGnUisDTHLgOU8nSuSzgABhygcZnRVIaw6ArC2w
         +ww9XoeeoD2WMcsmk8Qi5doZ9WX8BO0DSn+OKHMOF2K98fbAUlBiQLoeQ9D5gqc1CAbx
         o1fAhyVA33s9N9oHyBZVN0IuX++69EATIyPzMFJwHMAkvlV+0HykCUJrJYu32UfnYWd9
         pwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4nqLyUylM18RJa+zZi69IYzBmvhRXYaK1BbNK2tJus=;
        b=hzK6hv8YoKJLVYIChwx3zt7mWkr8CQqdqBpO5KQs2rva2fwmwNI6zDYk4l883mFnHx
         tHGqEkgwv+2NBU3YMTvTuVdIe0OiulWNFqqMAIObUIaar8HaUoJI8h9oV++4Kgl0s/j6
         w+jK5kUOWaRvVR8+j8GQmpsJAluOpsEfNEZnWL1l6JrmhSHzqcpJ7NiJEX+lWgFCctZi
         7CknggAZlgXVRQB9DqRVjznpdJF773iig0WlM3fi5EVAQv1fWcTrb4EL6SUZ+SgNjah3
         haDbo1H9GcFGO+8SZSdc7MpyX08yUHobGtUrQf56IzuSqKdxRyJ7raJdCiwSh6rxalvJ
         gJmQ==
X-Gm-Message-State: AOAM533Ha5AFkGQHwqPkelr1EcVEzdnU7Zsj654N1VFo7BSJ6OzGOLCV
        JLN7ACtg0Xf1R2/rQAU1hK5yrUxJUaCu/P7R
X-Google-Smtp-Source: ABdhPJwQgcx5R3mVa2JNpYcO5bdxbm0Q1dVI944Qd+xUwmc/keBd2kqxBkjydAqG3EwPEyrqkfQLHQ==
X-Received: by 2002:a5d:58da:: with SMTP id o26mr13959042wrf.140.1629721826206;
        Mon, 23 Aug 2021 05:30:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:25 -0700 (PDT)
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
Subject: [PATCH v4 2/7] commit-graph: remove redundant handling of -h
Date:   Mon, 23 Aug 2021 14:30:16 +0200
Message-Id: <patch-v4-2.7-bbed18ff193-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't handle the -h option here like most parse_options() users
we'll fall through and it'll do the right thing for us.

I think this code added in 4ce58ee38d (commit-graph: create
git-commit-graph builtin, 2018-04-02) was always redundant,
parse_options() did this at the time, and the commit-graph code never
used PARSE_OPT_NO_INTERNAL_HELP.

We don't need a test for this, it's tested by the t0012-help.sh test
added in d691551192a (t0012: test "-h" with builtins, 2017-05-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5af3cd7178f..3cf18dc5345 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -321,10 +321,6 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_graph_usage,
-				   builtin_commit_graph_options);
-
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_commit_graph_options,
-- 
2.33.0.662.gbc81f8cbdca

