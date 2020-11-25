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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C9C64E7C
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A8F206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQUv1XDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbgKYWNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgKYWNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE0C061A52
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c198so182704wmd.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zo3dkwqLduSB1lZ4v/CnmsRkQOh94CpIBzBmg4Ha3J4=;
        b=vQUv1XDX5KoJa3ndT9QzcSq/z1Lf0Dg8OVXAhneWlDsBv1U5Cjk6KpTk4WM1Ldf5er
         CXWLsc0M3kG47Mvz7TxwuXUlRlPsiX9GjFGBMn6e4i2idArmnJqD+LtSSPKwGC5E77L4
         NeSY+Y7qGCgBYaQ7QVydHugAQVvrsCZqrJC1IwQcMvOBHFK9htwU4BxwP3gqQhptX9yl
         FvpHYMlW2G8r71v24nJP8Dw1RoQgr2NserLaYWcFtGcQwOaWRP38dlp7ulpN0oZlkDrJ
         jSF14/p0ntHrbO4rxT+FiXNXiskiAxvQkRkWIIXvvVsvORsigaVEdDP+OAFb1IV90MJN
         gnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zo3dkwqLduSB1lZ4v/CnmsRkQOh94CpIBzBmg4Ha3J4=;
        b=lBukxsYX3GMMezonikMG5EOsp4PAlz8DkC4J0PA1aF5VBLJb9t/e0BknyHINfcd+88
         ZSNY79R08a/zrL2xMHH6jjpBLXns8r5gscEWy1EPcQ36xK3A6cLKDgIht5sAHmGms8nW
         5BK7WwgfpbZXScIjyPjyEZNva00gO4YiCOw+JvfOyVlWACUE0Yp0tpA4jVjKzufFKRnM
         lgbRpq3kW7eAoxyZmaeQuLUuen44JBknhH5WLbAcv76ItsQwxm91+bt+wxefJ5G9UC+a
         LFjX2GEUfdUwEplxO48ZxGF5M9OYLR4XcVJCfqkgvjihAr7fypi1d5PF9CPZP9QPw9BW
         1oWQ==
X-Gm-Message-State: AOAM5338kSoGff0/OjHR4ZlhwNBVwhSa63ZNfaRUg4EN/T0TejJjRsH0
        75/y10oKhsReUnTNmKLG0i8zQXfvYjU=
X-Google-Smtp-Source: ABdhPJyQbrUSdmRh5eZ44Mm0nbfFMQvhBX2Nph2jMtbcV+cG8+yJNDDgafM2j5Mj17oeC+YUlKEzsA==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr6225084wmm.89.1606342382619;
        Wed, 25 Nov 2020 14:13:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm5954846wmn.19.2020.11.25.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:02 -0800 (PST)
Message-Id: <75fb74da8324674194cca2b27fc4e6c0fdc6486d.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:52 +0000
Subject: [PATCH v3 4/8] t1300: add test for --replace-all with value-pattern
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --replace-all option was added in 4ddba79d (git-config-set: add more
options) but was not tested along with the 'value-pattern' parameter.
Since we will be updating this option to optionally treat 'value-pattern'
as a fixed string, let's add a test here that documents the current
behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1300-config.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 72f930ada0..040b9f7506 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1953,4 +1953,18 @@ test_expect_success 'set all config with value-pattern' '
 	test_cmp expect actual
 '
 
+test_expect_success '--replace-all and value-pattern' '
+	test_when_finished rm -f config &&
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

