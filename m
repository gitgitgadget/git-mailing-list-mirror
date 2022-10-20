Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A21C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJTWnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJTWnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5C222F32
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u10so1901941wrq.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfKpvv5tDE7ki3HjX6l5IbeBAnI8BgmVJAOYxEqtYgw=;
        b=Co485xKf6J57PDChdFqJeYHj6sTYabvnV38bPLCugJT0GXlkq0XLTbDZ9MK2SNcoHn
         SZCseH6E55pfcK7hqOcIEUQUVuMx5/tBxiNcYfzGmT+Ga8WW4+q+fy16yyU3wjJIH0t0
         RJlGuUq4dhN9rMJ/QSe8xTEB730dAtd3SmpsMhmHeWDlcKuffMLvpA9QY2S8WJKpU7oI
         +oKVK7vwjEvyVQG+VAsaKBOLBfodA2uZIoncsLljrOdcIYa3U07RXN1KETQYLz6Ri5LB
         vdXtITkQF/7vhACKh8RqCMd96KVsjCFCQcFBDCGJKwNMg1iPZhQ8/k44MKQY5CdPXM3j
         H+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfKpvv5tDE7ki3HjX6l5IbeBAnI8BgmVJAOYxEqtYgw=;
        b=gHF7RkZxqqQefSwdd1nSPTF4mizLgbWtSqY+sMXuzcgpvi/1bjtgX91L2JArqyOrtl
         6AS+2yn47QHz9GV5im6Y/M8Rej7MpYW0pmL/Kya6t4cwpSUTWizLoHUQZZ+R3UzsNkW4
         3oJ8hD3lIPj3YW47/4Dmh3t2E49Bqp0oOkyI6HYaBn4ESkfq4+BLm3SbQQ8e40RsRpF0
         kyGN9r9fmqdAeivp/D79sVThgqP+twKBh08B5h5ajiidengczNb/Qf5ONKA+YpRnwnyK
         4UehZBfZUfmhPzT6zsao0h93Im3J3hpbdzegw/t5CkYRsDfF6isLQmIBUP5G4aX7NmJC
         c2uw==
X-Gm-Message-State: ACrzQf1eXHLWFTS44w/C5mXK/i5lzGoPU5TampNEXfvBeGUbKVAi12wt
        9NTIuKXflE/zkLlacZ1hEyt+wgxxLMF1Jw==
X-Google-Smtp-Source: AMsMyM4iRFlEOlB3aqxD/lG6Y33OqAt8BMeW79AwYEsELcTLLRvEpwKn9qkQL8j9beWFMWMHEBEkdQ==
X-Received: by 2002:adf:d1ec:0:b0:22e:3341:a8cb with SMTP id g12-20020adfd1ec000000b0022e3341a8cbmr9905644wrd.151.1666305811397;
        Thu, 20 Oct 2022 15:43:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:30 -0700 (PDT)
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
Subject: [PATCH v3 3/9] Makefile: correct DC_SHA1 documentation
Date:   Fri, 21 Oct 2022 00:43:04 +0200
Message-Id: <patch-v3-3.9-62dd2d5708d-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The claim that DC_SHA1 takes priority over other *_SHA1 knobs was true
when it was added in [1], But that hasn't been the case since it was
made the fallback default in [2].

We should be making it not only the default, but something that takes
priority over other *_SHA1 knobs, but that's outside the scope of this
change. For now let's correct the documentation to match reality.

Let's also remove the "unconditionally enable" wording, per the above
the enabling of "DC_SHA1" is conditional on these other flags.

1. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
2. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5440089db3d..e55dc870c5d 100644
--- a/Makefile
+++ b/Makefile
@@ -155,9 +155,8 @@ include shared.mak
 # Define BLK_SHA1 environment variable to make use of the bundled
 # optimized C SHA1 routine.
 #
-# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
+# Define DC_SHA1 to enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
-# Takes priority over other *_SHA1 knobs.
 #
 # Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
 # git with the external SHA1 collision-detect library.
-- 
2.38.0.1178.g509f5fa8ce0

