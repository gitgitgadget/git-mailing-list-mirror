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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014AC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729E4608FB
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 12:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhGZMGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhGZMFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F39C061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so6167937wmb.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIB2AAOP3aOn+4x3Ic4fnOCSEJyID2+Csqbd4VIz00s=;
        b=JWZLANNp3L2n3AqoThF08TnfunL23DguTTLGkSd9r9QTJNmMdlfrTcccVUlf+YGoTz
         oJvEqc43Lnu9jDAGlvnzfd0kbR/kotR3h07ABIrjxKBTo5GakqwEm06+pDCsK4hDXix3
         qMbkMEiFVE6wY6/yd8545pd62AGM8Gwvd1bLY9gKQBEp4eL1oL2Ri8nm1rxohCsHpuMC
         5u/myty0Hxic/XX0E9Aw/yD68hVA7KDJYu03X9JfFKe8/kUX3F3PlKXBN4Mha47pAGdn
         hR2v/Qb2u6WMwD5OAqYFCBp8C0exOgl00d1GxLuJv3QBOm0EPd26gEbUgAC1stZe4YqP
         uf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIB2AAOP3aOn+4x3Ic4fnOCSEJyID2+Csqbd4VIz00s=;
        b=tmGNv0kVGxyPXBcVN7HSM5IRTvRgnWpLIZ+B4VYCtD+UuAXC4q6s0LjcxT0Rg7uAKw
         Wup7D7ViCLwgkAu8PcfGud4HCxx/x8D9FUZVWLAfZ4Fw6RFQRzGP6tZPVD+eqJmLBl9c
         86cmUR/aftnFbx5qFjwJQZn9pu3CBvs/61DnXc57spv/XOawiU6FWs7moh6jL2bz+bZZ
         c0Qzm41n6W0WcTz2gyIDZghDhqBi0159HirSqfRzTnnPkOEM+0qNJxwFl9VgEsPNOxDM
         Mb/YI+VRxMhD9ncE83yZ1PQIa/b1n6jwazYmRyiagOlbvYVgMccjEcLiztuJzr7hgpzy
         wqDA==
X-Gm-Message-State: AOAM532JKdlGG3B94TCRWm5OlAGRKWD/ZsG1x5615C/BhDTFPYFAVtKZ
        aLFnPK+qTB4lBhwnZIxxF8jAQRIqhRmNYg==
X-Google-Smtp-Source: ABdhPJz5vFuwQB56diJtFzL7QjN7LTr+lpQAH3p6DImnuLUx44jK1PJevYQPYZLOQ11UsOgX69IpqA==
X-Received: by 2002:a1c:9ace:: with SMTP id c197mr5501113wme.170.1627303573349;
        Mon, 26 Jul 2021 05:46:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm45155444wrg.68.2021.07.26.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 05:46:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/5] upload-pack: run is_repository_shallow() before setup_revisions()
Date:   Mon, 26 Jul 2021 14:46:06 +0200
Message-Id: <patch-1.5-b0c7ec31ca9-20210726T124425Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.956.g6b0c84ceda8
In-Reply-To: <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com> <cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_repository_shallow() added in b790e0f67cd (upload-pack:
send shallow info over stdin to pack-objects, 2014-03-11) to above
setup_revisions().

Running is_repository_shallow() before setup_revisions() doesn't
matter now, but in subsequent commits we'll make the code that
followed setup_revisions() happen inside a callback in that
function. This isolated change documents that re-arranging this part
of the code is OK in isolation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e0..1fbaa34f91b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3757,11 +3757,12 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	setup_revisions(ac, av, &revs, &s_r_opt);
+
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-- 
2.32.0.956.g6b0c84ceda8

