Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BCC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2162082D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbhAZQKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392763AbhAZQH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:07:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FEFC0611BD
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h9so6805483wrr.9
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpYFacqbcgRlS2Rw7rSVnc/x45fvjXSh9JHwzm7kxBI=;
        b=WJCow6DhKSyIX/X0CHgN6wMJzCPcCBLoFwaERWG9r1Q4apXoBF/qJpzUFjXMiwRXdQ
         FSaHPfz6oX2ZcMMx6j83rPOqI3L9F2k5rM6a0liOsEQmnBIIOk72dyXpOO4GJ6ln1CLC
         XThDPqe6rFBGE7bLvfKuOXxzQVUPvgHSU4fD+iujULRI5FaoTKC9blfv8lR6BN9BNVt2
         /W7zfK1iHHbSmcLKdpVakUTsIoKaByBj9U27+E7OGAYRMLB9b43hV8XCPdWj/xf62lHz
         JsGmZnz/9864l4F1GlsTB0he9KBblO85uuMximxVWyJnra6aOPnJDqJbE7yicCP4DCaO
         /22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpYFacqbcgRlS2Rw7rSVnc/x45fvjXSh9JHwzm7kxBI=;
        b=KW/a1lufJuYPiucIz6ZGmbQmwEeXL3j7Cqz53q6NLEaAvVDTuDpbc0n5eG5BeoCqF1
         ht6/LyU2z20QaoPeMYMvIFSQtF0BiQ3hAlj1Mv2xkbYFz+ZwETs/CH+Hg3LhxfEvw9IH
         fFn+HVDBBSteRaI/JkibACy7CdMcjxC5Zvwc9SzxkcZFoPYfEwsdUNuXuhvZYsZb99NG
         d7VzRj2b99PqWKZNCs5eLl6y8URS+HliS1MYixtIcSytzkGQm0ANYBb0etRmhSbXLBEY
         suAIQvC7QuWx9s0wopIHdG0MWTyNDtuRs/vV7/WcWkb54+stZe7bP0kh5IDTYEjn3fZ9
         QyAg==
X-Gm-Message-State: AOAM530opqZeCcN0KSD2b8L2BofIVyLZ2fwvZbtIYCTLJMXT+XI9e70E
        Iav3DWwGuswVahve3lgShO2JtHuAnE+DMQ==
X-Google-Smtp-Source: ABdhPJyQBjjKuk18rFK9bl3bhzciihzrIPJQiFmUJxErFkI5iIpKojoNUzR1ufQDsz+1AR+HfmhJyg==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr7055467wrt.404.1611677235941;
        Tue, 26 Jan 2021 08:07:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17209743wro.27.2021.01.26.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:07:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] Makefile: refactor for subsequent change
Date:   Tue, 26 Jan 2021 17:07:06 +0100
Message-Id: <20210126160708.20903-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210126160708.20903-1-avarab@gmail.com>
References: <20210126160708.20903-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the list of test programs into a handy variable. This does
not matter now, but will make a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 36c7b8fa08b..4031fb1b22f 100644
--- a/Makefile
+++ b/Makefile
@@ -2788,8 +2788,9 @@ GIT-PYTHON-VARS: FORCE
 endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+TEST_TOOLS = $(TEST_PROGRAMS) $(test_bindir_programs)
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+all:: $(TEST_TOOLS)
 
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
-- 
2.29.2.222.g5d2a92d10f8

