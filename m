Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5615CC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A86F61BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhKQKXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhKQKXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067DC0613B9
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:32 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u18so3599329wrg.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjDThg6J3EWSLvU0djNifLAzukbACcFOzjf8hCqyRlY=;
        b=i+L6wTInbt9mPiFEp0OHZwzjGAesXys3WGU8ZrxSWiSHMWyD7Y5o61wk0CG1vgWJ3P
         RcBE4AN6vaKQarLKb4D6mRy8ZrT1JAshLuc+Ijd2s/ZowQTQBr7NCYGVqpTee36DDsu9
         2+a5rWRlW4fhn1xPsF0fkUxGE8myzQAQCJNG6dBv9dlz3Ps9NSgmFpVEtNUZ9xgK/Ri3
         ZrinkAgdi0AjLCs/Yj8m5EThZs1sHHf4ywQPeAUTABNRME0lCp+4EanMf8pVqTYweJKP
         IB9ZFa9JD1cZAebJE9dZFOXzeU/5mLeu4gnY0ITG9egn1oU6hV2tNEGTzLd+8cdSIB1v
         E38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjDThg6J3EWSLvU0djNifLAzukbACcFOzjf8hCqyRlY=;
        b=f7342e/rB1Jl9zJCPVlDnLra8dsxEKlrecL5ybg47ohxJdR0ubWYxXkWfhtnC5oZZf
         dPKCcGt/xKhxVBxLWZiux2yuzIHZgOj/KJ9RtGruVBNAurcxexr5L4GZb32cbLiIETPI
         XAEkngzVoKKaJc17px09DRNutEMqSjH1eUcFA/3pLBbOhBvFmBebCNHbiHg+xMhX+bPj
         HmBkykUhuI08bJOO34p4XInxMgF5prriEcGR0e1TAz8Af+2O9ZD19oJ8gauWQjuKflOm
         bZ4NC2dg4ljNeagdCQQPGVidcEpCBNzAiKpIVg1O2pqCqt0m3Oa9FSoX60q1TRjd93xl
         etfw==
X-Gm-Message-State: AOAM531Zb2W8pUbIW572iaR+TonfkkcijUl7D2wI0tUp7XE+pR/6Ma+i
        0IV9OjGjsXpRtObHPALddPXpub6Zr1UgvA==
X-Google-Smtp-Source: ABdhPJwGHyW+9ymmxRLt/cx0alRi2Tr6BduOKPtH1dB0KBo8HFdpynymy7zqTZ3r10pe7bqpvPzCHQ==
X-Received: by 2002:a5d:6707:: with SMTP id o7mr18219921wru.172.1637144430447;
        Wed, 17 Nov 2021 02:20:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/23] Makefile: guard Perl-only variable assignments
Date:   Wed, 17 Nov 2021 11:20:05 +0100
Message-Id: <patch-v4-06.23-b57f582ccd3-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "ifndef NO_PERL" a few lines earlier to encompass the
"perl_localedir_SQ" variable. We'll only use it under !NO_PERL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 284725099c9..0cb10f00ebb 100644
--- a/Makefile
+++ b/Makefile
@@ -2291,11 +2291,11 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
+ifndef NO_PERL
 # Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
 # since the locale directory is injected.
 perl_localedir_SQ = $(localedir_SQ)
 
-ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 PERL_DEFINES =
 PERL_DEFINES += $(PERL_PATH_SQ)
-- 
2.34.0.796.g2c87ed6146a

