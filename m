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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D1FC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74890230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLETy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLETyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:25 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46992C08E862
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:44 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id i7so2259318oot.8
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWptlYuhXDCZAz0F+eIUPJTkgpL8Oxwz7vgAz6RQJ08=;
        b=ZtoSh/VAeI+x35Np0WYwJsur3g2dZmjdhTHzsjouNBLK4aPh6wIbgl8DcoGHOqgLlV
         qERo7CREnojosAhRvsPkkpYzW7TFfitKNuVbeTX2fGVNn9gEILMs/7gKmbEwH7QJONBt
         kGtzOK1uL9ojmCkacEzLkNvu63Z0rqo9hvMVYaEE7KFkaUhM80LP2c9GjznoJCG2zfuX
         mej+1sFOOTcvT5ewjlUk4xs1Im+XWk1kLYZD7BpXXPiOB9OwiT2+0XNucHXqQcZ0QjA4
         hwf4qzIUkFwiZQHpXkM9oKFs/C6exPPOnjh8I1lbe82h3/1v8YdMCbTTWN8aZOtjORan
         DIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWptlYuhXDCZAz0F+eIUPJTkgpL8Oxwz7vgAz6RQJ08=;
        b=J28Bz2hFfuA8ao3epdQqVEz5VC/WyD6lmOsmOZPzZ4I0L3QMAIfQPdP+fDTcndZVYX
         Lnu/I52DDozvbdE/nn0hH4WEFi9QHeGfpG+eJ/84wU3OV3/k9AK042z4kWOVQS2NbmL7
         8fxVzzfjojepwk3XCjEkMpX86Gbwf0WrGujnEEPT7xto58SZRPcCil8Pte9bTBWJpYwL
         T3DPeeyfM3wr8yqtrYEx6klMS97aUKXvs8nkZ1wLy3qtBfLTktqIceJRTrSx++fDWPdr
         9QZNCMHZxA1w57PfaTe3jaSl9Nk/IAZEk9Q0QPIGAdT9FECu+ejEmGj3KyUxh2dy1/8F
         cBSg==
X-Gm-Message-State: AOAM533qiObwcScnyVQ8HxHfETrW/S0Z5ciCHir3OSEfaH2Zi+HTX2PJ
        wIWwCRxsKBT5UyVY6UcTbHbQUe+VEh7Wnw==
X-Google-Smtp-Source: ABdhPJw+nZXQ+0WtA9yBBOD+yjXRp4OQhoDRn0h2yrnvwZEB46lTnd+U5z48rHEVSBhR4OZb3Qzhsw==
X-Received: by 2002:a4a:c102:: with SMTP id s2mr7815234oop.60.1607198023475;
        Sat, 05 Dec 2020 11:53:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a25sm1536760oos.23.2020.12.05.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:42 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 14/16] test: merge-pull-config: trivial cleanup
Date:   Sat,  5 Dec 2020 13:53:11 -0600
Message-Id: <20201205195313.1557473-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e01ae2a4a7 introduced an extra space.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t7601-merge-pull-config.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index d709799f8b..8a6aae564a 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,7 +33,6 @@ test_expect_success 'pull.rebase not set' '
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
 	test_i18ngrep "Pulling without specifying how to reconcile" decoded
-
 '
 
 test_expect_success 'pull.rebase not set (fast-forward)' '
-- 
2.29.2

