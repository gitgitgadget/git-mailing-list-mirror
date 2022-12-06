Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33AC47090
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiLFKiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiLFKh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 05:37:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902C31A230
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 02:37:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t17so5188014eju.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 02:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNZVZYk6ZxxEc1liZnb1SY6e9Ix2+tBiM5EaThu8Enw=;
        b=XFPV8J9I94fmU2b8iIXvCdfgCannqXZ7nKK/8koUeXAOFQe8zjryPk4EodM42/AVNg
         EZl5aLq5ulOQIUSZ/5uiAK4hztiTJ8h7NSzjO4SBMlyLDvVVc41vo7dqD7BLigJ2r3/k
         eGJkw5mEz3z/lPy4P8T8R9usoNVWxwSezzdtq6unAI35xQ9bFyPyt4WVtrpVwp8ejjRc
         7tVuVmNn3rTZVfvjV3Q81aT0ND4BqdMgRX0c3BkVAxXxpAH0xGQaAbxUnzXoTRZWfEMI
         00fLM7Y7oiTuvWVIJwVa4YyEtMBVqC9Md9Uo4SsXzN1QQ9Luf+Wnk81wR0zSVpXzL1q8
         mIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNZVZYk6ZxxEc1liZnb1SY6e9Ix2+tBiM5EaThu8Enw=;
        b=XMKypSQdkPLqYLemCuGUYQ3mwYkaSSO7gnuwaLvV/Xr5CxSHgoh5zrZFu30Q01xZVE
         G/FLhF08UW+YE4ef1UZYjiSu4FnBmD+xc1l8Vl6pubf6POUIGbYpHOKj5aRAOyzu/p3S
         JfB7nHq/uDTKWCiiCidT1o8A24fcH7dugAj0a4TGYjpf8UKUPxcuurd9CJcrPJ1ZrzMt
         EfZmb4HNXVPtEg69KCdWqySA0ZYTR+fU7TgZKINvxe76BIGpqOMW4j8GsSLjnxQppUOS
         f6VJuhe5L6O2p/sIUkCrFEr7TwHeq6BnofCBRIS0bCvElzUD/4W7+sweWJYlHLOisJ3w
         vmCg==
X-Gm-Message-State: ANoB5pmz0e5aXULH6eunL+uNxfa7ZvR3X2h8CN+vZ2KlF3WE5szcQ0MP
        ciGS84CrkB9mhD4Z9uoHzh+e4ioLIshM5A==
X-Google-Smtp-Source: AA0mqf5ZliFPecZM4BRKzquD4vehfGGmQu0BW2XMpUuTL5QmuiEaAfD5W0wx6OhCGlQmXcE6e3HrQQ==
X-Received: by 2002:a17:906:4c98:b0:7ad:b9f3:a66a with SMTP id q24-20020a1709064c9800b007adb9f3a66amr58759079eju.282.1670323075714;
        Tue, 06 Dec 2022 02:37:55 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906698900b007bff9fb211fsm7221035ejr.57.2022.12.06.02.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:37:55 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/2] t0003: move setup for `--all` into new block
Date:   Tue,  6 Dec 2022 11:37:35 +0100
Message-Id: <20221206103736.53909-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206103736.53909-1-karthik.188@gmail.com>
References: <20221206103736.53909-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is some setup code which is used by multiple tests being setup in
`attribute test: --all option`. This means when we run "sh
./t0003-attributes.sh --run=setup,<num>" there is a chance of failing
since we missed this setup block.

So to ensure that setups are independent of test logic, move this to a
new setup block.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 t/t0003-attributes.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f7ee2f2ff0..b3aabb8aa3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,9 +203,12 @@ test_expect_success 'attribute test: read paths from stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'attribute test: --all option' '
+test_expect_success 'setup --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
-	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
+	sed -e "s/:.*//" <expect-all | uniq >stdin-all
+'
+
+test_expect_success 'attribute test: --all option' '
 	git check-attr --stdin --all <stdin-all >tmp &&
 	sort tmp >actual &&
 	test_cmp specified-all actual
-- 
2.38.1

