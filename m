Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E0C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3AF235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbhANCFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbhAMW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:27:01 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15633C0617A2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:06 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w79so4439642qkb.5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gfK+1MKqel64GNCY5eNaDGEceywQu/Dwr9adToVw6K8=;
        b=YpS+48OFOEqkPmpsGnMno03EwaaHi1vPNNQ9c+YM0lwvpxjsLgAeyDRyR4f+iE2Sol
         BUFLQRmS61GfiNISF0Oyez+RQuSu5Jv9gwV9XNqA3y39Th6gJYn9Hflx3sIg0U7aOYTy
         5zpheitO45qGQZ6VG2yaCqKvg2mOnIa+jDvOP1/qMZLavygZyeP5xTruaFCrZVTacMMA
         cKHNuDN+AGZZeSddBBCegVd9kS7yP2hQKVOtOkLTkdisIUej2Igm7QHCM9j3GKArkGgg
         LfbQ/+n1Zqkikmh+eB0aSbZdeTCsJctVSeo75DP8IUipbTgVEWf8cKK307SISNs7bjH3
         lPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gfK+1MKqel64GNCY5eNaDGEceywQu/Dwr9adToVw6K8=;
        b=ZHHY2hsAmRH22QR/GIV8UXmTYIXyrIi2X0oqbCcVhFLFclIKh0LknCoR69wfDy+czM
         sXLJNNqiUhlQDMC66nuyYbP2VhFniIzpqFXzlvh9BvTf+HODVdqX2wrGEjsEoK0brUBH
         C+NPabIWFlu2icyLwV/EEoAQYQu08pnEs3aX0d2UF69GjiukmegTwxcRt/UdHdGG7Utk
         OKwcHC1UeEkYPba82XRHRqV/jg6kzpAKNb2JRVw+S47CJrPso9WW7jbTqU4UaauZJX18
         oJKpIFIsEtY2jly50LVSaqOWhH5TVk8SD6EPzDESWzEib8jA4jNkpMEBonbPE1Xfv0rh
         e+hA==
X-Gm-Message-State: AOAM533T4/JQhmSiIlnJ/NORLngeQYTlWlB6mA09F+TVjJIj3jFjS+xn
        SrHBvuyPA7bh9dV5VuHi6CHUNFUUeyGbFg==
X-Google-Smtp-Source: ABdhPJwnxrEbK2XitcbFHL8alNFQSdwDkrNTi9IS4kZ3nliBylkQ37CVWnaCCB7yYRSju/2Lxe3YRw==
X-Received: by 2002:a37:43cc:: with SMTP id q195mr4360698qka.382.1610576705078;
        Wed, 13 Jan 2021 14:25:05 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id 141sm1924390qkn.53.2021.01.13.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:25:04 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 18/20] pack-revindex: remove unused
 'find_revindex_position()'
Message-ID: <3b5c92be684b95f04cbe224c791d87657be9ff79.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all 'find_revindex_position()' callers have been removed (and
converted to the more descriptive 'offset_to_pack_pos()'), it is almost
safe to get rid of 'find_revindex_position()' entirely. Almost, except
for the fact that 'offset_to_pack_pos()' calls
'find_revindex_position()'.

Inline 'find_revindex_position()' into 'offset_to_pack_pos()', and
then remove 'find_revindex_position()' entirely.

This is a straightforward refactoring with one minor snag.
'offset_to_pack_pos()' used to load the index before calling
'find_revindex_position()'. That means that by the time
'find_revindex_position()' starts executing, 'p->num_objects' can be
safely read. After inlining, be careful to not read 'p->num_objects'
until _after_ 'load_pack_revindex()' (which loads the index as a
side-effect) has been called.

Another small fix that is included is converting the upper- and
lower-bounds to be unsigned's instead of ints. This dates back to
92e5c77c37 (revindex: export new APIs, 2013-10-24)--ironically, the last
time we introduced new APIs here--but this unifies the types.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 31 ++++++++++++-------------------
 pack-revindex.h |  1 -
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 16baafb281..282fe92640 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -169,16 +169,23 @@ int load_pack_revindex(struct packed_git *p)
 	return 0;
 }
 
-int find_revindex_position(struct packed_git *p, off_t ofs)
+int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
-	int lo = 0;
-	int hi = p->num_objects + 1;
-	const struct revindex_entry *revindex = p->revindex;
+	unsigned lo, hi;
+	const struct revindex_entry *revindex;
+
+	if (load_pack_revindex(p) < 0)
+		return -1;
+
+	lo = 0;
+	hi = p->num_objects + 1;
+	revindex = p->revindex;
 
 	do {
 		const unsigned mi = lo + (hi - lo) / 2;
 		if (revindex[mi].offset == ofs) {
-			return mi;
+			*pos = mi;
+			return 0;
 		} else if (ofs < revindex[mi].offset)
 			hi = mi;
 		else
@@ -189,20 +196,6 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 	return -1;
 }
 
-int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
-{
-	int ret;
-
-	if (load_pack_revindex(p) < 0)
-		return -1;
-
-	ret = find_revindex_position(p, ofs);
-	if (ret < 0)
-		return ret;
-	*pos = ret;
-	return 0;
-}
-
 uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
 {
 	if (!p->revindex)
diff --git a/pack-revindex.h b/pack-revindex.h
index f7094ba9a5..746776be7f 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -28,7 +28,6 @@ struct revindex_entry {
  * given pack, returning zero on success and a negative value otherwise.
  */
 int load_pack_revindex(struct packed_git *p);
-int find_revindex_position(struct packed_git *p, off_t ofs);
 
 /*
  * offset_to_pack_pos converts an object offset to a pack position. This
-- 
2.30.0.138.g6d7191ea01

