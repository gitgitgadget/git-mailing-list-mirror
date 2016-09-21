Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEAC1F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 08:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755846AbcIUIp3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 04:45:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33328 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755814AbcIUIp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 04:45:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id w84so7329154wmg.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NWvqJqv/ceRvb6yQPtSvlHWAwgkt0OSau8FFT7a750w=;
        b=zfftAXSM67YlMLSw8AgsUsgpQt8g3mlXNmfJOh7pvh9k1/kNNJczcPaOGDtpp17ToR
         3YHsnVHzJKhJjyBpnZoWy6w4IeoEtuSQXfbdTe3OMSoH0uESOnMWCUq1zlbPRqbLVCak
         U3kTkuysmP5DVm4Zh9xB7+QWmuUO/gkA3cirAggwQ02xFqSGDSUmq5lT2YmqJ21FULx7
         n1SmOs/uGKsFUdSdoT9j0M7cebn/fh602JbqgODAloVwjsgJqkvZMtrSDa4tcw5KBO71
         71g+Td2aGbZbG4Fld7avshGI9fmMqF9nerRt1phbRDUPIZveVbOLRp3tXjVtTQCjWfxE
         O1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NWvqJqv/ceRvb6yQPtSvlHWAwgkt0OSau8FFT7a750w=;
        b=RemMKfbn1+i7WOTPOsZ5FclqvT5wcWip/x+DQIs5IzJxqKuI0loM2OvtjV/i8pm/ob
         lifLRxIUoINkdozcjvPqDLn6/tLVSyzB5DzMeLpkjjmALAGQfGQhtY6iQ+NPKGXqBu18
         mdGVNtuciAIGOuykaGB5sJU7fTAmobBdOfGnofYVjDGSuxTZnr/h/sqtCHmTFOL+YlPL
         leuQfXu1MvYXy/HOhcGLzJ/drqoy9MG+o2VKmJVaHg6fr5+tPMcaoBKnkoiB+SW+e5hC
         vNX493Z44Rwl4fNKaBMWf93sK6W1nfvVs2bPOrrnjUE5Zjc/T+x5s5w0fVH3M2Ys2cA+
         1qoQ==
X-Gm-Message-State: AE9vXwNDqAHKTlGrOLDJbN+HPtD+erCteu1UXRdotkGoYo6ypTHFUeAjKZhF9U1fdSvztA==
X-Received: by 10.28.1.85 with SMTP id 82mr2229971wmb.11.1474447520464;
        Wed, 21 Sep 2016 01:45:20 -0700 (PDT)
Received: from slxBook4.local.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f69sm19772517wmg.19.2016.09.21.01.45.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 21 Sep 2016 01:45:20 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] travis-ci: ask homebrew for the its path instead of hardcoding it
Date:   Wed, 21 Sep 2016 10:45:18 +0200
Message-Id: <20160921084518.13091-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The TravisCI macOS build is broken because homebrew (a macOS depedency
manager) changed its internal directory structure [1]. This is a problem
because we modify the Perforce dependencies in the homebrew repository
before installing them.

Fix it by asking homebrew for its path instead of hardcoding it.

[1] https://github.com/Homebrew/brew/commit/0a09ae30f8b6117ad699b4a0439010738989c547

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi Junio,

the problem affects all branches (pu, next, master, maint):
https://travis-ci.org/git/git/branches

Is it possible for this fix to graduate more quickly?

Thanks,
Lars

 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 477c3d2..37a1e1f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -78,7 +78,7 @@ before_install:
         FORMULA=$1
         SHA=$(brew fetch --force $FORMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
         sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
-          /usr/local/Library/Taps/homebrew/homebrew-binary/$FORMULA.rb
+          "$(brew --repository homebrew/homebrew-binary)/$FORMULA.rb"
       }
       brew update --quiet
       brew tap homebrew/binary --quiet
--
2.10.0

