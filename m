Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A2C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B13061BAA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhKQKXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhKQKXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704FC061200
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o29so1689471wms.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioLkPq9nUvdEDMhLisH+SQLwIBW2WR9NSvP/bDOJrQI=;
        b=bwtLm0pz6agGdYdCKqqTdXgTYZ1GIdgT4Y0U7gv+ajZa6yICvu3f4EKVwPnN7qF9aK
         1K4XV0TgYmXQGvtcYjFzQMOpH00ll1P29PO4Q8Ns2pQl0yZx6I28R83FOY3VMZSQk5+P
         GM2sypcve/amZdps9AlDxKBbn2V84fIXleHsfI7SF7Xvn5Gb7DCd5sxqTebHJBreTlSY
         7zoaaZSjalILaWqR1qB1TWfZ1oa/CQOKnICl+ROt1itHfKsG9r2EVHT6X0xzFB0xt3tq
         HKuvFULvdnDkr+QVuYhV4VZxed6LKaUMmX8Xfl8OsP/GEWHBWFbP35vF+tTfOOLxTGef
         33tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioLkPq9nUvdEDMhLisH+SQLwIBW2WR9NSvP/bDOJrQI=;
        b=vkWf1wWd7xI/NCGcqIK0RRaWs+yjl3jXzbT6IVmLtDtq7yGqD94qAcKBENretX+EKe
         TYiP6pVgZsnnpXDzL4ex886gSHteiqMk3mwFV9YgJZjT214VGC9Na2wSYDOXn0CJWxeV
         tnDn65o4tUVsVVzMCyk2ImPsuFmDFme2zbfF4CXA4ynsJoEeZ/NJJj2NysxLHLkP4xb6
         fDYNS3wFQXIvwjEM5pvf3mbeBd1NZYE3g/UriEulA6illUMF9r7YXkWRTXvZHt197K+4
         SBYx5m8X0GHJgNIXBrHZxhiXC805g74ySVjal5WT3DwAlwTITk83R/p69xBIBOowBvlr
         zsSA==
X-Gm-Message-State: AOAM530d05CXVOLBuNm7D3MwxZAU1fUf0vXYJUmyuhIWp/K6ovDqEpJg
        vUsIhAnYFLIkQdXqkwc8E999Yo2LJH6+VQ==
X-Google-Smtp-Source: ABdhPJwiaXe2MQ59L9P9GfHLmyqFIWPCb/5VEUvAFm7cdgp1g0x7OdCXZ/HJ4D8F8Uv9vj3ZUmsxXw==
X-Received: by 2002:a05:600c:1d0e:: with SMTP id l14mr75321840wms.64.1637144431367;
        Wed, 17 Nov 2021 02:20:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:30 -0800 (PST)
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
Subject: [PATCH v4 07/23] Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
Date:   Wed, 17 Nov 2021 11:20:06 +0100
Message-Id: <patch-v4-07.23-fcdee92f64c-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
2.34.0.796.g2c87ed6146a

