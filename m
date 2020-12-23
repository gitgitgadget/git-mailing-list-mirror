Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39186C433E9
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C9B2256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLWBi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgLWBi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:26 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD504C06179C
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a6so3958054wmc.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrbByApAc2jmxVM97g3BogSoAof9RtN1ukD6xQV4Lfs=;
        b=CBgTUKg9TnBisNUtSJc77hqqBACjgfJkbhDmKzW6YAmzEvqg+P1zbI6x5A4CMkViJ2
         zh5WKpOs+5SL3gwqwNKLjF4Pfyid/fPd0pMgdCwoDY9ULKSwkyMvBMNXKdQE7j2OqSN9
         lQ05g3i0f8VEx9ARd9qydBNvZqm/jqub1pQ/KFBALsd3PMD0e+Yb6ctQKnft+GWAFkML
         SMdPxX/syBq9NzDQCCePqAq5FoOS42NdZj3o3Svcx47aKDT/7TvlU7XYZZveNlQjRRhw
         VghBPj1/+6ozorroN4mpiBaDbtwis1J5duXc85QWDEBO2tj1B9JQxw11/FcBSAvwxiQM
         D0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrbByApAc2jmxVM97g3BogSoAof9RtN1ukD6xQV4Lfs=;
        b=RqfxxBvxD2Ccfz5EX/xFCIAtjb59OQu+GM/oCGBweSWiCIi1eY4TjLeuFMVxZkr6TN
         DESQVYkeAYeN5ncjnd2LyXyzqA19XDAJ2PhvmIcGVT1Fj8+BrYiv+naCDx8wKv9JYh76
         a0w6ZDgrqZzhSJuD5KcnwPgtwmemCpn4G937XlMyiIxhVdTgUOCAqQ4OEL9KdMtofBCa
         y27sPuQuwXe4y+1ubpjQkPGE/oJMHAYydITTlEqH4Y57/X0TgE7Y4rb7RZzdvbbR89XF
         nxIDGwSMEPfc2ck7WDKUmxJbHutGdVa+vtauRjN2EwizbchgoVu48JFYoTVOZPNtfCaH
         sdRQ==
X-Gm-Message-State: AOAM531VS3aV3W/rAqX2d3zdA2ZLNib7Na/Nr51eBleSQuoN+UfSIuFK
        qO+gWC4klHFsnjx683hWJFqxVc1uBkLMYA==
X-Google-Smtp-Source: ABdhPJxBLngR0Nv4TP7aidg4PwZk55rAkIb1VFhARBM01yRwwHV/qErTRrJTyrtNzrXOGUMpGrZcYw==
X-Received: by 2002:a7b:c259:: with SMTP id b25mr24679133wmj.40.1608687464327;
        Tue, 22 Dec 2020 17:37:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/20] mktag doc: grammar fix, when exists -> when it exists
Date:   Wed, 23 Dec 2020 02:35:47 +0100
Message-Id: <20201223013606.7972-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the wording of documentation added in 6cfec03680 (mktag:
minimally update the description., 2007-06-10). It makes more sense to
say "when it exists" here, as we're referring to "the message".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index a158428eb9..1b0667e372 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -29,7 +29,7 @@ has a very simple fixed format: four lines of
   tagger <tagger>
 
 followed by some 'optional' free-form message (some tags created
-by older Git may not have `tagger` line).  The message, when
+by older Git may not have `tagger` line).  The message, when it
 exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
-- 
2.29.2.222.g5d2a92d10f8

