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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD195C64E7B
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9BD20857
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usNLgULJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgKYWNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgKYWND (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:03 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20473C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so31012wrt.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q01KP/mClcYGI2iUyxCOeEO/qmWF73sd6QO2OzcB53o=;
        b=usNLgULJrIs+6fr8b2zqK9ccrEfnEblh3WUSF6zLySca3hactcTHhglIYpDqit9uzG
         eBX4TVsFuSQvQx8cJUgXtHOD+6x8DGVTsOPWvSxFqF+keteHmqbXFjp6sADo8/sxUs+y
         8OYhEgqS2H0fQRsPBnqDGmoZ5sOfsJAUpr3cjl5LvnnRhTwWZ8zSKKLKd0i3aDUkih47
         b1Pb0khvSSDN3GseCG+To/NJAFBKg27rSKV4x2qiTGwazG7QbsLZATBKbDOvbM4zgj9K
         X0WWenN0ytR4Uyneq/a9VaPre8x50sQqqmylBxrnCEEwVIjHRZ6O3+X8lxKBQiu20HgW
         /B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q01KP/mClcYGI2iUyxCOeEO/qmWF73sd6QO2OzcB53o=;
        b=pdRprFX4AYxJDeFoXidgDaTkk+ykaJg0+air53EXKJQVpYGyIjBz4aufyvOGDrb9Mr
         PA4KRvGBAhNTSxnNFZnwbHTGgedXPrF8KXDUk7DCeRQ++wXDEGElDld21ymQdrhTXAFf
         MRFWG+8fGhw1CbdA8pxbSb8iBVkEfEohLdo6JwgCM6Yn5Ir3JcAYY+UYwiRwCEb8oM2r
         ZuVcb+7hWjXaXIZyhbZ0QMHqb56//zKK31Kz1Dzslo/8Vujo4W5BQIIrG2sbQbd1GRVr
         l394ArO8VOMHDx7S/f9VJ1OkdBemX4nCsSSz+yss+cTFDE2ggc3VSoEklS2EFJzhZHrZ
         WqYQ==
X-Gm-Message-State: AOAM532e93paFOJU3mQ+aHwCz8Uo3hZHkHr1XOf22tdqXLvHhxt8d/6w
        TpAVLH3RkRRcrNWMDhxQYYinuy5sdYs=
X-Google-Smtp-Source: ABdhPJxeTVtG1x8oRkck3zUiBi+ce10EXg/dyvD970HAsLGIwOMlUkeUM+ZAvAzm2iAGEQdkOq7OZQ==
X-Received: by 2002:adf:e481:: with SMTP id i1mr48701wrm.282.1606342381696;
        Wed, 25 Nov 2020 14:13:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm6512862wrj.8.2020.11.25.14.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:00 -0800 (PST)
Message-Id: <3b72082326b692542f29a71737e2459a1ae12900.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:51 +0000
Subject: [PATCH v3 3/8] t1300: test "set all" mode with value-pattern
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

Without additional modifiers, 'git config <key> <value>' attempts
to set a single value in the .git/config file. When the
value-pattern parameter is supplied, this command behaves in a
non-trivial manner.

Consider 'git config <key> <value> <value-pattern>'. The expected
behavior is as follows:

1. If there are multiple existing values that match 'value-pattern',
   then the command fails. Users should use --replace-all instead.

2. If there is no existing values match 'value-pattern', then the
   'key=value' pair is appended, making this 'key' a multi-valued
   config setting.

3. If there is one existing value that matches 'value-pattern', then
   the new config has one entry where 'key=value'.

Add a test that demonstrates these options. Break from the existing
pattern in t1300-config.sh to use 'git config --file=<file>' instead of
modifying .git/config directly to prevent possibly incompatible repo
states. Also use 'git config --file=<file> --list' for config state
comparison instead of the config file format. This makes the tests
more readable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1300-config.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..72f930ada0 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1914,4 +1914,43 @@ test_expect_success '--replace-all does not invent newlines' '
 	test_cmp expect .git/config
 '
 
+test_expect_success 'set all config with value-pattern' '
+	test_when_finished rm -f config initial &&
+	git config --file=initial abc.key one &&
+
+	# no match => add new entry
+	cp initial config &&
+	git config --file=config abc.key two a+ &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=one
+	abc.key=two
+	EOF
+	test_cmp expect actual &&
+
+	# multiple matches => failure
+	test_must_fail git config --file=config abc.key three o+ 2>err &&
+	test_i18ngrep "has multiple values" err &&
+
+	# multiple values, no match => add
+	git config --file=config abc.key three a+ &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=one
+	abc.key=two
+	abc.key=three
+	EOF
+	test_cmp expect actual &&
+
+	# single match => replace
+	git config --file=config abc.key four h+ &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	abc.key=one
+	abc.key=two
+	abc.key=four
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

