Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7225220323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdCVVuH (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:50:07 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33533 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdCVVuF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:50:05 -0400
Received: by mail-pg0-f49.google.com with SMTP id w20so10681896pgc.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHOcmMbFsNDFWjuMiZir6xd8/Kby3vEBPbdc9dJ6wcc=;
        b=DX6JrfONccwm/wO5khLLFdXMgwnrLsaVV/LB51e/Pwo7KpUp4FX5mkojIrLc/77HSm
         GIzpEhmQskIlaFmRKnRg159eJr/+kUf4f1GMQcb1Wovt3D3ujtDibqD2fwWVSVc9D8x7
         32i925Ih9ZYuH7rGrXU40T5LcTf5myfzfwcLMfObnIZlsc8zgG4Ts5ZMgrVHEFWMjAuf
         z6c51z/YUkWmOqjNPUYMw8fiZdzI7sZiFMCkUrZBf32lPvGlrml+hwj6MFPtghzBmsEi
         q5hBugJhibJfo9vVN4x6JJ0f6xfc+PHfXUv/cTIsGd5LDXlnQxZJfrX5xibVBU/gH3pB
         JphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHOcmMbFsNDFWjuMiZir6xd8/Kby3vEBPbdc9dJ6wcc=;
        b=Z368cWsdxTICxZtNqpEGC5wzENMH9P/pQXntBGIJLdc90/Ck/7XHcAEmQiJxSC7hTY
         6QIbsHpPxa1jkzNRG5x1fV0GrmEd3hw5wk71LLK5Ppy8XHIz8ppZI9dzW3UKH3jYf4M+
         u5W+nVE0D0wRM7HV1bcZfgpc1Y1s5K9IATwdo8p8z1by/YIi3Zir1kWWHfft4zrnOOk+
         hXbX6xf3Climl8riNXxgNKRQHsIXMWnVfMzAnwCMRs6RAHMop7/9o3dz38507U8sXf/z
         J0tSNIouwe9rBwLqpwPKUzuvxdaUFJOnFqpJOVLGZeOkI6PU0SgZXj9SH2BbtzqsgFYd
         Wm3Q==
X-Gm-Message-State: AFeK/H1n3EPYFeowYePfjp8fpRMcxOZzjuclhR6hSFvaZ19sPctmzXZ0nV3pNJiztaJD6Z4i
X-Received: by 10.99.139.196 with SMTP id j187mr41529379pge.176.1490219390192;
        Wed, 22 Mar 2017 14:49:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1959:c634:6437:385])
        by smtp.gmail.com with ESMTPSA id v11sm5775559pfk.32.2017.03.22.14.49.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 14:49:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, jan.palus@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] t7406: correct test case for submodule-update initial population
Date:   Wed, 22 Mar 2017 14:49:48 -0700
Message-Id: <20170322214948.12015-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.50.g9d09a6e.dirty
In-Reply-To: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are three issues with the test:

* The syntax of the here-doc was wrong, such that the entire test was
  sucked into the here-doc, which is why the test succeeded successfully.

* The variable $submodulesha1 was not expanded as it was inside a single
  quoted string. Use double quote to expand the variable.

* The redirection from the git command to the output file for comparison
  was wrong as the -C operator from git doesn't apply to the redirect path.
  Also we're interested in stderr of that command.

Noticed-by: Jan Palus <jan.palus@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is just one patch (for bisectability)
it applies on e7b37caf4fe.

Thanks,
Stefan

 t/t7406-submodule-update.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 8c086a4..c327eb6 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -425,11 +425,11 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 '
 
 test_expect_success 'submodule update - command run for initial population of submodule' '
-	cat <<-\ EOF >expect
-	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
-	EOF &&
+	cat >expect <<-\EOF &&
+	Execution of '\'"false $submodulesha1"\'' failed in submodule path '\''submodule'\''
+	EOF
 	rm -rf super/submodule &&
-	test_must_fail git -C super submodule update >../actual &&
+	test_must_fail git -C super submodule update 2>actual &&
 	test_cmp expect actual &&
 	git -C super submodule update --checkout
 '
-- 
2.10.2.50.g9d09a6e.dirty

