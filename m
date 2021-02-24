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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0439DC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B371764EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhBXTzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhBXTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15921C0611C3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3so2804629wmc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pw0jiAt1I2gW1fsZvZD72j6GVu7NokPW1exD1z5oArU=;
        b=r4isYiN95m0o5h/fy1hfzobYAFEjAPUN0nareo/1kmA80dIRLc75qWm71WiO3bNaja
         9Rh9LXie4IuAQaJZp2kAESJB/GLeZKd9t7R5Xcuj25Zc4aqf9ka+KpioXvkfC7KmTUCc
         uUWHfMIohxFD2Jg5zE1ISkkwtuG4kVPrxsuNvjBdTM4/qaOua8znn06pRX2Z64/O9I1c
         4QTB6cI0rPzMIzN7bUYRHLByKOlh8NVAXy67ROlGiPcz2QIkAb+wcE1n/NUCBc8fhcDM
         Ndreay21D0xq/yaTvK8P4zop/LXvFZVnQwYT46ctAHOVCpRe5Bl7n663VjqSNoc6C9Aq
         O2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pw0jiAt1I2gW1fsZvZD72j6GVu7NokPW1exD1z5oArU=;
        b=gJ9Md8UCxg/cXwkRwe1msnJkOcnhYxPF2x7A6KOsTh7NTGsdDnC6UjsDqpF+mVdXcp
         A91d3WqifN+jC66e+Hqg9mqDGqJgGd/+SvLHEmKAVlFvEZ8WC94FOA9USLah9yAnTwN+
         Yz5KDITtV25S8ZHfMk6cONTmFxwYkCqwkvxr3FsNEjm/wujIoiqBhVC/15XrA2kEpnPK
         RrRT9B1+yRqV1Xd7MA0AAo4RbYv2dKTNqsh877Kyy94Zfjpn/KI+gYp2cXEGP7+o+LzP
         2+2OxKJJfsj7t6JPxfM3pN/miE+Hl1Yp9CLlrwH7kNopG7xEGME/MZNHUDnvsR/a2I/n
         raMg==
X-Gm-Message-State: AOAM532x7r4S+aWCNakfBipIvyxhar6+uL8tx96GuELZH6l2rL0Xsa4y
        Uu+jD6I2wZFcJl4nmyRb1PtoGkgDTVd2Mg==
X-Google-Smtp-Source: ABdhPJxv+rgZ9LLe9oXPjPaUGoQo/hy2aBR3IZTgdF8JBdC+3K5TUUEzKJ/koEN88rKvxnfNJ8mnow==
X-Received: by 2002:a1c:107:: with SMTP id 7mr5157273wmb.28.1614196335595;
        Wed, 24 Feb 2021 11:52:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:15 -0800 (PST)
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
Subject: [PATCH v3 27/35] userdiff tests: remove "funcname" from custom3 test
Date:   Wed, 24 Feb 2021 20:51:21 +0100
Message-Id: <20210224195129.4004-28-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can only have one "funcname" or "xfuncname", any later definition
overrides the earlier one, so this configuration wasn't doing
anything.

When this test was originally added in 3632cfc248 (Use compatibility
regex library for OSX/Darwin, 2008-09-07) we had no such definition of
two patters for this test. Back then this was setting the
"diff.java.funcname" configuration variable.

The stage for that second pattern being set got set later. In
45d9414fa5 (diff.*.xfuncname which uses "extended" regex's for hunk
header selection, 2008-09-18) the pattern got converted from
"funcname" to "xfuncname".

Soon after in b19d288b4d (t4018-diff-funcname: demonstrate end of line
funcname matching flaw, 2008-10-15) another test immediately preceding
this one got added, using "diff.java.funcname" for its configuration.

Then f792a0b88e (t4018 (funcname patterns): make configuration easier
to track, 2011-05-21) came along and codified this whole thing when
converting the two tests from "git config" to "test_config".

Since this was never the intent of the test let's just remove this,
the rationale in f792a0b88e for having some test for the clobbering
behavior makes sense, but I'll do that in another follow-up test, not
as a hard to read side-effect of this one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/custom.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 97f310c02fb..58187c2293b 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -52,7 +52,6 @@ public class Beer
 EOF_TEST
 
 test_expect_success 'custom: setup alternation in pattern' '
-	git config diff.custom.funcname "Beer$" &&
 	git config diff.custom.xfuncname "^[ 	]*((public|static).*)$"
 '
 
-- 
2.30.0.284.gd98b1dd5eaa7

