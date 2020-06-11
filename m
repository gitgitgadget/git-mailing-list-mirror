Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA142C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901B120760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oV31lEZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgFKMF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFKMFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49924C08C5C4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so4762912wmj.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0APQgqlDE2yF+o5a60unQuOkJxpEta4Yy1BnJzPkn/M=;
        b=oV31lEZMKIaxRnL+cXCrCjXqKJwwcYA48Xfk/QQt+ITmFEOKtdL1YqskKoSuGahtve
         tJtYOV0+jUrcLw6oS2fyc85O2RahcRIehDe1bhXUp2qK56vpwKzdhx+Wj1MlyGXx0a/I
         +rTZYrsleHxNgJEMogx1PHYREgp1OGOK7TQzo3mrbx+qvJ4Eab+ebEGKU3KMCbtP9rbu
         RpMRjeQ6m3WVHgghL9V1794XckI9AFoX5SBK/5buGoxj+bNYqlCPfNZ+9aLI3wcD67Ux
         tHqXBF1Y8Js/ByZ3pFzKZ0ooR0IiaXZvPGVFMzddQGB3rYOF/MFrs5j5BvVUzgPo3YPA
         EB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0APQgqlDE2yF+o5a60unQuOkJxpEta4Yy1BnJzPkn/M=;
        b=k2zLbu7X6rTruApXB65RNglHATSWCBoP8uJpGfpZVWD8VbkWcXMzkFHAHn8RZGBzuL
         auqTPvgXOXHuHwtYQGPYCsp222mvSy1lVlH7jhXwk7UzxyjttizeOIQDnAlfjlx+F4FS
         B7EdRnwBo38vDnIvEQBnhHZd7+nXW1Tg2b9hPiPw30JUEKucEYaaAVcMptUEogidyNVM
         Ug8TzoS/+6KYGBs3a2tjBntTzpnBoya5dioNNhaiw2H1NZUv1cGNmuqu7L06P8pAcrZj
         +BY53IOMmJ+XlYl3haN0zWcY4VuAE5xcpusBqAtPCq6c/EXcm8WODVm73mAZbeOX7uHd
         5ASA==
X-Gm-Message-State: AOAM530HFszwz+lLfYWWS36QgzOrwLRpUwW51mJqhVZ7Qm6IkbRU1n1G
        zX18o+NMCSGSh6f0Y10YGzLH0xGTmX0=
X-Google-Smtp-Source: ABdhPJx2gX6NmPJDEcDecO5S4nEpjcci74DUkSrDYsTudcSYQaDC8Gpe7/b2MZijYJK2krKFrZOCyg==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr7842917wmi.30.1591877150657;
        Thu, 11 Jun 2020 05:05:50 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/14] upload-pack: pass upload_pack_data to got_oid()
Date:   Thu, 11 Jun 2020 14:05:16 +0200
Message-Id: <20200611120518.10771-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200611120518.10771-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200611120518.10771-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to got_oid(), so that
this function can use all the fields of the struct.

This will be used in followup commits to move a static variable
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 245eda8ba1..6729c17cf4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -393,8 +393,8 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	die("git upload-pack: %s", abort_msg);
 }
 
-static int got_oid(const char *hex, struct object_id *oid,
-		   struct object_array *have_obj)
+static int got_oid(struct upload_pack_data *data,
+		   const char *hex, struct object_id *oid)
 {
 	struct object *o;
 	int we_knew_they_have = 0;
@@ -422,7 +422,7 @@ static int got_oid(const char *hex, struct object_id *oid,
 			parents->item->object.flags |= THEY_HAVE;
 	}
 	if (!we_knew_they_have) {
-		add_object_array(o, NULL, have_obj);
+		add_object_array(o, NULL, &data->have_obj);
 		return 1;
 	}
 	return 0;
@@ -478,7 +478,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			continue;
 		}
 		if (skip_prefix(reader->line, "have ", &arg)) {
-			switch (got_oid(arg, &oid, &data->have_obj)) {
+			switch (got_oid(data, arg, &oid)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
 				if (data->multi_ack
-- 
2.27.0.90.gabb59f83a2

