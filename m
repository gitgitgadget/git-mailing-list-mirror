Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD3C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCQR5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCQR5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 13:57:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057324615D
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 10:57:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v21so6118027ple.9
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679075823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpRsuBQWcu76gTjViPBztaw2fhckRhM6n9O3e2nDcC0=;
        b=V1FfZ7jnQQFhU62VYcISwo9lzPBxlkstXu0s3MsHhPi/Mip4K9XojZiglRS/KcwgMS
         9YuUnNHR4dqzaUUAucKiDT4acMAeUH0Z13SkHrqmgBk/k5SIzF9uMWwWXSsTamu3JEI8
         2WVxoqz3De/91Qg2eb2WmKmDlQF4DQfAZdtbGl0sCaVuQJCSJr9W9n8XZOw3PRSLG4Ev
         2/qRSlbeIZricD20geWrQHGGjlC7gzmXSC1WhFr+lUFGWrlkzbDj3Muq7HBUyRcqePPi
         wNRmo6dEeKVQTA0PfiIgqhJALoWa9jTKNSIk6AdlAI4FTYXRkVPNYi0837dTc3CAm15P
         kA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpRsuBQWcu76gTjViPBztaw2fhckRhM6n9O3e2nDcC0=;
        b=NyXW9Pg76CLMS0Kc53UT/RM0lfm7uSt06v26bam7CopRQKHbIt970QW8lMSzxa/4ig
         C2J3LE5AFOdH1ATJjNS+NiNew4j0YZ2O++CFw5HlFBKx0Mpmel4aR7+l4yfi4edDB5bF
         mhPIhEa4aEv0+fDhjjnb9zQj0M108qmGRxIJT/NV7dQFBAoD6f8Uv4ytxy6p3WlGYkEl
         P1zRTxQ00fRJRKx6P0hh/S7sHiKjd1o1Y0Y7sjQvFUk4JIgx9Jnhmlimyc06H6BE8zky
         sNc3Q02FT4JPgxSHQfQGslGPwH1J/3sDxLtre2Biau+/7dPAzVO2CMGn9m44XnwlgB0X
         3g0g==
X-Gm-Message-State: AO0yUKWCmdcqk0G/aXo+y7VFTgkkWLcs9kfTYW6m8vBqPdldwRDKcinK
        0IW80kpkmejwU112RsVJFc2BOF8yaBk=
X-Google-Smtp-Source: AK7set8RXOaehSvHc9V9jMDLNqgKzj+/H2XHG45U2U9DRM7WPTjpj5AkP4WLRVdtm60FT+KQQKsyRw==
X-Received: by 2002:a05:6a20:431b:b0:d4:3031:de7e with SMTP id h27-20020a056a20431b00b000d43031de7emr9783929pzk.31.1679075823083;
        Fri, 17 Mar 2023 10:57:03 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.151.78])
        by smtp.gmail.com with ESMTPSA id h12-20020aa786cc000000b005a8a5be96b2sm1846241pfo.104.2023.03.17.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:57:02 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kousik Sanagavarapu <five231003@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4] index-pack: remove fetch_if_missing=0
Date:   Fri, 17 Mar 2023 23:26:01 +0530
Message-Id: <20230317175601.4250-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230313181518.6322-1-five231003@gmail.com>
References: <20230313181518.6322-1-five231003@gmail.com>
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

Though this global lets us control lazy-fetching in regions of code,
it prevents multi-threading [1].

Hence, use has_object() to check for the existence of an object, which
has the default behavior of not lazy-fetching in a partial clone, even
when fetch_if_missing is set to 1. It is worth mentioning that this is
the only place where there is potential for lazy-fetching and all other
cases [2] are properly handled, making it safe to remove this global
here.

[1] See https://lore.kernel.org/git/xmqqv9sdeeif.fsf@gitster-ct.c.googlers.com/
    and the discussion that follows from it.

[2] These cases are:
    - When we check objects, but we return with 0 early if the object
      doesn't exist.
    - We prefetch delta bases in a partial clone, if we don't have them
      (as the comment outlines).
    - There are some cases where we fsck objects, but lazy-fetching is
      already handled in fsck.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---

Changes since v3:
- Changed the commit message to give a stronger reason as to
  why we should reduce the use of this global and in this
  process remove it from builtin/index-pack.c

- Also made an addition to the test which I overlooked last time
  and without which the does not make sense

 builtin/index-pack.c     | 11 +----------
 t/t5616-partial-clone.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 10 deletions(-)

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
index f519d2a87a..41fa7130f1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,39 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_success 'index-pack does not lazy-fetch
+		     when checking for sha1 collsions' '
+	rm -rf server client another-remote &&
+
+	git init server &&
+	echo "line" >server/file &&
+	git -C server add file &&
+	git -C server commit -am "file" &&
+	git -C server config --local uploadpack.allowFilter 1 &&
+	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
+
+	git clone --no-checkout --filter=blob:none \
+				"file://$(pwd)/server" client &&
+	git -C client config extensions.partialClone 1 &&
+	git -C client config remote.origin.promisor 1 &&
+
+	git clone "file://$(pwd)/server" another-remote &&
+
+	echo "new line" >server/new-file &&
+	git -C server add new-file &&
+	git -C server commit -am "new-file" &&
+	HASH=$(git -C server hash-object new-file) &&
+
+	git -C another-remote pull &&
+
+	# Try to fetch so that "client" will have to do a collision-check.
+	# This should, however, not fetch "new-file" because "client" is a
+	# partial clone.
+	GIT_TRACE_PACKET=git -C client fetch \
+				"file://$(pwd)/another-remote" main &&
+	! grep "want $HASH" trace
+'
+
 test_expect_success 'lazy-fetch in submodule succeeds' '
 	# setup
 	test_config_global protocol.file.allow always &&
-- 
2.25.1

