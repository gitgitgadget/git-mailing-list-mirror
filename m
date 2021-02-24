Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C6EC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AE664EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhBXTy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhBXTxf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719FC061224
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k66so2911160wmf.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtJyhjN+eqrcJS5xBh7kjYEQfMWHO6hi9ZXIw2F5v3E=;
        b=XACqqRBSyMwrxAmuBOA1BEPw0CthKRb70FPh9QUT1Bjih9OrBnYsh1FjSXfa52j3+z
         TkjxM9BMNjCv0y2MWUoqyr++HM0wR7EFcMmERuxFSAd2Kb4sgET+dI3MmMsdY5QVBfU/
         7aKjzb+9q45eBG6sGi6O06Ef2UgPZbHUg+1gIzJ7N2XPmibvVwRxiYQ4KJSJxBtQ8aPm
         DZFGYfwm7WBUeAg06taXlZIWAZWGrSoJdgLCl0DmbUL3mLJVp95EP2BGMul/yE/9xCkp
         fQaSzU4ohOCVYzc2kLs0guRbdC+MKOBw/PMizFh1drFV5VuFtvhuNQP8sSzORyZCmdQ7
         ru2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtJyhjN+eqrcJS5xBh7kjYEQfMWHO6hi9ZXIw2F5v3E=;
        b=cUGWA6lN7RrKy78xRTuwT/1CZTE3Q6xLutFM6hZLP3MvUy8RE7+MEpaiiVPdcyxzT1
         JR/B5aREx+RB/JzXyxEMfRhCKfk+pXwcJj8c6z6HQPLjC25r4WAIq6rKq6NhppFZVTgS
         2axW+6pJZiwaAsT7EMEEssvGQcV2KtCL8jtIhOo4O/svaDsW10QJX8gRJ8Ph4fc5lwka
         0BUM7ruPAQYHByl5Zsi97oWv5BWT2S8BwzhSCh5K/wKAOEwfPZaXmGaSlEQbaljlSQT/
         QtrQBOnDlBQr5pot38rODOu9fhYv1gsHUCkFYOZPsc7o1lrQomTaqgju8doGSj8Dqn5J
         zL2A==
X-Gm-Message-State: AOAM532g4wmR5rEJDxdeNgntV9rj5uUcOLc/x5U3G6mZ/7+lLyydeOT2
        6HOzlsosoO1IBfjF0FkeWWniuaOQVD4e1Q==
X-Google-Smtp-Source: ABdhPJzmfAr4pKKOBlBB37hG+/egJCN1W/Obx9Po4VuhojhI+0oZRE1PKzqZo6NB+1I9UrIq7ug/Pw==
X-Received: by 2002:a1c:41c3:: with SMTP id o186mr5200722wma.7.1614196330525;
        Wed, 24 Feb 2021 11:52:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:09 -0800 (PST)
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
Subject: [PATCH v3 21/35] userdiff tests + docs: document & test "diff.<driver>.x?funcname"
Date:   Wed, 24 Feb 2021 20:51:15 +0100
Message-Id: <20210224195129.4004-22-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing documentation for "diff.<driver>.funcname" and test
for how it and "diff.<driver>.xfuncname" interact.

Between the introduction of the "diff.<driver>.xfuncname" form in
45d9414fa5 (diff.*.xfuncname which uses "extended" regex's for hunk
header selection, 2008-09-18) and when this documentation was written
in 90b94c26f7 (Documentation: Add diff.<driver>.* to config,
2011-04-07) we forgot to document the existence of
"diff.<driver>.funcname".

Let's make a mention of it here, we could also partially revert the
former commit and discuss the more verbose form in gitattributes(5),
but let's stop short of that. It makes sense to guide users towards
ERE over BRE whenever possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/diff.txt | 11 +++++++++++
 t/t4018/custom.sh             | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c2..6f39ef1da93 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -153,10 +153,21 @@ diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
 
+diff.<driver>.funcname::
 diff.<driver>.xfuncname::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
 	See linkgit:gitattributes[5] for details.
++
+When provided as `diff.<driver>.funcname` the regular expression is
+interpreted as a basic regular expression. With
+`diff.<driver>.xfuncname` it's interpreted as an extended regular
+expression.
++
+The `*.funcname` and `*.xfuncname` variables behave as if though they
+were one configuration variable for the purposes of what value
+eventually gets used. Setting `*.funcname` will override an earlier
+`*.xfuncname` and vice-versa.
 
 diff.<driver>.binary::
 	Set this option to true to make the diff driver treat files as
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index b208a771d28..72d38dad686 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -77,3 +77,37 @@ public class Beer
 	}
 }
 EOF_TEST
+
+test_expect_success 'custom: setup config precedence' '
+	git config diff.custom.funcname "foo" &&
+	git config diff.custom.xfuncname "bar"
+'
+
+test_diff_funcname 'custom: config precedence' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+bar
+EOF_HUNK
+foo
+bar
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: setup config precedence' '
+	git config diff.custom.xfuncname "bar" &&
+	git config diff.custom.funcname "foo"
+'
+
+test_diff_funcname 'custom: config precedence' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+foo
+EOF_HUNK
+foo
+bar
+
+ChangeMe
+
+baz
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

