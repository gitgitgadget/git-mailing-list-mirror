Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F30C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55D264DB1
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBOQBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhBOPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA56EC0611BE
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so9461789wrx.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BV10sIBUQ56+QURKfgJa7zquwqXXPRRrJ9gHRVn+R/w=;
        b=VZeuT8yyH81Ntp7LCieF7Wop0Rw7wMzYI7ROIi++XkGrGQUmfiVAoLIfQZ+3ZLT+I2
         x/YR7Tfd6ay57lGvb2IRIPmTKJuZVpR2CmdY4KChL9iXrpO+MYJ/KoHA37mGrto9oNrx
         8G3IIfVsw2tlDcew5lkxgAVB+s8bK1NKytnOFLGNJ+xM+g10F/1S9NaiJY7XLZLp8WPw
         KRahCmgi0diHT61hBUvhLQwpTRuvGLopPZqZsshoi/zXgTf3Wyp05EBWnhTu3+vQR2it
         TArgxzyMhGuO1QFcOFSs3J/K+QW+cEX8yR/k4emMZWmvsmdwEIlnNEeXjUwHfnmTVoO0
         Jsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BV10sIBUQ56+QURKfgJa7zquwqXXPRRrJ9gHRVn+R/w=;
        b=kgklnriLTymaocDrkClDzEIZgdp+bGz4XnAy2AFO71Ni2+3zgPmRzJfRn/KlcAZxEv
         BgUIrOBLyYkPMSY9fxtXE6/nIJNrRKE0dpD0078Dzltp4gJOylY4e96dgIXC4TIvid/M
         sZaVT4UB8xmNeGq+QBreUQeBa8TsPR/s+l6r9aek+s+8PzEPCpAdp4SmiltTdbleG9S2
         F16LO9dfFxTpfjCNGXt5WiuLMweFVtlVImBZGsd0+PopUvnuziwHMMlrKsNS8wkaUgCq
         9Lagk48klQwIn7BeRCaQ5ddhRJPq0OMFRR7tU2oJKo5rA7X61rs7u7gJ0Y08aiXFb0fO
         5/4A==
X-Gm-Message-State: AOAM532rwY3fAJlnErM+kPKFb5nRi9O2c5BVcLPqQ0n1c8z3FWJP5sMg
        f4j79X4gEnpFc4WqGFI8lmtmu165d0A3sw==
X-Google-Smtp-Source: ABdhPJyg3NtOCXxYnKlrRTXOb0i5qpVkRGJFmE7+zWxeD035+TZGxIb9hKCz516XxPx1CTfZooZnTg==
X-Received: by 2002:a5d:4583:: with SMTP id p3mr19642899wrq.305.1613403905504;
        Mon, 15 Feb 2021 07:45:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 23/27] userdiff tests: test hunk header selection with -U0
Date:   Mon, 15 Feb 2021 16:44:23 +0100
Message-Id: <20210215154427.32693-24-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The userdiff tests have used a custom -U1 context since
f12c66b9bb (userdiff/perl: anchor "sub" and "package" patterns on the
left, 2011-05-21). Changing it to -U0 doesn't change the results for
any of the tests, except one.

Let's test for this case explicitly. I.e. that we go "beyond" the
selected context to find our hunk header. In many cases the desired
hunk header is part of the diff itself under -U1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 13 +++++++++++++
 t/t4018/custom.sh        |  1 +
 2 files changed, 14 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 8b4500037f..d41aed9ba2 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -57,6 +57,7 @@ test_diff_funcname () {
 	cat <&8 >arg.header &&
 	cat <&9 >arg.test &&
 	what=$(cat arg.what) &&
+	arg_diff_U0=$2 &&
 
 	test_expect_success "setup: $desc" '
 		cp arg.test "$what" &&
@@ -78,6 +79,18 @@ test_diff_funcname () {
 		test_cmp expected actual
 	' &&
 
+	test_expect_success "$desc -U0" '
+		git diff -U0 "$what" >diff &&
+		last_diff_context_line diff >actual &&
+		if test -n "$arg_diff_U0"
+		then
+			echo "$arg_diff_U0" >new-expected &&
+			test_cmp new-expected actual
+		else
+			test_cmp expected actual
+		fi
+	' &&
+
 	test_expect_success "$desc (accumulated)" '
 		git diff -U1 "$what".acc >diff &&
 		last_diff_context_line diff >actual.lines &&
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 886de9cddb..a090f7bfc2 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -10,6 +10,7 @@ test_expect_success 'custom: setup non-trivial custom' '
 '
 
 test_diff_funcname 'custom: non-trivial custom pattern' \
+	'System.out.print(x + " bottles of beer on the wall "' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
 int special, RIGHT;
 EOF_HUNK
-- 
2.30.0.284.gd98b1dd5eaa7

