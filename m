Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ACBC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEBA61165
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhDSLie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhDSLic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63175C061763
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s7so33564705wru.6
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nAaI2/ecfrc2qcCxs34ZVZoSSLJHefKDvevbMrYH71E=;
        b=EfgSb7MnNpdZGtH7pp5T/jMICJjwnpAYY+dOfh12nhR8+rw9prVzWiFAponzyewdcT
         0qvADod86jyYv8dq69i7uT9JjxyuF7XzvmvdySIj9LMESaxGnhdZwpd2H6vMqrFUj7IB
         MkJVaiQj+RLnrUyhO/fhVg1vn555EwWFKzMUL7SXTAAcAnNJWboDRtx/SMrcCP3W8wK4
         i+K6lejFMnRWspXL/GhgwUBWdW5MhsTVmIjfO38+1nByCjg7Utg6T6k4djv2RjaHo7Nc
         aWrtoGby/+l9bqbm7SYzKAcBeO/tV1PX+ITSIk/wJw09A0gwe48BgawCQsI7QPTOfj9d
         Ul0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nAaI2/ecfrc2qcCxs34ZVZoSSLJHefKDvevbMrYH71E=;
        b=Ya8JbzzoMbwX4EQ09iOgvLnjDU/8qkrwuicMHL8VAKm2sjlt237RKGpZ1B07yc6KWP
         kEhPsbU4nAbgI/1Lsv0XFVmwzkZIsyPiXFNGVKUZBCtneQOKEABQnd6ZMjJOIRn8pWms
         4fxEFySAwnnZfL4+RIJG++TQ2B1koMsNGgZu+XAZslIj9hoTjiVuRrqmREwQZXI+PghF
         SrkadZjz5GkXzVDwtWkhNl2f4i4AE82z7MXE0tTUL/GWln3YZpEX4K0D5g9DmrESs/0P
         BUnpG9ue6cA573DO2AwUnJWvhPJa5CNvdW0KAHHa2AmI+b0aifA/gZivq+tOs/TpVjf9
         GlZw==
X-Gm-Message-State: AOAM531JxZIvmxAxc4hI0yBAqtuSb9jozk3l0gh9WWNVdcoOdxlQHlBO
        ZVWqVpQMKypzbBr59ZsLsrqTKn/JOww=
X-Google-Smtp-Source: ABdhPJx9t5U6hAHBq/zRp7wlNXL65v9Tv95y53P0UAN7qx6wK8SnncDJwB/YBih9SOQdNBXzckTlOg==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr13991457wrr.174.1618832281130;
        Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm19987408wmc.24.2021.04.19.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:00 -0700 (PDT)
Message-Id: <9ae5ddff6aed48184d2a10c569e41441b9199f10.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:31 +0000
Subject: [PATCH v7 03/28] refs/debug: trace into reflog expiry too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6ad9..3b25e3aeb1ba 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -353,6 +353,40 @@ static int debug_delete_reflog(struct ref_store *ref_store, const char *refname)
 	return res;
 }
 
+struct debug_reflog_expiry_should_prune {
+	reflog_expiry_prepare_fn *prepare;
+	reflog_expiry_should_prune_fn *should_prune;
+	reflog_expiry_cleanup_fn *cleanup;
+	void *cb_data;
+};
+
+static void debug_reflog_expiry_prepare(const char *refname,
+				    const struct object_id *oid,
+				    void *cb_data)
+{
+	struct debug_reflog_expiry_should_prune *prune = cb_data;
+	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s\n", refname);
+	prune->prepare(refname, oid, prune->cb_data);
+}
+
+static int debug_reflog_expiry_should_prune_fn(struct object_id *ooid,
+					       struct object_id *noid,
+					       const char *email,
+					       timestamp_t timestamp, int tz,
+					       const char *message, void *cb_data) {
+	struct debug_reflog_expiry_should_prune *prune = cb_data;
+
+	int result = prune->should_prune(ooid, noid, email, timestamp, tz, message, prune->cb_data);
+	trace_printf_key(&trace_refs, "reflog_expire_should_prune: %s %ld: %d\n", message, (long int) timestamp, result);
+	return result;
+}
+
+static void debug_reflog_expiry_cleanup(void *cb_data)
+{
+	struct debug_reflog_expiry_should_prune *prune = cb_data;
+	prune->cleanup(prune->cb_data);
+}
+
 static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 			       const struct object_id *oid, unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
@@ -361,10 +395,17 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 			       void *policy_cb_data)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct debug_reflog_expiry_should_prune prune = {
+		.prepare = prepare_fn,
+		.cleanup = cleanup_fn,
+		.should_prune = should_prune_fn,
+		.cb_data = policy_cb_data,
+	};
 	int res = drefs->refs->be->reflog_expire(drefs->refs, refname, oid,
-						 flags, prepare_fn,
-						 should_prune_fn, cleanup_fn,
-						 policy_cb_data);
+						 flags, &debug_reflog_expiry_prepare,
+						 &debug_reflog_expiry_should_prune_fn,
+						 &debug_reflog_expiry_cleanup,
+						 &prune);
 	trace_printf_key(&trace_refs, "reflog_expire: %s: %d\n", refname, res);
 	return res;
 }
-- 
gitgitgadget

