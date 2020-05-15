Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A5C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5F020709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnWNmSK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEOKFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgEOKFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F118CC05BD09
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w64so1985643wmg.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twgQ2UZz4sfi3eKXcgAhoOu+YLzubvDfZSxV8cgeS8g=;
        b=WnWNmSK5gk6p7Ol449g3CirpOHcOP1RlLCAnP2+M3cvbwlfudqpNh92LqtC2Ah3NB2
         igey+azjmB+QqWvZeJieOHhGDc+82LY1SgHJthzldRmIL5Vpc0O8k5BYpxBKuBPx3LUF
         2uv9fqvUZ0YGWk/66c5d+HYj8C4us8UbuEAjaSIBD0tPtjdVLAovRq37scRhaTTBcFvQ
         Rmd1TOU2v0A4F5LbQ+KDtRQEUZHxVQGFYP9YlmaieGZ7BMuviWLz1MP8Bx23EXrMowyw
         McTMheyXiBW0J6ebD6zyfpk/PzeiPOq/HHHrSI7/bnT+g2ayiZSDEid3hC9Q7hJpIRNv
         NYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twgQ2UZz4sfi3eKXcgAhoOu+YLzubvDfZSxV8cgeS8g=;
        b=Gq8vH+1bCQIvJylCp6fJdPo23oG6/aFhyKxgPs0VeFM+N6RJUHLFJ5X84XPKFBGrKM
         VniL0aehWyBQg9s8rXWrHccp0o2iylGQrFoKt2mCWdamQ8YpxIcNILg9N8bL3CltJcc1
         32KQwKejwbs9mixdd9fo8IJ1UQGkey/09eI7B6Lp58MXOltbnKhhwz1HqvAwhKdvo31P
         jaSPohCbIYOgLMhQVnFFBXg0MT5VEpJvDqwa8uVCumHhGe8quzY6y5aubfTBtQvfSZob
         CvdtqELQ9+ktWsjIg28ODV0FmQUwr2GyJmsJEIo2XvQCQcjnNiVxreAhZZHtke2LIfHT
         AroA==
X-Gm-Message-State: AOAM532WHWNtYPTPMwLo/o6Iv7essdMupJXWYpTHqygV8ZL/ebKwSS/l
        JXtXl+ZHZ0b1nJyVJzSa8lVA5QGVS48=
X-Google-Smtp-Source: ABdhPJyJa27N3jjNyCFw1fPknZN5OS2VlTQOIUyI0TKVJLZe5qRB+P9NpgJmD7jyJIorJzu+6AeFFQ==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr3201519wme.50.1589537120357;
        Fri, 15 May 2020 03:05:20 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:19 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/13] upload-pack: pass upload_pack_data to send_ref()
Date:   Fri, 15 May 2020 12:04:50 +0200
Message-Id: <20200515100454.14486-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to send_ref(), so that
this function, and the functions it calls, can use all the
fields of the struct in followup commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index c7e35a7fc9..bc259f1713 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1059,6 +1059,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		" deepen-relative no-progress include-tag multi_ack_detailed";
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
+	struct upload_pack_data *data = cb_data;
 
 	if (mark_our_ref(refname_nons, refname, oid))
 		return 0;
@@ -1066,7 +1067,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
 
-		format_symref_info(&symref_info, cb_data);
+		format_symref_info(&symref_info, &data->symref);
 		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
@@ -1161,8 +1162,8 @@ void upload_pack(struct upload_pack_options *options)
 
 	if (options->advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref_namespaced(send_ref, &data.symref);
-		for_each_namespaced_ref(send_ref, &data.symref);
+		head_ref_namespaced(send_ref, &data);
+		for_each_namespaced_ref(send_ref, &data);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-- 
2.26.2.638.gb2c16ea67b.dirty

