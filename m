Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25DEC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiBBChz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbiBBCho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E42C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s18so35514943wrv.7
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=cA1LwmUfxi8kiqA04k9tdctMjYIzf7ZFHEQyuTNZY98HdOYUtU27RVrx83R86cupaX
         Molf11TbbPFGzKKT7ZM6cy7eZN/Syrwg/Lt+W5j3t5xP/KX5SxUabEiXi9eIkxVk1jCy
         N2rZlTHMJlJAtJum1jhg2dL1yTdW7E8G1fQqUQnsiSoD3QXGhdwo2srKou3m+OkJM8hR
         k/oaNSWoEA1e8yczBHVOaJOYvoDMmIwqmvbOyEtjb8Vtrn4Z9QmGPPjx3tsMCtXHo3G9
         ZKomYTt8taNMcpjx0nA7l0E17N1O0GyD8b5CsWebHKA5wIaxlRCOWZ8qJkFYgNRTJvHE
         brxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=o0TNTTA80C3hILZ/Jx20KUWGZnCYNs1xbfmN6cgzyXsIcEhpCWNuXU4d8lPMsAe/au
         ZWV2lAxetW8nhu3/w2Bdki+teOtdoZfKUL2WZ+zyadAVkkAeKZYIbKTm3OVHjAO4T/94
         qvVe1YOXU1MaGKsFscGvgmvEKP1L4pe6Sx5gkRoUU3/V3Zgo0AuZxKyfIsIYL+IIhUY/
         gWsPtYIrJLmvXirglOgANeJfMmKQxiU2NMq16u137mBDYEFZ4IMvdUw5Nkdp/nRMYATK
         Z1N5O5/8gBFXV3qgN6GJ/GKzTX3UKV23VPY3H2eSK30ExtJZc12oUQ1U5FJ8aQk/Gs37
         saZw==
X-Gm-Message-State: AOAM530E3ZLVazciVIO8HZzu2JnPoRi7Pzn3GKKoVHu4FV/oWGb6JG+A
        Jk/z2S+5JxQxBUFb1SVQTDs2otUvpMQ=
X-Google-Smtp-Source: ABdhPJzTi51Joi6gtFwb7/k++98Es8UVXe7MT22k3gNFDAh0Y6l9hbyHADcfKfJll/oFgnxU3rM8wg==
X-Received: by 2002:adf:fa48:: with SMTP id y8mr23884626wrr.646.1643769462424;
        Tue, 01 Feb 2022 18:37:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm18878802wrq.81.2022.02.01.18.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:42 -0800 (PST)
Message-Id: <d7a1f4e1f9f5bdbd2ebff1586af73d2ea1a0319e.1643769457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:31 +0000
Subject: [PATCH v5 04/10] merge-ort: capture and print ll-merge warnings in
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

