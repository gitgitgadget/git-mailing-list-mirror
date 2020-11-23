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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ADDC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339FC20782
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJqYv7at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbgKWQFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgKWQFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:12 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F317C061A4D
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:12 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so19172700wrw.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BLK6DLFzBwpO+LuZ0Ay+j8PSkKIKU2e15/ivFjqhNC0=;
        b=sJqYv7ataN7TJTF3/gdOZ+enzeYlrtQ0W7B2LcC7mIAme6EJ4XKN2SbUlMOp50d+Oo
         wUien6GDrt94YqW1wlqXyg4SA36cnCurRI7QzMkOmjcIu9j3fXFbnB0cKQIObsz55y03
         q88ZV0OXnW91S9wRcRjtnKPBSg41e2NLHPAUO9u8ZhJQj2/+EcgR52/TAKmfwzKUmRaq
         ziAYA9F5PtbCKn4k2pWIR5k4Q+19+1wBO+LK1RHmgHo02xWd7cAjGPsJ71+XTOERfE53
         CdzhqnLGBg3t6cQKnjAwPXlbZ/W5Rsf7jayed68g7DlCE57wpYbULYA0mTC6zB7LpFM3
         aIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BLK6DLFzBwpO+LuZ0Ay+j8PSkKIKU2e15/ivFjqhNC0=;
        b=PTDH3ajtjLm9/O9Gu+1Fb6ixIJo/cVPfm78MeCFac9f/R5bslp7gZHWT4D1R+r4sj6
         4RQurqdYhdQD94/wzQjIUOEWTwpUg2TyIJXhqs0lFedcBAg5nLH55KYvhN/t3lnCb8Ek
         uH1ORvKehzSrSRwcOm0O/Clk2piwXunMrQZx7OtNanvOkzv8c/caQJMnnJLlSc7M2yhC
         nzNMsavmvVXs2kanQ6riE5NcdnkG3YcvfVr52lBXc2ZvxMlhYEzNQQTgXf1zJ/AuAsRv
         Awy6nLtd5OreRbnrL+OJyeNiFh8/M45e8si0cwGjtp4n3/U2DAHYd2vKGZr6hKpkoiH6
         Mhug==
X-Gm-Message-State: AOAM533cBzDb6LyXn40bu6/DrvRYsZzYtQtNzGxYY3WDIYPApXwddAV+
        +lg3hlB1sV3vRtgFVTykKeqETkh921I=
X-Google-Smtp-Source: ABdhPJzMkHJ71NVKDbnJ4zotTzuC4Qj3X/AjJy9G2kRAIQ8BJo/NFsvwH89i78PlcaAyefR3Hdgwaw==
X-Received: by 2002:a5d:62cb:: with SMTP id o11mr374433wrv.25.1606147510956;
        Mon, 23 Nov 2020 08:05:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t136sm17802156wmt.18.2020.11.23.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:10 -0800 (PST)
Message-Id: <ea3099719c867a5a475468ddb6741bbcd713dccc.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:01 +0000
Subject: [PATCH v2 1/7] t1300: test "set all" mode with value_regex
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

Without additional modifiers, 'git config' attempts to set a single
value in the .git/config file. When the value_regex parameter is
supplied, this command behaves in a non-trivial manner.

Consider 'git config key value value_regex'. The expected behavior
is as follows:

1. If there are multiple existing values that match 'value_regex',
   then the command fails. Users should use --replace-all instead.

2. If there is one existing value that matches 'value_regex', then
   the new config has one entry where 'key=value'.

3. If there is no existing values match 'value_regex', then the
   'key=value' pair is appended, making this 'key' a multi-valued
   config setting.

Add a test that demonstrates these options. Break from the existing
pattern in t1300-config.sh to use 'git config --file=<file>' instead of
modifying .git/config directly. Also use 'git config --file=<file>
--list' for config state comparison instead of the config file format.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1300-config.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..19836ec83b 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1914,4 +1914,36 @@ test_expect_success '--replace-all does not invent newlines' '
 	test_cmp expect .git/config
 '
 
+test_expect_success 'set all config with value_regex' '
+	git config --file=initial abc.key one &&
+
+	cp initial config &&
+	git config --file=config abc.key two a+ &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=one
+	abc.key=two
+	EOF
+	test_cmp expect actual &&
+
+	test_must_fail git config --file=config abc.key three o+ 2>err &&
+	test_i18ngrep "has multiple values" err &&
+	git config --file=config abc.key three a+ &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=one
+	abc.key=two
+	abc.key=three
+	EOF
+	test_cmp expect actual &&
+
+	cp initial config &&
+	git config --file=config abc.key three o+ &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=three
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

