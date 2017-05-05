Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2C5207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbdEERiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:38:55 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35097 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdEERiy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:38:54 -0400
Received: by mail-pf0-f169.google.com with SMTP id v14so5744744pfd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPsQ3rYY9RFV9bSLWgigSe/XOds0BTzOAaUipI+Tr70=;
        b=qNrzfQDQMtDEwiRI9ABIt9wtpcTbxsKshBluDsrkUIfl+2OdRd3AU3tSMzkiXulNiY
         13iFs5hYpI4Sc3hN29clFoMorn54lNt+7yPQmSOzDk62qgUoIR2KyWFGCq7fIdyGnBFu
         FsCWEgJYdzE6EiQ2TFjyyT7XL+Vn7eCHTql00Wu/LjsUdQ7/sPLYVaQCgb43KfTKI8Mr
         EKp+tmAfuGwe+zwmll8b6KRWpKPqbEzUEIh8HEf9TesP36jxPpfiYuzwXZfaRU1uQDaf
         hxW2qr7sl7VGCCQpTj7TDgq1grY13rqppQU1MQ4h8PVx7h9XFZ/iB1tvA/7YWmz9pZL2
         XGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPsQ3rYY9RFV9bSLWgigSe/XOds0BTzOAaUipI+Tr70=;
        b=ajCKTeTVOpy1iQuGf724ThfP5Rp7IKlnjq665ch5bCCzoAyOVyFmRBTy0jnCu6MGGm
         UsjFNVnn2Gvr/KuDvdlCzrtagqg/E+7J9vYAfFr1oy+kxp/qOmrLS70PCD0DlP8l80Cz
         SIEubwZdBzyDqtFaSKk/WL5vMADdj7NpGfpzsC+fjgr2gx0D7XVNpx8JctHdryEUYHp3
         2qoRRXnC2aJgtBTy7U6UaesS2SuHY8dqv1iCz+QD7oVgW3FPSw/J8zCXD3a+XdLTxS63
         nlfiJ5f33q/NXLTnMhZNLE4go85PG1EaU/GGKxdT1M4pfjodVE5PJrJ7GLCmllFoLELM
         IXcg==
X-Gm-Message-State: AN3rC/5IsrDLjDT+gjTNB3KrPHQyAKExmrpO0G2zIRegqWmq9xiGEBH7
        Hr4cyPHj1kKVWXQS
X-Received: by 10.84.248.12 with SMTP id p12mr4216848pll.155.1494005933509;
        Fri, 05 May 2017 10:38:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7539:a602:6c1d:4cc6])
        by smtp.gmail.com with ESMTPSA id 63sm14592969pfg.35.2017.05.05.10.38.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:38:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] t7406: fix i18n expectation of error message
Date:   Fri,  5 May 2017 10:38:41 -0700
Message-Id: <20170505173841.20555-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc2.dirty
In-Reply-To: <20170505154053.58128-1-larsxschneider@gmail.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message from "submodule update" is internationalized, which
makes sense. The test however did not check for the translated version,
but used a hardcoded string, which breaks the test when run with
GETTEXT_POISON.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4ac386d98b..12f6435ab0 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -441,13 +441,11 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	test_i18ncmp actual expect
 '
 
+sq="'"
 test_expect_success 'submodule update - command run for initial population of submodule' '
-	cat >expect <<-EOF &&
-	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
-	EOF
 	rm -rf super/submodule &&
 	test_must_fail git -C super submodule update 2>actual &&
-	test_cmp expect actual &&
+	test_i18ngrep "Execution of ${sq}false $submodulesha1${sq} failed in submodule path ${sq}submodule${sq}" actual &&
 	git -C super submodule update --checkout
 '
 
-- 
2.13.0.rc2.dirty

