Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F56C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhLIFPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLIFPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:47 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225CFC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:13 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y16so5309404ioc.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxquqGaM8TlYGQKnIwXy2Sx0LBZmFpI/LiJubjVh4eA=;
        b=EdAG6X05dXHqxv47tC0kpdC6qUopJsgXZvbd7cIOWtTuKHy2VCHgqOuKCsYc2H9q8I
         wTU3iI15Z7r+CSuGQkq08WN0zNmJzMnpnTmqgBgmHtmuGZcKwzoqbKYgEssb8wBzQKRa
         S2GN9ezh+0jsiRF5ETtsvDM5U1umVMNjEQmdagLU0UJsYy9SsseRi7TlwPbvduB1hX08
         G9MvxtCnG/H6iKQWd4EZSAVtAhWsaOai/j6Z5D7i9A+Drml4Mi/Pdv03IxYe8vT8Pc4e
         8gBIgFPlHfit+VfLxA8WzEwNJWLXydwmdbvGL1S4x/VFvqCjtTJuJQTRUYos6cBHJAh8
         TXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mxquqGaM8TlYGQKnIwXy2Sx0LBZmFpI/LiJubjVh4eA=;
        b=QhugQjEOWFg0avS2eDwbJWWCVX0INHlVEVh6CpO9Fa1m9/1cV9n8EH6MHyLCAsw7mg
         vK+K39bRZzoY6CMSbLZrFVY25tZ1W++3bEhOZu9vUVv9NWzOGvEgRoSKx7tpBHqkEbaJ
         CSqCn1pXEKg3OSxXROV0jcC8LaAOP684bhI32sGghOebXcraeEpWBmRTo+CBSMWmD+Qu
         39VNlcJyfDFpuZVvD5ozwlwNuJuvewoLTpRdIjGNbvYdg7r96Kwg6VEUWBtKriLlvsCu
         9j5d+77zGp453Fuqzg635XpRPCUkBhuEVxDvACflwaMyob8P2mqHCRtwO058zx8AsaFb
         BvDA==
X-Gm-Message-State: AOAM533qxhgSSA3sJcDK0zCNsTkAvUBmX4GFRmz+pKXSWb9r816fgmdU
        OHuAQIQ1phKdyZ8sC5b0YW462Xum6fAWaQ==
X-Google-Smtp-Source: ABdhPJyWVaJi5eO2Ykjekeo709yoBRbCDdHCWy3n2H24rYhcic2eJcxCc00poiBds9rFIZd0VK4v4A==
X-Received: by 2002:a05:6638:3183:: with SMTP id z3mr6074398jak.108.1639026731936;
        Wed, 08 Dec 2021 21:12:11 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:11 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 05/19] t5516: drop unnecessary subshell and command invocation
Date:   Thu,  9 Dec 2021 00:11:01 -0500
Message-Id: <20211209051115.52629-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To create its "expect" file, this test pipes into `sort` the output of
`git for-each-ref` and a copy of that same output but with a minor
textual transformation applied. To do so, it employs a subshell and
commands `cat` and `sed` even though the same result can be accomplished
by `sed` alone (without a subshell).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5516-fetch-push.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8212ca56dc..d5e19b54af 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1316,10 +1316,7 @@ test_expect_success 'fetch follows tags by default' '
 		git pull ../testrepo main &&
 		git tag -m "annotated" tag &&
 		git for-each-ref >tmp1 &&
-		(
-			cat tmp1
-			sed -n "s|refs/heads/main$|refs/remotes/origin/main|p" tmp1
-		) |
+		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sort -k 3 >../expect
 	) &&
 	git init dst &&
-- 
2.34.1.307.g9b7440fafd

