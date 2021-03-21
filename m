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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC63C433F1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4716661937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCUACR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCUABi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E6C061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t4so2419475wrn.11
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K76TXGnpVmMaZy+ataImqJLGLarHGA2byq8ElXBpqOM=;
        b=e7rxFOl3bhhTkks2/vvhm22jxCCFseiS2ZP+FTAmaEzekn1zLI5Ht0J6Yd/ntjPxzS
         ZKScCsqfofoP7X2OZGSLzDdNqOGRChFmp92InHHFjkONo19b1FkOR+6QqkMuuIrC6/NC
         P20kEJOkUSINE0u0z+lx7h2Cx7ZBVbMjVfe9OIz0ZbgK2u5eIJDhTaOC9wNK/QXK7gYg
         nsG/0JjhuhiD/vk5af/YI8hsogZWrYMaUcinI4vxdOI5uDFPVa7Ll2xoZ5VnMlWgCBoZ
         ET7YaE5wMxdXn6PaIU6d2tsFgbz0hzxL02k+6F6UPZRVyCdML/Nnh45YMFiD9hN+KvDY
         ejxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K76TXGnpVmMaZy+ataImqJLGLarHGA2byq8ElXBpqOM=;
        b=nGt2lFy18T5aqqxvWJ5oQjZC64+46zOQax3tJLfIwb8LZpWfZTp/TiO6G7R+xR+Zdx
         D/7b6dpH9xVpYCQ5laQjsFAFdM0aD7WB01M3IWKrZ41GO+ktt6XzuvyfVcN7X82RBoaR
         uhFh0tX2HCRWqOXLOuMx7RIFvaB5lnxEdlOpqkhdJoP9D7FWJYTN5jInKte1vEn0EwD+
         SENLi7eWdEjYYksRuHoIxruEKyfnx+dbc5W2POqDAdIjhHAZgoxzntg+tMVjG3RdBdY/
         qBGaeBp7TZaHWPI25y198VR2nYw2wXy4dYZHYm23CylHJo7nsjYbNYj3PHwtUdvMe5v3
         PCmw==
X-Gm-Message-State: AOAM530wRuGuIdJz59Lf5LASCMcYmPyFXwQFWn/gP36t56QAT+JrbRAz
        KOKmRJphjtKeygglFKKKewMRyHVD4x05cQ==
X-Google-Smtp-Source: ABdhPJz/e/LdATGsYEkvHstmX8R6jFnOtYbNFmpJ2UWEnvvt3HwdohOyucOLKzYmgfabV6/owIBzSg==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr11090207wrq.116.1616284888671;
        Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
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
Subject: [PATCH v4 03/29] tree-walk.h: add object_type member to name_entry
Date:   Sun, 21 Mar 2021 01:00:36 +0100
Message-Id: <4fed508f3cbb106c6359d31ca53d53e078fadfd7.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

