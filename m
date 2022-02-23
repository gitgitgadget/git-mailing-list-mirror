Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DEC4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbiBWRzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbiBWRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BCA190
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so14518723wrg.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1GVaBXimqBTY5hmpJCclNff/xDZkhFYtw17lQu0BLKo=;
        b=DVYAuW6Zz8Rl6oHlquxD4ZWRVupEF53LplHhncDumh+BRCU0OrKOy2nW50RGvWRLjj
         +G8Flc+6yzvEZypqGhgCWsqOkNcW9+a458N8s+PNO1fP4dg1cVkGkxXKoXJ6MDlhGJIT
         Yn1ZV0FgtK8ZwM/DBKlfnGzNEnW/oR6dHRs/NK9W5pYo7jqhFW4vmJF8m5wHcMzLDkkA
         xeh0vz1ApWe/JSfNav0fhOnotS6J7FjOXGQ9gv7jFAWi2/yJVCfZSs77lop7HIAFcsDi
         zyiwqkhF7AFoVahmO02hdo9Vl3Vw+ACd23DQfInCipdvAoAeQPXrFUoh6ENwivUe8DeZ
         CVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1GVaBXimqBTY5hmpJCclNff/xDZkhFYtw17lQu0BLKo=;
        b=FnsIhCSlhJFnymvgJ8X7KZSl7AmiFrxxzdd0IunF9PU+VSyVFfi5XXqO5AJw+vTZY/
         MFmY6jHtadPFmv1S6enup8k8LU0SrcohnxEj+feWf4ndC6C1kBSmckgS60pxgbdqi6Qa
         HLnGSzK5aKKK16FednhW+aSe3J+ksBOEDQqhJkSd/VUQx1iwaaO6dqQHdkjBWZFQ/Xf2
         /fcofdcD+wkz+Wx/xLNVpf0B370YAxZqXQ85tHBQzs9f04tfQNM80W0AI3RGoNBSjF3/
         MTXy1fKfmLcn/Zspsejvnm4dqw4htRMWXYvt8ZQk6Ou25cdUrsxZRsAYO+sDP0ZFVTxZ
         hMIg==
X-Gm-Message-State: AOAM531a8QjIrVKH0gLvXT2V+nnS66REGuZ8F4jhfB6aW9Vbx/0QHJW8
        voidayeRIktCdeLfgklLPSlHXDI9D7s=
X-Google-Smtp-Source: ABdhPJxX363JoeRB21RxU+p1qvZl5PVGbapt/tZ7k1BHp0PCDRwJj/lAnOsqhCxG6f4FCjY3AaPV2g==
X-Received: by 2002:a5d:4ecd:0:b0:1ea:910b:7641 with SMTP id s13-20020a5d4ecd000000b001ea910b7641mr561885wrv.103.1645638919741;
        Wed, 23 Feb 2022 09:55:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j27sm221559wrd.32.2022.02.23.09.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:19 -0800 (PST)
Message-Id: <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:07 +0000
Subject: [PATCH 07/11] bundle: safely handle --objects option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Since 'git bundle' uses setup_revisions() to specify the object walk,
some options do not make sense to include during the pack-objects child
process. Further, these options are used for a call to
traverse_commit_list() which would then require a callback which is
currently NULL.

By populating the callback we prevent a segfault in the case of adding
the --objects flag. This is really a redundant statement because the
bundles are constructing a pack-file containing all objects in the
discovered commit range.

Adding --objects to a 'git bundle' command might cause a slower command,
but at least it will not have a hard failure when the user supplies this
option. We can also disable walking trees and blobs in advance of this
walk.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 10 +++++++++-
 t/t6020-bundle-misc.sh | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..dc56db9a50a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -451,6 +451,12 @@ struct bundle_prerequisites_info {
 	int fd;
 };
 
+
+static void ignore_object(struct object *obj, const char *v, void *data)
+{
+	/* Do nothing. */
+}
+
 static void write_bundle_prerequisites(struct commit *commit, void *data)
 {
 	struct bundle_prerequisites_info *bpi = data;
@@ -544,7 +550,9 @@ int create_bundle(struct repository *r, const char *path,
 		die("revision walk setup failed");
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
-	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
+
+	revs.blob_objects = revs.tree_objects = 0;
+	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
 
 	/* write bundle refs */
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index b13e8a52a93..6522401617d 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unfiltered bundle with --objects' '
+	git bundle create all-objects.bdl \
+		--all --objects &&
+	git bundle create all.bdl \
+		--all &&
+
+	# Compare the headers of these files.
+	head -11 all.bdl >expect &&
+	head -11 all-objects.bdl >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

