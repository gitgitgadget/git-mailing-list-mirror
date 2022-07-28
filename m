Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0025AC19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiG1QbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiG1Qap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0702316D
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so1283530wmj.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=H6nK1+tk2A5o/4nnlhxT77iNxS2xLnxijTm02b4meOY=;
        b=PxDuWuiA+/VNODGLHybpYqXDwwRHrti9eMKqoDvoTMWT1QDAL3UisedOr+MNazKBRe
         KArsCxXmkdd2SsxH7begVlXaLHS1dT0JQuqrQBU+zgZ5kDP11BDsXizqbEwFDLlnKZfv
         gb/btBhCs+mcFtRPvX3n0OCU9mdlpNR/0jJxBVhEFiRTMEmS2TOFU6p/mK7ZVrff069A
         HY8qgl2PDth5UB7OHXm+tsa/mHQU5ERJqCCbXqe6WmzuybSB+JXzpwpBA+rjtXMxII+m
         4jsz1LL2+ChFrS8J8orvRqBFrkG9NB7ktmB+89buuIwHdVC7U66XiA8jpm3ehUmi0r30
         xRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=H6nK1+tk2A5o/4nnlhxT77iNxS2xLnxijTm02b4meOY=;
        b=Jg9NArN1RgyDcpizcDuJDJEs/W9hbor3x4CsdyxG9BUxaQmEyEnOonhPlTdDbEGmVX
         slxL1QPuefXWr6WP2TtZzWp06j2lFuKSD2bd7saW+0dHDbYjPJHhGyLpwi7FkYSRHnFF
         AqJaUGO3FB8GFvQJxcKFg/qr4xlW1c94TBrQ66s423TZeT0S1OzhuVYthVM1awHrcO7I
         gbQ4pQ/nwVE3Um5KwyAK/d0P8NoBZxQQ0070FTCttI0ip4hDoI1XX4rUx8EMFHMHjMaC
         wMX9tIMaG9CNiCd8mNgEHFO4iQ3jVGyjogV1pAABdh9VU0hoxMJQ9dovs10Dc9M8HkiR
         OE4w==
X-Gm-Message-State: AJIora8fUzZyoNTMsg1jI9ubUJDtRctgkYJbufxQgUyboemNFkje+zOp
        ifRjDYfETbYz9vnESOLdXKpeNknQCAG6wg==
X-Google-Smtp-Source: AGRyM1tVh5yn8gK6VTEbGOLNoaL1A2Dlglo/7bpYTNJ2asn0aDEPmotbdqf0139WxEDX2RScZEtPAA==
X-Received: by 2002:a05:600c:4fc9:b0:3a3:3537:1726 with SMTP id o9-20020a05600c4fc900b003a335371726mr164877wmq.26.1659025834642;
        Thu, 28 Jul 2022 09:30:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/17] submodule--helper: free rest of "displaypath" in "struct update_data"
Date:   Thu, 28 Jul 2022 18:30:10 +0200
Message-Id: <patch-v4-16.17-c0fba2f1c56-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24), we clobber the "displaypath" member of
the passed-in "struct update_data" both so that die() messages in this
update_submodule() function itself can use it, and for the
run_update_procedure() called within this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2e39750fb06..2a171d25992 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2460,10 +2460,11 @@ static int update_submodule(struct update_data *update_data,
 			    int *must_die_on_failure)
 {
 	int ret = 1;
+	char *to_free, *restore = update_data->displaypath;
 
 	ensure_core_worktree(update_data->sm_path);
 
-	update_data->displaypath = get_submodule_displaypath(
+	update_data->displaypath = to_free = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
@@ -2537,6 +2538,9 @@ static int update_submodule(struct update_data *update_data,
 
 	ret = 0;
 cleanup:
+	free(to_free);
+	update_data->displaypath = restore;
+
 	return ret;
 }
 
-- 
2.37.1.1197.g7ed548b7807

