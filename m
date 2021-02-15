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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4BBC43381
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2244864DBA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBOAzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBOAyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523FC06121F
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o24so6468419wmh.5
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCghpJlZ2OVn7dkq4uUPkFvjuzk3NRxS3G8KglSm0vE=;
        b=TOnA02VoJ4SPohLinhoXaE6sRKKD3R5ro96E9b+UHpYZy2nCUXfbJnoBuXqNC7Vp+E
         u+UlrSRpTKhwvhrcI0GV3UPZfEW5xfrHfqV4JsjXUmzAg7IcEzOVkmrd4Qq5BwNVrm/g
         pU8H+mmErbSs1ecyWZcOv8Hegu+ftVjf2APo4DayRXUPDuN19yYXzZ0Fd4z0BirFq1xO
         GSuJLSr2Ja+KZCtBMFTm+upP2kSI7wwFB/ktSiZsBzbZ2ykCBN8vH6dUcFYQbZ0Ov75r
         CSmu+7PqOTm4y6rgQnxgjnpyzfr+2Uay7L8tozByln3zYtEms14ofdP07hZT4Ek/EK+x
         QdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCghpJlZ2OVn7dkq4uUPkFvjuzk3NRxS3G8KglSm0vE=;
        b=rHUkkWFtd8lTII16aJGBxIl2RVaFjAw/kEKf1o3Wbt4ZMvcaTsFk800KK5o0DeligE
         99qWfgXj+nHMOvPHTUDHnFEU5SQQkVzLY+ieqG0/CjhSsagn47s3IvyzpK7HBSSrykn5
         apEGOgirsoSYV9IOZeWDHNSZUfsUc8TT1busZu2i0SjoIGN11POft16ReR+iYhYZF7Vb
         6vvhIE0pUGsxuLF16EBOh50vhzqNhrP76+KS3hki3Est0yyeLP+ztp/VSdK2ZNm7qees
         BzjFdm1zvpPtFpXokJRudqGwEPh37PvLpPvG7kT70ZPcNA8wEkBPXUby8q8PEEabI/T1
         t09Q==
X-Gm-Message-State: AOAM532LG1/e1NDFRizDnECMQR8ktd4D76VD37y87k+aDPYC15QPuKlC
        u2PPGqU3JcrzMaaGNdtGRiiUnKQoVaB50g==
X-Google-Smtp-Source: ABdhPJyyA09x56SAWDmMnkSGSbLpNNdn7JmKYL4nwysy6fqRfU7pTSy2f+kWYZzF/U0e6P6dVMDb9Q==
X-Received: by 2002:a1c:2cc5:: with SMTP id s188mr12281083wms.9.1613350394437;
        Sun, 14 Feb 2021 16:53:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/20] userdiff tests: test hunk header selection with -U0
Date:   Mon, 15 Feb 2021 01:52:35 +0100
Message-Id: <20210215005236.11313-20-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
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
index 0d75d93c69..94026b8296 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -63,6 +63,7 @@ test_diff_funcname () {
 	cat <&8 >arg.header &&
 	cat <&9 >arg.test &&
 	what=$(cat arg.what) &&
+	arg_diff_U0=$2 &&
 
 	test_expect_success "setup: $desc" '
 		cp arg.test "$what" &&
@@ -84,6 +85,18 @@ test_diff_funcname () {
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
index 81a68aa332..605e2d33ae 100755
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

