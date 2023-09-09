Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5774EEB58B
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjIIMzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 08:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbjIIMzI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 08:55:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCBCCE7
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 05:55:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so50354381fa.3
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694264102; x=1694868902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaAt6cv+5n5QHJE/PEfwH1jQp4ZoR03MRNg9zv+Q0Fk=;
        b=jGmY2fdvOlnom8K2hd9yg8RNC1Dm1lf2ewtsXbWHWDiBr9BT/hmwP57zUKASzGLCIP
         vNIlG4zjDXEU/12iMsqeEBhwK/If5MB/MlRkQD/MKVzgLodg7ElmVaL4CbxFW6bg7SUY
         XBBJfivOsKkPPhSQ7bd5O/ohnCnwsKHXrRhLwigIozTI+LTiykcdTQVj6Le2ggcEV+pY
         E/WcRsxFNKwFHVyTnA48LySadVfL+F8PVdBsnQjMNLwI2KhIzn2ha1bgYi2PS0TphxSw
         sTsBCf/oF91CHpraz+b8erIXaxomrYvML3rgwDvI6RXD/FUsDsJXURLUNTKQrNUnFDBH
         J5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694264102; x=1694868902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaAt6cv+5n5QHJE/PEfwH1jQp4ZoR03MRNg9zv+Q0Fk=;
        b=AuDcBm8/VWcTm9+1nhsx/0iHEoMnN65FvU3h8Kq2HW0l6MQy0RBVJGaBx2X/6340Qt
         kfZ2xx+msAuSzFocLmerp7ucU7HkRFvzHKeCDnc4GmghIsYWhjEZdsEAsffmaU7Kd8+L
         yFb0P9Q95n09C2gH0kiScynRRdiSwghZYkYIlivmFcItKSb4an8NwCQZZk6IUbz1tS9G
         DLznXlGoOl29CPcvpciHggRiJI7x49zx4XaS4HswwU5TehhHfOCKC6SIscJfChaly5Sk
         HUDqzgcckkkeQOLb8GNnRO+JiQ1mFWVG/hRiG8SqC73jMKhCVt28Xyawq/hn7cDE04Sn
         T66w==
X-Gm-Message-State: AOJu0YzPCGH2oV00sue/0vftkN2A5EztO612WAJHFyDUmxEBHU9K5qxw
        MNfYiJEuDrko55+6EPEJczM=
X-Google-Smtp-Source: AGHT+IE7mcuQhNolD7nAAeXOj+1MlEJUTIaMMK77Im39vVDBqcC1NHDYva0L+upWyYaFLSEwHnnr2Q==
X-Received: by 2002:a2e:7e0e:0:b0:2b6:decf:5cbd with SMTP id z14-20020a2e7e0e000000b002b6decf5cbdmr3282649ljc.36.1694264101783;
        Sat, 09 Sep 2023 05:55:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002ba130e9a29sm649871ljj.76.2023.09.09.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 05:55:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/2] diff-merges: improve --diff-merges documentation
Date:   Sat,  9 Sep 2023 15:54:45 +0300
Message-Id: <20230909125446.142715-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230909125446.142715-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Put descriptions of convenience shortcuts first, so they are the
  first things reader observes, not lengthy stuff.

* Add explanation note on '-m' not implying '-p' unlike similar
  options.

* Get rid of very long line containing all the --diff-merges formats
  by replacing them with <format>, and putting each supported format
  on its own line.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 97 +++++++++++++++++++---------------
 Documentation/git-log.txt      |  2 +-
 2 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f33f887711d..f93aa3e46a52 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -43,66 +43,77 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
+-m::
+	Show diffs for merge commits in the default format. This is
+	similar to '--diff-merges=on' (which see) except `-m` will
+	produce no output unless `-p` is given as well.
++
+Note: This option not implying `-p` is legacy feature that is
+preserved for the sake of backward compatibility.
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
+remerge, r::
+	Remerge two-parent merge commits to create a temporary tree
+	object--potentially containing files with conflict markers
+	and such.  A diff is then shown between that temporary tree
+	and the actual merge commit.
 +
 The output emitted when this option is used is subject to change, and
 so is its interaction with other options (unless explicitly
 documented).
 +
---diff-merges=combined:::
---diff-merges=c:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. `-c` implies
-	`-p`.
+combined, c::
+	Show differences from each of the parents to the merge
+	result simultaneously instead of showing pairwise diff between
+	a parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents.
 +
---diff-merges=dense-combined:::
---diff-merges=cc:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.  `--cc` implies `-p`.
+dense-combined, cc::
+	Further compress output produced by `--diff-merges=combined`
+	by omitting uninteresting hunks whose contents in the parents
+	have only two variants and the merge result picks one of them
+	without modification.
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

