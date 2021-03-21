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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73A4C43445
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E32601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCUACZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCUABl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD419C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so12841498wrc.3
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJcDJtxbIELT8ymRmWCDZyHv8UxNb50s38VEI9hP/+k=;
        b=vHkKx3sLZTMUxnp2NtFiLKpRF2Atm7yCtxZHvC75L9hX+ksKGphiXDstwbMkJHLcPO
         oQp5u32+bccdZg6BYdyrYJ9isDw0beCsrD8sApBYwVWZGTDYgIhY4UPfOC8vGKt3wbS1
         UVlNDVtvXJRnB0yYjlDim/bpa42n5/MmLQXqOzQYlzvtW32to4kFoHPyRcEZtLeXgqva
         Svr1lDs0f0bYt/SJDBPP9wF3y7DhIsM8meycF+zxd31YY5a1c7KVyuWsy+RcMm/sdT2l
         pYd4X4aeHp/KyfyNPFcYtA96X65c/k0cct98lZyoEw+DiwnsEy9FogRNxrYajmPnGSuj
         y+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJcDJtxbIELT8ymRmWCDZyHv8UxNb50s38VEI9hP/+k=;
        b=ticRfQotFhlt4O52SmoylHOlQ0MTHijKESFNIcznHpIs/HRfCkgmTtfXsV2Tgt+ARA
         W/swMTxs/4HCSgOvwMDQ6BREzhr77JVEmmCAw4XEArePGOybFeNHDUNkca0CIZpqdiVC
         a/+GbF2+tiVcOhIcsDt80kvVtUzprPgj0tiU3fPIxDChkGptmgRaa7obxWJFF5uyu5BZ
         7V1m4OBC4TY+Pe2gjNrQVX8J9wtIafp2AlWQV85kNPyhWA6CpRW/ezN8KRsl+OF2P2MP
         i7pmWMBIQPcXsRsa8kCtSq6a9EyOKgc1wiLxgguntHFJtpd8laGjk50d4EAAIp9cex6W
         I9KA==
X-Gm-Message-State: AOAM530bygSsqOaWUvOZKn597agWht4i5lupTTOiITTEoR5P1Hm7Nd0b
        qhFn4ydWuP0pwc/HROYdfjj9GesYgaHGRQ==
X-Google-Smtp-Source: ABdhPJzwGAXxVZq9qGkVu4BF6fgI8RvhnjX5faqzCQtaDXb0WjuipUxMjsKNETCfPlfGonjXhs6mbQ==
X-Received: by 2002:a5d:64ae:: with SMTP id m14mr11336277wrp.153.1616284899278;
        Sat, 20 Mar 2021 17:01:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:38 -0700 (PDT)
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
Subject: [PATCH v4 17/29] fsck.c: switch on "object_type" in fsck_walk_tree()
Date:   Sun, 21 Mar 2021 01:00:50 +0100
Message-Id: <685da1abbdc639099731caec2a25980d0fe12616.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7146e66f086 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06) the "mode" is validated such
that we'll never reach the "else" clause here.

Good for us that fsck_tree() has its own FSCK_MSG_BAD_FILEMODE check
which we can use, added way back in 64071805eda (git-fsck-cache: be
stricter about "tree" objects, 2005-07-27).

Except it really doesn't due to a regression in 7146e66f086. A
follow-up commit will address that, but for now we can simply rewrite
this code like the rest of the s/entry.mode/entry.object_type/g
changes I'm making.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b358..7c74c49d329 100644
--- a/fsck.c
+++ b/fsck.c
@@ -396,28 +396,25 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		struct object *obj;
 		int result;
 
-		if (S_ISGITLINK(entry.mode))
+		switch (entry.object_type) {
+		case OBJ_COMMIT:
 			continue;
-
-		if (S_ISDIR(entry.mode)) {
+		case OBJ_TREE:
 			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_TREE, data, options);
-		}
-		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
+			break;
+		case OBJ_BLOB:
 			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_BLOB, data, options);
-		}
-		else {
-			result = error("in tree %s: entry %s has bad mode %.6o",
-				       fsck_describe_object(options, &tree->object.oid),
-				       entry.path, entry.mode);
+			break;
+		default:
+			BUG("unreachable");
 		}
+		result = options->walk(obj, entry.object_type, data, options);
 		if (result < 0)
 			return result;
 		if (!res)
-- 
2.31.0.286.gc175f2cb894

