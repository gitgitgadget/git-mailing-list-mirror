Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137CEC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbiALSIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356045AbiALSIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:08:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AAC061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so5695285wrg.11
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wLutDQefu1ycD6mtB8C9FX3UTtjhlPxPgIFoAKuN6Dk=;
        b=l8hwrj2jXZ+FQjweKlRbJyrJHrCPJyGQTS/iYHI71UJRfCOQcmRp+nyaCMlbt0xPmh
         1SisoCvjy5L+1IrN5sAEwbl2nYqtziGK4xosh9xzoIYvM4NWrLq1PfGrb/YM/eY/86FZ
         I4jb3T3e7ZYqhWpFqFwbO2EpSWwlp+ShQePa+WVsasIEGq56dJG6wbeRXwTfLPvLZr0c
         LnoTUGWAprZrhdNvnnZZU1cRp5YBkQVoJAT0EFEcVxT0zkibNvtW/hojBEzTrmbGN2Gt
         zwBCw6e4dObGmFQMOlCJLiqSzmCV8IGt3jY/g7RhH6kyZlRkEbJIOx5jkKaapt1IXq+Z
         9GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wLutDQefu1ycD6mtB8C9FX3UTtjhlPxPgIFoAKuN6Dk=;
        b=UhJulK5No2wHTVdgPfr4OpQ0Q59M5WFXPmy6FW8LTUQ0hwINOu8IWoe/XzkacLG57M
         ViLsKM8pi1TerzjdJhjoR/xBwLQ9ikxXdvNn+jNaBB3GMVtkPu+Gcw/kL+kU9crVPulY
         P3HDBCUNVVBqRRZLYT3Tdy967dO+uswQzT6T7Bn7jWG91/tPmv/W8rsxCCjUVOgc5jxA
         HgVZWGTnOdlCqTVWQekZjDgleITaSPKHtcJSwJp3eWymd8w/dcv6DcjAs7HzRAxQe7oY
         wFJRWFXdB2fivsbXp9TxMrIhVbKOWFulkShTpvnotzrhnwO5zQW+V8a14I3FNjsOpsIw
         ZQOQ==
X-Gm-Message-State: AOAM532QNXZNCQw7IPt668qYi9aeVR/5HPl4VMKkqr6jTh3NUsUDlB2c
        rCOqjNNjYvEAw+8R9HRro75dORDJaUY=
X-Google-Smtp-Source: ABdhPJx07OEybRsHcI3uKTQa4h0iOH9kv7ZblT3YSGEwK+irUhl9t/gjSiYYi/Plx8Tkr051HJelqw==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr795534wrn.674.1642010880862;
        Wed, 12 Jan 2022 10:08:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm386533wmf.44.2022.01.12.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:08:00 -0800 (PST)
Message-Id: <3a72aba447c1405595922bc64b7f7a1a873a033a.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:46 +0000
Subject: [PATCH 5/7] reftable: ensure that obj_id_len is >= 2 on writing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

When writing the same hash many times, we might decide to use a
length-1 object ID prefix for the ObjectID => ref table, which is out
of spec.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 37 +++++++++++++++++++++++++++++++++++++
 reftable/writer.c         |  4 +++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a315c8992e8..b4371b75724 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -602,6 +602,42 @@ static void test_write_empty_table(void)
 	strbuf_release(&buf);
 }
 
+static void test_write_object_id_min_length(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 75,
+	};
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	uint8_t hash[GIT_SHA1_RAWSZ] = {42};
+	struct reftable_ref_record ref = {
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = hash,
+	};
+	int err;
+	int i;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* Write the same hash in many refs. If there is only 1 hash, the
+	 * disambiguating prefix is length 0 */
+	for (i = 0; i < 256; i++) {
+		char name[256];
+		snprintf(name, sizeof(name), "ref%05d", i);
+		ref.refname = name;
+		err = reftable_writer_add_ref(w, &ref);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	EXPECT(writer_stats(w)->object_id_len == 2);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
@@ -707,5 +743,6 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_write_empty_key);
 	RUN_TEST(test_write_empty_table);
 	RUN_TEST(test_log_overflow);
+	RUN_TEST(test_write_object_id_min_length);
 	return 0;
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index e3c042b9d84..f94af531351 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -508,7 +508,9 @@ static void object_record_free(void *void_arg, void *key)
 static int writer_dump_object_index(struct reftable_writer *w)
 {
 	struct write_record_arg closure = { .w = w };
-	struct common_prefix_arg common = { NULL };
+	struct common_prefix_arg common = {
+		.max = 1,		/* obj_id_len should be >= 2. */
+	};
 	if (w->obj_index_tree) {
 		infix_walk(w->obj_index_tree, &update_common, &common);
 	}
-- 
gitgitgadget

