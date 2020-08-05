Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB5C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1B62086A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ljjs5fqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHEXHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgHEXG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:06:59 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD24C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 16:06:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k21so25775430pls.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sGjqnareKE+4SgyC+B0Ohl5cA/K1RLZ5TkCckU85fM8=;
        b=Ljjs5fqaO8mbi78t2X6zx5CNmGGzYYMp1Bmmd2MAuKakgyowIEjk1UCkWaW5EmpzZF
         OGM8vMWJyeseWId9mLjLRHmr/wAFhI2LbSk5SuhhCY2h1YpfRbKkSOfmfAwMjvd0hadC
         BzT+umRWvBKO5AmrVyKRB6O+Czx7AEsEeMffUDB87KZBrZQMRyAffGCO1gA5jSjewKqH
         tMeH5tl28O3BEF60tSVBxPJ5t79oFi1bTTGDJbmLteEuo0dWL8/VP3OHa66vt54rwGru
         cdU+8+AmMIhVgbUxjuFK7NVsQyWkP+G6NCGaF9ueJuI8xih3d1gwE/J2fdqIsXvOtHeY
         QOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sGjqnareKE+4SgyC+B0Ohl5cA/K1RLZ5TkCckU85fM8=;
        b=IfY3LPbZ2WDzTFHIkUwD0XAnew5UNaN7hlp4DLIMqOk+TDr4eU2EG5Wa852UXU5MEC
         8PFmlvZ4nvRVyIcBsXSK5H3Nf8DQtbp4S9UXYkh74/E4FJVE5K7a9NNj3kG7oSVuwINp
         t98mlrccLs/jTjMf7VGLVi0QNenzQ6vCafEZKoJuBHPB6+zrsID7OD/FuSGZjkQtnCuU
         op8kJT6IqpK8YCxOoptynTWpEWEl/KWbdXhl+gSP3STUexJOB8cN86OmsWPlw9cCBDuH
         1IwxiVB8BoBpfFgZL5f8FkM6Dxgsa0byhjH47BQIFI5W7UQ/n3SrYSYER11UFGeD3VcN
         lf4w==
X-Gm-Message-State: AOAM533MWLXamFUHcauQ9cglBUFpYFjeTGt7VuGKzTTq/Dz3P/Ltzj0g
        MqyF6vdROTsl8UzfDb1HD+dVZdnG+6ZkF6TmAA9dbppVfGKos3aa78c0l53D5fUCGGqjtv7Zd00
        HbY4MvpHF23TYtAalKZNw+qrQbWsV7ackmPLCf/gPT+doDH/2AFgaozWKEV/p1p1fgWH8Nujsho
        XR
X-Google-Smtp-Source: ABdhPJzld3hfcxP7tvsb+LFq0YgAxttz6XGOKy3xy7DJDfVZcd5NpGNSyUSZSC31QhBr18bqr8te04Na6eiLVcQd8V6q
X-Received: by 2002:a62:3684:: with SMTP id d126mr5499604pfa.234.1596668818740;
 Wed, 05 Aug 2020 16:06:58 -0700 (PDT)
Date:   Wed,  5 Aug 2020 16:06:49 -0700
In-Reply-To: <cover.1596668156.git.jonathantanmy@google.com>
Message-Id: <f413b34574a330030e08a6eb93ad812975959d7d.1596668156.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200728010403.95142-1-jonathantanmy@google.com> <cover.1596668156.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 1/4] sha1-file: introduce no-lazy-fetch has_object()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
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

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-store.h | 25 +++++++++++++++++++++++--
 sha1-file.c    | 12 ++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

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
-- 
2.28.0.236.gb10cc79966-goog

