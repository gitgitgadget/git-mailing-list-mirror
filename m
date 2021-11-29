Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D656C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhK2W3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhK2W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BEC09676E
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:21 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w22so23622779ioa.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hkGzyKHnc9wQr7h7oh2hHBRxLGoqQj5I5JLLE+Haq2U=;
        b=mtaIwZqnKuJ+HldfRppHdlcjIFTY1N7ny1aVAb5Pc9MTtjuS/UsMIBZyVzrffGyaLE
         V8IRJrrxTqnO2Mi1lkwcVEUZPnFL71NntCYwu2GydIirAoWf1ap+GsT3pxwcvM45JEuW
         RSzkL/0RzU5c7gjlOr4d5CF/ny35Ri5TF0JAw7ThMLG06xZB6BsZS3yO5TNkO34Lhruq
         QZJC7CMDaaiIDfjPOCtUTVhlkAU3IPuLQ/GE3X6s8BODcNYPnC11shFm3g2CBK3ub6w8
         Q6cVNDqbzAQ3R506xw7FYa8yx6PlyJwzBY4SXfrfrzr/mlgXXY62hWijLlxfj06rDbFT
         BAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkGzyKHnc9wQr7h7oh2hHBRxLGoqQj5I5JLLE+Haq2U=;
        b=u1n5ejM6wABSTZ/ZzFoZb5vcbd9WJajnzdSXws4J6OYuWYnybysaJfRPW0d6zlWu9s
         iYpnMj6ToaFMFKrIG2yH4zn08agSqyntVUS2j07cPRCKxeeihdZZmDXC1a21g+EVpPaQ
         zLyeZ1Wc9e8PitHF9KBz2d/fBgA4Q6wWot/pauYsa/JmIiPEXKqf4NserBmCy+BjsBF1
         nw+PVuQiBQcYHCbC2DQB4+etia4fVVayMO4zerXbHOs99+BH/Mpdp8eHfhlY/Aqgq80F
         SzPFh9+SSOgCz4kf4smg5XoY3/f3SJNMl1NVYV4gPtgzUWBn2D1VYI0X3TFPuHcqaQVn
         n08Q==
X-Gm-Message-State: AOAM530LY/YOllAQoRoGunhQzIsaowtKyE7MM6Ke0fPjWN0sOwy748n/
        RU+Udwm973TA0IF3xAIR8tiHDKkrAo3FCRW8
X-Google-Smtp-Source: ABdhPJxmpHAj/3JEaWFq/8QjTemgWH0Op1DZPF7azUHz8cMLoZyC9DhIZYAe0BFWHmUQQbJYjhMgcg==
X-Received: by 2002:a05:6602:2d51:: with SMTP id d17mr61482095iow.47.1638224721332;
        Mon, 29 Nov 2021 14:25:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 1sm8772217ill.57.2021.11.29.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:21 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 07/17] builtin/pack-objects.c: return from
 create_object_entry()
Message-ID: <5710933127b01125ebcfe232868abbe87fce0d87.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new caller in the next commit will want to immediately modify the
object_entry structure created by create_object_entry(). Instead of
forcing that caller to wastefully look-up the entry we just created,
return it from create_object_entry() instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bf45ffbc57..3fb10529ba 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1508,13 +1508,13 @@ static int want_object_in_pack(const struct object_id *oid,
 	return 1;
 }
 
-static void create_object_entry(const struct object_id *oid,
-				enum object_type type,
-				uint32_t hash,
-				int exclude,
-				int no_try_delta,
-				struct packed_git *found_pack,
-				off_t found_offset)
+static struct object_entry *create_object_entry(const struct object_id *oid,
+						enum object_type type,
+						uint32_t hash,
+						int exclude,
+						int no_try_delta,
+						struct packed_git *found_pack,
+						off_t found_offset)
 {
 	struct object_entry *entry;
 
@@ -1531,6 +1531,8 @@ static void create_object_entry(const struct object_id *oid,
 	}
 
 	entry->no_try_delta = no_try_delta;
+
+	return entry;
 }
 
 static const char no_closure_warning[] = N_(
-- 
2.34.1.25.gb3157a20e6

