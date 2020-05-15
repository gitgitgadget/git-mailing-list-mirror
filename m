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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B8C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953120709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0iSZVDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEOKFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgEOKF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4550C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so2000080wmc.2
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfUC+WdGxe2JbHaPxGDUlL77vYVbSqjVQzMoGehgWOg=;
        b=A0iSZVDmUIshforVvKKKtI1bvv3MiPut72aTR8/SYegoWr3fI1XgZGIQ4lpI5XwY9o
         AIeDJWfUpx6vzlReH5yJ7FZhQpyCzgAPlb+DaCTIfEA9IcAFePoRxIAkH/kidE7i2VYb
         bith3jRpOwUcFOOJk9uRY/60jghPjp17J5ttajn2hkH+ZjtvbuzzL9kC9yBV+SNXyh6l
         rwFdxfoknavrnqR+rI6jDlVtinYNG1B92QJBz2+HTYlXDLlCv30O3helWsTAVRfMPh8I
         uUBiRlmGIUsNo1fT9olC/zL43Y/zcnjjJzYumtlzu2IEy+HycFOblGQoKvvUArjllc6b
         S7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfUC+WdGxe2JbHaPxGDUlL77vYVbSqjVQzMoGehgWOg=;
        b=G//YQSDAJLJqT4q7iQ044pvFtpjWfjgs40prgRZHL1Pi+g/StqL2tikmNPg8EonxiH
         EAVyAhsps+LlxpZhn4bjq/qbxjDuFzhgw5haJcHsUeB2tDVQSJ5VIi87z+LonkGedinH
         CVacvYM0zsH11gQRjc4jVAZHWIIQwE8g7VcX9Y75XQ/fIW5IAu9lAG4q6cnZlvqmwqUE
         vJ+6jXlenRjReWBipJiMA7jiUexHYwtyPNduUuY9Uk5pMJTLNECkm5qaiwTkTkvPjcc0
         h6aBN0MvUnTJar/+R6R8bOGleo7jDJ25kuDVZpSReEivytQ5RIeWpQ6FmvEcDOjOhgLC
         pH0Q==
X-Gm-Message-State: AOAM530wMUcFWEZFQQ4R+CAioQ4DXLLYCdWD9QJGt60ZnNaJO5MV1wRU
        FHHovlfq5j9a/4F5gtIQitKwfIhy4+k=
X-Google-Smtp-Source: ABdhPJw6cCxmRm2/6MoxaAQ5ju27aYtHNu1mz1MU2ZEet1nMqyBwvvShaYTtqCv6aM/7qtvaz86DOw==
X-Received: by 2002:a1c:dc05:: with SMTP id t5mr3352590wmg.112.1589537125270;
        Fri, 15 May 2020 03:05:25 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/13] upload-pack: use upload_pack_data fields in receive_needs()
Date:   Fri, 15 May 2020 12:04:54 +0200
Message-Id: <20200515100454.14486-14-chriscool@tuxfamily.org>
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
more thoroughly, let's use fields from this struct in
receive_needs(), instead of local variables with the same name
and purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 93cf4b1fe5..401c9e6c4b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -911,13 +911,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 static void receive_needs(struct upload_pack_data *data,
 			  struct packet_reader *reader)
 {
-	struct object_array shallows = OBJECT_ARRAY_INIT;
-	struct string_list deepen_not = STRING_LIST_INIT_DUP;
-	int depth = 0;
 	int has_non_tip = 0;
-	timestamp_t deepen_since = 0;
-	int deepen_rev_list = 0;
-	int deepen_relative = 0;
 
 	shallow_nr = 0;
 	for (;;) {
@@ -930,13 +924,13 @@ static void receive_needs(struct upload_pack_data *data,
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
-		if (process_shallow(reader->line, &shallows))
+		if (process_shallow(reader->line, &data->shallows))
 			continue;
-		if (process_deepen(reader->line, &depth))
+		if (process_deepen(reader->line, &data->depth))
 			continue;
-		if (process_deepen_since(reader->line, &deepen_since, &deepen_rev_list))
+		if (process_deepen_since(reader->line, &data->deepen_since, &data->deepen_rev_list))
 			continue;
-		if (process_deepen_not(reader->line, &deepen_not, &deepen_rev_list))
+		if (process_deepen_not(reader->line, &data->deepen_not, &data->deepen_rev_list))
 			continue;
 
 		if (skip_prefix(reader->line, "filter ", &arg)) {
@@ -953,7 +947,7 @@ static void receive_needs(struct upload_pack_data *data,
 			    "expected to get object ID, not '%s'", reader->line);
 
 		if (parse_feature_request(features, "deepen-relative"))
-			deepen_relative = 1;
+			data->deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack = 2;
 		else if (parse_feature_request(features, "multi_ack"))
@@ -1005,14 +999,18 @@ static void receive_needs(struct upload_pack_data *data,
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
 
-	if (depth == 0 && !deepen_rev_list && shallows.nr == 0)
+	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
 		return;
 
-	if (send_shallow_list(&data->writer, depth, deepen_rev_list, deepen_since,
-			      &deepen_not, deepen_relative, &shallows,
+	if (send_shallow_list(&data->writer,
+			      data->depth,
+			      data->deepen_rev_list,
+			      data->deepen_since,
+			      &data->deepen_not,
+			      data->deepen_relative,
+			      &data->shallows,
 			      &data->want_obj))
 		packet_flush(1);
-	object_array_clear(&shallows);
 }
 
 /* return non-zero if the ref is hidden, otherwise 0 */
-- 
2.26.2.638.gb2c16ea67b.dirty

