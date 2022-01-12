Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C19C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356061AbiALSIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356020AbiALSH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:07:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC2C061756
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t28so5746730wrb.4
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6MkNuKv4G1pDWUPPSlqjs1wH3HAiX3o8gHdGijEbdcg=;
        b=qQ7WAWaAZ7NOMUqxjs5ZE4CkR66y//AFn6j8yYbtbU2QT8k+GMUB3Kk4xzZtnFsib9
         /lpZw3+Msn3upIVIZs2C7YG1xbykiOujr38EXMKrul8UyP4F61dSsXv3IhXZkRWUiuoc
         R784dnBJ8WP8ZeZ/bP4GyBQ51aN9uzMrzUrs26tVbwnhbnvY7AwYhpmlfeBdV7O1G7Pw
         VfWN8nKoZJwza5IGbpNIUl9U3R6X6c6cIwXTqIhahDbFHoWLMmWjuRth8D2qZW/0SEaR
         0JngUmnleIg81spniEkS1KpwbkiWGrzs7kf+hELFJUUuznwevs+o2UEe8SNlbss3wlhK
         Cg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6MkNuKv4G1pDWUPPSlqjs1wH3HAiX3o8gHdGijEbdcg=;
        b=pIugM4N/ZFYYv43e9/MtiExAcXzf/vmkJs+vj7DhGMQSm6DGndw8/0vpQmybqiZjk2
         iLpeub+WQnuD4Fv01Zofd7AUDfVuKrFoHX2n5lzQD5Qx03MF5B1PAXd3KmtUmAveEwrp
         +QCcRfHx5MZSp+jknq2Lvwhe0RZKcskYaoo/pbRoBVfVm5R9+iKh1SVQWCBzExJFL++n
         +UFEIznz/7bZ564uawdTj/4tof3cSODaax0i40+Xn3fZfXVz3WVKpEkGzlLfKS2bs4oa
         u28w2RutG5GwRSH5Nq8JVuGmVfQQoTf9UUg8gRXetSiGdsDnMYzKZ+JEdMF5yZah48WQ
         p/WA==
X-Gm-Message-State: AOAM53320ApUD3Og9V54bSWmy6v4UcQrbsWm4cS6ptitu8ZQF2xA0Rn3
        AuKfqjKB3iQn29JZJZzwlEDV/YnMwas=
X-Google-Smtp-Source: ABdhPJz1Xp6y9CRj47YVX61igqds/5THr+mtkbrmkmOFyJ2PwmAeHZ/Sjc6wwemuvMdVIcN4gLFZgg==
X-Received: by 2002:a05:6000:1191:: with SMTP id g17mr807482wrx.512.1642010877383;
        Wed, 12 Jan 2022 10:07:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h205sm2481058wmh.19.2022.01.12.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:07:56 -0800 (PST)
Message-Id: <4eefedb0d07f762c98e8699c56a58b80df36ebe9.1642010868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Jan 2022 18:07:44 +0000
Subject: [PATCH 3/7] reftable: add a test that verifies that writing empty
 keys fails
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

Empty keys can only be written as ref records with empty names. The
log record has a logical timestamp in the key, so the key is never
empty.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 70c7aedba2c..a315c8992e8 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -602,6 +602,29 @@ static void test_write_empty_table(void)
 	strbuf_release(&buf);
 }
 
+static void test_write_empty_key(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	struct reftable_ref_record ref = {
+		.refname = "",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_DELETION,
+	};
+	int err;
+
+	reftable_writer_set_limits(w, 1, 1);
+	err = reftable_writer_add_ref(w, &ref);
+	EXPECT(err == REFTABLE_API_ERROR);
+
+	err = reftable_writer_close(w);
+	EXPECT(err == REFTABLE_EMPTY_TABLE_ERROR);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
@@ -681,6 +704,7 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_table_read_write_seek_index);
 	RUN_TEST(test_table_refs_for_no_index);
 	RUN_TEST(test_table_refs_for_obj_index);
+	RUN_TEST(test_write_empty_key);
 	RUN_TEST(test_write_empty_table);
 	RUN_TEST(test_log_overflow);
 	return 0;
-- 
gitgitgadget

