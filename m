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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02B3C433FE
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9676261027
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhIEHf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhIEHf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:35:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F51C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:34:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b6so4850011wrh.10
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HN2K8JLweIlubl4ICGLFXo02UX9Fu9TELb9VsE2Y2x8=;
        b=Cd+NC6hReyrOCjMOk6XRWqNsb1mru+lMFAntinbhzecknDXKArd/ARbArwITPAu+sf
         9tcGYPfWORS+R/RchrpTC0YA9N0rP73KPfOcqJGS9DiHgwNkodB1BpB0k3mEpwoYQcBo
         dtvluaoudmM6gH8Vk6UXc63xwL2g83r330waBftAyEkgN8rLDwFLwQzaK81eLNI4WM9G
         PjNHAI32aIZIMdflQ1e0grXx6j/+u2Z9IMHWjYxhjJPOZj5ZmFqjhULmRxKmEn2bmPRm
         xzf+JBbjlVfECBqU2RPZlfW9ErM+4+Jw79sSzNeJGK7K2+QjLILZ4wrQThFFCqE2087R
         qkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HN2K8JLweIlubl4ICGLFXo02UX9Fu9TELb9VsE2Y2x8=;
        b=M4CF/wICORXNhcGq/h1WVzM0msUK4hSUMp2jfaWwTLxCXYU+6lPhzWQzHEJf9MKZY5
         ySD80EQPaXYtM00FgKsvwgirkULHWZ3KHULQLn85mFiTp0rs1k/RcGSIPNcTs+frXDDJ
         kZ6nO4sls3rX8odTI4ocg2fcjdDKzlPhsnqIS9PihAZVe8lsm+csMJorJGEharz8k7wU
         3THfHUjRBIQLIG+Gnh/ZKo2vv6rTDh/hHmbI+o33afP6LBAXxJDXWXOeyy21Wv6DtVrZ
         0kqaRDr+1rSpRqQWh3oJMeG/IfOR43c9bjQ3RvslIw3erSPifIyZ6ob2U6JjyMskEvLh
         koRA==
X-Gm-Message-State: AOAM531KANQQ7stmhnPkfPWviiODfQEcW1YSzIUsi8XNMwMsNKDtmb9+
        4Z1v5oT7vSYdW1p3Y6M4g2dnhOFqXdH2cA==
X-Google-Smtp-Source: ABdhPJz8+1lWYn8CwQCF7hQaO2XX0kNamJYFEUciEZL3y9acB/AOMPWzHSfLHKdzt18dOsZllVwutA==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr7093897wru.232.1630827292919;
        Sun, 05 Sep 2021 00:34:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm4218734wrc.31.2021.09.05.00.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:34:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] bundle: show progress on "unbundle"
Date:   Sun,  5 Sep 2021 09:34:45 +0200
Message-Id: <patch-v4-4.4-8f4c7f99799-20210905T072750Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.813.g41c39388776
In-Reply-To: <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "unbundle" command added in 2e0afafebd8 (Add git-bundle: move
objects and references by archive, 2007-02-22) did not show progress
output, even though the underlying API learned how to show progress in
be042aff24c (Teach progress eye-candy to fetch_refs_from_bundle(),
2011-09-18).

Now we'll show "Unbundling objects" using the new --progress-title
option to "git index-pack", to go with its existing "Receiving
objects" and "Indexing objects" (which it shows when invoked with
"--stdin", and with a pack file, respectively).

Unlike "git bundle create" we don't handle "--quiet" here, nor
"--all-progress" and "--all-progress-implied". Those are all specific
to "create" (and "verify", in the case of "--quiet").

The structure of the existing documentation is a bit unclear, e.g. the
documentation for the "--quiet" option added in
79862b6b77c (bundle-create: progress output control, 2019-11-10) only
describes how it works for "create", and not for "verify". That and
other issues in it should be fixed, but I'd like to avoid untangling
that mess right now. Let's just support the standard "--no-progress"
implicitly here, and leave cleaning up the general behavior of "git
bundle" for a later change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 2 +-
 builtin/bundle.c             | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index ac0d0038350..71b5ecabd1f 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		    [--version=<version>] <file> <git-rev-list-args>
 'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
-'git bundle' unbundle <file> [<refname>...]
+'git bundle' unbundle [--progress] <file> [<refname>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 9b86c8529c7..91975def2da 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -162,7 +162,11 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
+	int progress = isatty(2);
+
 	struct option options[] = {
+		OPT_BOOL(0, "progress", &progress,
+			 N_("show progress meter")),
 		OPT_END()
 	};
 	char *bundle_file;
@@ -178,6 +182,9 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
+	if (progress)
+		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
+			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
 			 &extra_index_pack_args) ||
 		list_bundle_refs(&header, argc, argv);
-- 
2.33.0.813.g41c39388776

