Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C07C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E7861378
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 12:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhJSMeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJSMeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 08:34:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07CC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 05:31:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso2877914wme.1
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yleNOIhjt7dqx3dqKf5J56WhXEyxw87Rgc9tlataqyY=;
        b=AK8hzCj/zSCGXUpnWfSzwQVpiTfAGyTF/6QJ9HhLu7A5MOCWuho5gK5omM0FTINLX1
         spjsujIyVK/ldqOmUBoO6JeSWJEk2g/8YKwLfxkFObq06ioXnQzvWY5I7FNpOeRGplQt
         clGQGaIXuEvxv1efDMny5q53treZEfKpoAi/vzQwJ2eMVyKdGDtTWmp7eJ73h8vahYlZ
         fwLukPs63iMdd7EOCxOoz5ncfipE70OU8+Dj6lXnFipE+d0t0dksND0eFrCstz0D1IT8
         cxEJWK7L3tz2DyZE+qtS/FoexYrhG+A817j51ir9tJr/bf1PE2q+KTCmpWhGJMmioM3Y
         tAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yleNOIhjt7dqx3dqKf5J56WhXEyxw87Rgc9tlataqyY=;
        b=ir0i4p+T2YDrn9Rey/M1XboKR7pgiPlRtoGv9lXk+LCQ/dIKekKo82GEXv5vR7xKYc
         iQKhLMynNiYQ/b+uzFGoYrB/V9SbF1y1KV3tPP4SrHRTOgRUSG8zqh01061gANcx3kDC
         HIBbYtjN2BcwpKuThBn5GOy5vu0thKyyEXuqU40WXopgSrj1M79gfW1oIz0n1D1dEWh7
         mcb030o379ntp/ducALHqczqCsv0Z8ruZINDl8iueU7DPBY1+SuUuqhXM3EqKCJreTae
         FBh/kmSXTsy07pgJLNaD/y6xiAYizWxnYl0R60uwOVaGQ7oqev4LweeudH8BSAMfB4ec
         KhqQ==
X-Gm-Message-State: AOAM531u3I9qAmCZ1cCbMHhjxX0szLb2ELKmwHMgqnMq7iQY8M/r+OOU
        SuciLEm8XqXYH2ZzXErhXRXC9QtPcHMdrA==
X-Google-Smtp-Source: ABdhPJw2nmOTyGfQh0cnmA3aOQ6DhqV+NhRNIZ6xjIDshBx/QnbaZ67BmoK7DcDvQfbstUAtQrGdOg==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr5725390wmh.188.1634646715933;
        Tue, 19 Oct 2021 05:31:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z1sm5085109wre.21.2021.10.19.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:31:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] git config doc: fix recent ASCIIDOC formatting regresison
Date:   Tue, 19 Oct 2021 14:31:34 +0200
Message-Id: <patch-1.1-36700e581d2-20211019T123057Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <20211008091614.732584-3-bagasdotme@gmail.com>
References: <20211008091614.732584-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 8c328561332 (blame: document --color-* options,
2021-10-08), which added an extra newline before the "+" syntax.

The "Documentation/doc-diff HEAD~ HEAD" output with this applied is:

    [...]
    @@ -1815,13 +1815,13 @@ CONFIGURATION FILE
                specified colors if the line was introduced before the given
                timestamp, overwriting older timestamped colors.

    -       + Instead of an absolute timestamp relative timestamps work as well,
    -       e.g. 2.weeks.ago is valid to address anything older than 2 weeks.
    +           Instead of an absolute timestamp relative timestamps work as well,
    +           e.g.  2.weeks.ago is valid to address anything older than 2 weeks.

    -       + It defaults to blue,12 month ago,white,1 month ago,red, which colors
    -       everything older than one year blue, recent changes between one month
    -       and one year old are kept white, and lines introduced within the last
    -       month are colored red.
    +           It defaults to blue,12 month ago,white,1 month ago,red, which
    +           colors everything older than one year blue, recent changes between
    +           one month and one year old are kept white, and lines introduced
    +           within the last month are colored red.

            color.blame.repeatedLines
                Use the specified color to colorize line annotations for git blame

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/color.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index dd2d2e0d84e..6e817f60476 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -17,11 +17,9 @@ date settings, starting and ending with a color, the dates should be
 set from oldest to newest. The metadata will be colored with the
 specified colors if the line was introduced before the given
 timestamp, overwriting older timestamped colors.
-
 +
 Instead of an absolute timestamp relative timestamps work as well,
 e.g. `2.weeks.ago` is valid to address anything older than 2 weeks.
-
 +
 It defaults to `blue,12 month ago,white,1 month ago,red`, which
 colors everything older than one year blue, recent changes between
-- 
2.33.1.1338.g20da966911a

