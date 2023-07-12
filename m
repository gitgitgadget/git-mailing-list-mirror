Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B9CC001DF
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGLXhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjGLXhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B0173B
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:32 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5701e8f2b79so86759267b3.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205051; x=1691797051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9uGHYaZ/toenDKxFISe+cu37V6V1ShiODVe1qBMX28=;
        b=BIavTcLDcfkBjmtTi3P+cwfdiQegHae9r6gbfL/dNas5pagL9T3bRhh8fj7DkKlKKQ
         /LPVoLU12hnCcpemrmKnLQBzmPno/fVEQVuJt0hoeOYuTGlI9ddt6LZz0TaSgpSvlu5d
         PPqxWDXyCDDT82OGaVbJfykXLGB2TFk8UvvN6VeJrFzDtkBvmo4CLilPjnKOTxxVSZMV
         p8/moENdh+tCYDiBryNQToPnJfgvFyO939pk8N8wuAV2f6BinSk8t5cz0RMj9BUE/8QE
         II8BG7LMcOwMoMzQbksKhYAfHDN93YQTVnABg5ecZHMIUw7BNOXhgvJKj3Oy7Hs9tMr8
         WMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205051; x=1691797051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9uGHYaZ/toenDKxFISe+cu37V6V1ShiODVe1qBMX28=;
        b=CnAEb3ujD2e8fBsm1WBFCoSuGXAuTpKRUJY8hN5R+otB2vqPVQRghnUYmX+IYlgCzJ
         YHEPAKiHRWROMHkbnHCKUANV6Pu6cnn92PXXc0HRwpsvIxRqhtEa5ncUlcp9V/WbWssb
         dO2pJJ93d8LA14Nd6vqdznVboT027qiL6XZxFcOw7ePvnF5pbxQCNHUIpYJ8YYhjgoeS
         VZpEpZqNnaHtylTRk3+G4jbL7WkbXEOIQh1dE3VVkwadhEGzMUQ82ZUN0nBcynyUv8UN
         ifqjiTlxgKNlgwN509dbG96Wo15HnW0N9G6I8IoUi6WBRs7drdlQIB4/YaW5OD/VUwaY
         O5Vw==
X-Gm-Message-State: ABy/qLYZt3dWult5QztPVXboLgwPM3Hq9wLDJ1FkJutqlU+AF6tw+Dbg
        j3bG500ownbkLonuKsh2zp6sV5s10atzoI/J38abJg==
X-Google-Smtp-Source: APBJJlESJLlCTwlhjceSd2e00p9tq0st2jUVLzlAKirOMEZMSwfNMBtsgXzyOWAp2WN4rcZHEnccfQ==
X-Received: by 2002:a0d:df52:0:b0:573:b42b:4e27 with SMTP id i79-20020a0ddf52000000b00573b42b4e27mr109817ywe.16.1689205051164;
        Wed, 12 Jul 2023 16:37:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t81-20020a0dea54000000b0056ffca5fb01sm1472902ywe.117.2023.07.12.16.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:30 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
Message-ID: <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prevent an overflow when locating a pack's CRC offset when the number
of packed items is greater than 2^32-1/hashsz by guarding the
computation with an `st_mult()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 89220f0e03..70acf1694b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		     */
 		    (sizeof(off_t) <= 4))
 			return error("pack too large for current definition of off_t in %s", path);
-		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
+		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
 	}
 
 	p->index_version = version;
-- 
2.41.0.347.g7b976b8871f

