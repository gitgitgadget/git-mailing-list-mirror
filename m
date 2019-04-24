Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F89B1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfDXPO5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46335 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbfDXPOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id w73so8879913qkb.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ictdyif0MDE7m6xyHh5Pe8kojmrVawufZ/3Rr7I3XpI=;
        b=Iq+3dLx8dzmFOwYfqF27iuDmf8qQW8KL0aBhT5xr7P9oSADBADiGVjsbzycwFNdg9/
         7ZnhMAtiG+XRECRpo0avsv7J2TftDfbk93Rkfe7auT0eZdRk7aKGOaq3vA0881vgbyzH
         3HArFr9xx0celf0dgQt3nyXYp67mmie86GTmTi7GXdh/dNQ55pKC31EIVQgHCEtSstQx
         ZjjPu7/Y9dW3iZMlP7XsZ/xPcYYvkEXPnR1iNFx5y+ElT3bcstv+kr1UDKUiwdr3njaL
         f2u0+WZVHMXMcRf+8V78Feud06J30isPexed++bMzK25sbp32HWfAt05ab0l3YiaEq3A
         Escg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ictdyif0MDE7m6xyHh5Pe8kojmrVawufZ/3Rr7I3XpI=;
        b=FsIggNnoO0JfqST1jfBXxTbHGNcTMO8e4I/xFyKb5+BoVXU//SBaTvm1BdjdAcYjtd
         BtI1XlZkFVs5zE3AsCujL3kgn1kHqmJTJN96QDh/HPee3dSjj1vxAw6l6QAqwiIgjgVj
         4wX0WwKjbunU7nRq4mljvHZBKTsIMKxBIK2fWrwTNfrxDpfnxrA7DX1QnufaKVr40iVb
         zL4/JZ4Y5pH45loyiJoVAEReCVBoeXkZF1UfHifx/QHxDmLyC2b/IX6XLuqv9cP55KHH
         r5rgYOtXKVkVzQOY36CN0atI8bDd+oAjhnB3qcZn7Es//X4JunAxkmEq00u1LNweAcYO
         UIWA==
X-Gm-Message-State: APjAAAUDj0URFC1p57CrAi8MI9XVmIXEvVzKZ0gUSNOTESp4G4tmnc0k
        bg8ZCIWxVGqJ/aJElMeEyQ0qePdR
X-Google-Smtp-Source: APXvYqyhrObuhn2WNBpVVnpcfv+OK9+533tSzrS0ZlNOLzHadb96kM3sPd61zKy5yu8QZnk7oC60NQ==
X-Received: by 2002:ae9:e909:: with SMTP id x9mr24846519qkf.130.1556118894274;
        Wed, 24 Apr 2019 08:14:54 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:53 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 10/11] midx: add test that 'expire' respects .keep files
Date:   Wed, 24 Apr 2019 11:14:27 -0400
Message-Id: <20190424151428.170316-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git multi-pack-index expire' subcommand may delete packs that
are not needed from the perspective of the multi-pack-index. If
a pack has a .keep file, then we should not delete that pack. Add
a test that ensures we preserve a pack that would otherwise be
expired. First, create a new pack that contains every object in
the repo, then add it to the multi-pack-index. Then create a .keep
file for a pack starting with "a-pack" that was added in the
previous test. Finally, expire and verify that the pack remains
and the other packs were expired.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 19b769eea0..bcfa520401 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -495,4 +495,22 @@ test_expect_success 'expire works when adding new packs' '
 	)
 '
 
+test_expect_success 'expire respects .keep files' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-all <<-EOF &&
+		refs/heads/A
+		EOF
+		git multi-pack-index write &&
+		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
+		touch $PACKA.keep &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
+		test_line_count = 3 a-pack-files &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 2 midx-list
+	)
+'
+
+
 test_done
-- 
2.21.0.1096.g1c91fdc207

