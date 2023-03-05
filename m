Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AD9C678D5
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 01:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCEBiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 20:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCEBiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 20:38:04 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B97A92
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 17:38:02 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-173435e0ec4so7545107fac.12
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 17:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuEF7zSLI7xOvAIzOeCnf2qj0MX2j3ak9huvskpJb3Q=;
        b=TRpRrFFblQWcTBlrgzZRl/f1+fp6zSbmRs1WIvYbyEIErCfuD/fvYdH9WqKe2rK4F/
         rtLkVxneTMJNntUokFC62HVOkK9isEGZkuY8Nk9wMpjSVhpu95e10KUR7nw8SssOpLRn
         cJZhDzwtmul2O3Rp2K7Nj+N3XcrkpyaViOUxvCljua5hZSknq9WevrSfkhwughYTBbgs
         czR3V8+aMYFEnx4CN+Ia7ZXNF4/SeQBoiWll3Qk1MJYYjBwGRhD1IeGOPf6phaw+Bf/9
         xL6FVVPcVZrwZzj+2OVB2lTI4CbePlZ34A3Io84HlS5sGgcM3mu/tsD5vHek/IboxbVf
         0RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuEF7zSLI7xOvAIzOeCnf2qj0MX2j3ak9huvskpJb3Q=;
        b=m9g1emyFFmY9P0BswHXx9xjskOvudcT/Fur+1o2Ffa8bn7P5oaOy+gZ+TAYnzhcltv
         kPN051Oio3G6YLB8qlacb7YwtY+zZJGQeYd15OsejOq9atFNBjwd4eYg8fEwUxdRtEC+
         ZXXuu2pSzzKYgf/If8XpI0FF0J8X4lbb4WlDPnX0CpTFFnf9FIMnWMVHnrpVvAb7jKfX
         2OhT2hvh/Qvk5185O74toBRTkYmYZk2WiHyrqKsamBdfUCW7sVpCi3jJK3X/GD4/duN2
         51aSUkmfdh7ahU82N2m+3R0wB9BgGHpuqZ4Bt5/TV7OE/rSpVi6fxdB9O6qEAnVMovW3
         Vwpg==
X-Gm-Message-State: AO0yUKVgxNIC8owPVBW7whofP9w20UKMBQO2dl+2kMFda1JoZSEkIkZH
        gMAjgd+2wH3qOv75Un9/uaMrc2cZ+Aw=
X-Google-Smtp-Source: AK7set9myhIV4u81U1e8vJ3kMfATXPsWwzG6fvusjDi7SCuehK7VTCC7/EZTpiBh6VMI16j78TzPDw==
X-Received: by 2002:a05:6871:810:b0:16e:104c:e243 with SMTP id q16-20020a056871081000b0016e104ce243mr4191173oap.21.1677980281106;
        Sat, 04 Mar 2023 17:38:01 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e21-20020a056870c35500b0016e8726f0d4sm2562166oak.3.2023.03.04.17.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 17:38:00 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] doc: rev-list: simplify escaping
Date:   Sat,  4 Mar 2023 19:37:57 -0600
Message-Id: <20230305013758.344573-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305013758.344573-1-felipe.contreras@gmail.com>
References: <20230305013758.344573-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<= is substituted with the unicode ⇐, but it's not necessary to use an
HTML escape to prevent that, we can just use a blackslash.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0d90d5b154..84c742aaac 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -970,7 +970,7 @@ the '--filter' flag and is usually not necessary. Filters are joined by
 '{plus}' and individual filters are %-encoded (i.e. URL-encoded).
 Besides the '{plus}' and '%' characters, the following characters are
 reserved and also must be encoded: `~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+
-as well as all characters with ASCII code &lt;= `0x20`, which includes
+as well as all characters with ASCII code \<= `0x20`, which includes
 space and newline.
 +
 Other arbitrary characters can also be encoded. For instance,
-- 
2.39.2

