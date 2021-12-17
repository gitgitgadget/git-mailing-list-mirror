Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F041C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhLQA0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLQA0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C4C06173F
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j18so993492wrd.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4W5R5JEYJvYjWALoaXmaOm0pyfxrhI+5IquyE5fH5w=;
        b=jXgYbY5DWJOHtVhspBjTU2+AQhUtUIyLtqap8Np9WCm6fhDD9w6UiMstnjXjLM/i3B
         v/pVkU+Uc6InKViGlo5xxO4b0DSESpEjSgPDp4CjKD1hjNpQuOngYXx1qC5EYdIzmCiA
         ovy1KpNIX+8MPTvNbWM5iXdKqZh8f6MrOE+8mzcuuj+QiGvoHmRxekJ+iZuDtlYgchCA
         2i/djBp4V3OJEJva4A3G16Gh5YsXtt3CVJJBVgYYALxOxXCmKFAIPpiyqKPXzExVynrV
         jQ3gXJ5euWc+Zx306Lo3g0/rui6AtfhuFqJsvOb+2rh6UN3k2CjVRI6ogVfS0YU8lTx9
         EfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4W5R5JEYJvYjWALoaXmaOm0pyfxrhI+5IquyE5fH5w=;
        b=mghCxxaAp+9tfOx+KM0FsWuNRG7tTkDx7zXRPHfaF+ZaV37pIAxg4kpoq+vyHL/l+3
         vmwgGaSfkxXRO4IkzJ0qotVg+OQhur2vgw0Sd0h7yi6I+kIo/N3OeU1H6LeiDOyqgL+J
         Qm6s1A/S6Om+6nL4lIzla+wHIyX0XcN7TPDpCPR+pq0Cmq5E0j8/Knsa+3VnGDVbFnbJ
         NiPDPspavNCxg9R6vidfC/KavUJZpkKe+Sr5hbKIBCUN3hXq8bCiwZ0qv86VhkMmhm8C
         DhjfeJRTSG3YI6E2uRFJGQBMoaa7T/cBRHCVuyxOqQJkX6Vz8ZgTrLig2Q3hmxmEbuIi
         dVnQ==
X-Gm-Message-State: AOAM532fFznABO8DEX9pCDEzVeP5zVMQNs8M04lL9SuLvjwsiL4wR5pG
        +sgl4001qJFIUq4Sl5pkP0EgqXfO8TOqlA==
X-Google-Smtp-Source: ABdhPJy/DedXbunwTrxeMrR7/6tr8D58kv0V8i6qzAw3ZjeTHnBi4vY4emOlBQm23hhHhmmnWcY8Cw==
X-Received: by 2002:a05:6000:2a4:: with SMTP id l4mr371155wry.238.1639700796712;
        Thu, 16 Dec 2021 16:26:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/11] Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
Date:   Fri, 17 Dec 2021 01:26:22 +0100
Message-Id: <patch-06.11-5e94ef729fe-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
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
index 780f222face..4bb2da36e4e 100644
--- a/Makefile
+++ b/Makefile
@@ -2301,7 +2301,15 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
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
@@ -2373,14 +2381,6 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
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
2.34.1.1119.g7a3fc8778ee

