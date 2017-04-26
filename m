Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC85207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdDZRD6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:03:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36041 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdDZRDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:03:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so1383246pgv.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=NLT+/iUiV20asTldONPfHdlWgL+rAtVfLHKbEa/zK3dkBAvADq7u5bRBfa9fJ+mlx8
         4Nfdxs/B9cTTmGIckeBh0Bwr2DkNC6hNRcRejpBYs4ae35xLi2Som1gu3swLtBt983kc
         ses/0zAyNPcRM8Ey1Bd7nFR9qMrLxhAep+Wa9djLJIds7t8v++PARePBZlTmU373qHNO
         PdyIprjn/BHHr4tk6B9kBzRJGoYZwTw0J1wrNq0OOFEZdeOobfeJe3Y3qRBj17TC2G/Z
         l5GxuxRI3KVKy0jE3JRMuILaPDW/cUcc7mRaNiRIrw2vp1e5dE+3Nbc2hxnvYeIeJKCb
         fZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=VKXTSmG2IQbnFBU2MB8Wo/BDxNG2zws8haLUYnRPA6FBa7zBEspyTzBaVIcoDNgicy
         Pa/Vf5nzov50wgAqFMGP8IgkPlGJ4mBf1Iq7od+fxuW42PAAXuLforJla7iAX9G+ypYJ
         px+jXLzrz8NNZmIaEsda7guAMzr5X3AmyQx97LidGFdqJziKqXU8F22ZVHHE6EjNmimr
         tZHNKJHPLt1CjT4TGFrGFo2jAlk3GzLMJdHTQ8yu6wF+23yEaJEIk9htO0hxOa1zzV3t
         9ZBAmscY0VV4CsASceQN100Fcdfq6W+L1DaeUay8nIhisv/rQ86U6qmbAIVr88A7Pu4x
         kj5Q==
X-Gm-Message-State: AN3rC/4nT9vXky7LnjllBt3gl3Iezl9Pwe+NPr29TvTepLGpWLAoe86k
        PrB9ZCyuIxz3tw==
X-Received: by 10.98.66.82 with SMTP id p79mr914085pfa.146.1493226234768;
        Wed, 26 Apr 2017 10:03:54 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net (c-76-102-227-215.hsd1.ca.comcast.net. [76.102.227.215])
        by smtp.gmail.com with ESMTPSA id q70sm1376479pgq.45.2017.04.26.10.03.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:03:53 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v11 2/5] remove_subtree(): test removing nested directories
Date:   Wed, 26 Apr 2017 10:03:36 -0700
Message-Id: <1493226219-33423-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
References: <1493226219-33423-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test removing a nested directory when an attempt is made to restore the
index to a state where it does not exist. A similar test could be found
previously in t/t2000-checkout-cache-clash.sh, but it did not check for
nested directories, which could allow a faulty implementation of
remove_subtree() pass the tests.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 t/t2000-checkout-cache-clash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index de3edb5..ac10ba3 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -57,4 +57,15 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	git checkout-index -a -f --prefix=there/
 '
 
+test_expect_success 'git checkout-index -f should remove nested subtrees' '
+	echo content >path &&
+	git update-index --add path &&
+	rm path &&
+	mkdir -p path/with/nested/paths &&
+	echo content >path/file1 &&
+	echo content >path/with/nested/paths/file2 &&
+	git checkout-index -f -a &&
+	test ! -d path
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

