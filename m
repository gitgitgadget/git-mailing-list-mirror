Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AAEC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 07:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKJHK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 02:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiKJHK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 02:10:26 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C062648
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 23:10:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so948971pgm.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 23:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKQy/UNcXg5MzeFY1SLV102rrbsksXyFZn/aApdEO4U=;
        b=HNKA9lw9z6jQE3tRCbo7blLgKk0w0VFIK5ma6Kc3XKK+165xu2jCq1Q5COFDmSmZrN
         EzITMSyjecYbAjRFzlm6GzOJvMT39q0OJyVqOchqzFLjpgLFKS19nCPGnCIR81zOSrED
         H7ZZNmvHz3jd6sCCrsOwESz2hTgacS+G3MStrRmfj7/fd+h1tk3eS2nYA61EdpqW1MYe
         lls6SeG89ypo760H0XJa1rnxJKTTxYL2vodRNrae+otWVG32KtUIQoKQ2AO2WGnqCtDR
         KmgxxfILtsyNo8TJrSj/NWch/GpNYzdCo2X1F/rKRrvx4MCEuG8lZlz8SFvmdCKAUlwY
         NE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKQy/UNcXg5MzeFY1SLV102rrbsksXyFZn/aApdEO4U=;
        b=2MxL98xRvG/3ntDvuTPbSlEZF0p4/xKgxLnT0/oeghxLmpizKQRSW39RMV3IhXUWTF
         hIVh8aVX+AcuWFXihyGJfMOC9jomS7OlGJXnnGctl/fhmXbEOsEzhW2bOV5cgNSB9WqS
         0Aqk91Dfl9BWGBHXqwSrwggB460Na8QX/+i+qQbxxnff2xZaLIVDQCwiyRC4ZjWeBcYA
         Cv1wkOm6ZZaChshYCDR8D7XjQXdUevfUydRgZ+U0+/qIc1L71drVs1f+ecMfH+dhofwW
         k02g7mdVmOou5uBs4ZzNxBIblL4nZ70xcG4VQJ0qU7RhVzxFMPpJR+1amF9puaSGoF18
         sfjQ==
X-Gm-Message-State: ACrzQf2fxOo+VnQ54eEoeAgWVkVjzxaaNiAiS/FXY5mr71C0JTTKTyCf
        ViVdXs6RgDqdkJLPZpJN36E=
X-Google-Smtp-Source: AMsMyM4c5dWYbul0OTkkDHHhhXRyqnZQUODGnUFnu/2gCXNfd7hvYRoN3OOywget7ej9Amn6D3mDwA==
X-Received: by 2002:a05:6a00:d72:b0:56c:3c45:6953 with SMTP id n50-20020a056a000d7200b0056c3c456953mr63611460pfv.54.1668064224610;
        Wed, 09 Nov 2022 23:10:24 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0017f778d4543sm10517161plf.241.2022.11.09.23.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 23:10:24 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 1/2] pack-bitmap.c: remove unnecessary "open_pack_index()" calls
Date:   Thu, 10 Nov 2022 15:10:11 +0800
Message-Id: <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1668063122.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g7ac9b859f31.dirty
In-Reply-To: <cover.1668063122.git.dyroneteng@gmail.com>
References: <cover.1668063122.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When trying to open a pack bitmap, we call open_pack_bitmap_1() in a
loop, during which it tries to open up the pack index corresponding
with each available pack.

It's likely that we'll end up relying on objects in that pack later
in the process (in which case we're doing the work of opening the
pack index optimistically), but not guaranteed.

For instance, consider a repository with a large number of small
packs, and one large pack with a bitmap. If we see that bitmap pack
last in our loop which calls open_pack_bitmap_1(), the current code
will have opened *all* pack index files in the repository. If the
request can be served out of the bitmapped pack alone, then the time
spent opening these idx files was wasted.S

Since open_pack_bitmap_1() calls is_pack_valid() later on (which in
turns calls open_pack_index() itself), we can just drop the earlier
call altogether.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be..982e286bac 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -411,9 +411,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	struct stat st;
 	char *bitmap_name;
 
-	if (open_pack_index(packfile))
-		return -1;
-
 	bitmap_name = pack_bitmap_filename(packfile);
 	fd = git_open(bitmap_name);
 
-- 
2.38.1.383.g7ac9b859f31.dirty

