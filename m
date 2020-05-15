Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE263C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A9320709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVgQs6rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgEOKFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgEOKFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFCC05BD0A
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so1701936wmb.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmRY5N7KfrpjN5YWGcwt+7y/AoCt5pYfFpCIUp6pr9s=;
        b=fVgQs6rvaYWeVwfMkb3pvKLfuTQNnclwUedGYcLmjbookCb9AEqwmAKWLxjm52J9Qt
         KpVdl9wTeNoxqJxqRFp7rlnrDHs3adoZjaYEx5Qn4So1MiiYj8DaCI8P1C9gkyjWqi6P
         jYY616RqLyMopsVaDNSYuMUY01FREw6Jy9B3gbB6j+m4gcHpdmeAO6vS5XhMgvuiN4jS
         b+pkDBymTCptOI0ZKhdmBWfND4Iib4SCbwudfUJRuUudmDwor7S7xzZ3qNV88WgFpqaY
         J0cXprHF2yVWV045nHxdn4Rdb7PMt0iBrja7Bc/UO0q5s2ftjcDv18/Zufo8vE6TCSov
         reYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmRY5N7KfrpjN5YWGcwt+7y/AoCt5pYfFpCIUp6pr9s=;
        b=G3H6yvDOxLlsf3wHYEJceReETzbzJm/Gv/dD/74nv+n99zzqJTXDx/r889J787hakv
         /DKC8Zd4rjLI9jDzMn7R+OghKiB9TrqeGWeT1Z7mPvEK4ZepGr2G0dEXhfm+08H9cikm
         mw58FPq3E9f3twgWgBc6s0cWrDE7ebLy4KzIo00584ufdyig8Ips80sThQhCt2kbJzQg
         cmliXE22Sl9/U7nQughwvgXDfVlqiM8S1kQM3B51hxE7syhNqUElXaTCAJBnio7tymtb
         bnwvYEwjs5pvnd/N6ywDM10QnQam86MebC1+YlZmygJV7SxTazunQAmkdDRTTDrdEbWK
         pWFA==
X-Gm-Message-State: AOAM530Cc1LPmrjQUvM+MgplM9KsixnfWfjaBwpitV4OdkVIStoBolng
        dPDoLS96C9DGQD/VrmYL3TznNkdrtPg=
X-Google-Smtp-Source: ABdhPJzTZ093PEsnRadfQezOZ/OpMlXc9RmRJn31AIuIG8KTdQ1x7aIynx1f0WSjgyrJse7FujrkjA==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr3378622wme.26.1589537118085;
        Fri, 15 May 2020 03:05:18 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/13] upload-pack: use upload_pack_data writer in receive_needs()
Date:   Fri, 15 May 2020 12:04:48 +0200
Message-Id: <20200515100454.14486-8-chriscool@tuxfamily.org>
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
more thoroughly, let's use the 'struct packet_writer writer'
field from 'struct upload_pack_data' in receive_needs(),
instead of a local 'struct packet_writer writer' variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 94bf9cd088..399ec60ade 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -917,10 +917,8 @@ static void receive_needs(struct upload_pack_data *data,
 	timestamp_t deepen_since = 0;
 	int deepen_rev_list = 0;
 	int deepen_relative = 0;
-	struct packet_writer writer;
 
 	shallow_nr = 0;
-	packet_writer_init(&writer, 1);
 	for (;;) {
 		struct object *o;
 		const char *features;
@@ -978,7 +976,7 @@ static void receive_needs(struct upload_pack_data *data,
 
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
-			packet_writer_error(&writer,
+			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&oid_buf));
 			die("git upload-pack: not our ref %s",
@@ -1001,7 +999,7 @@ static void receive_needs(struct upload_pack_data *data,
 	 * by another process that handled the initial request.
 	 */
 	if (has_non_tip)
-		check_non_tip(&data->want_obj, &writer);
+		check_non_tip(&data->want_obj, &data->writer);
 
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
@@ -1009,7 +1007,7 @@ static void receive_needs(struct upload_pack_data *data,
 	if (depth == 0 && !deepen_rev_list && shallows.nr == 0)
 		return;
 
-	if (send_shallow_list(&writer, depth, deepen_rev_list, deepen_since,
+	if (send_shallow_list(&data->writer, depth, deepen_rev_list, deepen_since,
 			      &deepen_not, deepen_relative, &shallows,
 			      &data->want_obj))
 		packet_flush(1);
-- 
2.26.2.638.gb2c16ea67b.dirty

