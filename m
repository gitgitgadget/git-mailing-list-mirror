Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D115C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiKAWha (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiKAWgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74C1F9D6
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 21so23873142edv.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBcBjeXGFmcicrIVyeWKgUrc3Kdu7+IRrkI/jEaZZaw=;
        b=ESkunLfaXYiLW4czKuGPHvVxtLyESVv/tw1+CizHtfUWUn9sVCxrJDA3QC3ZpqP5gO
         v0moYRP0Gp3PQ2sevX1pbi1Muu4pl74tBJppGf8Or7X2gAYF74u8c20a6barwFIdLBqK
         IPLtKIg6TWkgB8ASb7ZQ26pU4VAHiN/oetgIzCw5HRQwJ5Ao7FEQAVOOzfKEkAJJft6D
         Qq1ouQGXg7SeUBh/k10nza7+NoUj6mAi8QbMUFoI70dpkvuCoDF9TkcT38MiRJKADFly
         CjPTTrftj9OxYug/7qlhbijn2OJo7762oui8t3Voo7F8W/tBSk7+P5vZjVCpONHRwimb
         2WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBcBjeXGFmcicrIVyeWKgUrc3Kdu7+IRrkI/jEaZZaw=;
        b=775L/6Bu6Z38mhMcde389vqH34INuuzf7MOD+iFUZLElI5qc5pSV8SCO7cVIJx3ULS
         aTqfhs7IiXc9hdL2iwWLVbFMmTq2vmoRl32WpDVhvQ0Ruso6xsApu32aIaYr61knzKqV
         5btLKKh3/28HrhxjjsHUb+LKvghefo0mYqA+9DJs64AfdlnMafnrM+SBp+yDH6ig9LZJ
         G5vnk+vCtpSBCNVMduVs2jXEylD8Q2BAXYgKowVRMfmCSsh4U4/xPAMNOkGYI0ISzZ46
         zQ509aeGTPgwJZyKNL5xA7Q661YoVUUJ+Vj0uQziQ2Od5ibenfWmy+2VRJTR0WADFM/P
         c8wQ==
X-Gm-Message-State: ACrzQf2zxZ+knmaYumtMjU2PU72vhXXfM+Pg5H57hYmjlgjl/Xdg3aL8
        QXn6q4crhn8wxGk1WYcmC4foC68xIddhEg==
X-Google-Smtp-Source: AMsMyM4tUUsUP/bu9T6E8EWTNzZJx/2vzMUp8dnbn5dg+GTqiDvTDnMTWq82T/okYyC0/YOQGCd6OA==
X-Received: by 2002:a05:6402:3789:b0:461:3ae6:8d73 with SMTP id et9-20020a056402378900b004613ae68d73mr21522513edb.229.1667342171493;
        Tue, 01 Nov 2022 15:36:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/13] cocci rules: remove <id>'s from rules that don't need them
Date:   Tue,  1 Nov 2022 23:35:53 +0100
Message-Id: <patch-v5-11.13-73bb897c965-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
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
2.38.0.1280.g8136eb6fab2

