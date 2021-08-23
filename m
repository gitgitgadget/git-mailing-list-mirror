Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DC3C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE1C61391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhHWMOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhHWMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54BC061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so766695wms.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIK+TCdRX34KNMiBA3GyxA9wV+XjF+28nZnkSCYejt0=;
        b=I1J0mPlOGzo4qtEgXFeBoUi7zZM8GRYY3dl5R84XxexQQ9X2/VrGw9vT1nXa/GS8JB
         RSNK74tWkrvGFVF8JG7Whb4CD6rKnmQ86BHkOdkZS+s9azSYoN33uqf3V+W73nI/yFR/
         ichcICkt8d571rKPfgFvMKccDSaWIqXQVMOio4lfmVBu+JPe5bYYfItmgQwwH14Q+Dh+
         qg7q2R0T/UHyt0KsEysKhlKIVH82woOkxleAIxzZW7fnc0o2aZTE79POXaF0PlFtxFbl
         2WjiiYl0tVFbBgeJafmVL3TdwGdOYTuSTlv6i2aXlZ2MVgH6i5W2TUrY1hukjC7gxStv
         SJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIK+TCdRX34KNMiBA3GyxA9wV+XjF+28nZnkSCYejt0=;
        b=ZJsiwEgg2cy5kXRuSjTW6dADSpbNcRVr7MeKgkCa8zfbEDce8PhmouQMxsHqLwneOg
         hCgsjPeMILdx4T7gDa94qcDfnwMVYZ+RW3C5jyC9RU3YwwKhk/rarHeYQTVdTv0OWl4E
         k88/g6Oh+dm+xoHcWcaoMDHe9XjaGcfTgQgktOZ2uzlJYfSTnSxJNqbVeF1w3dVi2jeP
         ejODkX7m7YcOxw+IG7sQIMWF4VDJUHX92Vpf1S5JQEN8NBifknf/ayHqtfaahz4u+VPu
         G09I9UQY8vYWgkWachwZTqcEOXcCBXIDfFBATbqeUw9nNHwBdPe7zQnHAbI3lszLki4n
         3c4Q==
X-Gm-Message-State: AOAM532qd6W7g5dZ7B0Tb6trWPN55ZAWu8Xw4CbIeNnkBlBFnnnwffHd
        CiRLdUG7qzOOdnRde6XSfm8GUr+2KCQBC6RF
X-Google-Smtp-Source: ABdhPJwYm6E6u3gcmL9HmAqrOtaQBzpc829dnOWK2LViM02w+SvTdgGkhlE/qSBGnXJwAF2CFCALEA==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr13250250wmd.187.1629720797681;
        Mon, 23 Aug 2021 05:13:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 26/28] reftable: fixup for new base topic 1/3
Date:   Mon, 23 Aug 2021 14:12:37 +0200
Message-Id: <patch-v4-26.28-dde80a982c1-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lifted from Han-Wen's [1], with the addition of the removal of the
reftable_error_to_errno() which is now unused. I also changed the:

    if err < 0
    if err > 1

to just:

    if err < 0
    else if err

Which is clearer in this context, i.e. the reader doesn't need to
squint to see that the two if's are related, but different only in "<"
v.s. ">".

1. https://lore.kernel.org/git/pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com/

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/reftable-backend.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d972910bf21..dcc792e5e87 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -108,7 +108,7 @@ static const char *bare_ref_name(const char *ref)
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 				     const char *refname, struct object_id *oid,
 				     struct strbuf *referent,
-				     unsigned int *type);
+				     unsigned int *type, int *failure_errno);
 
 static void clear_reftable_log_record(struct reftable_log_record *log)
 {
@@ -424,6 +424,7 @@ static int fixup_symrefs(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT;
 	int i = 0;
 	int err = 0;
+	int failure_errno;
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -433,8 +434,8 @@ static int fixup_symrefs(struct ref_store *ref_store,
 						&old_oid, &referent,
 						/* mutate input, like
 						   files-backend.c */
-						&update->type);
-		if (err < 0 && errno == ENOENT &&
+						&update->type, &failure_errno);
+		if (err < 0 && failure_errno == ENOENT &&
 		    is_null_oid(&update->old_oid)) {
 			err = 0;
 		}
@@ -1587,30 +1588,10 @@ git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return err;
 }
 
-static int reftable_error_to_errno(int err)
-{
-	switch (err) {
-	case REFTABLE_IO_ERROR:
-		return EIO;
-	case REFTABLE_FORMAT_ERROR:
-		return EFAULT;
-	case REFTABLE_NOT_EXIST_ERROR:
-		return ENOENT;
-	case REFTABLE_LOCK_ERROR:
-		return EBUSY;
-	case REFTABLE_API_ERROR:
-		return EINVAL;
-	case REFTABLE_ZLIB_ERROR:
-		return EDOM;
-	default:
-		return ERANGE;
-	}
-}
-
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 				     const char *refname, struct object_id *oid,
 				     struct strbuf *referent,
-				     unsigned int *type)
+				     unsigned int *type, int *failure_errno)
 {
 	struct git_reftable_ref_store *refs =
 		(struct git_reftable_ref_store *)ref_store;
@@ -1633,13 +1614,10 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 	}
 
 	err = reftable_stack_read_ref(stack, refname, &ref);
-	if (err > 0) {
-		errno = ENOENT;
-		err = -1;
-		goto done;
-	}
 	if (err < 0) {
-		errno = reftable_error_to_errno(err);
+		goto done;
+	} else if (err) {
+		*failure_errno = ENOENT;
 		err = -1;
 		goto done;
 	}
-- 
2.33.0.662.gbaddc25a55e

