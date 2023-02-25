Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF965C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 05:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBYFZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 00:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYFZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 00:25:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5A10EF
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 21:25:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u14so1588755ple.7
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 21:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPOm0VqitLwV7GAbVrtB8mbVPJWO66FsDo2U7QgXiQY=;
        b=n86W9alQ6Wtis+DXRTlHwSWxJkZLGA/GhrBPUsMW1dlsksiwc9TIRxP+4SyL02NBEc
         gc+Dao46iq2n42H/Bl/90Cdcm+yYxf/NNZUR27saY96D7fafv2A2FJMLt/GZjgLI/MmN
         jlCGpANtgxbNjvbc6QR2Lxh5wmwr9t2ML5BP7sWJgAQB1hZlH3lRI08XLgBlmKok9IA5
         yM86xOQ+LCKm8Zx/82xT+MzTrT5i8d59cxHQalUiuUikhRMbWdYLPtMsonlPsMOMAOHV
         OrAUuKMF/X1DQcJO66YWJqv3uPgJBIW/3YeFdPvJCIam+SmKcMdL8E+lOFONTLKtHGa2
         fYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPOm0VqitLwV7GAbVrtB8mbVPJWO66FsDo2U7QgXiQY=;
        b=gfbcNhSQr4it38tCq4D8ZfVkUXsKKNRWdJLkiy+5mn3sXhKYoWU5kHH2fsKaGMgUX1
         FUUFD8/qx3lHFqCyDJnaE9xK5RR0KJyPqgyM5fSEAavmhAqJZHmt4QyOHd/mdiAkLKwr
         30shzCa6qtfv6VwXbBYfSJhD4tsi7TWDg0TRlhakZRqN9GkN2fh2qpoTrTk5ofw8CkK4
         EvwofL/7pVyyE+KJT91xXzQud+EQbU08yhSci2/nSvdNehph66LiQs8nbF+avNTLzCba
         +3fnKAGMHuCks48VRcRTCjD7nMbghDWRTU40uADtHxlE4BPjrSjhwlMNYe62QhcBvD34
         0dYw==
X-Gm-Message-State: AO0yUKU8NLKkDL1X491kXqpaJW0hC0Ma8TZr75cnd6siCeDfpuCg3bqE
        AGHfG36NuDX88agxSrG5ivnat1cLhWg=
X-Google-Smtp-Source: AK7set+8a6VngKDcCEvZTQQim7iHamhepXWhdj8pGJnXMDqoYQZvtZywJXo0zkfDhzfrqTN1V500gw==
X-Received: by 2002:a17:90a:e7cc:b0:233:eba7:10c0 with SMTP id kb12-20020a17090ae7cc00b00233eba710c0mr17413075pjb.1.1677302703378;
        Fri, 24 Feb 2023 21:25:03 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.88])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a348200b00233567a978csm2338748pjb.42.2023.02.24.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 21:25:02 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, five231003@gmail.com
Subject: [PATCH] index-pack: remove fetch_if_missing=0
Date:   Sat, 25 Feb 2023 10:54:39 +0530
Message-Id: <20230225052439.27096-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A collision test is triggered in sha1_object(), whenever there is an
object file in our repo. If our repo is a partial clone, then checking
for this file existence has the behavior of lazy-fetching the object
because we have one or more promisor remotes.

This behavior is controlled by setting fetch_if_missing to 0, but this
global was added in the first place as a temporary measure to suppress
the fetching of missing objects and can be removed once the commands
have been taught to handle these cases.

Hence, use has_object() to check for the existence of an object, which
has the default behavior of not lazy-fetching in a partial clone.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 builtin/index-pack.c     | 11 +----------
 t/t5616-partial-clone.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6648f2daef..8c0f36a49e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -800,8 +800,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed =
-			has_object_file_with_flags(oid, OBJECT_INFO_QUICK);
+		collision_test_needed = has_object(the_repository, oid, 0);
 		read_unlock();
 	}
 
@@ -1728,14 +1727,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	int report_end_of_input = 0;
 	int hash_algo = 0;
 
-	/*
-	 * index-pack never needs to fetch missing objects except when
-	 * REF_DELTA bases are missing (which are explicitly handled). It only
-	 * accesses the repo to do hash collision checks and to check which
-	 * REF_DELTA bases need to be fetched.
-	 */
-	fetch_if_missing = 0;
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d..4658ce0866 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,34 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collisions' '
+	rm -rf server promisor-remote client &&
+	rm -rf object-count &&
+
+	git init server &&
+	for i in 1 2 3 4
+	do
+		echo $i >$(pwd)/server/file$i &&
+		git -C server add file$i &&
+		git -C server commit -am "Commit $i" || return 1
+	done &&
+	git -C server config --local uploadpack.allowFilter 1 &&
+	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
+	HASH=$(git -C server hash-object file3) &&
+
+	git init promisor-remote &&
+	git -C promisor-remote fetch --keep "file://$(pwd)/server" $HASH &&
+
+	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
+	git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
+	git -C client config extensions.partialClone 1 &&
+	git -C client config remote.origin.promisor 1 &&
+
+	# make sure that index-pack is run from within the repository
+	git -C client index-pack $(pwd)/client/.git/objects/pack/*.pack &&
+	test_path_is_missing $(pwd)/client/file3
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.25.1

