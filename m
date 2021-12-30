Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3AEC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbhL3XgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbhL3XgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA82C06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so14021439wme.4
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=hgIDFcjOI4cgdMKW1Rho73XQcdGwBQBsHQpPb5ZZrlKJVr4K98iA9bi6BERI66KUKR
         51QleoLfhlwBs82nyMVmq3P7Jw5iL+/+nmslPHczciNu17HqKYj3tn6eg0wd0Z2YC1D0
         qyo2I0R3WMvu5wDe39CczSzeAC3kh0nF9xMDGBeQJPjlAKJfuhUUspRjIQYlQ/1w9d3y
         JjiJJnfhjsrtTkUgPdIC4vSf3+sd5GLToE/FDYGqTo8+T24bfA6jCwxAhuMGoCdsrAih
         20NkAA6ZxG5C4ghHw29Snqg4zoUNXcqqhTRQulKeF4/8DA56vI48a1T6h8W8LQS+dtKE
         hAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=obkKWvubyxcsBWBqodq9GjqtIG2fyoJpZDBmj1ztp44=;
        b=AzMZgbP7EUtyXhb+NSAqvgycfcRNhsWeTfA/646izJuZpR9LBbKM8ClFgcle/9JvHh
         gkkuAq0BByexCfKMpgjBKnREXP6TQAvWDyhdsMa11gi58KjVqgDi7Vj6mXxTiZJECkvH
         O1eMEROob4Ad24PsXCJTdG5ypUdRtpZRAOKMibkwD3mGdkqJyg21O9OCuX/7GDHHM0lR
         yXFYKs2gLD6gwqy/AiCRKTCB9lnMgSp+Bs4fiH5SQ6r+2orFTNb//bvUDmwOU83DbOPJ
         YtDwxxaEP3XkJnrTzXct7e2ygmqNj53FXrxDjfMXNCsFIVTusIEbCgaumAGsPUstk+Nd
         B10w==
X-Gm-Message-State: AOAM532CDl6Flgem3EPs4XpD560NfwxuBFw67mRuqamPy5f4SgakxZWK
        5UGKwKDMflnQ5YEYi15OsmBsPLEgHM0=
X-Google-Smtp-Source: ABdhPJxyhGI0Xc6HXb10vjJV9waBBAeLk9k4nEH3BXECasAYaI2rJS8SsCRMBWFXbJG2OGRgr+oCJA==
X-Received: by 2002:a7b:c1d5:: with SMTP id a21mr27684519wmj.97.1640907374070;
        Thu, 30 Dec 2021 15:36:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm25265820wrz.31.2021.12.30.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:13 -0800 (PST)
Message-Id: <e8cf1626960774d524367c17db01e2a29eac7759.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:04 +0000
Subject: [PATCH v3 4/9] merge-ort: capture and print ll-merge warnings in our
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

