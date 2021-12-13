Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E127C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhLMGcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhLMGb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:31:59 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD5C06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:31:59 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so17196259iol.13
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjmiBxNJ14WLAMJ69Bk7Mc2PPGKV1OaRxla+zsh+NhY=;
        b=X9Hm9Il2UEVSO3Xw6cl32F4DI+wNsqFaWTki08pAmsquegPgOIMz4zLImhWPDYLq+x
         XyUSyNHtnLFr4F/1e1PvnbZ+SdUpbEniw/+z9cTYNdB0hKVvq6zQAgEjP78sioGkLpZV
         qlTTF6n94WZrgUb7E/f6+2AS3sq79+tCgyNmYxaeqWWiDN/vJh2Mr4AdP5U2RAEhreK8
         Uipc+gXQfp2EsL36wFOQTH4oov2mmuS804+/ACCXoIkjpZhPg2gEEJQBpLFGfBlK7VSc
         XYSo48fjA9ejW0ciEAMsKZsdGwf8ryEuAt4Uyyn2NIsxFu7UBHh5/zcCtvPFtpYPiTiO
         hnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qjmiBxNJ14WLAMJ69Bk7Mc2PPGKV1OaRxla+zsh+NhY=;
        b=FZCfWhnwbQ/gWYbWA+e2qarvJ6vacOGxHwaUzyikxO4sRu/MlsXMCAPyRubQZEGoMv
         vR1APIai9RKcTUZs+7D1JuDyxE2NIL2avaZH/TLaXiUrpZVOTlSDl4iMp5fGkGCjWWFc
         ZmDFwHiHlPEDdd0uKeM/N0tfBI7EtFejYHFmIflmeQNNz3Cy0XJEs35N0eqHGQMYBiEA
         3pStq517nOcRsbwt+i4oKZadTB3bj2Qjf0/7j72o5D5sfexMK+CcsF/Pz4tO7kLuPY0f
         7h9aGOaQwVrxc7JpdWE53BDY8p2UfNTwMaelSmJbol+uVMkarNe/W2Mp3fWZZCyKExZ5
         vfgQ==
X-Gm-Message-State: AOAM530tNTZsjYGZ3Vs5h3LpaND61LCulnYdo3pS99Q5+ukdAPV3tXKJ
        Pn1QnTxG9gWIQrz+jG6OuWwO6nTZJ/dx4w==
X-Google-Smtp-Source: ABdhPJxDWvyY3Pxsf4biiRORuuLeKPXXU8obtR+yftojZGdRO8U7OdkaXUFa3zPIOXe2hLgkLom1eQ==
X-Received: by 2002:a05:6602:1813:: with SMTP id t19mr31705144ioh.135.1639377118926;
        Sun, 12 Dec 2021 22:31:58 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:31:58 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/15] t/chainlint/*.test: don't use invalid shell syntax
Date:   Mon, 13 Dec 2021 01:30:45 -0500
Message-Id: <20211213063059.19424-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The chainlint self-test code snippets are supposed to represent the body
of a test_expect_success() or test_expect_failure(), yet the contents of
these tests would have caused the shell to report syntax errors had they
been real test bodies. Although chainlint.sed, with its simplistic
heuristics, is blind to these syntactic problems, a future more robust
chainlint implementation might not have such a limitation, so make these
snippets syntactically valid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/if-then-else.expect    | 5 +++--
 t/chainlint/if-then-else.test      | 3 ++-
 t/chainlint/subshell-here-doc.test | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index 5953c7bfbc..a80f5e6c75 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -4,6 +4,7 @@
 ?!AMP?!		echo very
 		echo empty
 	elif test -z ""
+	then
 		echo foo
 	else
 		echo foo &&
@@ -14,6 +15,6 @@
 (
 	if test -n ""; then
 		echo very &&
-?!AMP?!		echo empty
-	if
+		echo empty
+	fi
 >)
diff --git a/t/chainlint/if-then-else.test b/t/chainlint/if-then-else.test
index 9bd8e9a4c6..d2b03ca6b4 100644
--- a/t/chainlint/if-then-else.test
+++ b/t/chainlint/if-then-else.test
@@ -7,6 +7,7 @@
 # LINT: last statement before 'elif' does not need "&&"
 		echo empty
 	elif test -z ""
+	then
 # LINT: last statement before 'else' does not need "&&"
 		echo foo
 	else
@@ -24,5 +25,5 @@
 	if test -n ""; then
 		echo very &&
 		echo empty
-	if
+	fi
 )
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index f6b3ba4214..0cce907ba8 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -11,7 +11,7 @@
 # LINT: missing "&&" on 'cat'
 	cat <<EOF >bip
 	fish fly high
-	EOF
+EOF
 
 # LINT: swallow here-doc (EOF is last line of subshell)
 	echo <<-\EOF >bop
-- 
2.34.1.397.gfae76fe5da

