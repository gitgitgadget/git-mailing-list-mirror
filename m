Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6571C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834DF23A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbhAHSSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbhAHSSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:43 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB98FC0612A6
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:55 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c14so7190369qtn.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vCuddtAjGaCy9Blc34YzMVmKVBD1Y4MOb555wFeIH2Q=;
        b=Eo0TTAXW9XDtd1S9Jjqp+zUL4lWS2JA34VlflkaccsmtzQZhg4Iq0sCEYQPEIyhkVJ
         9JKi/hDA3vqeaqGULliB5dIzX1qVMdVycEg/iJ4Tfs0DsEOwFSzbqwHZlLLcUhnPQsMl
         OJDv4uueT3hKfQG8TAsjHJd7H9xodoBNpfCrp9hGfvL4hVQPf4aed0tLLXK5jkF32ZgP
         2tWGsVeQq2X8wiuSaVP6EqyjwQ9U9mhTdNocv38ZNrg5NcWEdLgv2itJgkDN36LlYAaj
         9Fa4658xCbaTHVLEi/n5sYTrZ37Qa9dJIe6jx9xu8QT0LaMsUON89X0TOzX6PoSYhpsZ
         fHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vCuddtAjGaCy9Blc34YzMVmKVBD1Y4MOb555wFeIH2Q=;
        b=iyx3OHjYrjLgSAmlf4p+fQxJZV0A6lPW3/3WpGVzyhsz2kndbxv6TZfalZ/Ct6qCsE
         3ELiP/71y1KNzYfftk/tuQ2gpXdnXwxYdCaomoaiMHSJWdeMDg6xz/HSDENmfIDF3xa8
         uZxEG1WkoXFpAXohdiekGfdzqolnAlrXzQrbef5kwbvY94nnjuZtXtaQw9jGaTbh9Rm1
         SkbrsgTg4iPEuyyyGUm+S6+NdYFT7KpHRGGMenNHoMkhAXTdT4TwCslKSllIrg6/SzCT
         AjqDiOAUd3RmRc4Gte0zd2VGqeUexdAjKWBSlxOjjDoQr/n+/TCHSxasFd5gj1p++JiG
         jlcA==
X-Gm-Message-State: AOAM532IZQrp2mkoaXfI82cZ+fId+f9S8JWvtbXpNEAJPBMt0QWAGCCc
        onSAR0WGp1ljlZbAzI3xvbokFFaJ7Nx8Sw==
X-Google-Smtp-Source: ABdhPJxrkbTkRAyXH3ZtkWUnqCabMqOEbnBgG325rwSikA38JGD9tGOOeOfVK5GTb3FV0I20OU3tdw==
X-Received: by 2002:a05:622a:201:: with SMTP id b1mr4532527qtx.237.1610129874884;
        Fri, 08 Jan 2021 10:17:54 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id b6sm4900647qkc.128.2021.01.08.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:54 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 17/20] pack-revindex: remove unused 'find_pack_revindex()'
Message-ID: <c4c88bcc3da6c0a7e28b82e0558a44195403fe25.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that no callers of 'find_pack_revindex()' remain, remove the
function's declaration and implementation entirely.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 15 ---------------
 pack-revindex.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 6d86a85208..4e42238906 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -189,21 +189,6 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 	return -1;
 }
 
-struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
-{
-	int pos;
-
-	if (load_pack_revindex(p))
-		return NULL;
-
-	pos = find_revindex_position(p, ofs);
-
-	if (pos < 0)
-		return NULL;
-
-	return p->revindex + pos;
-}
-
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	int ret;
diff --git a/pack-revindex.h b/pack-revindex.h
index 256c0a9106..07c1a7a3c8 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -11,8 +11,6 @@ struct revindex_entry {
 int load_pack_revindex(struct packed_git *p);
 int find_revindex_position(struct packed_git *p, off_t ofs);
 
-struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
-
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
 uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
 off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
-- 
2.30.0.138.g6d7191ea01

