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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C2C433E3
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DC520709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tk8mWrHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEOKF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgEOKFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EBCC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z4so543414wmi.2
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82o38QBR6yozcXy267KbHiFIkbot/catexYuNhkYE+E=;
        b=tk8mWrHf39oOzWmLZXCQLdrYYndu12AF6eHj6tmhvNSWAeIK9ov7jv4jSm2JFcKU8g
         QX7N5k9KEQzA6hSBWNf93l2VQDASqi4PbHOR+fa/bXX8mRZUXhKumqxM+mwFGS8oiQVW
         piz8wqcgLBMAutP6PnlSh98jcfDf7oS0BO5y5YWBdEqvS8dQGN9DC4kvn6q87vWYjgzd
         uvEDxlH5IrmPYxbyt5f++RS9mxqkx0IJO+GKOltUaThfu72w/6ACiA5LsSWikZCiFKvK
         rCAOirj5PZ4v1cp0gaCS/ajyUbezS46lukg7Lgu3kcCZgxCTL58QDjnDvz3rM4jDi+Yb
         I7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82o38QBR6yozcXy267KbHiFIkbot/catexYuNhkYE+E=;
        b=qmjdY0DBJsAq1ezE1deTgltZCntup6aZoWtxWFHxnI7FSc1Cyz5azTnsw1ZIeQ7fIF
         qF4f/mkHmmTUbrga6rhAlAsM9S34SFyiRs5m/i7sddJ1Y1dk69AV7JfjE9fpy5KNQWIH
         DiE5rRE4ud8M3iHKsWE9HX2tbtuAf4u5Z0C5c+UajHWxNKISbDlPYhhyTbgVo2xjCgGE
         wLyfph3XijLQUzRyHwUYwuIsPWNK8XnjyP81jQn8wMLuCbqhD/vSO7yzIBodf00wyMYu
         AaMDEuXMjEARkBWBPNcNz9lrYN0z5G+ozvwDAz9q2R6LAaBH7yv4Cg1vLWS4I6Yudzko
         VV2w==
X-Gm-Message-State: AOAM531o/+jvaokOvCpPGofGBa0g4FUK+PCTrRgljipWuNBN2jCGSO+P
        SbKvgGyHm6P95Jdk9tLxK1cQiooMT3E=
X-Google-Smtp-Source: ABdhPJwCoTS//3U9uay8uSOK4Y6/uCyeWdSM5Mus7GhqtZITpmG+GOIhSRuxWReDJfF2yqbknMYE+w==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr3379040wmb.56.1589537121508;
        Fri, 15 May 2020 03:05:21 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/13] upload-pack: pass upload_pack_data to check_non_tip()
Date:   Fri, 15 May 2020 12:04:51 +0200
Message-Id: <20200515100454.14486-11-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to check_non_tip(), so
that this function and the functions it calls, can use all the
fields of the struct in followup commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bc259f1713..680c38cc13 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -654,8 +654,7 @@ static int has_unreachable(struct object_array *src)
 	return 1;
 }
 
-static void check_non_tip(struct object_array *want_obj,
-			  struct packet_writer *writer)
+static void check_non_tip(struct upload_pack_data *data)
 {
 	int i;
 
@@ -666,16 +665,16 @@ static void check_non_tip(struct object_array *want_obj,
 	 */
 	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
 		goto error;
-	if (!has_unreachable(want_obj))
+	if (!has_unreachable(&data->want_obj))
 		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
 error:
 	/* Pick one of them (we know there at least is one) */
-	for (i = 0; i < want_obj->nr; i++) {
-		struct object *o = want_obj->objects[i].item;
+	for (i = 0; i < data->want_obj.nr; i++) {
+		struct object *o = data->want_obj.objects[i].item;
 		if (!is_our_ref(o)) {
-			packet_writer_error(writer,
+			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
 			die("git upload-pack: not our ref %s",
@@ -1003,7 +1002,7 @@ static void receive_needs(struct upload_pack_data *data,
 	 * by another process that handled the initial request.
 	 */
 	if (has_non_tip)
-		check_non_tip(&data->want_obj, &data->writer);
+		check_non_tip(data);
 
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
-- 
2.26.2.638.gb2c16ea67b.dirty

