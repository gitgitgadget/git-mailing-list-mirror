Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610E71F597
	for <e@80x24.org>; Sat, 21 Jul 2018 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeGUVbF (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 17:31:05 -0400
Received: from s019.cyon.net ([149.126.4.28]:35136 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbeGUVbF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 17:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=btZ0wFbpBI1lh6st1mZmSD8by/ViVKWMt0nbI1vwjfY=; b=XvjOQ3cCgNc1c7d01dOeF92Vx7
        Tp2sH5pFi11B4f9DqoEJnPbGETfQBX9yIpPlH0au8g+cHZt0/0nY5krkJsGfoFkq+enMDtrWP4Bc9
        xsRKIlgjk3q9Cu8qq99C4iSPRZKcwmvrwR657EnBgZigh2TdYNlGIn392bhXtDgQU0NDp57mQTvXW
        0kwERQguHg7sisUXdTSEpjDmI23hrd8n+IxBeUC0HE+XFgmFV9UYk5zBup48d3RnoOhlfkr2swktr
        gSGH5MqKPtZK/XuxPf33M8Wr6XOudiIaXWukW4SRJIojoI1AOENcdzTO4lrIeG4DEq2PRUv3CPLGc
        /g3c0liw==;
Received: from [10.20.10.232] (port=50360 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fgyce-007IiD-Ar; Sat, 21 Jul 2018 22:37:02 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id DC5E0200F6; Sat, 21 Jul 2018 22:36:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2] Makefile: add a DEVOPTS flag to get pedantic compilation
Date:   Sat, 21 Jul 2018 22:36:47 +0200
Message-Id: <20180721203647.2619-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: https://public-inbox.org/git/87wotobclv.fsf@evledraar.gmail.com/
References: 
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
+CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=no
+endif
 CFLAGS += -Wdeclaration-after-statement
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
-- 
2.18.0.203.gfac676dfb9

