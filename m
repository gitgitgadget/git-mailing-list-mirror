Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B8C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 10:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786B061130
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 10:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhI1K4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbhI1K4I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 06:56:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EEC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 03:54:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x4so6405880pln.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71mPEPcKxips2n9+90w81lqkfDmnSU8eNVgO9GLReL8=;
        b=WpZJPeqYMfp8Edfi1ua8IQ20n25EFSyd/6ybi1iagzk23GF7oAyQIWJVyMOqC9V4/M
         Ap9mhE2Ki5gUsdVBkNu9u1/XIvO4wyx89erJeRgOUbaS/qbZ56wooo+7o8bGcbR9yy6Z
         0bTXxn0hfeZ/maZfZCQCLoDnYSKtaL8nnVUWtAe+Pk9DLtVdkoQvB+Bt2SJwxTaTmStp
         S1ukf2J5AAXCajy5/MbkCEoJvepx0USC2nnCwKHiZSan3W6Ou9mKssMGvJm2swpVPyoV
         sXnucibppRdm1rdU8xjl/9UnCgxP6Cn4vGqBz/6yLSJPSL9ApIYGG72v6YwQK4QiLXUv
         PsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71mPEPcKxips2n9+90w81lqkfDmnSU8eNVgO9GLReL8=;
        b=tdN9ZZ7RvbmiZP7Mf3JEW4s5FbZzBBAgJ3CRD+yaoGOQjR+Vl9EChToU1GJx+xg4UL
         y+ImsKeGwgVkDGzgWB1udivcpNrIemImopjSTBjo8VfmSccrXy6EM8iOL8zje/Lxu8te
         SwIcNZsPoO3siyHdxIRZ1JFwEAbcEdqX+/WcrpRH3Q83r7BHClVfAhbtiggYaountOTo
         WF5Ta1aFmKzTff2DB9upUtircU104dgL78kkKzvkYxY2dV+T7SypBFQ845y0p/sIIkWe
         3nSFMmlqyuKFiXYPNtsH3RBEiN+3G66LPDlZQfuvL9XDNL+x5tV1up5qfyxYBNAP1hYy
         XMLA==
X-Gm-Message-State: AOAM533mCEbmN045KOCe/F0IjVWVpLWkxWDRKVhOvyC1P6sIzdenl5II
        9FOe7dw0Z6JvA0hoh69KMnRY7Hgx4Ed6MQ==
X-Google-Smtp-Source: ABdhPJzQfq97wA+2zf9kZ8jqTvWtoQfjU71DYxmcGIBbrq52ae5syzS34Jb5ZyrHD1OX8S2FjdJHaw==
X-Received: by 2002:a17:903:11c9:b0:13b:9a01:aa27 with SMTP id q9-20020a17090311c900b0013b9a01aa27mr4437975plh.46.1632826467166;
        Tue, 28 Sep 2021 03:54:27 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id d14sm20325099pfr.123.2021.09.28.03.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:54:26 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] bisect--helper: add space between colon and following sentence
Date:   Tue, 28 Sep 2021 17:53:53 +0700
Message-Id: <20210928105352.500265-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing space between colon sentence (`bisect-run failed:`) and the
following sentence (`git bisect--helper --bisect-state`).

Fixes: d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13)
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bc210b23c8..28a2e6a575 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1157,7 +1157,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed:'git bisect--helper --bisect-state"
+			error(_("bisect run failed: 'git bisect--helper --bisect-state"
 			" %s' exited with error code %d"), args.v[0], res);
 		} else {
 			continue;

base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0
-- 
An old man doll... just what I always wanted! - Clara

