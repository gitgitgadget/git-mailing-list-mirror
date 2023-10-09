Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B3C2BA1B
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377135AbjJIQGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377121AbjJIQGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:06:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FA9C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:06:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c131ddfeb8so53272281fa.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696867605; x=1697472405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jBqmNGoHlVjhrcYkCvjjdl/nEY99/zHYoS/dj2G1pg=;
        b=kRcgo7Rbun3RGTnIjcmSEVBWNJYWQPNgqdu7c9y8yROt8WocSfAnLZ2rTTaNcr8Rzu
         tfKK2LcaMAGDg6zEwj25YLVZS/m/4Ad/FKImFnYdXsUuNtQ8CcbhTCeBHFF6H9HgPyVn
         PmnmA/cGwfxdlsC2So3dgZSrZ3EmM/fylfju9hBOW2xbNTgNuD6+VKyVFWmf3M1YJ+MI
         8Wouid8ukwQDp+Rk8adLaQTiDjk3nKG9NZeQ8BBZnHJZJh32eXsl+pDGhZhHRTV+YOUl
         4CHTfJvOROD14/4+uzPTMUBiHJ8kFeZ9LxAdh5yS3UXAWivFwdcHlqT473B3BNhipYKr
         lNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867605; x=1697472405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jBqmNGoHlVjhrcYkCvjjdl/nEY99/zHYoS/dj2G1pg=;
        b=f+YTyGvC6qu0C9O80xYEwVYYrtnAzEIljl2Oprd3PVK/cfrJrIw2F8nrV8rs0uIHUK
         jnCu4vNRn3TczV9QjNsfuZ6DoIVLmofKkoF3NZSbaiLHbE0Vxq8T8HLYlHnW+WTLHZpC
         4sTHJEe3HSHck3TClIFEXp9tFZpcMM2vtKZrXkbRvtaiTmY+hXCII9xT34wdLudE8m2M
         908+2uODKzSDofvlfwvXUgLFthSkQ9mlq+lu1JbBDUi3cui53PhQ2udzZXodMcdy8bhv
         0P65L65X/8Zvqvob2xn5DseEBdfv0MC8s5qdvhAHCi7Uu8H8C6dRpk8SiS5jQ/SPeaeN
         wfRQ==
X-Gm-Message-State: AOJu0Yy5hMP5sXIY/qP45BiWANk+2hlFRvtEbpK+s5mV+5cZzIqDQOq/
        LtyOTbShFBRnxgwQRgEt3796Pydp2S8=
X-Google-Smtp-Source: AGHT+IHmhE9o7fEBxcwC5aLjCJGjszBwus3Bd+jO7iLaJyvLuTqOl4+4DQVtrvpb16xEtk9d8SRazA==
X-Received: by 2002:a2e:a281:0:b0:2bc:c771:5498 with SMTP id k1-20020a2ea281000000b002bcc7715498mr13081716lja.18.1696867605146;
        Mon, 09 Oct 2023 09:06:45 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j22-20020a2e8256000000b002b6daa3fa2csm2019715ljh.69.2023.10.09.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:06:44 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v4 1/3] diff-merges: improve --diff-merges documentation
Date:   Mon,  9 Oct 2023 19:05:33 +0300
Message-Id: <20231009160535.236523-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231009160535.236523-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20231009160535.236523-1-sorganov@gmail.com>
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
 Documentation/diff-options.txt | 100 ++++++++++++++++++---------------
 Documentation/git-log.txt      |   2 +-
 2 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f33f887711d..69065c0e90a8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -43,66 +43,74 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
+-m::
+	Show diffs for merge commits in the default format. This is
+	similar to '--diff-merges=on', except `-m` will
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
+	Produce remerge-diff output for merge commits.
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
-	`log.diffMerges` configuration parameter, which default value
+on, m::
+	Make diff output for merge commits to be shown in the default
+	format. The default format could be changed using
+	`log.diffMerges` configuration variable, whose default value
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

