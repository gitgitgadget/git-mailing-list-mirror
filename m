Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC86C433FE
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbhLUSF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240818AbhLUSFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5FC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso2302728wmc.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=Pq6bNlLE0V15qJi+Uxt8NfwB6TpmQrX3OZ0rvzIwW9nffeNSL6fEZb6pRwJyXHQfO6
         yIyFa/iWYmsOkLbp5bwuVoDHpAeG8csmxObJ9Q/xbzspv/lWgtZGPCRN2/QxN1nDohgE
         /DPXao07ZUcjvh7gv0n6GTX54W0sQpf6+dycloCsTn6fcgVYZOFKelKUFzXF8ENEUhIB
         auA8OMnisXshzhvjrHUJXVB9FoA13do1p+jSkijts5uvKG3PdR+l54HbPZIZMc4Vxh3N
         VUOaK1ko8XWPq9dkKpS8M4oCUW4DbZDkuj0KwlTxp5J48FriK7uO+D3au5VMPAWFeEWJ
         9owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=k4kjgKm8r+GKOubY5zTJbwojxpNcoKfsLb7SQW/+3ArWvFn38cLdblWAF7N9qQj5Ji
         crzLymv5lHls7Wpqyn4qwJ+u0/KgL9bDCQpTV9lgn7xP/Yjihqg6FV3b+A5oLvZiYZyX
         aza8NXhR3+rX7Chfuh+T6Z/JtEjOmLkA0q7Xm6OB8+f7grLUf3Uww5cw9Fpfw9+GyHxJ
         f65WRgOEL8D78Em/aXKYBGi/bqpwc8OD91Y1FxtaF3OWs0sN8oH9xr+W5IQDT/shKxGA
         l9vlBXqExFDbEIyOm67qTb+bkRgOUw3ZjGAU+wN88Tg7e/2k/8wcAeI0SvoNUay2arge
         xqOQ==
X-Gm-Message-State: AOAM530hLOeqWF8RSF2WQcKTxBvBwMLkKoIMQI7zpENh0tCuaSiTX4Zw
        H5PzyuRzyi3rBsG8guCN/ABTVe+3Q6s=
X-Google-Smtp-Source: ABdhPJzHLLLCnoc/B1WwkuaAuiArarj1rDl+tDm9UNsl+7ntHFDat/K615kbYscEEywBLP1kBvOvAw==
X-Received: by 2002:a05:600c:34c1:: with SMTP id d1mr2589498wmq.118.1640109952269;
        Tue, 21 Dec 2021 10:05:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j26sm921002wms.46.2021.12.21.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:51 -0800 (PST)
Message-Id: <f36395fdee044a077a640bd3031a7a8da8a39657.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:42 +0000
Subject: [PATCH 3/9] merge-ort: capture and print ll-merge warnings in our
 preferred fashion
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

