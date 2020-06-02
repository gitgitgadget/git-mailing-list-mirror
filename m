Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378AAC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03868206E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhvPSBcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBTF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:05:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009AC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:05:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r18so18394191ybg.10
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zVGUQ46i/sT1rue0cxm+TNO01SeW+Vv4+qBjwHI48ok=;
        b=jhvPSBcZ6knSIG5UiuAM0qguR7PUq9KnSBaJAKmBO/tPNeNVWaMu05BH70EXk+l5Oz
         WGdmbL+d+Pw5QS5efhKcr8jkftWvOjMYOkQ3oAo4HJ/e17arwIKfTD0ausbuKcJMZpRx
         iNKIQfZl1ucgqoviVXedboNlDesLLJr3SvhEzLztjIK6yQG8/7UT1leoHQSbp67jtaPr
         qRj7qPzJphy0IyU1Rw8CxMGbdfhBKpdzRob6IRsTbWSwnk29I24+d70J6jF6QGVoRz4f
         Bwxx57I4f0ROcLBpdiXPZNZDcFzgGQ3UGQVzjCDeaX3j8G64tFVBXQkzilWm9K/DSL/g
         HzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zVGUQ46i/sT1rue0cxm+TNO01SeW+Vv4+qBjwHI48ok=;
        b=TwP9BF+gwV4hRLXrB0yfcmuF6SLHXWfZJ6Iuh/HDWgqKRl4U51RXEQcq23/PRZOgv3
         cofnEcaWtDe9yFFwaZBK6SJdEg3A8GPFMWR1u3Lh9Y6XoLF4WsKkm7yRs2b7Z1PeHcc5
         bpM8f4/bZjoVg4RZWaBRSPsYdAOfOUx7M2NOao2TaU4WWykc1j3Rt6S4V/ZuoKe4nHzs
         fNRdTteKabERqtrAtuva+RByrkiKhlKWSW2a/p0wsw84aEX+7zjfhdx+FiYUkqyoSxz4
         Rqxo1zeFFRbpf5LRZrAu4l7Yh1H4696Aw+IJplQ1bIVbfKJkbkCz2ypAsyS0JIfWPRfX
         pYgg==
X-Gm-Message-State: AOAM5328oAvaiIhnrIrzr56Mbu3jo6Hv7FXs1qHjSB0uIfGuA3QlRhdk
        Fu/SyAsB7NxkuCaRl+w0asxzo9Yi7R1grUwUhiTkfp5hRaiT6OVgmFR+gn1XvRHlPteEpx/acgP
        TkB9eshyc7OjQTSW+jtdyW76GI3EtObxEjhMZzilwvrvoJxpVbD8faWPyTQuaMaUvAPpoxScXIu
        CR
X-Google-Smtp-Source: ABdhPJxFW+H4qplw+kapYWEQH6MbjipRKzZ+miIeOFPz0qmSY+Fc6vGOFwS54w7pnnLCrZcwElbgQEomFuDUnzPOmzNe
X-Received: by 2002:a25:b0f:: with SMTP id 15mr13470031ybl.258.1591124725786;
 Tue, 02 Jun 2020 12:05:25 -0700 (PDT)
Date:   Tue,  2 Jun 2020 12:05:21 -0700
In-Reply-To: <20200602041657.7132-1-chriscool@tuxfamily.org>
Message-Id: <20200602190521.32877-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] fixup! upload-pack: change multi_ack to an enum
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I think enum values should be all-caps, so here is a fixup for that. I
also fixed a spacing issue (2 spaces between "enum" and "{").

Also, maybe replace the first paragraph of the 1st patch:

  As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
  more thoroughly, let's actually start using some bitfields of
  that struct, which were previously unused.

with:

  As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
  more thoroughly, let's actually start using some bitfields of
  that struct. These bitfields were introduced in 3145ea957d
  ("upload-pack: introduce fetch server command", 2018-03-15) but were
  never used.

Other than that, this patch set looks good to me.

 upload-pack.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 30e8c54060..bc7e3ca19d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -74,10 +74,10 @@ struct upload_pack_data {
 	int keepalive;
 
 	unsigned int timeout;					/* v0 only */
-	enum  {
-		no_multi_ack = 0,
-		multi_ack = 1,
-		multi_ack_detailed = 2
+	enum {
+		NO_MULTI_ACK = 0,
+		MULTI_ACK = 1,
+		MULTI_ACK_DETAILED = 2
 	} multi_ack;						/* v0 only */
 
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
@@ -451,7 +451,7 @@ static int get_common_commits(struct upload_pack_data *data,
 		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (data->multi_ack == multi_ack_detailed
+			if (data->multi_ack == MULTI_ACK_DETAILED
 			    && got_common
 			    && !got_other
 			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
@@ -478,7 +478,7 @@ static int get_common_commits(struct upload_pack_data *data,
 				if (data->multi_ack
 				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
-					if (data->multi_ack == multi_ack_detailed) {
+					if (data->multi_ack == MULTI_ACK_DETAILED) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
@@ -488,7 +488,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			default:
 				got_common = 1;
 				oid_to_hex_r(last_hex, &oid);
-				if (data->multi_ack == multi_ack_detailed)
+				if (data->multi_ack == MULTI_ACK_DETAILED)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
@@ -968,9 +968,9 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "deepen-relative"))
 			data->deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
-			data->multi_ack = multi_ack_detailed;
+			data->multi_ack = MULTI_ACK_DETAILED;
 		else if (parse_feature_request(features, "multi_ack"))
-			data->multi_ack = multi_ack;
+			data->multi_ack = MULTI_ACK;
 		if (parse_feature_request(features, "no-done"))
 			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-- 
2.27.0.rc2.251.g90737beb825-goog

