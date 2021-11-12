Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD90C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDFE60F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhKLVwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhKLVwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C78C061210
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i5so17929126wrb.2
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYybH9DBZhcZ62MZaPH+VEpmGWYx30Z1Uk/F0PjaC+I=;
        b=ArP9CM8ko948j57t/tfXL4feWFlL41VUX6HXuIu1xgbgeOaffmpUJkocmpyuj1LMJ+
         7XGtrNb1QjHlDxl/LdZ7ktYZ+c5579NZwoKebaUQMMnvTZkD7QW57oOFZAJus8Q+W3Bk
         cVGu1767yaNv7DoCLD33DNb4gsXxu4JbFwBzkljrT4ej6RtpOVXtK4aTEDOYlx6P+KNQ
         NyGn0gqf5JOE1gss1Wt3XnyDzZDY6Ff+HUemiJt/m9TY0BUd3hFbMs0FooKrA0yNh5E3
         dK37hdX9V7MHeHaM7h7hWYO7oRhqY80PrVyAJRWGUNkzPVprmDVaKbPSq4CN1XPo0OcZ
         /wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYybH9DBZhcZ62MZaPH+VEpmGWYx30Z1Uk/F0PjaC+I=;
        b=WRcJuAlG46t5tKxQWSsMdRF0UE791Ed9yF+gxDYjs9WcHyf114vVk5/bY/HMOaoX7H
         gUz4tWw/duFTdcKwUJrNCCiLBlckXYfQAgfC0Ds1GcJuhxm9JsoFJXzOrmV/Cbep3lwG
         gZrD6uhxaARJuyxBbFvkStkAqpXqfPN9qG9KvXYLOir8cZVEcsDYgkc/Mt7qtDI8waZp
         MD2g88B90VWgqcflFryKzditkcOcauOM5uj2mtiAq3Y/UIwz8hwLWnWk0NcaMlSnTwxg
         3Xe2V9Z8BZLGBYTY++zxEoTk/ySPud1j0qu/nlsv3Ti9Wrb/WGA6UqHovuzGW/LAPi65
         pJPQ==
X-Gm-Message-State: AOAM531uH+slvR84CBXfRWUR2P9vZE3oZzZEc6sjgR1zoU5HvKbaSmul
        1oXY6YY4NHvCDLO+wrLFDZVAVdjGNtAeCQ==
X-Google-Smtp-Source: ABdhPJy9QoDsniT85XlCUKAyr2aLf+glJwJRVx3Gffuf63v2MGiHNc3H/NxJF8pF4gAulv4aO7Txlw==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr22493205wri.222.1636753753063;
        Fri, 12 Nov 2021 13:49:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/18] Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
Date:   Fri, 12 Nov 2021 22:48:51 +0100
Message-Id: <patch-v2-07.18-e06732d4639-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the NO_PERL variable assignments so that they declare the much
smaller fallback condition first.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 0cb10f00ebb..288f4834db8 100644
--- a/Makefile
+++ b/Makefile
@@ -2291,7 +2291,15 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
-ifndef NO_PERL
+ifdef NO_PERL
+$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
+	$(QUIET_GEN) \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
+	    unimplemented.sh >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+else # NO_PERL
 # Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
 # since the locale directory is injected.
 perl_localedir_SQ = $(localedir_SQ)
@@ -2363,14 +2371,6 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
 	mv $@+ $@
-else # NO_PERL
-$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
-	$(QUIET_GEN) \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-	    unimplemented.sh >$@+ && \
-	chmod +x $@+ && \
-	mv $@+ $@
 endif # NO_PERL
 
 # This makes sure we depend on the NO_PYTHON setting itself.
-- 
2.34.0.rc2.795.g926201d1cc8

