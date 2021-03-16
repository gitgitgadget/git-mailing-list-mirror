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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD5C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A377865029
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhCPCNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhCPCNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C71C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so6651938wra.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRg52qgd/pCwOEEZgfanBQRk62b4rbTbyMKhZOHKVlQ=;
        b=YxH9a6cpqEOSJD2QshxGzLe+fWoMJ0Qvd9p6MYfXH1ultdPIWHV61jtMsgalcAKygj
         8H1HCkQ7Eq2V+SOBIma76o5bP6mDa3adkHDwmVEK0IpDqTVNTB4ApaqWyXsWv1Oedirs
         kyKuqU+EFGd3k/njaBmcrFWzF+3wlZ/nMzA9AuyLgSkGkOceAtuCXM3Lv1w7H9+NdZcc
         UlCqrac+3CAvxOb61vmyEpxURvQilPCpUT0+zksN30Z7+FfxQciNGBe32gUYNbBeWRGu
         7WT+7/tZyd/nea0wPkR6fCIqCjFX22CzLWQbMd33EsBLO5knYYwiPnyDnhSFBbX0rY9g
         b71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRg52qgd/pCwOEEZgfanBQRk62b4rbTbyMKhZOHKVlQ=;
        b=IQLVv829HFUvLF7B/IsSQu6SDp+JxYnwrQzRVkdEAn+Va9rarXogs+CuFD6hY0rY+Y
         QTr1HKKQDpQC/JJnVV0h1zn6cfLS1LuzOiOZUSw5fxQkMswnlzUkv965NQlGCDX7qoEg
         MOErQi5VQ7Dv4WMOTtbIs1ARWsayNbvCbFbTbraIpLFSFaXu51br/xM9HS7bjtCHxOoI
         GhEmPPz/R+qfsekMCWsh6H8JprO/bvxIla2SPtQLqn09DdOSzXVQm9sR0d8TsVItw6Hp
         +UwEbIN4F9ZNhrjlpFJLVrgXH4Nxf5Dx4mqFRF1tZaAWeQ0HYXt+9VWPYzFmq5iXVrpn
         5sIg==
X-Gm-Message-State: AOAM531teaV0jaW4YrcCh2jutMAquWGJPTmu7AS2GtV/A7JQ4Si9w0vJ
        p8Pj+zDboxk7elzTU6V3rGxpdZ16lejbBQ==
X-Google-Smtp-Source: ABdhPJxLkD5noCViY1gpoBxNK3Ei95x4TSWkW8RDkonWD1+yUozMSB1ujOkHa5wNi3i6LsBFcDFJqw==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr2243140wre.386.1615860814556;
        Mon, 15 Mar 2021 19:13:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:33 -0700 (PDT)
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
Subject: [PATCH v2 04/29] tree-walk.h: add object_type member to name_entry
Date:   Tue, 16 Mar 2021 03:12:47 +0100
Message-Id: <20210316021312.13927-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
index 2d6226d5f18..b210967b73b 100644
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
index a5058469e9b..9f3825d2773 100644
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
2.31.0.rc2.211.g1d0b8788b3

