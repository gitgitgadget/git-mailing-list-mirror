Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4371C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiL1SBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiL1SAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B21EA
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d4so7537085wrw.6
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lqA3yuulvDMdeQe8LLJKH1qTvxkQsuxqj8I7uFcZJQ=;
        b=JkgyC4c1ysJH4oxXMqZxgGaNnZd9STwfLPxSCJKLG3CU8U34c0YL7Qdie1EXcJ0/HE
         kgIFqTPiSNp4ebP2MNTtahK1KhGFmTbv2rAM5B0MKeJpMqWFuuE422tLrZG0sKEhcgKU
         msH3DUo0gtB2ISJtuvipmGEXFZ9oyI1ZnCNqKM9RmKNIvqjKdtEVY1dSaET8fBsx33Qq
         GVZZrMtMhkIiVbTVVMZmF+fdgCfvtTURzBki6/jtRkXlKilJfgrGCXEiRvT4yDUG0hkE
         oI5HIIHsKyJks2erDPsi4AlSBiDoGOyn55KmB7GvD+Ccbyo9WNd6n2uHPmLdG7lT0d1U
         vuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lqA3yuulvDMdeQe8LLJKH1qTvxkQsuxqj8I7uFcZJQ=;
        b=YyXXIqj4a/7O7jzSSFBPUJJLjIjYF0qW6AUC+q8aDS76gpSs/MHQ8+V+DEKCKcGRXl
         8hFHuRFSE2YKz+6vX9SOUzRXdyKIfB9EsUJiurIcWxd8JlZewZn+dDn6jfDBmn1djHRa
         kapSGxiv7IXk/a5DdqpZlxqoObvs6mKatBJF+inNNZP1N5hK9nHXlqc1QBHbywhGEPs1
         d1/ARIagrrat6rQj9pktYOHcunjTgp3VxUbVEosahcCM4mbhx77JwPCquJxXsLS4cNU8
         KuWET/EvXJVHsBPOTAeB5hP5ugIChH+/dzaSIweswBbM1WChPgf7yDS7D4kLpKIGZL2q
         TdyA==
X-Gm-Message-State: AFqh2kpeMfakOmn4jVnU/343CUwLXyTGYKDEeLnmTANflG1QSKOb1LSD
        xus6REakE1dxWyADVRiSShO5vmFD7fl6RA==
X-Google-Smtp-Source: AMrXdXsiY7/2TUKHE+Sz8nUHEzfszvlGftRiV4xpCXOzVOpVCH4rT9zXuW1Kk7f/RX8wzd36jLubBg==
X-Received: by 2002:a5d:6145:0:b0:27a:5709:7d96 with SMTP id y5-20020a5d6145000000b0027a57097d96mr8178265wrt.41.1672250441575;
        Wed, 28 Dec 2022 10:00:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/20] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Wed, 28 Dec 2022 19:00:16 +0100
Message-Id: <patch-16.20-95d59b914d0-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c                | 3 ++-
 t/t6439-merge-co-error-msgs.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8f78f326dbe..e29b456f92c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1623,7 +1623,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 52cf0c87690..0cbec57cdab 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -5,6 +5,7 @@ test_description='unpack-trees error messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.39.0.1153.gb0033028ca9

