Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EEF2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbdHCJUA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33221 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdHCJT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id y43so577280wrd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hve26B/H85ubNVySvTm7JdBhOlLoo9fBKAn/LpP6Cgw=;
        b=WZzjDZaOGDISsKDBd4iY0Yp6k6nE2vtqyt2Ube1s9s9FVI2OvZ++oPsGg/V8YHH1fr
         bW5RG4U6NSqr5Zi4Ub7PY9IO0mbU7tBC7Zceaw6BdSqMt0uY5CQUv+NdgixSrXzfpWfh
         zTm7mUPSaoSWzUm7qAFvIf10wDQzlX07Y3L0qCxtkQv7TVFoJeQ2X+gLPU3bGj9aknUv
         efknO9hA/Fdc2zc/16p8/7vYDWCk2IHCb9W0WmlLmE3HmE1ocLh32YbZ58TSHDpTSM/a
         IYED3MaT5oZeYky5wQOAzPvJbMYouD8aWmerzBppJXjccTmgSu++p6PuYPmTTDENDNyr
         sA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hve26B/H85ubNVySvTm7JdBhOlLoo9fBKAn/LpP6Cgw=;
        b=HK+ZtP0y8bGYBCkKSPwDyqp68V+5vOu9tilhbiiz+0qp6E5MtF6yvkRIrpa1mLQjgY
         sfXf9xeRQP0JSZyZfyJ55MXSADI6mTlKe+jodVtilkbWG/5wXRXbV9u4iEVRCrnOpiqX
         BdLFEPXg6SuAoAgkvUhZVmy/cS6R3n5hyScfZ3RKIXZbPfxX+odm82AS/V77fKr825wz
         dcdBpnqA+0preLkaHOzN7GazzSDKSBFqXc15EKgDQMLfkrm5C0TBmpOQMZPLUoccIWYH
         E2ycX19wjoNtqIjkZ+2KKQIE5CTgbpX3K+QS1DZu8XljRe8IH03IV+b6M9i7dByioY1R
         jy8A==
X-Gm-Message-State: AIVw11017tq4jPHljcF9wvQ0XHfvOMPVxmwxKVyZUgi4M/ttlBGB+cUH
        KG16ZRwUJXWjgbrd
X-Received: by 10.223.161.200 with SMTP id v8mr776615wrv.135.1501751996166;
        Thu, 03 Aug 2017 02:19:56 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 15/40] t0400: add test for external odb write support
Date:   Thu,  3 Aug 2017 11:19:01 +0200
Message-Id: <20170803091926.1755-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 3fa0449883..fa355bd7bb 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -71,4 +71,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.scriptCommand "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo && git show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

