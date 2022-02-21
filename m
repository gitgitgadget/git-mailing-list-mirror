Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A9BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378347AbiBUOsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378319AbiBUOra (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2456315
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so1530280wms.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RH3YHdyRn6SczNP3Jk6YG7loMe+6cfAyl+F50M5kPPQ=;
        b=m5EKPW/wYpsPrh5ZFrzBXB0KVToNJIy8lh2jLJoUcOrebZHKO93xmKv25hxX9Y5UOQ
         X+ipRkXKPjk+LDgNw61fduTLW3N3V6gaQ1uRW4DOy/giY+cPOKQztW4eIAs5v4oe2tL7
         b/qfpyYieoMWNmjWBo64cKYnNg1FvhV/GZVipxAheXW5VAz/9uAIWDdf+7EuEIn/JN79
         QPmXy0KuFYIjn/xkdocW+OQ3YdN3Nz/gYGJu6KPVtB8MSZIcORMCF6oOowRFV/HrErLV
         TL2FarGDOz7smu9QhfERl3OySJ77GVfzMUJHO4Cms8p5KX2//q7eLeLKtwEYQJCR2Rh1
         K85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RH3YHdyRn6SczNP3Jk6YG7loMe+6cfAyl+F50M5kPPQ=;
        b=qbpuvDaP7bqbpqcs1w9UBiABP87B3kB8tHT3rq6I3nVW7yfRKs92vudW2D2ldAWF7N
         v0lOS8apnW+DOtvnb/xxVq3kiiTWbXjCnZ0w4bVaDjQ0jeJhgkWK6TrIPINBkNk+j5QP
         E04/EaAzqILk/aeLhM3+OZr80nz0WjyjUpMwZ72oFNZKqnk2b7msFVXEvSf6XvUJ4Oqg
         8kNDThPf6xIk22PcSZ06bR79a0XelS78X3gh3Vn5dTNaR54/SiPNAw7WmihPKEHX7IFy
         1+AXzJqJSmu/0SGByNvqHzNKhdPQ3qFHG8ugoM1XsVA7ohTjkpUMXjXjUdzFbkPMXo/A
         quWQ==
X-Gm-Message-State: AOAM533xxKzeAije0WRTwji9oMUW4INb+AFkK/XNag73eZAzmbpOwI4x
        j2pnrgEQsuO4YHvFEy6ZOiEB6rF7p0uePA==
X-Google-Smtp-Source: ABdhPJy6rLRuJelwNEYgzcqKIn2uVXlbKgNCnVbKjdTEvKygot6AO8WUFtSp0a7zHbn5NED7HI0VkA==
X-Received: by 2002:a1c:ed1a:0:b0:37f:a539:5d5e with SMTP id l26-20020a1ced1a000000b0037fa5395d5emr1871033wmh.37.1645454824513;
        Mon, 21 Feb 2022 06:47:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/25] ci/run-test-slice.sh: replace shelling out with "echo"
Date:   Mon, 21 Feb 2022 15:46:30 +0100
Message-Id: <patch-18.25-a6106525b7f-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend this code added in b819f1d2cec (ci: parallelize testing on
Windows, 2019-01-29) to stop shelling out to "tr", all we're trying to
do here is to turn '\n'-delimited output into a ' '-delimited list. To
do that we can just use "echo".

None of these files will contain the odd characters using "echo" might
choke on in the general case (i.e. '\'-escapes and the like).

This has the added benefit of not adding a redundant ' ' to the end of
the T-parameter, which didn't matter in practice, but as we'll see in
a subsequent commit makes for slightly nicer output, as we'll show
this variable using a GitHub CI-native feature.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/run-test-slice.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 70326961454..1de6a18ca47 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,6 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-make --quiet -C t T="$(cd t &&
-	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')"
+tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
+	t[0-9]*.sh))
+make --quiet -C t T="$tests"
-- 
2.35.1.1132.ga1fe46f8690

