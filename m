Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24CC433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D71B611F2
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhIKLTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhIKLTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:19:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C21C061757
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so6579497wrb.0
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=We0/183vDZznJ5HPp/BdHvZ1dyRP219QB41Q6uX+w4s=;
        b=RKn1ZGcU83QBciW/R4FFMs+a/zJdS5crVa06CPaB/qelzCj09PUs2XPd4MT5ZBUNVs
         i+vnv4kbFS3xCROKIO60+ZQdHIOEW+6goRUzBHo9GZtGDG5upmaj6t7dmCmic5QUndCZ
         dK1dfzSQ/OfvWURMHNhQSd+mKzI1Kro8wXQYV1eKPniwfScKYKLMgiCwVq/a3fJHKBkh
         ol5APXiwVTBdgwsvHXa+oLjgUPh16PeuqRA4kuQoJ/G52aTHUm/dKLXKUD15661TlfBt
         PsA0g45gTG8GAFUbG1XZN1qqUfpU4+o83b80d2n2vMjqJNFNXvHV8OfcbdLfpECkUrRj
         QkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=We0/183vDZznJ5HPp/BdHvZ1dyRP219QB41Q6uX+w4s=;
        b=FgtcaVEiTnAHYx2yIosYcpVqclUQLFwPPDmf6nYdcqyttPotUF62/T/Jfp6yCz/K6j
         Ma8ZDstFfOrpF+dpbQSpxNgsOWcnaBJuW9LDK6z8IGtiI0VzZscojql6SQwOmTeLvEIJ
         WFJJXbYwOXQVt9Pv7b6WbavNUuozx7jsLnaLtGFgdEVIaZobXJvR7VlIKyCYmnMuhDfz
         zRBwpijp8UkaaxyTXA0WqqajHBdYlaF7A1gNUThw1IAMkwT61IuQRy6pFpE/6/jIVaqa
         8/ufNjXCSuTBO6ZxbyYHVWhQ6r6SzN9e6ZVwetOqzxQnG0ClCXECItF+5WLvs9YJDF23
         YnZg==
X-Gm-Message-State: AOAM531Uvb1RfMXDg+QZN64+AjvRo0Mp18TvjcWfU41fwTbLApTKvGCM
        B0yIq8vW2/ErST+zeH7Leh9WI4vLaFqbKA==
X-Google-Smtp-Source: ABdhPJwboSvnZejJj4YrHoYysdZo7o7hbQzw4wZonKXTM9E2b51ATjqMESbZSwelBK+unD5VIEefSg==
X-Received: by 2002:adf:e34a:: with SMTP id n10mr2649762wrj.320.1631359076048;
        Sat, 11 Sep 2021 04:17:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm1549731wrd.25.2021.09.11.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:17:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] git-bisect: remove unused SHA-1 $x40 shell variable
Date:   Sat, 11 Sep 2021 13:17:50 +0200
Message-Id: <patch-v3-3.4-cc2059f09f1-20210911T111435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was last used in code removed in
06f5608c14 (bisect--helper: `bisect_start` shell function partially in
C, 2019-01-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-bisect.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6a7afaea8da..b59f3aaad43 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,8 +34,6 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-- 
2.33.0.984.gea2c3555113

