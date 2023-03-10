Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F3BC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 18:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCJSay (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCJSaw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 13:30:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA7FAEF1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:30:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p6so6609267plf.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678473050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh3rokNbbmbHKegSlCtSgxzTm6ma7KYBJKGBe8QpMu0=;
        b=alzCAHTw4NOsYPHUQnwkPtfkWUFf3fdHYAaGI6r/JDWbSkns1Fq9ztcfOax+BcKohs
         wV22975Ix75AMu2E20NtwTgw+Fzw5yuAPQdjyp2G6bPoPrHpYdSlb1aVW6b+Mv4Z1WWL
         BH2HYExUaXZxtLdf0YY8A6fy+vCPMNpyzPUcUPRBEJ6TbGy/af8EQ76pIMZYkYLD0Y9N
         6J6vyBo2aE0PA6CtzZgmwe90B+s28qxxvyHHV58I904SJ+FZCwvhFJfeVJlR6jmGqr8U
         oAsxHdW1HSTFlLILko0R0TmO4RqY1oYcK+a4kErVQo6kp4AZ1JrsTOyptjzqQFJKYOFw
         kCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678473050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh3rokNbbmbHKegSlCtSgxzTm6ma7KYBJKGBe8QpMu0=;
        b=scz0qU8A/JMxgkhwLu/9uiNiDG0C8SfjyDSdbNK6D6obq/SQhBVo96caNcEjoUGnwd
         aJyl/6EgG1bstEtv+n6AgorOUSN5hrbQyzdQnxolQxY8vn6HnvvkKYqzvSRRvdKY0/YH
         LNfRG+oJLDGvmJ55TAauw9IXLTc011gmlv5D3qtmdXLrrXYrs13pw+txYZtFfbe1erZK
         qBhe4My+me8EaNjNEkin1uuoyOWh4tIynFm8Ceq1iw+ChxuxhfqQV7a3pPQznfSQMvLh
         AtFtxWt8LG8APVhJwruUhf9He0Sf773RNuY2cPZJz0OC4OhvLkGlnPOYTLIunHi3cUFt
         ER9w==
X-Gm-Message-State: AO0yUKUzktF8Moo+2cnCeU9DUnl3nJ43tb/qVRvFwOe7+xNZVeoFPc7A
        YrhkuwA3Vd59DFRG+Fov1mP/40unEWE=
X-Google-Smtp-Source: AK7set/xgVfFCOctQ9aO6v3PdxI3aPWfdGCaMnWZnCpxRkOJJljpGXiZZ5AXTIE+83QHqxwkjJZqDQ==
X-Received: by 2002:a17:90b:1c07:b0:233:d91e:e651 with SMTP id oc7-20020a17090b1c0700b00233d91ee651mr27474861pjb.23.1678473050070;
        Fri, 10 Mar 2023 10:30:50 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.151.127])
        by smtp.gmail.com with ESMTPSA id g21-20020a17090ace9500b00233aacab89esm227460pju.48.2023.03.10.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:30:49 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, five231003@gmail.com
Subject: [PATCH v2] index-pack: remove fetch_if_missing=0
Date:   Sat, 11 Mar 2023 00:00:29 +0530
Message-Id: <20230310183029.19429-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230225052439.27096-1-five231003@gmail.com>
References: <20230225052439.27096-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A collision test is triggered in sha1_object(), whenever there is an
object file in our repo. If our repo is a partial clone, then checking
for this file existence does not lazy-fetch the object (if the object
is missing and if there are one or more promisor remotes) when
fetch_if_missing is set to 0.

This global was added as a temporary measure to suppress the fetching
of missing objects and can be removed once the commandshave been taught
to handle these cases.

Hence, use has_object() to check for the existence of an object, which
has the default behavior of not lazy-fetching in a partial clone. It is
worth mentioning that this is the only place where there is potential for
lazy-fetching and all other cases are properly handled, making it safe to
remove this global here.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---

Sorry for the late reroll, I was having semester-end exams.

Changes since v1:
- Changed the commit message to be more clear about the
  change done here.

- Changed the test according to the previous review.

 builtin/index-pack.c     | 11 +----------
 t/t5616-partial-clone.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 10 deletions(-)

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
index f519d2a87a..46af8698ce 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,41 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collsions' '
+	rm -rf server promisor-remote client repo trace &&
+
+	# setup
+	git init server &&
+	for i in 1 2 3 4
+	do
+		echo $i >server/file$i &&
+		git -C server add file$i &&
+		git -C server commit -am "Commit $i" || return 1
+	done &&
+	git -C server config --local uploadpack.allowFilter 1 &&
+	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
+	HASH=$(git -C server hash-object file3) &&
+
+	git init promisor-remote &&
+	git -C promisor-remote fetch --keep "file://$(pwd)/server" &&
+
+	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
+	git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
+	git -C client config extensions.partialClone 1 &&
+	git -C client config remote.origin.promisor 1 &&
+
+	git init repo &&
+	echo "5" >repo/file5 &&
+	git -C repo config --local uploadpack.allowFilter 1 &&
+	git -C repo config --local uploadpack.allowAnySha1InWant 1 &&
+
+	# verify that no lazy-fetching is done when fetching from another repo
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+					fetch --keep "file://$(pwd)/repo" main &&
+
+	! grep "want $HASH" trace
+'
+
 test_expect_success 'lazy-fetch in submodule succeeds' '
 	# setup
 	test_config_global protocol.file.allow always &&
-- 
2.25.1

