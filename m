Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E61C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06A161414
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhKPMGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhKPMEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8385C061226
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d24so37129048wra.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klTjINaqjN/jgn6GXv6s9qPSilPAQPY1xHxfkZ7f6cc=;
        b=ZYUGXaTTIlve/ooopKOzBUWlja/lQoLz+jXtx8VaQdmnISUrzwQRFIqXkgFaDxgKwT
         SXtyW4IvK3+MbLHxiXPciJCc8271vdmAMumP8sO3clarU7MYrSfE1+KI5qYM0GFexdXR
         NKU4AKuTTDWjkGGrhMHYx7+JPCS42KwH4lhFkbANTPlOXUUVSK36DdOHPOkdTOsaaJhq
         Bd0mOWj96XdI+2UUufKtlGNidffx32INVdIB3eSdqsUeDlCWeRcnS+WaaCxavpbD+qLd
         WJ5phbuev4kIZL8SICD7hb+Ea6AlKo+glrwX6GxhBJXfj2uMR/PRKBC8qIWmc4D6zZv9
         1C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klTjINaqjN/jgn6GXv6s9qPSilPAQPY1xHxfkZ7f6cc=;
        b=h/A91UX2l4OK3L8UiPwZD7N8AZcSRDK0k7OeeVSmQJ1XxYP/00tZNPHANCnKA5wAqv
         x4QaIMNSVfKwNXlA9/WQUwQfKQag97ny9K70E1DRgZlOFWCdrfLUMkro9nnnB3WCx/PF
         SoEmGPy3IrIX6Fu+CGVxb56EFvtFIk3JsIt+8LR9fHegUUa+jcksKWDSqJSHwmwSLj7o
         lCiNYZbQ5Qn2RsfSWg3SkVKziVVg730VmYnmbp8JoxKtPGm8dpeYTMUW7v1V8CICh53I
         +5eL16WMYdK4kZ8jwV6/WG1SbJyK59ZokmXcJUL9nmr9OYPaM+PvfkVYV8NJMrvQj/Sv
         +6zQ==
X-Gm-Message-State: AOAM5336igivJjBAcaz/ZGN60Hl6eP0dnsRNvU3laNG9xJycbKLcvXDq
        FSE2ALz9TWYaWGwhMXkt5h1LUkin6TPC5w==
X-Google-Smtp-Source: ABdhPJyh88vyeCt18BxK9vrpELA3JqKGInYHQpDG7nmARpjNSXzKqea/pHM4HI1rQjQTu46WwH+L8g==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr8667679wrp.112.1637064040328;
        Tue, 16 Nov 2021 04:00:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/23] Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
Date:   Tue, 16 Nov 2021 13:00:07 +0100
Message-Id: <patch-v3-07.23-047a42b01cf-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

