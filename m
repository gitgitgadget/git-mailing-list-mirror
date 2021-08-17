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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0272C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE2160C3E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhHQLJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 07:09:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243AC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 04:08:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q2so24468080plr.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBpQz9vNfSafiWdmuPpJ2TrJrCgBrzw5WEwfucQU7WU=;
        b=E1DcSZSGaXo7sxUNmZpyY80DDu62/baG8Jxo43tMLyeJpQ4cp5QDfHLcsYAmhTxyuV
         NNh5cr3ON+Rcglw+RaJwHxb3Rf3D0dxcPC3bhD2Kib/9h6IWIBKAzbIygHgbzGeAYHrg
         g4ypjTOfzlx+5kKPhi5S2CzG+DDpEX3zSiMmA75Mxjp3Hd5Pcq8Xv9wS49P33c7ZQpTl
         lK4otA66MgF6iVFc+dtaa1eLRJihrXg8Le7DnAaz62G7ZPX/fE2tY4CWYfHrFFma2gXy
         FGFBrWWlaKpxVGUu6GZAljzgz4zhaDlf9voCRXwY9CyD4BTDPFDKrIhdDCKxiGdSc+RT
         nwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBpQz9vNfSafiWdmuPpJ2TrJrCgBrzw5WEwfucQU7WU=;
        b=freDhcT2FrmKrHyZSNIGJQxERmOTwhEinaDN6w4TvF//saLeWoJ2HwV/pdWWNwysBf
         xh8fELJCKkqngzi7OTDERccWqHEARZ9yLF38fd8byooQ/IJwd9ZdBYZbDzyJF0UHfHrG
         adUUeulIyF17DO9DN9qQX4ETcbf0EIQIssiRgWNECdeZVb6LyB0UUprgspIM0uiXQDXT
         OtNcfOrleapabX/kEmxHMDV/UtAg7w4C1DbXoHGtqB6wlKHx/Ov71IUAne4rSrLQ7Kyw
         PM15tC0FLZ1ftj7CRyLCGrpbdCvx9kx8H9DoXnBQmopnmCpChSbPb25QtG7GdkPPPcSi
         sQ0A==
X-Gm-Message-State: AOAM533E/08MAELfEafcUjdbzosNyrPcBO02B+pRF4ctBrDbofNXww15
        mexYPyDPhLUTMRtDK2ycGXUFngElPTM=
X-Google-Smtp-Source: ABdhPJz7JHcKnBFESyD4sqtEFWCzGnTvQL12woOuZs8qvt64uEeLq3478jLnv2K849v6QRGYdKLlyQ==
X-Received: by 2002:a17:90b:1e10:: with SMTP id pg16mr3097278pjb.233.1629198537568;
        Tue, 17 Aug 2021 04:08:57 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-20.three.co.id. [180.214.233.20])
        by smtp.gmail.com with ESMTPSA id gg6sm2004971pjb.46.2021.08.17.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 04:08:57 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] make: add install-strip target
Date:   Tue, 17 Aug 2021 18:07:29 +0700
Message-Id: <20210817110728.55842-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously to install Git with stripped binaries, users have to do `make
all` then `make strip` before doing `make install`. It is nice to have
`install-strip` target for convenience, so that they can simply type
`make install-strip` and have Git with stripped binaries installed.
On some environments where disk space and resources is limited (such as
embedded systems), installed size can be smaller that with non-stripped
binaries.

Also mention the target in INSTALL.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 INSTALL  | 5 +++++
 Makefile | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 66389ce059..6e6303d482 100644
--- a/INSTALL
+++ b/INSTALL
@@ -25,6 +25,11 @@ set up install paths (via config.mak.autogen), so you can write instead
 	$ make all doc ;# as yourself
 	# make install install-doc install-html;# as root
 
+If you're tight on space (common on embedded systems), you can install
+with debugging info stripped with
+
+	# make install-strip
+
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with
 
diff --git a/Makefile b/Makefile
index 9573190f1d..8c4633ba8e 100644
--- a/Makefile
+++ b/Makefile
@@ -3093,6 +3093,9 @@ endif
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
+install-strip: all strip
+	$(MAKE) install
+
 .PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
 .PHONY: quick-install-doc quick-install-man quick-install-html
 install-gitweb:
@@ -3265,7 +3268,7 @@ ifdef MSVC
 	$(RM) compat/vcbuild/MSVC-DEFS-GEN
 endif
 
-.PHONY: all install profile-clean cocciclean clean strip
+.PHONY: all install install-strip profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: FORCE cscope
 

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
2.25.1

