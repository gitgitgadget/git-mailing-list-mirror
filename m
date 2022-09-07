Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D92C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIGI1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIGI1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E340A2A9A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso9036433wmq.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zwFfjSFkNH0td4rutJ0fUiJwA+6eKA/iIsNyTIHZy2A=;
        b=PhYyXO+tH2rM9Zh+9do0KoArcyADKA9zxLenfVLTud2O4xs98IQTZbcrtbND8Ozlu3
         WQhVAno/92hke1LXMJ3ad2jtdjS410zdxtW84YhZTSmbmH9FBuEwSQKkkhThqXwE2uQN
         9dNUEg75ZupWx/9RU1JAbq+1gfi0rM8qg2FrvXviQpPx0dp86MLhVpMYO2cs8LeE78QM
         bhmMr75N/nNRsDAJHvJgk0obrQKUGPwIH37RNKOVvOoLPXsWAoD9rgJq5HaBK2gZoyfb
         +kybqa5B6tu5UEH9mzDb9FwWGgsRTpl18qDLMTFLTX0l2lP0TfW+3kgL91Bv7dMkJTeg
         h9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zwFfjSFkNH0td4rutJ0fUiJwA+6eKA/iIsNyTIHZy2A=;
        b=Uq/NOmXEZ1ItjDcErQwSBxZT62WkKwcFA9eZPHurSMg+xJGnQxFzSUDPpT2Fcw+9tk
         WzN7kJhUdGvsor4hBAzbdJqvEaBkMgTUfqW9VIJFtvRSRcpeTRk0ypc1HC86nDOBwq16
         sD5lSJMu2z72s0X4HLejtQi03h2FR7i+/4bmF88kmeKNfbPH0bqbr6m1FLUvI1sqtEfN
         wO4yBTccqvKt+zehC99HjevL4AEbzw84Hm5THxcN2AIsW/AAJOKsNKZCTF3oSUVkGN3L
         Xnt6V8NZAeRp8t0ssRmpalgn8/mq5fF0ebZnYrQTTFfEFMrsfmx38ZfmHqhfVn8HZKiv
         hiig==
X-Gm-Message-State: ACgBeo0aG7Jm3LtOkJsWTaxWY+oS+uoopJMudKUsT0lx0y1GpSpGhNSZ
        I6eejVViPDbXxHJQVB6YhhCrMy961hmAcQ==
X-Google-Smtp-Source: AA6agR5jtlGxC19qUjc8tivFFxks/Ake4V7Rc19c7Vk88zTogBzrSU0uu3IjfyI2ye3pG0PYI2i2Wg==
X-Received: by 2002:a05:600c:254:b0:3a5:a401:a1e2 with SMTP id 20-20020a05600c025400b003a5a401a1e2mr15334080wmj.14.1662539235689;
        Wed, 07 Sep 2022 01:27:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/9] apply docs: de-duplicate configuration sections
Date:   Wed,  7 Sep 2022 10:27:00 +0200
Message-Id: <patch-v4-4.9-5523095fe7e-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The wording is not identical to Documentation/config/apply.txt, but
that version is better.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-apply.txt | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b6d77f42068..1d478cbe9b5 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -263,13 +263,9 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
 
-apply.ignoreWhitespace::
-	Set to 'change' if you want changes in whitespace to be ignored by default.
-	Set to one of: no, none, never, false if you want changes in
-	whitespace to be significant.
-apply.whitespace::
-	When no `--whitespace` flag is given from the command
-	line, this configuration item is used as the default.
+include::includes/cmd-config-section-all.txt[]
+
+include::config/apply.txt[]
 
 SUBMODULES
 ----------
-- 
2.37.3.1490.g9adf4224da0

