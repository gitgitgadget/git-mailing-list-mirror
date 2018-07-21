Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFD01F597
	for <e@80x24.org>; Sat, 21 Jul 2018 18:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeGUTxX (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 15:53:23 -0400
Received: from s019.cyon.net ([149.126.4.28]:58898 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeGUTxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 15:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Qb5KrmXQ74Y5euPQmNB//SGzGwDhxLEsQFmVGGFqw+4=; b=YxfC9SbPH/lbNTf8ylggkobJGO
        c1bEqK8ItDx+xweCKEVlFLGRlqANND9QkxtGyzF4OwEsvr4H7acZX2838bgB8hBKUPSFMpQ5XVswp
        kf6cV7Wnr0LpT0WbNJHHnVTPwJONLIdwo3FBiJzOLXAeRgWRoNxOjLEvah01eVLBDIKTGx80zZOTQ
        8J4PfPzrkkaxFLOdvrMtSA1ObIF5iahOPDSIoJJHtVQD9NpAtvNZHI8/LZIPZgihSGRLPoogrxLEd
        5tGXCnayQ5U5cIKt/AfDjbTboMqIgielQrgHhSIrlgMNpG6l5zeqtKEF7wvd9cf6GeGnZLFM5iERB
        c2rieYcA==;
Received: from [10.20.10.230] (port=10752 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fgx6N-006pqk-5Y; Sat, 21 Jul 2018 20:59:37 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id CE880200F6; Sat, 21 Jul 2018 20:59:34 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] Makefile: add a DEVOPTS flag to get pedantic compilation
Date:   Sat, 21 Jul 2018 20:59:33 +0200
Message-Id: <20180721185933.32377-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the interest of code hygiene, make it easier to compile Git with the
flag -pedantic.

Pure pedantic compilation results in one warning per use of the
translation macro `N_`, therefore also disable the parenthesising of
i18n strings with -DUSE_PARENS_AROUND_GETTEXT_N=0 to show only real
warnings.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---

This is the convenience knob for all developers that led to the series
bb/pedantic[1]. It does not depend on this series, though.

[1] https://public-inbox.org/git/20180708144342.11922-1-dev+git@drbeat.li/T/#u

 Makefile       | 4 ++++
 config.mak.dev | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 0cb6590f24..f800054379 100644
--- a/Makefile
+++ b/Makefile
@@ -484,6 +484,10 @@ all::
 #        The DEVELOPER mode enables -Wextra with a few exceptions. By
 #        setting this flag the exceptions are removed, and all of
 #        -Wextra is used.
+#
+#    pedantic:
+#
+#        Enable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 2d244ca470..f21f0d0209 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,6 +1,10 @@
 ifeq ($(filter no-error,$(DEVOPTS)),)
 CFLAGS += -Werror
 endif
+ifneq ($(filter pedantic,$(DEVOPTS)),)
+CFLAGS += -pedantic
+# don't warn for each N_ use
+CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
+endif
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
-- 
2.18.0.203.gfac676dfb9

