Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474BC6379D
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EDD2078E
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWenVaJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbgKWQFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgKWQFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113EC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h21so17737272wmb.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fg/2Sdn3NbNMM0c7lOw6XNDPCLjgLRzyoI03OVgAd0k=;
        b=fWenVaJM0tbv+uWjrx+dGXz5uLQ8Trgxn4y1pCBtcGEp8616C2o6OQ8lKSvViZI+fv
         zW7Q5Wl/Q9hqLCCxGvN540OwVVnt2LeP+UQNRDKOXFvX5b2BhNj0ug5JEN+zroDl0AUD
         Ul1eV1G/sbT13juzemACJdRGwAJPqt5W/cEFATwGP4CLOBJYXiTivVVJ+nU7L0jzi1Dx
         GlAG9xJCiO4Pzim/INheA39l+Qae5Pzca8q5HYI998AuFGwPE5tn0MVdoWBlyCeqltNd
         8D27sh+sgaNgiKwweTWjnirqh6dpl0+guDW2hxY332YooCgD8DkyEY1gmNJ/jH/SxGbh
         PFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fg/2Sdn3NbNMM0c7lOw6XNDPCLjgLRzyoI03OVgAd0k=;
        b=IMMOUABSEh8EsFZ5U3NvvGiLxXsVoT8EPJOvB7p7BTOFPhexIegBzigRrIH97/jkC/
         dp019bfcF4ci6vgv6nA4bdtBjkvAU2CE8C5xI4iK5sQMg4gmj4MVe9XsqE8k/01+lRFw
         lQ0JfGQui3AsGtnLSTw/GQXmBbP/kGRWvZKV23AOl8mq6F6P/J9O5HHk3QeB3q3+QdC7
         vf4ZyEY0kSiS6P1+8VkrxEZU0OG08u48pa9Voeb0jBGGfl7GqBlcfCPyA8vB3Cj7R7rZ
         z6TLEeKfkH1Xn4K31Mt/HSeqxeTmWpW7K1BKQJOxasxEMB7blfUsdAQ/YkJN5xHByVMX
         5m1g==
X-Gm-Message-State: AOAM530a/i4MksT739P5Bsd4RWVEs8EzOUpYiSVQCq8cof6YAObrfiOs
        n4z1A8Fo3uFKfhKHwGrsIcyCqk/SEvU=
X-Google-Smtp-Source: ABdhPJwVaCOixj4SL//FN9HLA7v9ubwqtXAsCtD7SW5AwNzVk1EGF/Jetn7i9js8/rfWHNo9cBnsbw==
X-Received: by 2002:a1c:a445:: with SMTP id n66mr25545165wme.51.1606147512096;
        Mon, 23 Nov 2020 08:05:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm20165777wrm.1.2020.11.23.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:11 -0800 (PST)
Message-Id: <829d0ccd8c6ae52e78eda52b15283867a0be673e.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:02 +0000
Subject: [PATCH v2 2/7] t1300: add test for --replace-all with value_regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --replace-all option was added in 4ddba79d (git-config-set: add more
options) but was not tested along with the 'value_regex' parameter.
Since we will be updating this option to optionally treat 'value_regex'
as a fixed string, let's add a test here that documents the current
behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1300-config.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 19836ec83b..8783767d4f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1946,4 +1946,18 @@ test_expect_success 'set all config with value_regex' '
 	test_cmp expect actual
 '
 
+test_expect_success '--replace-all and value_regex' '
+	rm -f config &&
+	git config --file=config --add abc.key one &&
+	git config --file=config --add abc.key two &&
+	git config --file=config --add abc.key three &&
+	git config --file=config --replace-all abc.key four "o+" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=four
+	abc.key=three
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

