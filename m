Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80023C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIVDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLIVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:03:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BCAFCF3
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:03:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m19so740907wms.5
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNZVZYk6ZxxEc1liZnb1SY6e9Ix2+tBiM5EaThu8Enw=;
        b=ToZtofbbVUV0k6a32N96GXvuU51xNEIQu/3qPdqKc7+sIpfRtJOEvgymuELBPceizm
         kl8WC5/5h1MlVTqCfzNKQ+b9kiGkmtjL3qHck/fLQG+06ZfiM8NpCHmWPIJdKcbvbi5C
         lKbRE7oXAQfvgsLGN+5iH90XkL4Rnynh8stI2hd9Wv2VUXlTM2bCbFXHGkYLIhJH1fUh
         txcvRyhGI0IwDhoPfV5dR9AuFHZgjg9q1r4yVBoGZchChSuANkozGHim88ri3MGQUCRD
         NdLw+sfVARs+LKNOKvxvvajBORJKVWxYPyfwQMtmgTfsLNAnATc/UhbjGEVAs1Ct/YZe
         Hl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNZVZYk6ZxxEc1liZnb1SY6e9Ix2+tBiM5EaThu8Enw=;
        b=QdJtEdghiUScizPwhikb43yhIOBlY3Rmbb+G2JZ4MGp/4l46whdO82l4Tb2K7Xs9bj
         jpZ50tObuGXvMvyOTArF3ZiLU0zLCPJRaNc0JMZOyFMfRAHhS1pCLgXo8X42sw+FObLr
         V5Du0wjgu/HjxuR43ViHgSQ7QZd57jk/foLpB+gYQEnYEuhAPQCu0KajGYZG9R4tn464
         j2YyTvoWncQ4SgamMX/yZjItl52h6s8/YTCUdOuZO2IIm1guEp6AICHqR8DX3WtRg4up
         0wQTicTAX/ovDYz8/MG5GqSN9JvLuo9a1cMEN4JjXT/E/cyUmO72NWxCP0ROVRGFQIlJ
         2WgA==
X-Gm-Message-State: ANoB5pnyJXliq/ARhWcSEDfBKZcnwgkYkSdk33Xicwh1/GKKx9TR/2uc
        VCdmiXoEVNsfX5oqUkM00uJkgG3mktct6w==
X-Google-Smtp-Source: AA0mqf7XPfXIazs09gQQDPF0DRTbBdPQYyec2wZYSwsJyeHQAe3Wd8v+tB51GodbkyVduQwvlEKhcA==
X-Received: by 2002:a7b:cd18:0:b0:3cf:9ad3:a1db with SMTP id f24-20020a7bcd18000000b003cf9ad3a1dbmr6160741wmj.7.1670619807355;
        Fri, 09 Dec 2022 13:03:27 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003c701c12a17sm887838wmo.12.2022.12.09.13.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:03:26 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/2] t0003: move setup for `--all` into new block
Date:   Fri,  9 Dec 2022 22:03:20 +0100
Message-Id: <20221209210321.709156-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209210321.709156-1-karthik.188@gmail.com>
References: <20221209210321.709156-1-karthik.188@gmail.com>
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

