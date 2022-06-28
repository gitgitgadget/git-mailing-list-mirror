Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF1CCA47E
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiF1ITt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244220AbiF1ITG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6470C75
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a15so11300848pfv.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UId79//JeIuY+oKqjYOXD/Nq6lYWgpGjKSGJwa1/atA=;
        b=U4M+xvzlx7OIs4kVtMYPAcVN3N/KgN7whXMwQm7C/WLuc4sF1jqJtRo1cfntDLimPu
         UtFjpzmloQxi0hkka1Z/Nud0bcHK2l9NyR6tkqOsuw1WNT+/kkA41eLZOLZNRaIiO7CK
         NwrwxJtTI5KT3oXTUczCvZ4ilr9BZC0a2VX+wo9pPFABckoDAz2idaH/QYcvWtD3W8r/
         Z0QZIo+K0FyGs2iI+5JtcMoBTn5pjgw9u48c0hCV+T+VDNpAH2DFoVpc2kYdbH4GIA52
         YWPLexCij0zuDakpkLIxZxb209pC4KxO2GIkB/DikMZgS53GK9d9S4lkzQGA8YW0IGJ6
         eewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UId79//JeIuY+oKqjYOXD/Nq6lYWgpGjKSGJwa1/atA=;
        b=cKjpZFwEkDITDDjE1KNjNJSJuEvEUld4rfPPC2cL1dl2FxNTniPSCGVom9rASUVwfG
         0QZbY0wnPERXs58uNJ9z0tvY+qs/t+SCDnZGTzrOqN/ZzqRy6bAL771VU/AXj/YFiY0p
         Rz+HJsmn6Y7L4Z9p5+qDFYSfz6X0R/Lub2hGmJh+HWSkPRdbuHhwxWgexTw8nBuHfQ3y
         ocaDngEE34mWvAFvrOOBn3iazyWR3PfEJ5GJrYoW/ooRf76mqMAaJXhIOFviB2kTQShC
         scze821WFI9NGBEXGPSNZgq3rlLbRuFgT4m5dxJNRX49DnydqxTPlJ1eckxDMp0yfctM
         utBQ==
X-Gm-Message-State: AJIora90Q3RNN9AfEVPqtqMZObCd194SrZOb59xG3SJh1MUhK/oQiq49
        u8aXLA3poXImGTDnGWzETU8=
X-Google-Smtp-Source: AGRyM1sV1zRm/QBf4muK3GuUW/Xe+DWDOfHRbNeo26GnP0bbf/AlEYuSYwgWtRrtEmz+RpxD1fQWhw==
X-Received: by 2002:a05:6a00:1592:b0:525:7809:42c6 with SMTP id u18-20020a056a00159200b00525780942c6mr2354851pfk.64.1656404285399;
        Tue, 28 Jun 2022 01:18:05 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016368840c41sm8551206plb.14.2022.06.28.01.18.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:18:05 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: [PATCH v5 3/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Tue, 28 Jun 2022 16:17:48 +0800
Message-Id: <82d4493a6ee7d18063e0feb72d0bc1cc450f2682.1656403084.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.gf3b87a33da
In-Reply-To: <cover.1656403084.git.dyroneteng@gmail.com>
References: <cover.1656403084.git.dyroneteng@gmail.com>
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
index f13a6bfe3a..9f60dbf282 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -323,7 +323,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error_errno(_("cannot stat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -361,7 +361,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	bitmap_git->map_pos = 0;
 	bitmap_git->map = NULL;
 	bitmap_git->midx = NULL;
-	return -1;
+	return error(_("cannot open midx bitmap file"));
 }
 
 static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
@@ -382,7 +382,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error_errno(_("cannot stat bitmap file"));
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
2.35.1.582.gf3b87a33da

