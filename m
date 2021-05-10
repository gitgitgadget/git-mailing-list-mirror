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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A634C19773
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E3761075
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhEJLNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhEJK6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C3C034602
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m12so23825599eja.2
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=es1nebJMPl+ZLX5xfTWOxRD8gkAC3gkOeNtJ/aNOA2E=;
        b=kja/V8jb1TSGx8GK0ov9NZFVfvYy+MmGGENIOvLVBUW5nR3aS08kqUfnm0w9ZHyT+w
         pfV7lxLURsnjTFy0Fk6j7p7vAFHbyN1M2grSSI7LQkWtu3M2MzpCqRlpSBM7t4O1g6U3
         pPAgmqkBxIIyjnOioPjThd9DoYTkMTE0195VPjALB4b090l+CC1/4JVpIqD5nbV3Ncv9
         otMdT0PJI7L/PFYhijEQbovDtaB+QEIWwFyTs2e2B9+xusx0HMlwtBF4S8mHAEm5OOjx
         SLDBUl7gHkdXhbywhIwUqV8SVFFjrGZ0BZY8uvNalxE2pmyLCGQhAMOkJzOVmm+uEVGa
         ctSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es1nebJMPl+ZLX5xfTWOxRD8gkAC3gkOeNtJ/aNOA2E=;
        b=EXDLglWa+Y95a6RFNzeHDxis4rtLq1LaoyiDtakW6NwWLY1JgbweGGiG43+FpSZEfW
         7omHTxJdx9Fy0nVPC3yPLK3lLUDSdzIyVUer1PS+TEz9Xs+9+0Sc0F7UoT1sG17rnkfM
         TaIP9/cqkRStORYDPFThjoUmdbD7Mjz9bxlASsv6BQp81/+akVa5TiXLo6AFFheAL7/T
         RUU01B+Eh6fYj0HUhCieoOG+BmecWwh1bH3bn8XE0WRqyCZ0YfF/OwCQ6G6D2CH+CLGx
         K5ebwaCUXIcY9vavPbCeTnWb0dOgZOsTkw91iTVv7NpiRP/dsA2XV1m3/VOAZvm8OikT
         dfCg==
X-Gm-Message-State: AOAM533i1/c5YuPhA5iKtaxIPpwXGBgp79lOKbpg2EqLb9R0OIZo0uXr
        auL88QQtEha5W7NlsBGezsWVKpxcZaHVoQ==
X-Google-Smtp-Source: ABdhPJysnFEb1wYvsM3ImSK4BkB0TeG3UVWsoyHsOIZBftHbKF+OML8n7lj0UWCKD8U3f5es9lualA==
X-Received: by 2002:a17:906:d145:: with SMTP id br5mr24477972ejb.452.1620643831779;
        Mon, 10 May 2021 03:50:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
Date:   Mon, 10 May 2021 12:50:21 +0200
Message-Id: <patch-5.6-1171b73256e-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com> <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regenerate the *.pm files in perl/build/* if the
NO_PERL_CPAN_FALLBACKS flag added to the *.pm files in
1aca69c0195 (perl Git::LoadCPAN: emit better errors under
NO_PERL_CPAN_FALLBACKS, 2018-03-03) is changed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 4f68f5e1dba..aaa972c56aa 100644
--- a/Makefile
+++ b/Makefile
@@ -2275,6 +2275,7 @@ PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
+PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
 # into Perl scripts.
-- 
2.31.1.838.g924d365b763

