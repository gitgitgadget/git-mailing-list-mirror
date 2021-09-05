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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C4C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0718A61004
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhIEHf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhIEHf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:35:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E4C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:34:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so4855952wrr.9
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Zr1SfXdaFTETJ/mOF0cdlnXmFLsrAdyymKzjgXaE78=;
        b=W/rOhf8jg9JwYTEiDPOccSQvB2dgfD4XzROL3BqpLvKr8crMSdENk+naSBIHRctV/l
         v53SYaFkczZCuhdH4zrYKJlmFgeFFHQZrmEtEXTEyw7XVloejkHWcGIrxOeXHWzdvojU
         9YLDET1tmmw8Mk+vnPj8zkkAbD8Mkv9dAZgQ9BDyI12GI3nuI8Y6lWDdpetHE+wEDhwv
         AOKAzMBNkL0GcG7vG4HIYXkOJvPznRWkEI4XevbrMsUy8bOyYgiM+CpAPa4fR6pwFYTK
         olNaXwU2FSVPxhbbEebgXUaVLj6ukac5oEBh9i60BRchwpouJgwAo25c5eQ5zZusYl03
         qWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Zr1SfXdaFTETJ/mOF0cdlnXmFLsrAdyymKzjgXaE78=;
        b=lKLNs5mhSwzICt7jrd2Z7nDieOEkZR3bRcK3rZqXUCHMW3PH+6udjo1XSx530tn3Ig
         KNAIpOePmXE31MLTGYgY5vHIDer7yY2oj13QEWDbYHBI5qlYrKfZOaJsg+tRSGP958HB
         oaXNtKh5eP0zd1/NDggO7pGcrUwwsIfhLw6Bb1OFvkXH0hSrLuSqwb8FqyEDDXuUqOFV
         pAYiv9TKki8oZtsEQXvXggkESpJptO9ByeVjqR0B8koPGrCjBLfdgXzlWPaXqks7QwBH
         hqPak8GSCfjesPSNlSEK2vCWAwLPxljKymg5T87Ls2OgNyRVw11qQFgsocMlqx+VmvT5
         kDYQ==
X-Gm-Message-State: AOAM531ZHPPpVykSOThOcAsMmKNdUl44Lxu2A3w/Lv0Ww/4D5Kky+fV0
        Qju6EtsH+Q8QAXnR2lDVM6BpAeIUH8VywQ==
X-Google-Smtp-Source: ABdhPJxK56QGLTwOavnTb3NYLf6Zlz67mWCLcupohK+mNfOJAptjE2yKbv24SDcggl3WuQoBuyEXpw==
X-Received: by 2002:adf:d185:: with SMTP id v5mr7181245wrc.378.1630827291886;
        Sun, 05 Sep 2021 00:34:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm4218734wrc.31.2021.09.05.00.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:34:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] index-pack: add --progress-title option
Date:   Sun,  5 Sep 2021 09:34:44 +0200
Message-Id: <patch-v4-3.4-338c0e1e518-20210905T072750Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.813.g41c39388776
In-Reply-To: <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --progress-title option to index-pack, when data is piped into
index-pack its progress is a proxy for whatever's feeding it data.

This option will allow us to set a more relevant progress bar title in
"git bundle unbundle", and is also used in my "bundle-uri" RFC
patches[1] by a new caller in fetch-pack.c.

The code change in cmd_index_pack() won't handle
"--progress-title=xyz", only "--progress-title xyz", and the "(i+1)"
style (as opposed to "i + 1") is a bit odd.

Not using the "--long-option=value" style is inconsistent with
existing long options handled by cmd_index_pack(), but makes the code
that needs to call it better (two strvec_push(), instead of needing a
strvec_pushf()). Since the option is internal-only the inconsistency
shouldn't matter.

I'm copying the pattern to handle it as-is from the handling of the
existing "-o" option in the same function, see 9cf6d3357aa (Add
git-index-pack utility, 2005-10-12) for its addition. That's a short
option, but the code to implement the two is the same in functionality
and style. Eventually we'd like to migrate all of this this to
parse_options(), which would make these differences in behavior go
away.

1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-index-pack.txt | 6 ++++++
 builtin/index-pack.c             | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7fa74b9e798..1f1e3592251 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -82,6 +82,12 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
 
+--progress-title::
+	For internal use only.
++
+Set the title of the progress bar. The title is "Receiving objects" by
+default and "Indexing objects" when `--stdin` is specified.
+
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865c..0841c039ae2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -122,6 +122,7 @@ static int strict;
 static int do_fsck_object;
 static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static int verbose;
+static const char *progress_title;
 static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
@@ -1157,6 +1158,7 @@ static void parse_pack_objects(unsigned char *hash)
 
 	if (verbose)
 		progress = start_progress(
+				progress_title ? progress_title :
 				from_stdin ? _("Receiving objects") : _("Indexing objects"),
 				nr_objects);
 	for (i = 0; i < nr_objects; i++) {
@@ -1806,6 +1808,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				input_len = sizeof(*hdr);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
+			} else if (!strcmp(arg, "--progress-title")) {
+				if (progress_title || (i+1) >= argc)
+					usage(index_pack_usage);
+				progress_title = argv[++i];
 			} else if (!strcmp(arg, "--show-resolving-progress")) {
 				show_resolving_progress = 1;
 			} else if (!strcmp(arg, "--report-end-of-input")) {
-- 
2.33.0.813.g41c39388776

