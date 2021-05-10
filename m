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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3813C43470
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C457261041
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhEJLMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhEJK6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16EC035433
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so18148473edn.7
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1URNNKmMjwn47oZp8HI/A6GyRvPCwpjgQQ+F2Tud8I=;
        b=gzloYD6gXKjaaitJvkkyWPW1XAHpZE2E6fST43ZFSFtiFj2NnqilggEci4lkBuhuzv
         jojrpDaEXs5bAtKovRDmR+EWVulVKiHjqeuJaECBRSLIxoXQQ9QPt4cNTPG+xD+03mam
         Epva8ait4bM+wF09QwL7c3g44UkBrrlrPkDLsjF6hrqloChfygDl0tMPtRznnS+nFhWD
         hqdIEupIqQYY5VtCGHW+yqqHXU+Uo7vVLS5XESm/G6zUwr/h6Iyd3xy+gSIbzB8I3g6B
         pOtAFyrUvyp9uwwtLFuieAhRbR6JTDqY0U6Zj1XvALyvZLWdoPmF8NxCcPGBtHWrVZca
         7A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1URNNKmMjwn47oZp8HI/A6GyRvPCwpjgQQ+F2Tud8I=;
        b=DaKbTvXZMCV3C/RTN6Ka7gwtkOxUpPUnH+P77RN9ZhXKfXOwT8MV5g8hOoG4vjt26D
         habB1pVORnjRRWQPdVTGUk1iluImKvjZD/re0Rg86SsGEpnL9C1pG/g6E6Y+VYQZYXTX
         ISQfI3x4oo3iVEztvOFRv4ys+7zG4wRH9vOYIR8reuPYSfdz/3MIZkUgDRm1lrCetiji
         PtxYM3QMRLPWptOk5iBhwW//6pz/mGqkq0St0bn1FtSVjvOYcZ4u1qWu79e+euSS+VZj
         SucLgpYK/VLs+Pi1xKabRbeW25ISsjBkiRXWYquNGdj9arQH4eMgBRPZiOD5J5iSQitx
         l0Kw==
X-Gm-Message-State: AOAM5316qjGKo1zdJT8CNyIQlNSn9pfDTtFhWzl0jXJ5DbalMc1buqlm
        uFg9BtSYH4JVNpJRahi8yoVPqbvZLizKOQ==
X-Google-Smtp-Source: ABdhPJykgxYQIEJTsolWe5HS1SpWtWM7ScwJLAZPBxryMLq6iQXI23/u3RWLUWbx5Nk6+sVt+lLUqQ==
X-Received: by 2002:a50:bec7:: with SMTP id e7mr29319409edk.295.1620643828761;
        Mon, 10 May 2021 03:50:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
Date:   Mon, 10 May 2021 12:50:17 +0200
Message-Id: <patch-1.6-8b899364916-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com> <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the logic to generate perl/build/* to regenerate those files if
GIT-PERL-DEFINES changes. This ensures that e.g. changing localedir
will result in correctly re-generated files.

I don't think that ever worked. The brokenness pre-dates my
20d2a30f8ff (Makefile: replace perl/Makefile.PL with simple make
rules, 2017-12-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 93664d67146..ad618cea33f 100644
--- a/Makefile
+++ b/Makefile
@@ -2675,7 +2675,7 @@ endif
 NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
-perl/build/lib/%.pm: perl/%.pm
+perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
-- 
2.31.1.838.g924d365b763

