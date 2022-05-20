Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A9CC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiETHZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbiETHZC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 03:25:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7799F158974
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so4586291wmb.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDrhVsWgDlagBwj1sJZl8xCs18n0618FmRFZVeQiUfU=;
        b=MwgyfpIpJqvL/mGUeZsw/BZ5SE8QYkivx96ugWZCqhO1g9QwnCuLbrrVrPCK3sCzc/
         hN1v32DzKycIMwwgaN49GFEXGXj5Cb50OtwWESWDC0S6K+kRfnE/K0nAUCK33YhKyx7F
         DU1ItDA9o6aeAuQNEoWjvzhLaYKmFX+nyMzy/hjl8TsL/NZftEl1JO9rjEYqU91OdRKX
         u3goPiKYrKvP2Qtpnew+3at5Y5t+ZFBxvIRJUvjxJKTTTZ6Pg3wFBjWZYyIXLObIX3Du
         mbJaAMyEp5TplUFUgRzZ2KPbQpPu6X0Yr+wCBSnnviFIhgUEsN+dc96GfnkFvzQ3YNW8
         q6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDrhVsWgDlagBwj1sJZl8xCs18n0618FmRFZVeQiUfU=;
        b=wg+3wdDOGPmSC+ThXZQmLnkdLVQLDwobiPNzH5IdJLg4tsBXvzXfybzSrj+p9Ddrca
         hsy45dkZNLe1xOSqPb5oqfZs+UmgHgvTkUioOZ2tgHSlYd02RCuA1Gixt31m6MDVaa6/
         3clMfwu6wIa4kwf+4USf/QWnPu12jz88rXuS4hBPomAM2GGBlOI5LgrW8CAs+ukPloUv
         p1f+YoRzUj6IvTGhVJW6o8lP5k72vyv3Y+aOa6vL3w5mfFHbvOL6tMZw+/RXA3NZ5HxP
         utBMnx/5HgMWIYRK0l71MoV5Wx6G4Ra2Gw6lZ9ajMy5aSUY5peHfwaBMotpp8TpZSnN2
         WnfQ==
X-Gm-Message-State: AOAM532lsPJuil1rzdeiwRXaL2zgzXHmQCerPP0CIAN8ZIBJjmPUTGZr
        xonHLNs0RMMP9bdpSALfr/ATG+cIH5ooSg==
X-Google-Smtp-Source: ABdhPJw318ZQqWVQWMXnrxOc8MKRsVEzKIj7+uQCCKc2I3Et9R+jWVpKA17Woen454ZECUkfO3BkFg==
X-Received: by 2002:a05:600c:2045:b0:394:2457:9c36 with SMTP id p5-20020a05600c204500b0039424579c36mr7192863wmg.76.1653031493854;
        Fri, 20 May 2022 00:24:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16-20020adfa2d0000000b0020d0a070c80sm1668429wra.35.2022.05.20.00.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:24:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] cocci: remove env_array -> env migration
Date:   Fri, 20 May 2022 09:24:41 +0200
Message-Id: <patch-v2-3.4-ca09da570ef-20220520T072122Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the coccinelle rule renaming "env_array" to "env". In the
preceding commit we carried out this rename based on this rule, anyone
with out-of-tree patches still referring to "env" will now get a
compilation error.

We could keep the rule to help those developers change their code by
running "make coccicheck", but as the solution is obvious in this case
let's not leave this stale rule in place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/run_command.cocci | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100644 contrib/coccinelle/run_command.cocci

diff --git a/contrib/coccinelle/run_command.cocci b/contrib/coccinelle/run_command.cocci
deleted file mode 100644
index 709fdfcf720..00000000000
--- a/contrib/coccinelle/run_command.cocci
+++ /dev/null
@@ -1,11 +0,0 @@
-@@
-struct child_process E;
-@@
-- E.env_array
-+ E.env
-
-@@
-struct child_process *E;
-@@
-- E->env_array
-+ E->env
-- 
2.36.1.957.g2c13267e09b

