Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644F7C43219
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3736F23A7A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbhAHSSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbhAHSSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:23 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE3C0612FE
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:43 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e22so10099399iom.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0YLqogTG7EGmbcQlGe+sLIobSiAU164UujVh+FiSqhY=;
        b=0RVvCiYTMGUmvcB6J4yP2MTV8iLrvOYM2yb1MqA/k8UNsPal9Y2yrV+dBAGI2eLE0V
         4jq9EeL7uCGleQUoSglA5cwiLlGVC8V2YjmibfqN5af9qPzqBqTs1OIMsowF/oFofoBE
         XlDzO2EU0AdOMf2qTLIshRxmVR94E9nYzxZD9KtjohK0CCSpOdZf31/w/KmFQECPp8ZQ
         sG/UNL5YoMXOddMkHWy2be07QBXCkTiJf57doi4ly+XbC3aaa0XG70q/H4xGC7LES5f/
         8DX6R/rDBy6CWJWuJdrJ7nL4mW70UCkIks9lFS/z7DbkAIzNMPKA0GLV25Jruq+ZQMIE
         mHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0YLqogTG7EGmbcQlGe+sLIobSiAU164UujVh+FiSqhY=;
        b=b2VgivkJa/knLFbHAyu4CH0aj8zqNjYCxg1I7c3yqKMVk5G3YcjSPsFr4zYD4LZGkS
         M2Mr/JPUqV1NAoLnNYhVAKrvD0RHsLl+6nwWHVjWrwINdqLqR4f1nBNIepDfXKJHYn3J
         2rE0KG0pt3yC3YxqHeVib3R2QUW2d4aZoMwL9IEl8CrSWcbhGyRTJROIKcemmToAi02C
         YRtWigQ6V0VHB1oIx98YE8rx+3VUnKvRMwlPsvUv5Fo5oZdS3g4bSlaDWm2/WkGyJvDV
         OVqdUzWqqVq+GQM+yMhVQU+sFoOVYmYzVtJKPcOf+9weh5baVzMYEWaS2NxO0gmUrJnc
         dI9Q==
X-Gm-Message-State: AOAM531Xh3uUzn/bp74x1DfezXWh+jAGBEMBH4gDoct0IgSrKr+S1K0b
        R5MYBF1Xcy2oCVC1da0GkYQsfbSsB+IJNg==
X-Google-Smtp-Source: ABdhPJzP5eyYht2QxzeDlGfzAHrOjZrYDLNU6JuEwGKsEPhyTvfdMgFriwZ7meiI94HjoBaxpM9acg==
X-Received: by 2002:a5e:de08:: with SMTP id e8mr6207576iok.203.1610129862155;
        Fri, 08 Jan 2021 10:17:42 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id w3sm7824072ilk.17.2021.01.08.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:41 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 14/20] unpack_entry(): convert to new revindex API
Message-ID: <13c49ed40ca72b7ab50939244616f0a90b5bf7f6.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove direct manipulation of the 'struct revindex_entry' type as well
as calls to the deprecated API in 'packfile.c:unpack_entry()'. Usual
clean-up is performed (replacing '->nr' with calls to
'pack_pos_to_index()' and so on). Add an additional check to make
sure that 'obj_offset()' points at a valid object.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 469c8d4f57..34467ea4a3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1692,11 +1692,19 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		}
 
 		if (do_check_packed_object_crc && p->index_version > 1) {
-			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-			off_t len = revidx[1].offset - obj_offset;
-			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
+			uint32_t pos, nr;
+			off_t len;
+
+			if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
+				data = NULL;
+				goto out;
+			}
+
+			len = pack_pos_to_offset(p, pos + 1) - obj_offset;
+			nr = pack_pos_to_index(p, pos);
+			if (check_pack_crc(p, &w_curs, obj_offset, len, nr)) {
 				struct object_id oid;
-				nth_packed_object_id(&oid, p, revidx->nr);
+				nth_packed_object_id(&oid, p, nr);
 				error("bad packed object CRC for %s",
 				      oid_to_hex(&oid));
 				mark_bad_packed_object(p, oid.hash);
@@ -1779,11 +1787,11 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			 * This is costly but should happen only in the presence
 			 * of a corrupted pack, and is better than failing outright.
 			 */
-			struct revindex_entry *revidx;
+			uint32_t pos;
 			struct object_id base_oid;
-			revidx = find_pack_revindex(p, obj_offset);
-			if (revidx) {
-				nth_packed_object_id(&base_oid, p, revidx->nr);
+			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
+				nth_packed_object_id(&base_oid, p,
+						     pack_pos_to_index(p, pos));
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
-- 
2.30.0.138.g6d7191ea01

