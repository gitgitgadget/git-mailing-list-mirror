Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B13C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2074124B27
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgLPRob (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgLPRo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:44:29 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5BC0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:43:48 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id l207so28439874oib.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxD9c+qq72ObQPLy5mGVO52AlNrPW+keMtvBU/kZSJE=;
        b=lwpPOMWi5mBP0rr7p/qflq3B4jcd9mkfizkxlEi5q/Gpr1GGT5jPWU8O1+wg4qt5b5
         VTiK9yUMmq+w1l8Damibpwt1kwf2x4/UsArmVzfUB15aPnZhEZfQ1paS4F6xuMcUhp+X
         s2vyM+qcEdDHiBNLmjYIh8HhlzCchidQCOpBdJvm5PRiXSkSqy84pxU2RXNfR9Z1FYZI
         2wKwySfrBcwWi7zTTdbzEJzAmBUkyOGfAqlUsuqvdeUOu90HAnTG2YvtmU59zWwxTe9l
         yZIhnxurwhmPiLzLlvcjhDlWSr3luhVeCvdI5RikEg3Ra2xhEZYpMTAwmWOna3iRjwqg
         G6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxD9c+qq72ObQPLy5mGVO52AlNrPW+keMtvBU/kZSJE=;
        b=L7jOLOdbSfAn0txRpYeby/hzd1/rKGv3oWb7ntdKgMq8bZLXcJtQ66gfHFhEoougnc
         l3tmhaPcHsY5EiBQxt9M8MrAI3pp17l8LNqoUFldoyD5HazntWsKxLrB+q+YGZGGu8nZ
         NzQm8RecwcgFEHvF6kfs0DfuVc4UqokAyJ8Ac6+W5fPQUYZC/MHxblEmklpX6qt1zJpH
         jpR6W6P+oS0YVUYmbtxwkTZTKwNnkQYdykcRKjeJESTZ4uSPyCFiT8kZl6eTPbAyjIu2
         wY+oOPlxQ/k8HUCZf++8sZK6yVoYoCq1kxvBIlX+j5OxcxB8p5RkBnHpUiWtNK+Qbwe/
         CRUw==
X-Gm-Message-State: AOAM531VS2Ym/Gbl5UAKM8rzt6r+24/vfyKW4xV6NOChaLPwoeXjCUjQ
        ydBlyzsoz8kNotTv11okWwmBAqhIwHAKiw==
X-Google-Smtp-Source: ABdhPJxvzp3IzfnkCPA628MhERUa/lquG3OAlVWnIaws/c9OY+9Acdj7nu6LNSnKrMgY37AXSTGGug==
X-Received: by 2002:aca:4ec9:: with SMTP id c192mr2704139oib.115.1608140627738;
        Wed, 16 Dec 2020 09:43:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z6sm643758ooz.17.2020.12.16.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:43:47 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>
Subject: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Date:   Wed, 16 Dec 2020 11:43:45 -0600
Message-Id: <20201216174345.28146-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't make sense to display already-resolved conflicts in the
different views of all mergetools.

We already have the best version in MERGED, with annotations that can
be used to extract a pruned version of LOCAL and REMOTE. If we are using
the diff3 conflict-style, we can even extract BASE.

Let's use these annotations instead of using the original files before
the conflict resolution.

TODO: There may be a better way to extract these files that doesn't rely
on the user's conflict-style configuration.

See Seth House's blog post [1] for the idea and the rationale.

[1] https://www.eseth.org/2020/mergetools.html

Cc: Seth House <seth@eseth.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-mergetool.sh | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..4759433d46 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -227,18 +227,6 @@ stage_submodule () {
 	git update-index --add --replace --cacheinfo 160000 "$submodule_sha1" "${work_rel_path%/}" || die
 }
 
-checkout_staged_file () {
-	tmpfile="$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" &&
-	tmpfile=${tmpfile%%'	'*}
-
-	if test $? -eq 0 && test -n "$tmpfile"
-	then
-		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
-	else
-		>"$3"
-	fi
-}
-
 merge_file () {
 	MERGED="$1"
 
@@ -318,9 +306,10 @@ merge_file () {
 	# where the base's directory no longer exists.
 	mkdir -p "$(dirname "$MERGED")"
 
-	checkout_staged_file 1 "$MERGED" "$BASE"
-	checkout_staged_file 2 "$MERGED" "$LOCAL"
-	checkout_staged_file 3 "$MERGED" "$REMOTE"
+	# TODO: How do we get $MERGED always with diff3?
+	sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======$/,/^>>>>>>> /d' "$MERGED" > "$BASE"
+	sed -e '/^<<<<<<< /,/^=======$/d' -e '/^>>>>>>> /d' "$MERGED" > "$LOCAL"
+	sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$MERGED" > "$REMOTE"
 
 	if test -z "$local_mode" || test -z "$remote_mode"
 	then
-- 
2.30.0.rc0

