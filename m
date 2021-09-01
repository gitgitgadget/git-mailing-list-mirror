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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB83C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BD760200
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbhIANcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244094AbhIANcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:32:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F0C061764
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:31:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n5so4498912wro.12
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=l4wJlBlRPAMXhwD+jzwqwSYZLkoTPG/4P8J+YiMohjgaOhExOBuOGkEyEIKUTRp2+d
         HWNXD0WJ0HB9QV22IbGMt7mc2ZjZjKR0/Y0OoN6Y8ZrYfPknm84U5FvDaHz9XTWGfDfh
         zDPV8WHSRyYsS6bUaTzgnnzXRdFQTX9e3CkpPOE7wrD7Fn0RGr8w++xUOG4YL9jgsElw
         G9KrSusHBm/scP5eY7fh6zOW6NFL/bG8zOR6qge4U+VyCtj7dHedNzAP1kKb/eDeNimE
         lYo3WRRwnjtOIyKa9SR4LMbZcKWAYV414Xia5g1wn3EVMUm4Vj0x4Tu28evA7elRu6r7
         7LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=EXXJ1LZv8FQwunfiZmTcsMNopRcoOMvzNlRH27UwQdhmZaPYnFveTT+9ZPyPFsZeHc
         AkRn+iL/xuRptTbo3Y8bNq/TtHhZJAojGYvIqqBaUmDfjt1V3a8fHcv+yUUQlFcmEpQI
         z+m5/KGRSaRVGtEWcrIn8Ve3YCqb9BsP5d/es+DYGQkgTDTUiKG1vtkQnNNv7IpzN9OC
         tyl1k7aAwqa3YEwRZQsHO+jzGhSJcHOt24U2D8cWdDCIJZIInxJCGmHKQjg3xOzd6mGy
         4PvP3EMXnQxe+d2kPIh0ZvgFmTqzjUx6i1NWcZtcGVljDbtI/VgUA2H++nLGgkTzLNJD
         WptA==
X-Gm-Message-State: AOAM5308CmGaLwISCexkNYEDGf2HztDX0NGA/cEvpxmywAFXnvVbb+KX
        tutyl4Tn0Fk8On4H1qTxQUvrhSqxVGI=
X-Google-Smtp-Source: ABdhPJz0lzeKIOBHzQPGdKFOolycvPR8M8mce08+aqZdQ8W1hNhDsUkEQCxfcRopR0s0pgdzXGHwyA==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr38738208wrx.70.1630503104787;
        Wed, 01 Sep 2021 06:31:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d124sm5382509wmd.2.2021.09.01.06.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:31:44 -0700 (PDT)
Message-Id: <2f566f330e01ed4249edad54671e98301dbeec5a.1630503102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
        <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 13:31:40 +0000
Subject: [PATCH v3 1/3] test-lib-functions: use 'TEST_SHELL_PATH' in
 'test_pause'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08)
made it easy to use a different shell for the tests than 'SHELL_PATH'
used at compile time. But 'test_pause' still invokes 'SHELL_PATH'.

If TEST_SHELL_PATH is set, invoke that shell in 'test_pause' for
consistency.

Suggested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..1884177e293 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -139,7 +139,7 @@ test_tick () {
 # Be sure to remove all invocations of this command before submitting.
 
 test_pause () {
-	"$SHELL_PATH" <&6 >&5 2>&7
+	"$TEST_SHELL_PATH" <&6 >&5 2>&7
 }
 
 # Wrap git with a debugger. Adding this to a command can make it easier
-- 
gitgitgadget

