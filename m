Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA94C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824F060F13
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhIVUSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhIVUSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:18:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2820C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:17:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so10429495wrr.9
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxIBbN6TUcBQd7ZfWzdRk4xeUoOsDMjHnF0rGic5e8I=;
        b=Z3jn250OQ36JfnJuFT0if/fUskGRL+CTmsCxx7Ue6ZFGCH3yEyq1GuqCBN/QfEH0XK
         LXq9M1HbAAa2y/kUAxe1pn3b1mB9wBqdQ7IDQZuDGudaye2hahBlYGlnSgWQgetp9WP9
         66KPJkP92sIHXYHe9/llhA86lJ1Firs40giOJYrpBulRG6nL5y7R6/oRnsZubhDF6JGE
         tZGxOHB5e1O6Tp8HeDlF5oQf3B2yzEEa1cVf//7Zf/We7IWJLQtZd6nzf6ftjmU3fM/b
         VBDKVisAhxu03Yq6QnYZnqtHtGZ2FusQT72XsceRifzMGsvz4h3wbFDS/PEwx7ynlh/t
         GOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxIBbN6TUcBQd7ZfWzdRk4xeUoOsDMjHnF0rGic5e8I=;
        b=rKoEnEke29XS+4ZaQkhZxAtIABYln+POk33LEXh5c5oJKfIJ6Jcjstnbm2FWHuW4qd
         LR4N87/buwWqgfTk0b1g+C4YAlrK5fAYxa1bh5Z9FJTNqyT9TO66MZF6k6SPlOhgqaED
         rBMH+iJz3kVi5X0HqJC4auB2jlUnTktYUejFZwxMxHW1N4c1iRimo5BNBsg6XhuzsvZ9
         72AzzMGaGIKDvWNZFg9Cbf+kxHrzkMN8gsgiMEESdZUbUMEdcsrTA01smArAbSQZSU4z
         QnV/WKwlunZD/FtDTfBFbMD3Ombej6DB2JpvxTpyD6aHGeuhjVVeiQ0KRkygBYO69Ec8
         flKA==
X-Gm-Message-State: AOAM531JzOvADdtO9D1XANVjQ4hWBMgz+4RdJvHvNo7YbORI26LNc4Id
        1EThFI0mfp5tIOayjVeJep5njDjWqbl68g==
X-Google-Smtp-Source: ABdhPJwYPCuIyfzMYm31bg8iiBvfjebQn20B9mr/xsjpBKl8X98oGUr+Q+tt2+1NW2SQHhgoQM4ghw==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr12349365wmj.176.1632341833251;
        Wed, 22 Sep 2021 13:17:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18sm2966741wrp.97.2021.09.22.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:17:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: clean .depend dirs under COMPUTE_HEADER_DEPENDENCIES != yes
Date:   Wed, 22 Sep 2021 22:17:06 +0200
Message-Id: <patch-1.1-b8bde2ee7b7-20210922T201615Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error in dfea575017d (Makefile: lazily compute header
dependencies, 2010-01-26) where we'd make whether we cleaned the
.depend dirs contingent on the currently configured
COMPUTE_HEADER_DEPENDENCIES value. Before this running e.g.:

    make COMPUTE_HEADER_DEPENDENCIES=yes grep.o
    make COMPUTE_HEADER_DEPENDENCIES=no clean

Would leave behind the .depend directory, now it'll be removed.

Normally we'd need to use another variable, but in this case there's
no other uses of $(dep_dirs), as opposed to $(dep_args) which is used
as an argument to $(CC). So just deleting this line makes everything
work correctly.

See http://lore.kernel.org/git/xmqqmto48ufz.fsf@gitster.g for a report
about this issue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9df565f27bb..bc987daf495 100644
--- a/Makefile
+++ b/Makefile
@@ -2466,7 +2466,6 @@ dep_args = -MF $(dep_file) -MQ $@ -MMD -MP
 endif
 
 ifneq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
-dep_dirs =
 missing_dep_dirs =
 dep_args =
 endif
-- 
2.33.0.1225.g9f062250122

