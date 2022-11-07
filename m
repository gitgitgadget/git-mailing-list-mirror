Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2DC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiKGVXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiKGVXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B411199
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id y14so33602958ejd.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tG9V2itct4loqz4lNc8+gYSOVsoZbLVfGkFTrxXN2k=;
        b=ZM8sjbd/A69rYt75IJgqfvd8OxwuT26MlRqsh5BPinHR5WUBIvR2h5Drqx4THG/jKc
         foMYZ9VTMuauNYine8w9Fv9xUcROa1d3rn7X7tSsqXcJICvOnjqyeaZN3qWcCyfrMY4C
         7tWACbr0+OrHHru2/r5ID6dfQy9G3Bay9MN3OdKNKNHe4nrLUGXkP5qNqJQeZy6Lq47Z
         53GQeopoRUavA0Qz6sfT8b2ddJYbFViwdJ669Mbc15La1sEp7kMxpN9EgtYZy6p9hYb4
         MRoYSQ81mvUV3wkVhpmqR6jVGM1Wm53kBnxvrY485zrTF9IsVbhcHRxjsyjrlbXYcoVc
         nvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tG9V2itct4loqz4lNc8+gYSOVsoZbLVfGkFTrxXN2k=;
        b=7U0wa1oVo45+3gDz5B2cVV03rdknZwSD5MaLgakIV3ccWSFdUX9j92dnayV4iCJiv+
         3rr+/AKTTjbrgaxcX88KvXIjb9w3BmZVyTcs6fFap02X5bg6mx3TbBGrSaN126Gy2i/X
         EVMx2Twd50gLgtfhCPqVFIujVFwPfR/LfjXaREZD6wkSNwDyF9AI/rnn/7KrR2ysS6X+
         7fgViKzSDg9ST7uh65FUvgnFlFxzwAGBVRQqfER21a/Yga2B1kUyidGUPUtIOvy5CaH2
         QJG876veILsMo2MmrQFzEPqb0IAXKo0kLXTGLcEDdkr91jiLVocdpfQBhdJQbvp9MSiH
         aD+A==
X-Gm-Message-State: ACrzQf0YLOitnQYKWYmrMCU5Cc9mRpt6Yca6VKABJLohA8iMl35v7Usc
        fCWRHxWteax+SpyLqCHfpUW/i9UxaNuH7g==
X-Google-Smtp-Source: AMsMyM5zFDgad0bPeurnGZ7hx76UMihuX1j8bKujEUQRRgX+qx4jjhYu8k7Ddr7DNxpJK+lYk3954w==
X-Received: by 2002:a17:907:88ca:b0:7ad:b635:2f1c with SMTP id rq10-20020a17090788ca00b007adb6352f1cmr47966493ejc.6.1667856196497;
        Mon, 07 Nov 2022 13:23:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/10] Makefile: always (re)set DC_SHA1 on fallback
Date:   Mon,  7 Nov 2022 22:23:03 +0100
Message-Id: <patch-v5-01.10-24d503e5a2b-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an edge case introduced in in e6b07da2780 (Makefile: make DC_SHA1
the default, 2017-03-17), when DC_SHA1 was made the default fallback
we started unconditionally adding to BASIC_CFLAGS and LIB_OBJS, so
we'd use the sha1collisiondetection by default.

But the "DC_SHA1" variable remained unset, so e.g.:

	make test DC_SHA1= T=t0013*.sh

Would skip the sha1collisiondetection tests, as we'd write
"DC_SHA1=''" to "GIT-BUILD-OPTIONS", but if we manually removed that
test prerequisite we'd pass the test (which we couldn't if we weren't
using sha1collisiondetection).

So let's have the fallback assignment use the 'override' directive
instead of the ":=" simply expanded variable introduced in
e6b07da2780. In this case we explicitly want to override the user's
choice.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4927379184c..0ad9a6c5bc1 100644
--- a/Makefile
+++ b/Makefile
@@ -1826,7 +1826,7 @@ ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
-	DC_SHA1 := YesPlease
+	override DC_SHA1 = YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
-- 
2.38.0.1464.gea6794aacbc

