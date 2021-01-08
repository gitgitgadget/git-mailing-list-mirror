Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C0EC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6DA23A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbhAHSSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSSD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:03 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46AC06129C
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:08 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bd6so4693296qvb.9
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eOAfwdgszWE6+IKgpnVgHm09fwsqu7Q3acsEhFfnltQ=;
        b=DkbhD5koMxgdchCsTxweoeCcl9z/t+2mCqeID8eBCcK5cByQpmkADQU/taXOaKRgeb
         fUJxRngF79V1TvmJDlgPGjAvdB6oBUDHxOqhl+1+MIepFaN4onUnY9verE+6aGLQYj2n
         4Q2gSGb9Vc8g9XQNPCm7Pvibwu34kSITVLdHgrK/hkhxiiD2NxMF2IraXl4oNnDf0LPS
         3siS2ZJ2r5rF6CIoC8sCG2fJjW0VQbsgqdVSGZj5MyyOOFsdzzcuQwK/kXZD7GxGuSAz
         e7uoXvBlS0SSXNBG9+qsyDSSHcJx3DTpYjipz2KPRpUvnU5Ds/pVj0wP20TM4Vwd9wpc
         xb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eOAfwdgszWE6+IKgpnVgHm09fwsqu7Q3acsEhFfnltQ=;
        b=FLu9xtjDI10QG7xpO6hwU8kw/BRcJAWtY+L5sfVCh/NWmw1H6HXQ6piRNjg+kAdFsY
         mpuQobPg6ka2HHA2eNVD/7Z1etlPimTVqnZ0Z8gndf9Gslm4TKCZVF5VRGPjxXiQPExo
         RvcSXZhn4utG2LJtECG0VAqZutqNxFbaciYvZ8H3ejVqZMjubhA0LNiI98COFjmOjI5X
         ybbuXJ2GQ12/zteXx9tnMb4QeYaatBhffSerX0/VHYuZtIJKmx6IPjYN4Q1Y6nsy0Pw6
         X0vRhlfv2uV8BCtetMOIhITf8bAtwxclTllzSig/29VoiOadQp/Y4LSKmuOPHG5mmGS+
         J8hQ==
X-Gm-Message-State: AOAM531v1vu2uPL3PzLsxJK5vO5eWxKYsw/Vo5SyeawK6Vx51xKux0JU
        F2tNkS6iLWJtnf9PF8ficfA8Ha0XVdiyig==
X-Google-Smtp-Source: ABdhPJyVmY06Oq64yCdfppGQ6zH//mXvkIqL7uBp93s1/uSwzkjuwKw1FCqtPVplxxMg18rh/lN3XA==
X-Received: by 2002:ad4:4e4d:: with SMTP id eb13mr7936518qvb.6.1610129827597;
        Fri, 08 Jan 2021 10:17:07 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id c20sm4755655qtj.29.2021.01.08.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:07 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 06/20] bitmap_position_packfile(): convert to new revindex API
Message-ID: <3b170663dd57f33678cd24270d65153772043670.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace find_revindex_position() with its counterpart in the new API,
offset_to_pack_pos().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d88745fb02..d6861ddd4d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -407,11 +407,14 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
+	uint32_t pos;
 	off_t offset = find_pack_entry_one(oid->hash, bitmap_git->pack);
 	if (!offset)
 		return -1;
 
-	return find_revindex_position(bitmap_git->pack, offset);
+	if (offset_to_pack_pos(bitmap_git->pack, offset, &pos) < 0)
+		return -1;
+	return pos;
 }
 
 static int bitmap_position(struct bitmap_index *bitmap_git,
-- 
2.30.0.138.g6d7191ea01

