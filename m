Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47512C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAJFoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAJFoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5741A7E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vm8so25800597ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVHliO8MG7jMVOnByGlLXXS7QdQ0h2zR1hZePGUNKoU=;
        b=YYNV8SnnVgLEyRuKOPiOYk2y+n3vxmha3pRI21q7ykUMWQO2uZoVCM275xMW34u70D
         iqE/hVmBgCLi81Kbv20u37xy1gpUTth57NlF4Ki0UKyxKVfdLuAeLUNBFqgg+C9PEtx4
         bjG7XidZQnOj7CB+Kr72Inktp0Wwoi8WAB6Y40JEeLxSoHzPmgPLBnIVeml2kTfwklPA
         Oaz4tHyyQkdxWgQdfAW6aqWdSqUMPPTSd6XKpN+8hsMfT6S7uAqfvXI4ovZtZQ6HRNY0
         ZUeoSEw0elIDJ5ZbnQvz5emjqRr7dAHmr33tLSm59/unLk6F/866+uYYDKb8pyEOewcI
         dV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVHliO8MG7jMVOnByGlLXXS7QdQ0h2zR1hZePGUNKoU=;
        b=b3dJI27RXoB83UUZoh5rxlPQ8tkx5VSW/cNJ6N/i4tjkquPqQKRMUglwXj6CXB8K+d
         M+FR1SgtnsxeaceA0KdSTC1VnQzLCjlUUVtbT9uMNZYbfimZRpeAT9WVaM+Xev7AAyiN
         zWTZrnpMaxEEOmR7OcIc99ljQf/o+bco+lA7fRJ7juPBh5YpHyFZxF2r31PppTN16wUQ
         GkuWP7ah+O+LDSVIxrk7s1KZJ3F/Oob3EJcRnSm7pcVge4UD8FMNq+3oyrlWBuDypiD2
         GQ6AqqFcuULxvlF7CCj4IkX2wq+kghzQZmOtpTXZ1nHQP/BJ3qW5XabYjiyTEWZQ/Wjq
         AdUA==
X-Gm-Message-State: AFqh2krcKTb6Gg1S+yhjpK1y5Rgr5VKaeFE6i/Vs6/kr8c455YGIq8Ol
        5OqRdWYxCmpNmMSqOoOa8B/ijXT3tptU7A==
X-Google-Smtp-Source: AMrXdXuQcggWLStDygeq0nLj+9+LfUd9jYOZp+2p51SKsMy6W3vYXzBlbGQDQDtfW6vwM74BsUoFEw==
X-Received: by 2002:a17:906:b150:b0:7c1:2931:2263 with SMTP id bt16-20020a170906b15000b007c129312263mr60655533ejb.71.1673329436020;
        Mon, 09 Jan 2023 21:43:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/19] name-rev: don't xstrdup() an already dup'd string
Date:   Tue, 10 Jan 2023 06:43:26 +0100
Message-Id: <patch-v3-06.19-39cb8aefb58-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "add_to_tip_table()" is called with a non-zero
"shorten_unambiguous" we always return an xstrdup()'d string, which
we'd then xstrdup() again, leaking memory. See [1] and [2] for how
this leak came about.

We could xstrdup() only if "shorten_unambiguous" wasn't true, but
let's instead inline this code, so that information on whether we need
to xstrdup() is contained within add_to_tip_table().

1. 98c5c4ad015 (name-rev: allow to specify a subpath for --refs
   option, 2013-06-18)
2. b23e0b9353e (name-rev: allow converting the exact object name at
   the tip of a ref, 2013-07-07)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/name-rev.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..49fae523694 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -273,17 +273,6 @@ static int subpath_matches(const char *path, const char *filter)
 	return -1;
 }
 
-static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
-{
-	if (shorten_unambiguous)
-		refname = shorten_unambiguous_ref(refname, 0);
-	else if (skip_prefix(refname, "refs/heads/", &refname))
-		; /* refname already advanced */
-	else
-		skip_prefix(refname, "refs/", &refname);
-	return refname;
-}
-
 struct name_ref_data {
 	int tags_only;
 	int name_only;
@@ -309,11 +298,19 @@ static void add_to_tip_table(const struct object_id *oid, const char *refname,
 			     int shorten_unambiguous, struct commit *commit,
 			     timestamp_t taggerdate, int from_tag, int deref)
 {
-	refname = name_ref_abbrev(refname, shorten_unambiguous);
+	char *short_refname = NULL;
+
+	if (shorten_unambiguous)
+		short_refname = shorten_unambiguous_ref(refname, 0);
+	else if (skip_prefix(refname, "refs/heads/", &refname))
+		; /* refname already advanced */
+	else
+		skip_prefix(refname, "refs/", &refname);
 
 	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
 	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
-	tip_table.table[tip_table.nr].refname = xstrdup(refname);
+	tip_table.table[tip_table.nr].refname = short_refname ?
+		short_refname : xstrdup(refname);
 	tip_table.table[tip_table.nr].commit = commit;
 	tip_table.table[tip_table.nr].taggerdate = taggerdate;
 	tip_table.table[tip_table.nr].from_tag = from_tag;
-- 
2.39.0.1195.gabc92c078c4

