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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D725EC4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77C564F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhCPP7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhCPP6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2527C061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o16so7701444wrn.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wuM+mu1FmtgxjEuKEr+f4w1LWONmtKD6SvuFG09b2VM=;
        b=q5ulKRkxVGqKy+epN38fsfCX8SQPP4uPlEMR/coBHEWRlESV2pBNqPgGnVQw7t57W9
         tjnBVFxpd16VB3NuidIiEbZhBNe6qBrOAWWiA1tqTr0i2YdCXPHeqsMTGg6iTG0DCF5X
         tn9CW0wbVtQNaUAR8jYzTNzvREVJn9pWPsvkvvEA46TsYBlinUQRMNatFT+kYeOhYQ9d
         PnNKu9SYVrCC4Bx5DWEl1khvv1ZzRe6TnvMtILC0V3LRkpk6+AZ45PVcVygzBX+NCyFA
         x3b/qjiYXwXo7STEzMVPFsQRu+0gqTkm4n5DhNE6YcuUqq7t2YlLVMjs1VS59jhYigyc
         6ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuM+mu1FmtgxjEuKEr+f4w1LWONmtKD6SvuFG09b2VM=;
        b=Sjvw5CroUrgasTZbJFGae8GnF/BtB8prIXgl4dDNIlWHj2jlS0LCZQJCwD58hgtL11
         mfAISeX36hNpvzYtN5rVvlHEl8epFNj7v+/4WKvz4+/qc8Bo2J4JEeAfZA4FbEwkKiRL
         MWLCYo0z7CBp3/V9EJIT99QfZa1Aq+QDrddmGzzpHkYJUnpq06eivv9PVN1fjARBJ4c8
         BLJ44gmUycwHzLv7kaWtCDeITaDfHDgJIBqqtl46jflCeIAd/ETu5IoqS1/aEx34EcLB
         WCdMrtxZcEajwcjKbNbnWCCb07Q0ELY4RRo79TgEi2tdrhD+dVPfITq8PbvX9d/yJcuC
         5RAg==
X-Gm-Message-State: AOAM532C7nDvkWkYNzoK6ZPMg92JwCgj6icKjvRgCQFn29AwubHtutad
        q1Jpw0tAHem+X1RMyhTy8SdSniTTfarKqQ==
X-Google-Smtp-Source: ABdhPJwE4Mg83Y9IBerwJi/00MarcQ/phXq0qfWf0obgJviqowfzjNVYo6vTCtjZztN+I9cdo96a9w==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr5663069wrr.49.1615910321115;
        Tue, 16 Mar 2021 08:58:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/32] tree-walk.h: add object_type member to name_entry
Date:   Tue, 16 Mar 2021 16:58:01 +0100
Message-Id: <20210316155829.31242-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most users of the tree walking API don't care what the specific mode
of an object in a tree is (e.g. if it's executable), they care if it's
one of OBJ_{TREE,BLOB,COMMIT}.

Let's add an "object_type" enum to the "name_entry" struct to help
such callers.

Ideally we'd have some subset of "enum object_type" here with just
those three entries, so we could rely on the C compiler to
exhaustively check our "switch" statements, but I don't know how to
create such a enum subset without re-labeling OBJ_{TREE,BLOB,COMMIT}
to e.g. "NE_OBJ_*" (an enum is just an int under the hood, so you can
use such a struct with "OBJ_*", but the compiler will complain...).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.c | 4 +++-
 tree-walk.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 2d6226d5f1..b210967b73 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -47,7 +47,9 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
-	desc->entry.mode = canon_mode(mode);
+	mode = canon_mode(mode);
+	desc->entry.mode = mode;
+	desc->entry.object_type = object_type(mode);
 	desc->entry.pathlen = len - 1;
 	hashcpy(desc->entry.oid.hash, (const unsigned char *)path + len);
 
diff --git a/tree-walk.h b/tree-walk.h
index a5058469e9..9f3825d277 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -17,6 +17,8 @@ struct name_entry {
 	const char *path;
 	int pathlen;
 	unsigned int mode;
+	/* simple 'mode': Only OBJ_{BLOB,TREE,COMMIT} */
+	enum object_type object_type;
 };
 
 /**
-- 
2.31.0.256.gf0ddda3145

