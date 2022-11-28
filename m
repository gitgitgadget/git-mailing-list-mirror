Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1464C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiK1OKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiK1OKG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:10:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37A2F7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k5so9578887pjo.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaX2bT7uVTzl4d9utxx2MU4TwG5fEWKWKpooBTBekfQ=;
        b=qu6tYkbgIG7ayLEqHjbAhpi16nhaezwU9c3s7f3vh6jkMG1KU7FIZUXptH93xB1E+s
         cf/z3s/JmcHbCpkVen39kegMkr5OD++Et4hUqj/sOm/1vqx+AfuITFFYXQEhbjrIFD/6
         jRuJLE/wd9H4kg0BBbDExhclvZzQU0N7QPxmn2pmWfT5Jmo5RpRYI4xdbCUEn6ESVXDz
         jm6NWZHHywZOPd4It3IZls9B9j7T/hv+UmE67jY7d3c1EePECuW+/Gnscrhj71qU4xTt
         ZcbBoQJ/Pja78V3f6Sg0fLVYHIaggnw38rpae1VSlSOJwlcVmBl8/riQcpu8YHKHKMF4
         sxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaX2bT7uVTzl4d9utxx2MU4TwG5fEWKWKpooBTBekfQ=;
        b=r6c4UDo/5NShX5zW2P+cUxdLpkY2wW2FnjWtWzWa8Kn1xX50HwjA24RukI5w+DMsqZ
         OUGcmxl0GWD5x+f4cUt5AwZXHwLRlPGiQ7A3KpOUkM7VQrIshwbS5+LBqUsRUwCc0lpK
         QzjVNwk0cQQ94zewH+Ji4LmqsNHz298qLA5v66XBlPpaxgV72ou/BwoCJN6DgJXQj+aU
         LMTxrrMLj40fZbHp9bO5gjENJroFhmhnLnRLo8HWAK4JqO+45hEfAqaOLkdo1CikDefO
         ByaE2IeProV+slIzN6HJukoPhoJQiGnMmVS8ee7OWAX91zY6ZwFQCRvl+524EBaOFLWz
         mquQ==
X-Gm-Message-State: ANoB5pnohJstHzLRbtbuOqZ/CGUHm9PAqaaJy5+CxzopYvvWYultTsQc
        iY5RpAFVLFHrsbvRPLSWb5o=
X-Google-Smtp-Source: AA0mqf6XfIi4J9jarTUqIP+5GQyFnnTlPPlnRUQ+RxXHLyF5669hsRD3XrV/qBFO+nYjjjNQG8+5kA==
X-Received: by 2002:a17:90a:e387:b0:212:da06:88ae with SMTP id b7-20020a17090ae38700b00212da0688aemr54302949pjz.228.1669644605302;
        Mon, 28 Nov 2022 06:10:05 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0017f64ab80e5sm8842819plg.179.2022.11.28.06.10.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:10:04 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 1/4] pack-bitmap.c: remove unnecessary "open_pack_index()" calls
Date:   Mon, 28 Nov 2022 22:09:50 +0800
Message-Id: <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1669644101.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <cover.1669644101.git.dyroneteng@gmail.com>
References: <cover.1669644101.git.dyroneteng@gmail.com>
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
2.38.1.385.g28306b7e8d5

