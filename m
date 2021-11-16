Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26195C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA1B61040
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhKPMFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB9C061220
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s13so37114115wrb.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y8Ujq6qGOd3NqRgUwFyGFX0aUIjId4CKZRnoX3PP1U=;
        b=LaKVfMSytuPNC0kYU8HeZt1T0DAKdOIOHrA/wIN4SDv+tCxXguqx+HnLI4Ep2pU6IM
         mJNJKyJfXIB8Kv/ztT544z14HghlQ44rIP7aMgiGLhZByYKtBEjdUWVRt7hjkoPM1IfP
         qpu8kyR5Vg2+xuhDMtmV0g30C6NfQxqg4P2QqjxYj0dJzP2fxnsMWpMpTXgk2XsKpy8Z
         88QM6/hyo5z7gcxUsnggDooDbt/G8z5sfm1jwYQ3Pa+Cy6HRIjgoCAcs2yG8hX2/jU5+
         I8kJbO6KRlPKocmru2Mmyu0x1V08T//fVIYFL/XpqJl3NlID0nE2J8p7gpl2cFiHjlWP
         O3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y8Ujq6qGOd3NqRgUwFyGFX0aUIjId4CKZRnoX3PP1U=;
        b=HYN/vLba6neirrnF8lnlWUFEJUIaWf10pPphaain/4cIa2i18/3z0C/zqNlZVVKDj6
         uVrvZcspyipeoiyxev5qQsyX+882iydvsFa93+WSTVBLRRFEqnNOMINHz+0zMhIRHi4K
         g+Rxli3GdjGZ4DPFXQmTdMmGTW2tugiqoYDaHJ5EfBWlq10zDXeyECa9zba9Nw3BaxPq
         L5/LocXrM2KX/1dKQm1IM5Mwdum4uxoflN0GmDkatbqNLF6/1jU2gZvJTPQnmeFGydTT
         OZpEr1ORKbBDVl531WkSwcgHmEd84nQo0csOQtwCWL687SsYdRZ+n3BtagMkGUgc7oRk
         kG6A==
X-Gm-Message-State: AOAM533zi1u2aRL7kWMUP3ScWXD95Nuoy/MAbzr+FkfLFdPNYJEwE9iv
        vKfqTsueHNfiJu0krpACS8JuMtR0Kalzww==
X-Google-Smtp-Source: ABdhPJzNeIiSQdvXep22XEimZOw6a38lOSpy5btba3Y0jBOy5++yGKtWMJbFjh/tlclK43CoJJKxsA==
X-Received: by 2002:a05:6000:15c1:: with SMTP id y1mr8765778wry.63.1637064038971;
        Tue, 16 Nov 2021 04:00:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:38 -0800 (PST)
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
Subject: [PATCH v3 05/23] Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
Date:   Tue, 16 Nov 2021 13:00:05 +0100
Message-Id: <patch-v3-05.23-e38c90ad0b6-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29) we don't need to guard the clobbering of $@ with this sort
of "mv $@+ $@" pattern in these cases where we're merely generating a
file that'll be used as a dependency for other files, as in this case
for GIT-PERL-HEADER.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a71fba15e30..284725099c9 100644
--- a/Makefile
+++ b/Makefile
@@ -2349,8 +2349,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
-	    $< >$@+ && \
-	mv $@+ $@
+	    $< >$@
 
 .PHONY: perllibdir
 perllibdir:
-- 
2.34.0.795.g1e9501ab396

