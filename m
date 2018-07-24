Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4311F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbeGXSV2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:21:28 -0400
Received: from s019.cyon.net ([149.126.4.28]:44044 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388408AbeGXSV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P9AhAsLuClj9g17q6qTpnUNJQzGXVr9HNhhZHDu4ooQ=; b=h+tBfjDfWT9HDmBDhwssTfAAmM
        JLWE03T1i/jPTw7WIVJxRbWQJZem9BnjcqHMepR1ZRt8iExaNFKubTJwflRn6QOJ3WY5p+BJmsgxd
        uYK72VOLibBZuvZiWpZv5qEpKoTVWJkHL9t/f4iSLUsloKP5fubLCYZ/rO9sGf52pzN2/TMqJ/UpO
        ekFzLJM0mFCe3BzY1Cdcvo+7dRARU7NookO8bbxsGOPK15eIVvFyugtdEAoE2TgsnuCs92bSpYB/I
        FEJlD/QEY3COBqBAvEYnEfcG93x4e2UFJIk3hJamkQkpos7mZAmuNSC8MS7hvR6J6IR+gBHlrCcHn
        nCNvfFpA==;
Received: from [10.20.10.233] (port=46904 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fi0se-009e0p-M7; Tue, 24 Jul 2018 19:13:52 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 65D1D20F1D; Tue, 24 Jul 2018 19:13:48 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3] Makefile: add a DEVOPTS flag to get pedantic compilation
Date:   Tue, 24 Jul 2018 19:13:39 +0200
Message-Id: <20180724171339.18983-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <xmqqa7qg22he.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7qg22he.fsf@gitster-ct.c.googlers.com>
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

Pure pedantic compilation with GCC 7.3 results in one warning per use of
the translation macro `N_`:

    warning: array initialized from parenthesized string constant [-Wpedantic]

Therefore also disable the parenthesising of i18n strings with
-DUSE_PARENS_AROUND_GETTEXT_N=no.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---

Now with -DUSE_PARENS_AROUND_GETTEXT_N=0 instead of =No.

This is the convenience knob for all developers that led to the series
bb/pedantic[1]. It does not depend on this series, though.

[1] https://public-inbox.org/git/20180708144342.11922-1-dev+git@drbeat.li/T/#u

 Makefile       | 6 ++++++
 config.mak.dev | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index 0cb6590f24..2bfc051652 100644
--- a/Makefile
+++ b/Makefile
@@ -484,6 +484,12 @@ all::
 #        The DEVELOPER mode enables -Wextra with a few exceptions. By
 #        setting this flag the exceptions are removed, and all of
 #        -Wextra is used.
+#
+#    pedantic:
+#
+#        Enable -pedantic compilation. This also disables
+#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index 2d244ca470..e11dd94741 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,6 +1,11 @@
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

