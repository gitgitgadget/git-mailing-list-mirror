Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F633C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiAUTMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiAUTM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E736EC061744
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u15so1399301wrt.3
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=p8RK3b6HA0umuMtzFD+ZbFOkIKY6vzI9YFfWOlXgzZPGXyvaam1asUcXhgi92VglGl
         n9E44UQ6QTXz4jydm0dRrQETWwqzv0RHUEikMdmhVHKsjOhgpDqPozkLeO/rspXknfys
         jYu2HaND5leE5oZ2+6w1c3qAQF7cNS5S1qTGOXW1eNluyhCnFMB5FK9KfrniOV9geYP7
         4oSSO7fu1XIZ3g+3WMrHjeOHjJPIrU+oFR5dWMSbcRAN0VljwM36G5h0V3VabDOPnYag
         tlhR3X4wyUoZI0ErD5y5lDN5r51uOY7iBRQGfAkiascbdQzCi4hOxvgs6FaeU279qUmB
         iS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=Le0dRY17A4vne0ejxTgELrBVPCERxw42b4ZJ+YF3vxtVotH0d5cO7TYoYZ2zOO/j3F
         2TsSKcofKRA5JizDAAyKQ8uftyLO1XUzzahlmTAK6WB+WXQ3g1CgAqyS5lhpPcfAPupU
         7TtxWhRXEKhAsAIDLWnfGJmnZcLBvdVdbA8RidHXezy2yMiLtz40jE2CHP+iPGLS24JZ
         XbZqW1A4zrOCrw4aDD89hS6Evv4OYHaPuNfZCQ9iiAXFk1oqR7zTOgXE8POErBBTpXsA
         GCpHTeswpsaFUzz8AcpQwAEf27T4OdKl50ZsgvOuOptG17p4m2JdlEtqPCFUZSbZkZ9/
         8+yw==
X-Gm-Message-State: AOAM530oH5cKd7xOFIZFh17l7XzHbO6ricrxbQMmAzgGiKPVHCIxpsjP
        5OvtORTdMlH9pkDEIurrEr6J6vE8a5U=
X-Google-Smtp-Source: ABdhPJzRp8/sp4ukZh7dFAvN4N6RcQ4LkCvDKplf3rsP1YQtWeF88hzoBnVsjCwg+KIUBKUvCpGJgw==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr5058324wri.667.1642792346343;
        Fri, 21 Jan 2022 11:12:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm7936453wrp.55.2022.01.21.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:25 -0800 (PST)
Message-Id: <de8e8f88fa475681672990b04c00b5ed397a8e01.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:14 +0000
Subject: [PATCH v4 04/10] merge-ort: capture and print ll-merge warnings in
 our preferred fashion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Instead of immediately printing ll-merge warnings to stderr, we save
them in our output strbuf.  Besides allowing us to move these warnings
to a special file for --remerge-diff, this has two other benefits for
regular merges done by merge-ort:

  * The deferral of messages ensures we can print all messages about
    any given path together (merge-recursive was known to sometimes
    intersperse messages about other paths, particularly when renames
    were involved).

  * The deferral of messages means we can avoid printing spurious
    conflict messages when we just end up aborting due to local user
    modifications in the way.  (In contrast to merge-recursive.c which
    prematurely checks for local modifications in the way via
    unpack_trees() and gets the check wrong both in terms of false
    positives and false negatives relative to renames, merge-ort does
    not perform the local modifications in the way check until the
    checkout() step after the full merge has been computed.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                | 5 +++--
 t/t6404-recursive-merge.sh | 9 +++++++--
 t/t6406-merge-attr.sh      | 9 +++++++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c24da2ba3cb..a18f47e23c5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1788,8 +1788,9 @@ static int merge_3way(struct merge_options *opt,
 				&src1, name1, &src2, name2,
 				&opt->priv->attr_index, &ll_opts);
 	if (merge_status == LL_MERGE_BINARY_CONFLICT)
-		warning("Cannot merge binary files: %s (%s vs. %s)",
-			path, name1, name2);
+		path_msg(opt, path, 0,
+			 "warning: Cannot merge binary files: %s (%s vs. %s)",
+			 path, name1, name2);
 
 	free(base);
 	free(name1);
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index eaf48e941e2..b8735c6db4d 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -108,8 +108,13 @@ test_expect_success 'refuse to merge binary files' '
 	printf "\0\0" >binary-file &&
 	git add binary-file &&
 	git commit -m binary2 &&
-	test_must_fail git merge F >merge.out 2>merge.err &&
-	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_must_fail git merge F >merge_output
+	else
+		test_must_fail git merge F 2>merge_output
+	fi &&
+	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge_output
 '
 
 test_expect_success 'mark rename/delete as unmerged' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 84946458371..c41584eb33e 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -221,8 +221,13 @@ test_expect_success 'binary files with union attribute' '
 	printf "two\0" >bin.txt &&
 	git commit -am two &&
 
-	test_must_fail git merge bin-main 2>stderr &&
-	grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_must_fail git merge bin-main >output
+	else
+		test_must_fail git merge bin-main 2>output
+	fi &&
+	grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
 '
 
 test_done
-- 
gitgitgadget

