Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA009C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiJZOVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiJZOVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7994111BBB
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so21711085eja.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Heq0OqDIVvowwGBXIMsmCv53reNVGf0Cs0djYono1Yg=;
        b=cql6XTpoojCXMNEjPMVMQlhydcxiGSEYmMfewQDWDBpd/s4JjMZ8Pv/swuqQqsZMo2
         m7rxI90vxjOYtbtja48GDFA/teYwmvAbZemTy7x66qeC4n5+RJzAwng/DAem/vkYMFDe
         bxUl+RjzP8w946kUm/rqn+zkRwFEfhocw+Nr8lFkl0OWo43ID7M1Gtw58rS2KxYAr6ZJ
         ckNkEBoEk5qoj90XobwOJMYy9xAxNh+b+SKNQntknYTyZz/SeWXSHRAeu1qLhYQIR8lk
         mCuaCl6zcnutpU3t2boZ0P2WAJxqqqpDryZ4wL+PMcvaP8rmss8YSdVQBClzaMlhAal1
         T3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Heq0OqDIVvowwGBXIMsmCv53reNVGf0Cs0djYono1Yg=;
        b=1Y+KrVK5v4QTMGQmJFkl5g7igKnoOQHyTgxfNQJGFz3bNoNtk5Y9eP0FWxqTZGVU2t
         uPYD3xSWtmg8eQjGxqn/yirgnO7edbdKEUlv+/eGuadoBAYG7lrIsZP2YBVB6WsTzcCy
         6S4aV9790zKOhYH5XVdqE2M8V+4KbboRqxIllsBhrvDhJrVm9xiAFA6ppucZc2Ci+5ln
         0FRJBij4UqgUAbciil4W5dffAwf/nIZZvs8LJmRmIYncW9R8Ni2SGiAh5CnLfDRcKU6s
         lDaMlfW/GfR2HcNTmVcsMlEsw3tYajTxUJ7rifgiZoa1RvK2adMQjb++3izB1millliT
         5TZw==
X-Gm-Message-State: ACrzQf1R1IKbhCAlZQ/6N3hpHWR6LZ5+5ev5l1pL3BfZvNmJ9w2y/FnB
        x1TqTT2Z/4GFIh3dR7mL3iLhB+hr3281/g==
X-Google-Smtp-Source: AMsMyM52bxoYjMZdfRn3YJQ6XOk/G3RmkG0qCa42Vn9zCVHL10xxV7yk+oqALTFjFPRuXkvU/0cGhQ==
X-Received: by 2002:a17:907:2723:b0:78e:214b:e3c7 with SMTP id d3-20020a170907272300b0078e214be3c7mr39008618ejl.186.1666794065969;
        Wed, 26 Oct 2022 07:21:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:21:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/12] cocci rules: remove <id>'s from rules that don't need them
Date:   Wed, 26 Oct 2022 16:20:37 +0200
Message-Id: <patch-v4-10.12-89f778ac055-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The <id> in the <rulename> part of the coccinelle syntax[1] is for our
purposes there to declares if we have inter-dependencies between
different rules.

But such <id>'s must be unique within a given semantic patch file.  As
we'll be processing a concatenated version of our rules in the
subsequent commit let's remove these names. They weren't being used
for the semantic patches themselves, and equated to a short comment
about the rule.

Both the filename and context of the rules makes it clear what they're
doing, so we're not gaining anything from keeping these. Retaining
them goes against recommendations that "contrib/coccinelle/README"
will be making in the subsequent commit.

This leaves only one named rule in our sources, where it's needed for
a "<id> <-> <extends> <id>" relationship:

	$ git -P grep '^@ ' -- contrib/coccinelle/
	contrib/coccinelle/swap.cocci:@ swap @
	contrib/coccinelle/swap.cocci:@ extends swap @

1. https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/hashmap.cocci | 2 +-
 contrib/coccinelle/preincr.cocci | 2 +-
 contrib/coccinelle/strbuf.cocci  | 2 +-
 contrib/coccinelle/swap.cocci    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle/hashmap.cocci
index d69e120ccff..c5dbb4557b5 100644
--- a/contrib/coccinelle/hashmap.cocci
+++ b/contrib/coccinelle/hashmap.cocci
@@ -1,4 +1,4 @@
-@ hashmap_entry_init_usage @
+@@
 expression E;
 struct hashmap_entry HME;
 @@
diff --git a/contrib/coccinelle/preincr.cocci b/contrib/coccinelle/preincr.cocci
index 7fe1e8d2d9a..ae42cb07302 100644
--- a/contrib/coccinelle/preincr.cocci
+++ b/contrib/coccinelle/preincr.cocci
@@ -1,4 +1,4 @@
-@ preincrement @
+@@
 identifier i;
 @@
 - ++i > 1
diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 0970d98ad72..5f06105df6d 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -1,4 +1,4 @@
-@ strbuf_addf_with_format_only @
+@@
 expression E;
 constant fmt !~ "%";
 @@
diff --git a/contrib/coccinelle/swap.cocci b/contrib/coccinelle/swap.cocci
index a0934d1fdaf..522177afb66 100644
--- a/contrib/coccinelle/swap.cocci
+++ b/contrib/coccinelle/swap.cocci
@@ -1,4 +1,4 @@
-@ swap_with_declaration @
+@@
 type T;
 identifier tmp;
 T a, b;
-- 
2.38.0.1251.g3eefdfb5e7a

