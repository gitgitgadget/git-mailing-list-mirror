Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A59C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiCINSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiCINSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73AC14FBF1
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x15so2936164wru.13
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuVGpbZGk27UjxrE8ZOvmt37LP90Wns4uQu2mYun1/k=;
        b=gT3cIq27gCnaLDyHWyRm1pH4K1G01qHj/y0J7ku+dBQHvkl7fNYFJX3UaNYGnbkblu
         GDxxIVB73KZvCvEhTaVQcNgeLUe4pwb7gwjQq+Wpa7QYj8a0k9sK+8Wf4A8nUTBqZYSA
         xhDKWpzHKbCrkfFFopV8YBmRD89p03/VgCTG4bKl+gRq74ei1cfpyWdI5/X53f/JnXEX
         QRutVzVPqAztjM5DzrXUIE1/bHB2dZvoRwd0jFQrOiwsHYvjR9MoSBeNxN2glOc/nIJh
         ndfTWulceFayGxKyIDJt2++TDkAvwUqXSQLbDCmc1IetOEfTAPll7Agm2JzOgtWK6nDK
         u3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuVGpbZGk27UjxrE8ZOvmt37LP90Wns4uQu2mYun1/k=;
        b=zVIhOQJfhj3A1NvaM0gEfy0fdp1JBDQbgYcragvZ7KafoD1Ky8Noqq5ZQurNnB6MCr
         /BTAJ7xj8PwciuWPvoymtu+w8XdAPkOj7jidwa25aSQeFaLwhY25XPVbDSw+eU52B7ej
         cGrDY/LYLveCqmDK2EbaftqKLLOsQQJc+QM+gqS+IJNaQL6TPgY8XCLlzi6h9qpz3b1P
         SeZiystH+LWCRGbvurmHB8Nqrc4szuxVbPPmc3mxnF7Ci+vRC3DuglvnpIFmenxSUqki
         UV9x/3dawuxPWZZr/H5v53Wa/mD3ZRUMSRdPNwhfQpkIySWDBza8Sn+FOjmQ2EHp7Bmn
         9zMw==
X-Gm-Message-State: AOAM530ZFCHrsInbitJz458CKprUy4p4l379KDTHRhqs/mMdNKnbr9gx
        poy8RBreaYePZUqwE9iQ7Wcc9Ffn2jk=
X-Google-Smtp-Source: ABdhPJxgXwOyy9nzUzW35LpwDI5hCGQtxKOnmOSMvPXJ+spOq22Lxhy7fdexrdlK1ZduQ0SePa45vA==
X-Received: by 2002:a5d:45ca:0:b0:1ea:9bf9:ce5a with SMTP id b10-20020a5d45ca000000b001ea9bf9ce5amr15907543wrs.620.1646831865266;
        Wed, 09 Mar 2022 05:17:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/24] blame: use "goto cleanup" for cleanup_scoreboard()
Date:   Wed,  9 Mar 2022 14:16:32 +0100
Message-Id: <patch-02.24-db0b04e53a9-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a freeing pattern added in 0906ac2b54b (blame: use changed-path
Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
sure that we call cleanup_scoreboard().

This change is needed so that a subsequent addition of a
release_revisions() doesn't solve this unrelated issue while it's at
it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc9..885b381ab83 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1167,7 +1167,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!incremental)
 		setup_pager();
 	else
-		return 0;
+		goto cleanup;
 
 	blame_sort_final(&sb);
 
@@ -1201,6 +1201,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		printf("num commits: %d\n", sb.num_commits);
 	}
 
+cleanup:
 	cleanup_scoreboard(&sb);
 	return 0;
 }
-- 
2.35.1.1295.g6b025d3e231

