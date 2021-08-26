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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98905C4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8294C60E0B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbhHZOG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbhHZOGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:06:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175FC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:06:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h13so5321296wrp.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyAcrN9MRvHtfPfkXyWg6sEvHQJZNU5V/0uNpUlL1vY=;
        b=Fnt8aSYu/G2IANzIzxWHfQN7k8W8x+4EP53ULBXxspuAMpNR+lN4zJzBDEDajTC52b
         HqknnGot3rFFFX4Ypc9sfKb4bOuNpW16teudooHqMkR1xeDvxiOEUed3DFGcCS2+eexe
         S4gnzknGHk/ZAD3/1m7UDkqDDCNVpxnDMbB2ycY8GdeA4J6XWKZXIYEGc/ATcumxciXG
         ILSOuUSo7gWvvJa4auUoHu44ZW/FraqE6SHUS6vc6c4jS/0zIRnhplU6ZSeGKu8uz8mZ
         dawKgKtl7HwX9M0GU2egR7revDkMCejS/OuGdzyJ1tUCr7BxufEJEjQjcQG7rbuvQBX7
         ymuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyAcrN9MRvHtfPfkXyWg6sEvHQJZNU5V/0uNpUlL1vY=;
        b=KjFftFkrMMNHrAbC5jAMxGYZkUBZOsPmtHI82Tf3NXr8JL35i2uaJMQVUo46XS18Ws
         zyn1ZPDgvUYu7IvCkXxHWJG+5tJJq9J4TZmVSkmnJExhaRUjo62g6TAWqcBGiZ8faml0
         L6fWdcg4m4q+juSw5ReT8zt6DjRaf9RBir0Ot2+aF1inyN25a03VVg6RUL+6pVcwfXJq
         NvjdkKuvekNOFtrTotSvm40Xz4dCT7GeW3jMqBOuHY7n0wqTUnLKorQDIwMQz8784duc
         GS2G26+ssP7dLNUmVj+ByID8AnKom1+miae3eshIXkSkBbCvOoQ57P2KHcds/F2j5KOc
         pdKw==
X-Gm-Message-State: AOAM530jP577mh3gvdwho3tGXuA1MOOO+4aEoMlE38K8w00RahckmEVa
        VSrYBqQCGJq5WBeWEKFDdoQNZa2OSdYbaw==
X-Google-Smtp-Source: ABdhPJzjewECe1uKZnrdiaiP0Zd+NXn2JqqhwDvMyC3++eRtWh+UGOswnW5PSdB+W97K5OpD93O9pg==
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr4415390wri.250.1629986759181;
        Thu, 26 Aug 2021 07:05:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm2471987wms.33.2021.08.26.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:05:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] bundle: show progress on "unbundle"
Date:   Thu, 26 Aug 2021 16:05:51 +0200
Message-Id: <patch-v3-5.5-cd38b0f0fed-20210826T140414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
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
 Documentation/git-bundle.txt |  2 +-
 builtin/bundle.c             | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index f9360c32c6c..1fbfe280c57 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -162,10 +162,15 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
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
+	struct strvec extra_args = STRVEC_INIT;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_unbundle_usage, options, &bundle_file);
@@ -177,7 +182,15 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
-	ret = !!unbundle(the_repository, &header, bundle_fd, NULL) ||
+
+	if (progress) {
+		strvec_push(&extra_args, "-v");
+		strvec_push(&extra_args, "--progress-title");
+		strvec_push(&extra_args, _("Unbundling objects"));
+	}
+
+	ret = !!unbundle(the_repository, &header, bundle_fd, progress ?
+			 &extra_args : NULL) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
-- 
2.33.0.733.ga72a4f1c2e1

