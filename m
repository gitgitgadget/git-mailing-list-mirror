Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C2C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2C206B2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNER8BKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgIPTBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgIPRsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:48:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B73C061351
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so6370920wrn.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1q8skUEkEgmD3KhZu5V9H1XxMJJc6nqiyeSZyK5mIgk=;
        b=RNER8BKoyLnOmtpsOFPDvfD5rD+kIaoMg0lTUSFgnA+b4+vkl8iby/5ZChncQO1hny
         E5Y6/uAeG8pZWcaodR/bM1dBDolEkoqMArIsqTu7JnxMmpNBwATEoiTfLqf4/UPcChFD
         Y0+DetG8O+t9wHRNasuG9roUIxj31gmeLROAOPssIFaCvQ6xwInLFwTMdAZqLJO9XMZD
         IU+SOXX5k7m5WiboUysNxnnI+AzVkBzewTsTsfM47f6UhElhJ0zoKcea6debaEIBzS+g
         v/0LDajDn1d/0iZqlgjrjANpgBLXBRO5BL3QsvmLfh0BH2aler+FJPzA5CCwLHwGKUz6
         7BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q8skUEkEgmD3KhZu5V9H1XxMJJc6nqiyeSZyK5mIgk=;
        b=q2xZaRFOW2VhRo4g799DXTED2GT8rIVfCpYg/2rj74b6x0v2f+7C5RBEtya6xbj7UU
         6DPNPlw5lRlJiHkfyTWLd+cxWd9+RYHXjvbSfd8zZsgLApNAvhkdgyUW+K9+g9ApaPeh
         kcmFgJldtXQhwSsQIy+d5LYT5X88YMXis2wiwcjpgaGXN80F5lnT58CUUA9mX39H/Jes
         emezTLPCzE29OxTYZD1LCWRXcJKFfOQzb8YNk7zq+10AdqbyCa+MCUivneu0VVzQw/Op
         qT8CG8sB3PBTm3dp9vYU0tZRwTjUcwlRcGPzOalGmwe4U57IWI38m9p0B+iytwIvQnXM
         nfHg==
X-Gm-Message-State: AOAM532mdJ+T0PN3fiT4Md0rS8YXHyDPxz4+qYxv+Q1gDVRijW3B1GDH
        VYqYcVWOzEAe3wASHSfxgO1iikv3zqiGuGcL
X-Google-Smtp-Source: ABdhPJwhFdem+x2LWWrgXveN4g6M54J4UbXUQuTm8xDD4spEdcvzrGfjVhk4/EgPY+r5+GD5HWvC6w==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr26384799wrw.331.1600252203400;
        Wed, 16 Sep 2020 03:30:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/15] remote-mediawiki tests: use the login/password variables
Date:   Wed, 16 Sep 2020 12:29:07 +0200
Message-Id: <20200916102918.29805-5-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a hardcoded user/password for the corresponding variable
defined in contrib/mw-to-git/t/test.config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 3ff3a09567..43580af3cf 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -27,8 +27,8 @@ test_git_reimport () {
 
 # Don't bother with permissions, be administrator by default
 test_expect_success 'setup config' '
-	git config --global remote.origin.mwLogin WikiAdmin &&
-	git config --global remote.origin.mwPassword AdminPass &&
+	git config --global remote.origin.mwLogin "$WIKI_ADMIN" &&
+	git config --global remote.origin.mwPassword "$WIKI_PASSW" &&
 	test_might_fail git config --global --unset remote.origin.mediaImport
 '
 
-- 
2.28.0.297.g1956fa8f8d

