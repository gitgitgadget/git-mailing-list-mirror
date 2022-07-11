Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C883DC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiGKMpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGKMol (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6E64E2A
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so4631380pgb.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df9ewZOSiQvm0vC5SkR0ilADluZ9ks2y49P7DgI8hyI=;
        b=MazZ/FBIw9zYeNGTfG4Xo+Vhu8M9LFMrDHLETBeEbTFnWUD56DieBeIr/S2QUd1sf+
         i3DJ+ocvX+kXUHdbob7sQxWMvy7Ip9oi4SZXx5jMY9h6BMyQSPVaRTbgZ7mIceBX9fft
         f8MPPqYO+T4IOgtdozkb52KgRoOxDznklkvft2MWrMhifhHl0JskU3KfxXe1wdUdqqGH
         JAn0kP4KaUttVwrlMCET9efSyISbr+xypGBz24BBr+ClshGqhfwhaehFihttutsxBeAo
         WdOq3rsmXkXAo5/HubYN/+5jXNk+qJZy2LbBF0U2a3f8+OPGlM+xMWqyiTTS/xkYjdtx
         twaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df9ewZOSiQvm0vC5SkR0ilADluZ9ks2y49P7DgI8hyI=;
        b=YNX7DV1Ys4jpHta1BFOHlUrhTiZUID2QICkvrIiNOeuSTyCCsX7pku1P1JzViGdhQL
         ZPJxnx/8ksf4Z0ZhYn3znuOHEymrXvawmY5Drfg/MBNUkgTEDFsBo4ykABkmMznDUuzq
         PDUYKTTtB/X10XokW2f/Lml62H60vSB12ecSu1fcjTo0jcf5LFynFXUqfOEMPLIzfQre
         dkhjx7XU8eJhEkswkuUKeqwtvHN1oN9H7pV1EytY7ryequOzqqyHUJ4e6JEd7e9RUxS/
         hNxulkH7DiC+z8lui9adPba/TW8HfmJ3GzS1mxE+80+zHMt11FT/DQuontN8dfmV0zL/
         KPAg==
X-Gm-Message-State: AJIora/k4Z7EpTXJ0dg16/VAMU9IXvLCztGrWYbzGe8YVuyUnHxPZEsE
        3PCee858ZzIXcLfb79/pob0=
X-Google-Smtp-Source: AGRyM1vz+Rmgo94gVKHj99NoJBGlVMWVaXrF4xSmW8/eISPMJ2xEaHMJHT94Jt8AcVztcldvAbY/rg==
X-Received: by 2002:a63:8ac4:0:b0:414:df9b:45c6 with SMTP id y187-20020a638ac4000000b00414df9b45c6mr15502265pgd.560.1657543469849;
        Mon, 11 Jul 2022 05:44:29 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:29 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 5/7] pack-bitmap.c: using error() instead of silently returning -1
Date:   Mon, 11 Jul 2022 20:44:01 +0800
Message-Id: <52783555e206060465743b5587580a6bd4a1f008.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
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
 pack-bitmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 319eb721d8..fbe3f58aff 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -327,7 +327,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error_errno(_("cannot fstat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
@@ -350,8 +350,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
+	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
+		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
+	}
 
 	if (load_midx_revindex(bitmap_git->midx) < 0) {
 		warning(_("multi-pack bitmap is missing required reverse index"));
@@ -390,7 +392,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (fstat(fd, &st)) {
 		close(fd);
-		return -1;
+		return error_errno(_("cannot fstat bitmap file"));
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-- 
2.35.0.rc0.676.g60105b7097.dirty

