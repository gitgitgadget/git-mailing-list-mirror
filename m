Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85359C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 01:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554C7206D7
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 01:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKglNZd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgG1BEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG1BEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 21:04:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B7C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 18:04:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i1so14170672pgn.13
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eSqKmXG3ZWXDi4UMmsGfehPG5mszYGfWt4SdSzAu/vM=;
        b=MKglNZd+rg8SkkfRrgTNgpALTIMuZJbB8TmlYopfLdh83b8WuL89XXpXZ9P869vJyX
         xaD2dJ8lIjOZ2MovjlV+oCXxUMUkvBloIslrWwbnCb0XfUx94MnmB3BpB/07Byzp3dRX
         IB6K2BV6/ljPX8+Em6RzaUBedlF756emikVwl/T5/RJjb2FQMDPL5EWLSc4vAHWuHS+a
         aiWAZYE0aZd4TSlXd24tTx+HnhxYySBaCdY0Gq7ASgXEbfJZ1smrh2zCrhuDf3mECxA4
         c+k59S0q8NdYx1tJ56q3adBQTqN2Z7nyFkHe1bhYRKGlfDSTre/hWmSy+kT95Oz7umDM
         9ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eSqKmXG3ZWXDi4UMmsGfehPG5mszYGfWt4SdSzAu/vM=;
        b=h/Uwrd8YwdK1zDv5/MEBlL+ZQr1vnDvDyvGIfU8okcAGzPUwV2WO2pjmjOTunH9o29
         w+md2vVozL7bev2xYlWYbDdkE84HKngLBAdLlHvibp8hyfOEjDUP6E+gqCQ923z0q86+
         l7/rlzKjKwls3S7bWaRgynMoyLZtNIOzXNIVlnc/HJvD/wJzYsrQoZjYlDePSqVldRlV
         arHQxMbR5F5AaNsO+HkF0iec5u7EOohQj8ycIOEulKSktn95w31QfGtp3ElwTeQMDmxh
         AW+jiz7gIvD7rFVfqFoKMp512X8EM1GWd7WRPmPzvkRxEyH+ZkQohhnxRgtkYsKKt9xD
         J2Gg==
X-Gm-Message-State: AOAM533BBk///5IE9wstlTsyZFRXpjNSeFoTTNEPW7b5NzKkdPaCV0/5
        FqmukkBwmo3BIKM4OcwPTxfRN9byC0AFNvOP6/T5j4kxgoe/gVQYTanEbv4d1DZZb2ShCHYYQl0
        UbsY2cERza3dtSvT90tz+BL4TgJevaVrQg/BT2Co0d0xnUtgngs6CZSuRWf/BpJyzhFVJvddgyv
        +i
X-Google-Smtp-Source: ABdhPJxIVimAXFH8FX8meI3hKYKVgvowk/YQeQ4WxxnDDq6wJtY0r7fyfKEugD2WQEtb4TivlkI4DCp/adamJLGG/DM2
X-Received: by 2002:a17:902:8693:: with SMTP id g19mr12662024plo.66.1595898249133;
 Mon, 27 Jul 2020 18:04:09 -0700 (PDT)
Date:   Mon, 27 Jul 2020 18:04:03 -0700
Message-Id: <20200728010403.95142-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH] apply: do not fetch when checking object existence
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been a few bugs wherein Git fetches missing objects whenever
the existence of an object is checked, even though it does not need to
perform such a fetch. To resolve these bugs, we could look at all the
places that has_object_file() (or a similar function) is used. As a
first step, introduce a new function has_object() that checks for the
existence of an object, with a default behavior of not fetching if the
object is missing and the repository is a partial clone. As we verify
each has_object_file() (or similar) usage, we can replace it with
has_object(), and we will know that we are done when we can delete
has_object_file() (and the other similar functions).

Also, the new function has_object() has more appropriate defaults:
besides not fetching, it also does not recheck packed storage.

Then, use this new function to fix a bug in apply.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I mentioned the idea for this change here:
https://lore.kernel.org/git/20200721225020.1352772-1-jonathantanmy@google.com/

I included the same have_repository check introduced in 3e8b7d3c77
("has_sha1_file: don't bother if we are not in a repository",
2017-04-13), but I couldn't verify if it is still needed. In particular,
even at that commit, all the tests pass (after I make a small change
to an irrelevant test about the order of entries in a cookie file).
---
 apply.c        |  2 +-
 object-store.h | 25 +++++++++++++++++++++++--
 sha1-file.c    | 12 ++++++++++++
 t/t4150-am.sh  | 16 ++++++++++++++++
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 8bff604dbe..402d80602a 100644
--- a/apply.c
+++ b/apply.c
@@ -3178,7 +3178,7 @@ static int apply_binary(struct apply_state *state,
 		return 0; /* deletion patch */
 	}
 
-	if (has_object_file(&oid)) {
+	if (has_object(the_repository, &oid, 0)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
diff --git a/object-store.h b/object-store.h
index f439d47af8..c4fc9dd74e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -239,12 +239,33 @@ int read_loose_object(const char *path,
 		      unsigned long *size,
 		      void **contents);
 
+/* Retry packed storage after checking packed and loose storage */
+#define HAS_OBJECT_RECHECK_PACKED 1
+
+/*
+ * Returns 1 if the object exists. This function will not lazily fetch objects
+ * in a partial clone.
+ */
+int has_object(struct repository *r, const struct object_id *oid,
+	       unsigned flags);
+
+/*
+ * These macros and functions are deprecated. If checking existence for an
+ * object that is likely to be missing and/or whose absence is relatively
+ * inconsequential (or is consequential but the caller is prepared to handle
+ * it), use has_object(), which has better defaults (no lazy fetch in a partial
+ * clone and no rechecking of packed storage). In the unlikely event that a
+ * caller needs to assert existence of an object that it fully expects to
+ * exist, and wants to trigger a lazy fetch in a partial clone, use
+ * oid_object_info_extended() with a NULL struct object_info.
+ *
+ * These functions can be removed once all callers have migrated to
+ * has_object() and/or oid_object_info_extended().
+ */
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define has_sha1_file_with_flags(sha1, flags) repo_has_sha1_file_with_flags(the_repository, sha1, flags)
 #define has_sha1_file(sha1) repo_has_sha1_file(the_repository, sha1)
 #endif
-
-/* Same as the above, except for struct object_id. */
 int repo_has_object_file(struct repository *r, const struct object_id *oid);
 int repo_has_object_file_with_flags(struct repository *r,
 				    const struct object_id *oid, int flags);
diff --git a/sha1-file.c b/sha1-file.c
index ccd34dd9e8..ff444d7abb 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1988,6 +1988,18 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	return ret;
 }
 
+int has_object(struct repository *r, const struct object_id *oid,
+	       unsigned flags)
+{
+	int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
+	unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
+		(quick ? OBJECT_INFO_QUICK : 0);
+
+	if (!startup_info->have_repository)
+		return 0;
+	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
+}
+
 int repo_has_object_file_with_flags(struct repository *r,
 				    const struct object_id *oid, int flags)
 {
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bda4586a79..94a2c76522 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1133,4 +1133,20 @@ test_expect_success 'am and .gitattibutes' '
 	)
 '
 
+test_expect_success 'apply binary blob in partial clone' '
+	printf "\\000" >binary &&
+	git add binary &&
+	git commit -m "binary blob" &&
+	git format-patch --stdout -m HEAD^ >patch &&
+
+	test_create_repo server &&
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	test_when_finished "rm -rf client" &&
+
+	# Exercise to make sure that it works
+	git -C client am ../patch
+'
+
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

