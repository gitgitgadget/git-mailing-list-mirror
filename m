Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15E8C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 11:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiCXLpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242866AbiCXLpn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 07:45:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1866E352
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u22so3788278pfg.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsLdaNnReNvbkTuYjTWRE9fE8C4rLnJukzH0AkBxjsk=;
        b=DRtrKatUH6ytqJpnHPn/C9OkRwAjjpOZU0l3lwEgQRTLSiAeIK6/6UOAN4aXa84MrY
         OAqkrnBbjUrNyFP8fWMhOm0gKcoGfefYFRgayf+SywWFtB5MTQ7hLqUhXQOQpD2iKJWi
         j1Ca4QDrzZETAEmejEtk04OcEVE2InXa4t2huWFzCUcSYsJmnCy/A6VHUDhIasq0b26g
         bLigTfw3uGrV9QAEsbkTtPG9KiOK48w7thCNRLCwvAHQLYrpfyl6LqBA4l/RAmw9pcja
         ekqj9DTGXXf6hvVxktaY5P6jceuqpLtEZEAEJKSkemRK/Rvt2xv3qWVMotZMl7W4Y+0P
         kTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsLdaNnReNvbkTuYjTWRE9fE8C4rLnJukzH0AkBxjsk=;
        b=RUNc3jAnqxn6KQ3hAfjq5TEMWqZf96ciw/H6dHWmDhXdME4D30heDMJgh5TJkCAUVL
         V0Wy/0KFngnqSd+WlseCdocGfeSxi2Ih9beV96k6eyjQzwNLgKjMpI+tG/U+5nLJj7AB
         tkRBdHOEsCayw/E1A2G0PqfOg4B78U9o0KCwNwQPNMKuMZjaNoSxhexMBKOvibpMl7yE
         izCwCZCyrfUQ6Cj95iMOvO7eF9hKxuuPFYINzQ7Tf/K/QIkUIY2sRxpC7WxdRD5hsLnG
         Jfm18rPQz/9LCkuuxtB1O7UmL/byeU9J4Ohjts5WEBNdh0zek3T1xsUBRQ8544J2/+wH
         lx6Q==
X-Gm-Message-State: AOAM531UFiUnRx3hBQUOLwzua1txBDJ8il2jnkhhMEtq5KF/Zk7RUKp8
        quVQoHzS5ZRyd8gjay1lshLgqhrwVV0MgGAx
X-Google-Smtp-Source: ABdhPJxcG+zEqqANpohetzIDGtofcLf16zE/dDpS5kaI5DPCzsCC+WvzvBagVwp/OflIS1AlzYb8SQ==
X-Received: by 2002:a63:fc0e:0:b0:365:39dd:2cd0 with SMTP id j14-20020a63fc0e000000b0036539dd2cd0mr3849109pgi.173.1648122251670;
        Thu, 24 Mar 2022 04:44:11 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm9717498pjb.16.2022.03.24.04.44.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:44:11 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 2/3] pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
Date:   Thu, 24 Mar 2022 19:44:00 +0800
Message-Id: <70500b63434f6e454631b3a8fde07c62b5adfef0.1648119652.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.579.g70500b6343.dirty
In-Reply-To: <cover.1648119652.git.dyroneteng@gmail.com>
References: <cover.1648119652.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There will be only one operant ".bitmap" file in repo, so let's
add "break" statement in "open_pack_bitmap()" when looping all
the packs in repo.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 931219adf0..b1357137bf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -484,8 +484,10 @@ static int open_pack_bitmap(struct repository *r,
 	assert(!bitmap_git->map);
 
 	for (p = get_all_packs(r); p; p = p->next) {
-		if (open_pack_bitmap_1(bitmap_git, p) == 0)
+		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
+			break;
+		}
 	}
 
 	return ret;
-- 
2.35.1.579.g70500b6343.dirty

