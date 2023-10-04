Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA3E936EA
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 21:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjJDVqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbjJDVq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 17:46:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31770C6
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 14:46:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32336a30d18so277801f8f.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696455980; x=1697060780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwULGC8BAfLATKKheQRRpOJp8nqzM2A6Zm3K6cZnB8o=;
        b=eDEtQ5Z0LVWy4hZCzsaLAoWFHSkAy1Kt7KfRNeA7DGgDrpnAuf2Lgz5JzuVzMFxYCv
         InWVM1DWrFIYXDVkeMmXvR1JKlXEOL1S48P1JkxCROml1L1u/3yPsubXQRnMoUuZ5kwF
         UiHIu3PtjQpS2T30aKXcSSYOTL11hkiyPu0uQbdrQLMQ8k5vJPTFrQqfGOKV4kMFXtsk
         zeH9LtMiyhIqud8AdDG8154WsVByfDu96Y7Fx9r1m5qqhbO4VhBDdSpR/3a4bkuhi+d4
         JqRGm+B9yR10s46PDDxRvj2gGkqpQ4a6qzDIkWwQWyzGlfVH2mtEATkKClaYwormFLOa
         9YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696455980; x=1697060780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwULGC8BAfLATKKheQRRpOJp8nqzM2A6Zm3K6cZnB8o=;
        b=uX/R6OEIvDD4n2miY55G1/xc+7heZ7MQZ2LAlvIdZvUf2dV8W/kZHpD8Qr6+JhxZ1M
         ZzELJ0MZDnTZZl80pLnBqWFxzNKIGiVkj3WQuxhw+qoOJ4w0YDP+Tw9qX1OR0KZXry5I
         FhmbAay0KrdCAtytbvLu3nc1egjg1vneiFI7dOrfG9qmGiakH6go0g85L7rtATIIfl/S
         of7liRL42qB40UiqHQTUepikVtWdX0x2cVAXLjpCEsoy/KVrlz8lPyfqU2ajnWJ+rfm3
         Mfa0f3clnkR0+XVSga+Ezve05mNEXHyaVe0/pIq4Efa4Zo103LCXeQKpjXidjzALH9Om
         Hnsg==
X-Gm-Message-State: AOJu0YwFwWWEobDoAAYSVbreKN6BJBb/dj239RjtD07zcRyWR2YM6T9p
        Jt4wSWqHt90NL3bILLFAuJw=
X-Google-Smtp-Source: AGHT+IF9iYHtfT8f7hZ1Ea0BNf7wJV/ObnaNSNElipeKg73gu1S1NUGnRGBz4PNHfKT7vWgE4PavLw==
X-Received: by 2002:adf:e7c1:0:b0:323:2f16:66ee with SMTP id e1-20020adfe7c1000000b003232f1666eemr2788368wrn.71.1696455980363;
        Wed, 04 Oct 2023 14:46:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b002bfba0d26bcsm7818ljj.8.2023.10.04.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:46:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
Date:   Thu,  5 Oct 2023 00:45:56 +0300
Message-Id: <20231004214558.210339-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231004214558.210339-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20231004214558.210339-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Put descriptions of convenience shortcuts first, so they are the
  first things reader observes rather than lengthy detailed stuff.

* Get rid of very long line containing all the --diff-merges formats
  by replacing them with <format>, and putting each supported format
  on its own line.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 98 ++++++++++++++++++----------------
 Documentation/git-log.txt      |  2 +-
 2 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f33f887711d..8035210c1418 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -43,66 +43,74 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
+-m::
+	Show diffs for merge commits in the default format. This is
+	similar to '--diff-merges=on' (which see) except `-m` will
+	produce no output unless `-p` is given as well.
+
+-c::
+	Produce combined diff output for merge commits.
+	Shortcut for '--diff-merges=combined -p'.
+
+--cc::
+	Produce dense combined diff output for merge commits.
+	Shortcut for '--diff-merges=dense-combined -p'.
+
+--remerge-diff::
+	Produce diff against re-merge.
+	Shortcut for '--diff-merges=remerge -p'.
+
 --no-diff-merges::
+	Synonym for '--diff-merges=off'.
+
+--diff-merges=<format>::
 	Specify diff format to be used for merge commits. Default is
-	{diff-merges-default} unless `--first-parent` is in use, in which case
-	`first-parent` is the default.
+	{diff-merges-default} unless `--first-parent` is in use, in
+	which case `first-parent` is the default.
 +
---diff-merges=(off|none):::
---no-diff-merges:::
+The following formats are supported:
++
+--
+off, none::
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
---diff-merges=on:::
---diff-merges=m:::
--m:::
-	This option makes diff output for merge commits to be shown in
-	the default format. `-m` will produce the output only if `-p`
-	is given as well. The default format could be changed using
+on, m::
+	Make diff output for merge commits to be shown in the default
+	format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
 +
---diff-merges=first-parent:::
---diff-merges=1:::
-	This option makes merge commits show the full diff with
-	respect to the first parent only.
+first-parent, 1::
+	Show full diff with respect to first parent. This is the same
+	format as `--patch` produces for non-merge commits.
 +
---diff-merges=separate:::
-	This makes merge commits show the full diff with respect to
-	each of the parents. Separate log entry and diff is generated
-	for each parent.
+separate::
+	Show full diff with respect to each of parents.
+	Separate log entry and diff is generated for each parent.
 +
---diff-merges=remerge:::
---diff-merges=r:::
---remerge-diff:::
-	With this option, two-parent merge commits are remerged to
-	create a temporary tree object -- potentially containing files
-	with conflict markers and such.  A diff is then shown between
-	that temporary tree and the actual merge commit.
+combined, c::
+	Show differences from each of the parents to the merge
+	result simultaneously instead of showing pairwise diff between
+	a parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents.
++
+dense-combined, cc::
+	Further compress output produced by `--diff-merges=combined`
+	by omitting uninteresting hunks whose contents in the parents
+	have only two variants and the merge result picks one of them
+	without modification.
++
+remerge, r::
+	Remerge two-parent merge commits to create a temporary tree
+	object--potentially containing files with conflict markers
+	and such.  A diff is then shown between that temporary tree
+	and the actual merge commit.
 +
 The output emitted when this option is used is subject to change, and
 so is its interaction with other options (unless explicitly
 documented).
-+
---diff-merges=combined:::
---diff-merges=c:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. `-c` implies
-	`-p`.
-+
---diff-merges=dense-combined:::
---diff-merges=cc:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.  `--cc` implies `-p`.
+--
 
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2a66cf888074..9b7ec96e767a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -124,7 +124,7 @@ Note that unless one of `--diff-merges` variants (including short
 will not show a diff, even if a diff format like `--patch` is
 selected, nor will they match search options like `-S`. The exception
 is when `--first-parent` is in use, in which case `first-parent` is
-the default format.
+the default format for merge commits.
 
 :git-log: 1
 :diff-merges-default: `off`
-- 
2.25.1

