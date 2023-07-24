Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F1CC0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGXQjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGXQjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:33 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136F12F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so5140234276.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690216767; x=1690821567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGucZYqlPmDeNkD6LmNX7+4hO+9pKL7I7jdJTgf/k9g=;
        b=VxUGAd23RMq7TTg7iMfK6RzfwJe1S88eDtBoYg3xot3DVwd/qfqDomwE7S3iFAihRw
         ev/+M6Np05sVomFHB/2AO6Ux9v9e4w7uQr8UEgBKV5ifqs3nZwspcCTUtbPQDXd2YcUj
         kx5X9QRVEosjipO5P9XoAJ+pdbzk2VXQB0pmswwfiQTNMulZ9jogYTkQx8mmSqMrhorq
         Z5yxG+KbDwuUQQPjVVZ0DuuIVnAsTAzwWUmg+1ylz5BdllQOdpGjUsxl88jntVLGM6o4
         AU1ryJuZkqXzTqM2QbyLZV6C1hwpyDDeuHAY3asmRQO7wIJdZDW0xq/S1FPJH8mkgzcO
         Z+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216767; x=1690821567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGucZYqlPmDeNkD6LmNX7+4hO+9pKL7I7jdJTgf/k9g=;
        b=kFGtAWS+uZKWHSIbr8X7SqjChu72qv+SKlRyWIMrjBakeLeLqZsjdabUboH7dY3a0p
         09cjDPw/rP35amQIUUzyTyJ7Ul2h9EUE8DprhD60UmlttFMBnSjG4P+VfKm2oObOWG1C
         9T0aH2ZIEkhA9xlRuEVq1KSO66SCdD/kyqEmyMN5Ducxyj2jll/8sCAZ4z2RXNNU60JM
         geabEWa1k3mCm+x+o/ar/QLrCTPGUlR5UNS2gPS6jPogcz9zvO0FYKsAaWmXD1JmaVNI
         PbNHCJib15m7VMneMZ81E7KqWHqgZc54d32eLMB4lDyJAUSj/yw7DQV61NZzckglF+2+
         dEdQ==
X-Gm-Message-State: ABy/qLYY0AEqUlYCLKC22HmE5krM6imTAU6ztz8/5T+b7omfzHOTRICT
        tQ6fJOZ18L4YHskPIisQFKDztwZvpeHWuSS9O2wnLg==
X-Google-Smtp-Source: APBJJlEwyg1aXxq7TWo+IGxofCDnXfcIeWjvUUzoF97JKLd6KjfWfyDRNmln7r4ylhewzjgjhigyfw==
X-Received: by 2002:a25:dcc5:0:b0:d11:a1f6:7719 with SMTP id y188-20020a25dcc5000000b00d11a1f67719mr2186928ybe.35.1690216766939;
        Mon, 24 Jul 2023 09:39:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 7-20020a5b0107000000b00d0538bab61asm1703002ybx.65.2023.07.24.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:39:26 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:39:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] t/lib-commit-graph.sh: avoid directory change in
 `graph_git_behavior()`
Message-ID: <115df6fe22688bc6305dd5bdbbec83e37cccc1df.1690216758.git.me@ttaylorr.com>
References: <cover.1689960606.git.me@ttaylorr.com>
 <cover.1690216758.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1690216758.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `graph_git_behavior()` helper asserts that a number of common Git
operations (such as `git log --oneline`, `git log --topo-order`, etc.)
produce identical output regardless of whether or not a commit-graph is
in use.

This helper takes as its second argument the location (relative to the
`$TRASH_DIRECTORY`) of the Git repostiory under test. In order to run
each of its commands within that repository, it first changes into that
directory, without the use of a sub-shell.

This pollutes future tests which expect to be run in the top-level
`$TRASH_DIRECTORY` as usual. We could wrap `graph_git_behavior()` in a
sub-shell, like:

    graph_git_behavior() {
      # ...
      (
        cd "$TRASH_DIRECTORY/$DIR" &&
        graph_git_two_modesl
      )
    }

, but since we're invoking git directly, we can pass along a "-C $DIR"
when "$DIR" is non-empty.

Note, however, that until the remaining callers are cleaned up to avoid
changing working directories outside of a sub-shell, that we need to
ensure that we are operating in the top-level $TRASH_DIRECTORY. The
inner-subshell will go away in a future commit once it is no longer
necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-commit-graph.sh | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index 4d3e7f0623e..c8bd76a7777 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -14,18 +14,27 @@ graph_git_two_modes() {
 	test_cmp expect output
 }
 
+# graph_git_behavior <name> <directory> <branch> <compare>
+#
+# Ensures that a handful of traversal operations produce the same
+# results with and without the commit-graph in use.
+#
+# NOTE: it is a bug to call this function with <directory> containing
+# any characters in $IFS.
 graph_git_behavior() {
 	MSG=$1
 	DIR=$2
 	BRANCH=$3
 	COMPARE=$4
 	test_expect_success "check normal git operations: $MSG" '
-		cd "$TRASH_DIRECTORY/$DIR" &&
-		graph_git_two_modes "log --oneline $BRANCH" &&
-		graph_git_two_modes "log --topo-order $BRANCH" &&
-		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
-		graph_git_two_modes "branch -vv" &&
-		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+		(
+			cd "$TRASH_DIRECTORY" &&
+			graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
+			graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
+			graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
+			graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
+			graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
+		)
 	'
 }
 
-- 
2.41.0.399.g887006eab46

