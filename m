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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6259C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962C8610C8
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhIBFbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 01:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhIBFbj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 01:31:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D7C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 22:30:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so823247qkm.13
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqMpyzp1e8ketJJzk4P/hQYOlr6YEoAQb8i8D3U+faM=;
        b=jwg3o9kysdTHjL9ACHqJnCGS8DZ/HYdLhwbMGtncYh6OdJ5SLhXFJcGcTrXWeVy1sc
         PjnjP/LQOXYrP+RQ41u52KO9LeTxx8Qil2GVXKImMIVi+OWszt3DRgy4cBUqneCnCyns
         SMhIX0IKLHV7k3T25zq8GcW6625dSJ05MhEst4npvC9UEumg73qgW5OQw/RzmmSRknxG
         K4M6kpSWI2Jv2wbcoN+7LlpjqyUI6IiAEzE+qtzGNFo3Pr1Wg57ihcgufT3VVBFdFNRj
         oMH5hOT6ebkygcjRjX65lFjD1KTrYYkdd/Nhb4d0EpdlTj52cw8q0brcL1Akx6fdl2PR
         YQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqMpyzp1e8ketJJzk4P/hQYOlr6YEoAQb8i8D3U+faM=;
        b=HHd6z2GQ1PhSSmQES8GJs488dDR1UtOMB1PEpmZdvfeVngKgAPNznneV84riAOS5iq
         Qo7wI+o4cYOCIjrSP1imEB0iQPQv0NcXPOpkACMLEqBBIxwWYNKBzAjC/4LIhiclkSmR
         6/P7hYj7n5oIhpv8cODykp0WDhLr28cGM7/X773ecyT8lS+1eYvX45mTWTOk4Pc+g9Pe
         1bEy1EgakUGkfNdQDbHkmbVopLwLTjxBJKUpPIeOV3ou5CMAIfTnU0Wn2fktv7QEEYzD
         ogK7GQOFkoc4R3u2nv4hXG2QMmb9LIw1NEwiIzNuZ1EUcolsVviPh0ShtmdZITGaNd/J
         niCA==
X-Gm-Message-State: AOAM5311vyritEDkPXjaRz5WTO6go26yGGVtvN6eMaaSn63mUZbrzgSg
        IBeND4iJx4BD747QDHl9CJNBBznuiWg=
X-Google-Smtp-Source: ABdhPJx74cyQs5hg/+Cca9RFKZMyRyVpbQMYGvoZ7lxKg4WwNds79vRuvj2rqcCy+TRH7Zn7c1F+qA==
X-Received: by 2002:a05:620a:a93:: with SMTP id v19mr1573140qkg.185.1630560640885;
        Wed, 01 Sep 2021 22:30:40 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w19sm669346qki.21.2021.09.01.22.30.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 22:30:40 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] fixup! reftable: add merged table view
Date:   Wed,  1 Sep 2021 22:30:22 -0700
Message-Id: <20210902053023.44006-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210902053023.44006-1-carenas@gmail.com>
References: <20210902053023.44006-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Just like in the next patch, having relevant code in the assert might be
a problem, but this is mostly test code and still passes.

 reftable/merged_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index f58e44003e..b7be4dcf9f 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -47,8 +47,8 @@ static void write_test_table(struct strbuf *buf,
 	reftable_writer_set_limits(w, min, max);
 
 	for (i = 0; i < n; i++) {
-		uint64_t before = refs[i].update_index;
-		int n = reftable_writer_add_ref(w, &refs[i]);
+		MAYBE_UNUSED uint64_t before = refs[i].update_index;
+		MAYBE_UNUSED int n = reftable_writer_add_ref(w, &refs[i]);
 		assert(n == 0);
 		assert(before == refs[i].update_index);
 	}
@@ -181,7 +181,7 @@ static void test_merged(const char *fn_name)
 		},
 	};
 
-	struct reftable_ref_record want[] = {
+	MAYBE_UNUSED struct reftable_ref_record want[] = {
 		r2[0],
 		r1[1],
 		r3[0],
@@ -251,7 +251,7 @@ static void test_default_write_opts(const char *fn_name)
 	int err;
 	struct reftable_block_source source = { NULL };
 	struct reftable_table *tab = reftable_calloc(sizeof(*tab) * 1);
-	uint32_t hash_id;
+	MAYBE_UNUSED uint32_t hash_id;
 	struct reftable_reader *rd = NULL;
 	struct reftable_merged_table *merged = NULL;
 
-- 
2.33.0.481.g26d3bed244

