Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C5BC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJTWnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTWnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C890229E57
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v1so1808401wrt.11
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn6tAe5mS0wHAw6+1U8ybRyZxUE/LPKPG6hJb/Hu79k=;
        b=q0WoSNkf1bGMQjWhiv4xsiIjrO0mUGyeuHKGmyg9F8Wmz9mR5ultBIzEsNpvDtOCxV
         smO0vzGh+n+2vTiaenTqJFzBcRW/2Ta4f5F5WM2Kxu+KO/zwueZnTGELXsGybwDmPvv1
         h4BAU3cWVyDLS9eGZ74VAGJCYjRE9Zol81jjoL0Q8E1QdCyyEdJsnIMT4YMHfNGOpmLp
         znDsLwtGiYRzxmwBpAeLAnrGeToVzJsdbjGL88/qIcayFKE6BKnWfyqnOerTzV1REP7X
         0FFm3C2fOK4ngIOObTjWvrPj/qmbhghI4ShrHCkXbSHVO32KmcZORLthsnqhCX3nhanh
         wlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn6tAe5mS0wHAw6+1U8ybRyZxUE/LPKPG6hJb/Hu79k=;
        b=sGexWBK831b6DEl0gVeEOK062hrlPLFL1M5je8Ck7nON+e3JIP0Sp3TiSQWuHwfWke
         r7SP3XymRzcEJqlZkv7LkpxhUA3zkUcyO4izEpe2FxX7nPGxcGgF6bLZFfLcOcIdgFfb
         Uwb08zpCV5GaG1psT287J/1L7OVsnrTe8zs2gUzkiyxhokY7tA3gKKMnSAvemTKKqSct
         HLl44j9yNv2UsZF0XQMWiIpTAx72MCX44wbFunFx4BzPEHqIsw5TvDEt9HCoE8IVBvcO
         It/CtS0Jr2yFe2OrEios4F3rvRsgIS/hqVZwwsQJidrYVHxClXpbhvb6PjI8NKrpxQuT
         oQLw==
X-Gm-Message-State: ACrzQf0fXFsUX+uO3tqPoPbMyImGTxqHmYyi+ONN5mNADVU0kpBcMhgC
        MzMIxHvt8DGb/h6bzZdoBSn/CGAc/xysZw==
X-Google-Smtp-Source: AMsMyM4IcOpHBmb/PnA/vA/JGa+12T+Hn8+HNYnxjxYMB9a5qxBuIqzWXuk8G8pQmiboWadPzObZiw==
X-Received: by 2002:a05:6000:2c1:b0:22e:7507:a182 with SMTP id o1-20020a05600002c100b0022e7507a182mr9964571wry.550.1666305808815;
        Thu, 20 Oct 2022 15:43:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:27 -0700 (PDT)
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
Subject: [PATCH v3 1/9] Makefile: always (re)set DC_SHA1 on fallback
Date:   Fri, 21 Oct 2022 00:43:02 +0200
Message-Id: <patch-v3-1.9-ef3c5be11e0-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
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
index d93ad956e58..5440089db3d 100644
--- a/Makefile
+++ b/Makefile
@@ -1822,7 +1822,7 @@ ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
-	DC_SHA1 := YesPlease
+	override DC_SHA1 = YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
-- 
2.38.0.1178.g509f5fa8ce0

