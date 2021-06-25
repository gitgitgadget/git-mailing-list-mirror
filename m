Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B784FC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04F9613B9
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFYTlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhFYTlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:41:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A6C061766
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:38:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so9130772wme.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jJJv8XPBnB4iAefA38zBY1cHB5c4qwK5KNumc6jHwz8=;
        b=emO48+Gtglmf8VV5hvB927eFNYD1IU5WFZwA1FjtrixJewCA+SmzWBPiFzumce1vdh
         CR5q2phZexErxwp2OL+mmQei/2/tZf8a75xM3ALc+aLPJzUctmyigHwh204E9oonS6qA
         isDr49AkbgFmbuaTjVUuDlvZSe3mkboPLMiFTJ6SiV/7H2125eAniAqfd/pbaPmZML1m
         kxa5Ct7/bf+HMprpjUWdPiAMBYD5RJCIQBR/0xRB5/L4BbkzREF+2Qi9lH8LYWJqGUhc
         kUkhW+U98w8kii1KHbrgXkjG3VZiHhNUtQI2DB/dABJhXZq19UPqVgtQMiwMqb0/DXdT
         6e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJJv8XPBnB4iAefA38zBY1cHB5c4qwK5KNumc6jHwz8=;
        b=Nrzzfg+ZP6IIYYz4lRBtXrdS0gcPl9UARsh7dURLA6rzsmPPxNsj366W6hvyefspaN
         LKnkWfxrTWZCvXdjvWzuzQ4/BXRzmbloHzlJRElpdSy/De0g+DhlSzhp4CcEgX3jjZUS
         tSHRbh6tS5FY3HBVeGQRN+6U+ErIGSYRk3mFuHKaT5QGiDpBKeVpuCPdYZIREk1LfOuN
         MAYkW2h+SknPYisMTErrsl7kM+gkMqz1Ig1BS5ivmugmU2PXDBtg8i8NizyVs8mpN5KF
         2dJJdzudx6ZXfF7Ff8iyCGq5siw+r8pBieCzTWyLVzgK2mOaNZlbqVfS5Hqxm34N9koa
         XWRA==
X-Gm-Message-State: AOAM531n5G5Pr0PuGFTlQQT+dLBoTXotSmnvGaDPwgFccXLSaJhSYAl8
        9YIiJLs0Cei2y3nY4JeIXZS7WmKgK20pM3V5o1cjCQ==
X-Google-Smtp-Source: ABdhPJxKM2Alg63vyhHlCU068ysd6+jsnT+w2hHGvcynOuuwGYZN34L8rnnPY4Jx1KxBDM0GIykK/w==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr12538479wmc.71.1624649937542;
        Fri, 25 Jun 2021 12:38:57 -0700 (PDT)
Received: from localhost.localdomain ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id c18sm6679233wrt.83.2021.06.25.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:38:57 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 2/3] t: fix typos in test messages
Date:   Fri, 25 Jun 2021 21:38:50 +0200
Message-Id: <20210625193851.2233114-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625193851.2233114-1-rybak.a.v@gmail.com>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both in t4258 and in t9001, the code of the tests following shows the
proper name for the configuration variables.  So use the correct names
in the test messages as well.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4258-am-quoted-cr.sh | 2 +-
 t/t9001-send-email.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
index fb5071f914..201915b45a 100755
--- a/t/t4258-am-quoted-cr.sh
+++ b/t/t4258-am-quoted-cr.sh
@@ -26,7 +26,7 @@ test_expect_success 'am --quoted-cr=strip' '
 	git diff --exit-code HEAD two
 '
 
-test_expect_success 'am with config mailinfo.quotecr=strip' '
+test_expect_success 'am with config mailinfo.quotedCr=strip' '
 	test_might_fail git am --abort &&
 	git reset --hard one &&
 	test_config mailinfo.quotedCr strip &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c66d9190de..9ec7d75f0f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1839,7 +1839,7 @@ test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
 	grep "^!somebody@example\.org!$" commandline1
 '
 
-test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
+test_expect_success $PREREQ 'sendemail.aliasesfile=~/.mailrc' '
 	clean_fake_sendmail &&
 	echo "alias sbd  someone@example.org" >"$HOME/.mailrc" &&
 	git config --replace-all sendemail.aliasesfile "~/.mailrc" &&
-- 
2.32.0

