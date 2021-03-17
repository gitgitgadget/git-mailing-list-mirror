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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CD5C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8994464F45
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCQN2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCQN2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:28:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E883C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so1840784wrn.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACCj49hyr765l6Gy6oWTa7XyouF3E3+19J/B1RsAP1Y=;
        b=YyhGixSDLhXXfn5XPVoK7ElsyDi2B1Q/4qM04fgWUtafzKgZOzH8eWG5yRsTNN491X
         Ngb/1H8hu6oi9pQThC/0KyFtkpgarSYCIrKRtym132f1h2ioyHsIqM5CyuvNt47thqdA
         uoaip4PLJZxs8eTIZ3qhcXgummcYvCaOyLfeXFZtu4lDh3xgFUebpEaxtmrTsYArXC/E
         S6+8F1CEnp+Ux1IgRUhnQirZ35QhvXjvCg6dtY6kFtO3JwMzgRdH66/EZLLDm/UbfVmR
         WFPSFEwhNt9ZxUR7n+Zso15SN0vKpwQ/DsjhVYApo/H4mG117p5sCKvzkjXSkNRurLt8
         dzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACCj49hyr765l6Gy6oWTa7XyouF3E3+19J/B1RsAP1Y=;
        b=HYKSJFclowoaii/aTkaderSlKIKfItitnarVImOFDcJJPVs7NXczp5eRN4/HJwIdfx
         h6dNKtnEzqQuLM2KePxHHlPbXTwqtmw7k+96+f1QTHQkdsbtgGJ4GBPqQ7D3vtBjEw1Q
         9VqnI03JMSan6usUWVFRZpvX339wWTU0/iwrHMI9TUWzwY4UKnXzVmGZzlu4OP2SdmXQ
         xLS0VSgRM/MUEXEgx+dQ39auJoiTQpljPvR+ScFelkhAnP0wbgitBAaeYllk8KU395Zx
         sSbrwarDXzaeazJDNUU0cIfYLWDiKboQRlTZ3qYbah7AFcMGwM+XUdGtR7X3X0pATpfk
         +TWQ==
X-Gm-Message-State: AOAM533pfB3b9j7ZBogM838R7IQuTQ4lF65rkAHVUZyRs6ASGVML35OO
        jfhds/h8qpVyOLvxxz1AX8TGOjL7YmVyNg==
X-Google-Smtp-Source: ABdhPJwwR+CtnoYAVdYD+wLCOX2O1y+NcpK4ERAbu63WxSswogI8bB79JxK0KjeCR5WROgtI3o7Taw==
X-Received: by 2002:a5d:4532:: with SMTP id j18mr4363239wra.239.1615987713992;
        Wed, 17 Mar 2021 06:28:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm26061448wrt.70.2021.03.17.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:28:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: [RFC/PATCH 2/5] ls-files: make "mode" in show_ce() loop a variable
Date:   Wed, 17 Mar 2021 14:28:11 +0100
Message-Id: <20210317132814.30175-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit I'll optionally change the mode in a new sparse
mode, let's do this first to make that change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index eb72d16493..4db75351f2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -242,9 +242,17 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 		if (!show_stage) {
 			fputs(tag, stdout);
 		} else {
+			unsigned int mode = ce->ce_mode;
+			if (show_sparse && S_ISSPARSEDIR(mode))
+				/*
+				 * We could just do & 0177777 all the
+				 * time, just make it clear this is
+				 * for --stage-sparse.
+				 */
+				mode &= 0177777;
 			printf("%s%06o %s %d\t",
 			       tag,
-			       ce->ce_mode,
+			       mode,
 			       find_unique_abbrev(&ce->oid, abbrev),
 			       ce_stage(ce));
 		}
-- 
2.31.0.260.g719c683c1d

