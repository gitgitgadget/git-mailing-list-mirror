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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD02C63697
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70C7246DE
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwN51CiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgKSPw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgKSPw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A737C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:26 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so6893721wrf.12
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1GgAmuFPRJYZ+FUW0eyYH5o0bmzoEDvVV5Hz6ckF9j8=;
        b=TwN51CiDsLbRdGqFdoBT0mraWO0deR6IaVnVN/E1ddybXIN3Nycu0DnVZkz8FVuRCk
         jwEURCwkQKpDart3ukUs+VTX7sA+iWk0nqBmkMo742/KjRct8YK+bAUiC2XUTnUTM+jJ
         LoPHpOHNOnFMlDU4h3E9WCA+mpFPJQiiDQMUhhXHsZEOWh4raIpTZYSLRyBChXi13NkF
         q/okd+E9YRVaFYC8s7uykss8tcLakN72BrTUS67FHENGxQcUebVzBfzpa2ypplHtLW0c
         FTtiGj2Ezx2kYEtDG6tFaMFDMuwjMIF/ZMY9ROlW0Urf9T7st1laWPC5cvdZLeTGFXkR
         PzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1GgAmuFPRJYZ+FUW0eyYH5o0bmzoEDvVV5Hz6ckF9j8=;
        b=g2jsVlzPVHp6OU4R7Mn2cS9vbSOax603Mt1PeKIZqg7kHyqLyXdANMMOJ8LMlbjH3d
         88RBWFodcPtGvyI9J3fsUdPCRxC6YkFyfN8g7EWG8ckrsj6/Cud1JEiKm1cYPLUDcWvL
         k3KQ0puxYcWVPAxGJmURfUbN/P76HNGNI7N/hb/i8oPErsgjqlPDYlv65dZhntg1tC4j
         ZjoXwZLv5GJunoJESii1AOHG4r78q/7Tu5cPlWjb/cDruVdiLRMkkBE2Rdt+fAiIi5vd
         NAxvcaLjNHt8sMlaTb3co6mQs10oEUdBDcbKBCTJFQpUrvhSC6CyiQryS74dsb47rMDQ
         Telw==
X-Gm-Message-State: AOAM530PIQVw49cXfOSaUJTRFQ/XPPLbitE9z+HISMXJOXyhLjQ3M7FM
        YZ9aoAu27emnEGOs3ePcjmtFjRvbNMo=
X-Google-Smtp-Source: ABdhPJwkmW1ggq2CYymRbr9oqEt+YClaurrgE8vWa/vUfe0Mvslr+Nj56WIaDeUjLwE4bebNyT4/+w==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr10865761wrx.196.1605801145120;
        Thu, 19 Nov 2020 07:52:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm148492wrg.95.2020.11.19.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:24 -0800 (PST)
Message-Id: <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:17 +0000
Subject: [PATCH 1/7] t1300: test "set all" mode with value_regex
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
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

Add a test that demonstrates these options.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1300-config.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..ef56b08070 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1914,4 +1914,39 @@ test_expect_success '--replace-all does not invent newlines' '
 	test_cmp expect .git/config
 '
 
+test_expect_success 'set all config with value_regex' '
+	q_to_tab >initial <<-\EOF &&
+	[abc]
+	Qkey = one
+	EOF
+
+	cp initial .git/config &&
+	git config abc.key two a+ &&
+	q_to_tab >expect <<-\EOF &&
+	[abc]
+	Qkey = one
+	Qkey = two
+	EOF
+	test_cmp expect .git/config &&
+
+	test_must_fail git config abc.key three o+ 2>err &&
+	test_i18ngrep "has multiple values" err &&
+	git config abc.key three a+ &&
+	q_to_tab >expect <<-\EOF &&
+	[abc]
+	Qkey = one
+	Qkey = two
+	Qkey = three
+	EOF
+	test_cmp expect .git/config &&
+
+	cp initial .git/config &&
+	git config abc.key three o+ &&
+	q_to_tab >expect <<-\EOF &&
+	[abc]
+	Qkey = three
+	EOF
+	test_cmp expect .git/config
+'
+
 test_done
-- 
gitgitgadget

