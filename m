Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C06C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiIZMGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiIZMFS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 08:05:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64B4E613
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 03:55:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b75so6292517pfb.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9WcIDgpYibA8rFSiPcsLYTwLGFImnvaPeWwKIx6ONR4=;
        b=R5po0G96SIBYVk3fgqjo4QW3Qm0LRjLJlyaOvf8mCQiP5e4/37XA3YGku2Ff+fRrvs
         GMpw2zBR3bxZn2jlYOfYXKW1zPaXYAEux5Nfafa/BbbLX4ygKwxw2Pk6WD0WNU+z5B3b
         y9KjDpwjgzz5gbWDlpskgdUB7l0ZoHxLPEx19n864ZUnG8jioMQ6srmkocXIWOKKSGAW
         MOf4j75rpcJn1d+3i21TISuWgM1Pwp7YVYw6n4121Mi2RSgDn5NS7xP/C0QiM2I/I5qh
         DnUvBvM5fJ/EHEAE1QkcG1yTjDA0cVt5ycKs51O1r+QXOneS8QaCs2pTKb6awFUKka3p
         7ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9WcIDgpYibA8rFSiPcsLYTwLGFImnvaPeWwKIx6ONR4=;
        b=TqCHn2Wa4W9njvlqkjaebg4SQVpry+Q6OuDICt8aSDnO4iaFh+QJpoavdPJJQYPSPi
         WEOe6o9mHBX/BM6F8WZGdmsk9uRVDUajsnvlLswJRdwfmr7gP2jIxJkGrIv5hDLRR8lx
         gJOJM25T9R9F0fX0ZeND2EkYnNgCzoP6iJyunbTIFB6mHCsx6Sc4Uvh5pbwlf0/IXDOv
         9t2Pe21grmnMkVmqqkdUIw1KuelE8C8rBLLTGvYh++FajZ5ZBDcA/LEwObMz6TbVmOS5
         8Cmn4l+t8KF1cfgHQomwBUXgpUDnPlRMgr8qQztNjocoDpSnmd1vIUU+DWikIjK+7T1A
         eW/g==
X-Gm-Message-State: ACrzQf3y1xKqFqnYirngoLb/wnzf1/PpCo599/MN5Ie/cbyz3lwwyKz1
        7DegFYoEJpYB3T9AhLZKvV39st9t8wcZiA==
X-Google-Smtp-Source: AMsMyM4jYBDk/AxrfTF8DBD0xysHSkAHetqPKjGyXWVFeiJNHRIbHGOPaolCF6FAhLrKS90WyEbG/g==
X-Received: by 2002:a63:fb56:0:b0:429:983f:b91e with SMTP id w22-20020a63fb56000000b00429983fb91emr19462185pgj.399.1664189652211;
        Mon, 26 Sep 2022 03:54:12 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e0a:3b3c:baa6:3f:18b6:80cf])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001782aee4881sm11031794plk.153.2022.09.26.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:54:11 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 1/2] cat-file: add mailmap support to -s option
Date:   Mon, 26 Sep 2022 16:23:42 +0530
Message-Id: <20220926105343.233296-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.8.g9592ff2ba4
In-Reply-To: <20220926105343.233296-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20220926105343.233296-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the cat-file command with `-s` option does not complain when
`--use-mailmap` option is given, the latter option is ignored. Compute
the size of the object after replacing the idents and report it instead.

In order to make `-s` option honour the mailmap mechanism we have to
read the contents of the commit/tag object. Make use of the call to
`oid_object_info_extended()` to get the contents of the object and store
in `buf`. `buf` is later freed in the function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  4 +++-
 builtin/cat-file.c             | 13 +++++++++++++
 t/t4203-mailmap.sh             | 10 ++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..594b6f2dfd 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -45,7 +45,9 @@ OPTIONS
 
 -s::
 	Instead of the content, show the object size identified by
-	`<object>`.
+	`<object>`. If used with `--use-mailmap` option, will show the
+	size of updated object after replacing idents using the mailmap
+	mechanism.
 
 -e::
 	Exit with zero status if `<object>` exists and is a valid
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4..9942b93867 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
+
+		if (use_mailmap) {
+			oi.typep = &type;
+			oi.contentp = (void**)&buf;
+		}
+
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
+
+		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		ret = 0;
 		goto cleanup;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index cd1cab3e54..59513e7c57 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1022,4 +1022,14 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	echo "220" >expect &&
+	git cat-file --use-mailmap -s HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.0.rc1.8.g9592ff2ba4

