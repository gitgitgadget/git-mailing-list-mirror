Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF8C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCJSWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCJSWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 13:22:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F66138697
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:21:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so10735688pjb.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678472469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh3rokNbbmbHKegSlCtSgxzTm6ma7KYBJKGBe8QpMu0=;
        b=h4H6BWb9D5rJheD3fW1MHpHZ1zjuSY6TutIVCWh+ML739Ovpfq3zMugqFteyfPU947
         o4ZV3lL7uCKCUoyFaaVoBAMv24sJle+NbJ+XAyloM21WENO99J76+V6svR39f+8JMQPk
         S1SXIYtkfeK6KocJyjJtoBVVgUMjsN+E2sa4SjxtkIoV4ukq/2XNjYcLDauEVNswpipB
         B/HuH17gVEtd/7l99Nhy6OsgoZ09m7sedsfYJHy6dKqZzXTDfJWOqLvLkARRxW1cJRVd
         KrgAMfD+0z3AnMSUUPZorTjUjlrsrg5rYG3oKMrprf/NoiAQAZQOhHR0SSR5OgeqNZaw
         PU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678472469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh3rokNbbmbHKegSlCtSgxzTm6ma7KYBJKGBe8QpMu0=;
        b=1KhinNSsnqRsI+pZeOsa5r9gYI6iGypcbSULDMGtS1m4nKwAkyDMzBuGIg6BtC5fR7
         Sk0vNqRcohvTbcVYV9EKolP5xo7uGPu2RIBJb1HUNk3g5IwFGeMpRt6H6d1Bhg4+mZyk
         HF3Frey3UBCHAJUeEWXEKrLt3AkuBc51gIlu79ejqvoXzuaWeyV/v+pYgPH1rxxTiLif
         E3i/vRG0UTu2SD4sqMcJWrs02JMO+5ckHrggawYhpO3zAu7l71V8FTGgUxpCwMFWTQX6
         R3F98gxB5L2EfNVzj6t2hxY7cgNQItMxnWXCPEj4+/XpXr5Kby1XogQmFSJR9fdEN3L/
         zb7g==
X-Gm-Message-State: AO0yUKVKUAQ1L+89i7KwJXZuHSNumZnIa65SZhTUAOGRttRGiNks/6gp
        ZI8K1w8zFGDblxnheLdHxCA2fuqO3Fs=
X-Google-Smtp-Source: AK7set+jUiEt+WsaOqrtwf0UEWar3GNvSV9qNri9tRYW8xk1afw2zv9cKy2gvkKopX23+y96VWJjLw==
X-Received: by 2002:a17:903:1cb:b0:19e:f647:6075 with SMTP id e11-20020a17090301cb00b0019ef6476075mr3466810plh.27.1678472468846;
        Fri, 10 Mar 2023 10:21:08 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.151.127])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902b59400b0019ac23cb6edsm296839pls.181.2023.03.10.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:21:08 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, five231003@gmail.com
Subject: [PATCH v2] index-pack: remove fetch_if_missing=0
Date:   Fri, 10 Mar 2023 23:50:43 +0530
Message-Id: <20230310182043.19242-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <--in-reply-to=20230225052439.27096-1-five231003@gmail.com>
References: <--in-reply-to=20230225052439.27096-1-five231003@gmail.com>
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

