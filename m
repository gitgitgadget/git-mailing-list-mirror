Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC00C43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 07:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiFLHoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiFLHop (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 03:44:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937852512
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so6048136pjm.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKuJ3KBnGPCrWR2pmz+TPMtNbCZTXDpz8XvdX7cCCn0=;
        b=bGTU4iNFdBlWoumYY9rVtEq+/iAqJur0qkrXuC7LPSfg9/Y4f6TQMyJFU9uI1NcYzW
         /CkMaI/lOIXkcLzcyeTJ813kKqkliJ/zwAeDbahl2Or2YClo4NqeBF9v/HOGigYG52ZH
         SWopuNmGem0SJ6V4DrecLVCsUJfdfIhRsauzsiNesZK9J/5b8iPwwvLQHZsgU42qjgi8
         hRPryUCBm4nUYGbCu4ucMWYprFdY05FVQyWhdwlF7+qg1eWxrsDkmXAF+H0nkoYzsMFA
         ESXTHUfOACc/gqMVbdn5MZuqtPh4IaIMdRgxsQl88nakR9QkggYV1E98UWKRW2duuMSB
         hOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKuJ3KBnGPCrWR2pmz+TPMtNbCZTXDpz8XvdX7cCCn0=;
        b=guhE/c5D1bt12aHAaexR8d2nft6VbKw0HpUDz/yfoV8RSr2boJMZHvMsEtKtf30SFK
         pXzvHPiHjt0qiYQMjxVPc9znyyB7/yjzrDhKGGjnvg4QrV+vOyfdAV9HMNhPAQ6kU8tX
         mk+O14gbZnsHsRQMZ8vkwlQ0ZYSFKDQYbNULlpPka39rYrAXIbgwNbiDZVX78UybqiJP
         w3Q46xuipSpviCK2OUt3nfR0lZtoNBCPqPS4bL9ibJpTm9jnS1nKVB5ywzINSDRuTxv6
         ebGHtAzMR/ZgRIiwXbUhx/jOFqZKgwstrn6bCJGWr5oOlezE9dPKcu1bw8qUzrOBV+uT
         vy3Q==
X-Gm-Message-State: AOAM531WCAjSD69Ufr0WtcQHpmIznBGP0wSSpKLFuXmC6t74gwo38agx
        lKIrcbGqYmtYdOnTovPg8XCd4yg2twYLX3xh
X-Google-Smtp-Source: ABdhPJw+o3Qb2m9GljCUHH+ABt41stMpKi3Ti0yJ58grTAQ9iH+f92mjNQ+oHfXJ7izQFfCaYAeY2w==
X-Received: by 2002:a17:902:da87:b0:166:423d:f3be with SMTP id j7-20020a170902da8700b00166423df3bemr51206892plx.150.1655019879784;
        Sun, 12 Jun 2022 00:44:39 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm2559707plp.302.2022.06.12.00.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 00:44:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 4/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Sun, 12 Jun 2022 15:44:19 +0800
Message-Id: <72da3b584490467c2492578a8125cbcfe05aad9a.1655018322.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g320e881567
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_pack_bitmap_1()" and "open_midx_bitmap_1()", it's better to
return error() instead of "-1" when some unexpected error occurs like
"stat bitmap file failed", "bitmap header is invalid" or "checksum
mismatch", etc.

There are places where we do not replace, such as when the bitmap
does not exist (no bitmap in repository is allowed) or when another
bitmap has already been opened (in which case it should be a warning
rather than an error).

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index af0f41833e..5654eb7b8d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -323,7 +323,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error(_("cannot stat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -361,7 +361,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	bitmap_git->map_pos = 0;
 	bitmap_git->map = NULL;
 	bitmap_git->midx = NULL;
-	return -1;
+	return error("cannot open midx bitmap file");
 }
 
 static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
@@ -382,7 +382,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error(_("cannot stat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -394,7 +394,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (!is_pack_valid(packfile)) {
 		close(fd);
-		return -1;
+		return error(_("packfile is invalid"));
 	}
 
 	bitmap_git->pack = packfile;
@@ -409,7 +409,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		bitmap_git->map_size = 0;
 		bitmap_git->map_pos = 0;
 		bitmap_git->pack = NULL;
-		return -1;
+		return error(_("bitmap header is invalid"));
 	}
 
 	return 0;
-- 
2.35.1.582.g320e881567

