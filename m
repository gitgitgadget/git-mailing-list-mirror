Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3FC54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAQRMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjAQRLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F2442FC
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 18so46001789edw.7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XYzzDZOSUDBBe1ZGCFYhwfsb6htnueNwPuJIfYkT3Q=;
        b=S600OSi8skaPLrt6TOcHtnbBHhCVcHzHtL7J4MdDyD+cncjDL7bX9IFVY7a7Ov1WzZ
         zBqS26LLSF8HnfN1qTY3drvVm4CbyN8YmphK/J0MwvjjBLqpmrBJyr5AAmLCkas22SyJ
         e1zL36oMREz6dDoJQpI/pJvclxcP/FKwCcykT9qRg3sjYbmSc/jotBh12+WaZzWaKUID
         ErolDr8I0BtkDI+OwMzcE/HVEmfEZEzS2xOSxvIiYCVho0CQtcmqm28+cv7nEfKOoiOz
         LRv1m6K+V5mGDzFHOunjtGR717yOerc7HKeaSSJTsFpLr73ebTIrwl8wYex/Fbuz6giV
         DEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XYzzDZOSUDBBe1ZGCFYhwfsb6htnueNwPuJIfYkT3Q=;
        b=NTUs7U6DxYERUnj5JcDRXzM7uvwy5Lg4XAR474/Hif4sBHeN6dFIdX/doJFdzHaBca
         yuGpVcjPyJaX/bTfp84HSpQVNlUVE1TcfvKQ7YS9E2T+2/h+1hs/xFYMCW/uN7Ic7YaI
         BoFZLxKDv5pxByjKe4fCCE4adLlfJAnjK+Zc+Kts7gOk/k/nTw3gCrkRvrNntGjpl/VH
         9P/J0Wb3IUsdmrBLG1t9HF6vqSCSnxAzVrGnHT+8PxRRXfhS9Xricm1xtJh74hIwE+pY
         JaoXZsyW4pzedbzajvhUlPueSyiID4O+UOkDyamcfqvU0VcSXdfvIzKKwRIVNddxX3LT
         Q4zg==
X-Gm-Message-State: AFqh2krtGSpIYw0FbjNMWs4p4t1Q1L8fgv6s27Q2H+Mb7KKVv47EMo+7
        T/7fREYqO1lzgwzpO+8fEyYyKLsyYEysTg==
X-Google-Smtp-Source: AMrXdXveEh2+32bs/6ULABKvvjAQwWe83+FXr3g7GX1jWPOgCHyNMuI86XPcDynKygfA2zx4GT+dlQ==
X-Received: by 2002:a05:6402:298e:b0:496:6a20:6b61 with SMTP id eq14-20020a056402298e00b004966a206b61mr4067136edb.22.1673975497490;
        Tue, 17 Jan 2023 09:11:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 14/19] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Tue, 17 Jan 2023 18:11:19 +0100
Message-Id: <patch-v4-14.19-e8ea18b08c2-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 91dd5435c59..2b13124c497 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
-- 
2.39.0.1225.g30a3d88132d

