Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324BEC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjAQRL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjAQRLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6C33452
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x10so43143426edd.10
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJsc2mByCTaVzvS4IrvPa5rvQz9EYF3b31Yl3yAfz8k=;
        b=Y8JDF+sl/MoPZaIWoyLR5U4SXWIP6GKIcK1+qJVw+ybI392/7sVks49P+byZIaWiv8
         7hc4+B2fKho3IVfrdO7InhpGf1BlGz2VyrqKTQlzRvltHldAi5srOvnEsDovyV3sFtDn
         alI9+9rdExrH/Dqr4eO5v0jNVQOvaWje/qdlk8JwAvTjCwEzJoNSCpuq59pPYRrI1a8n
         kZrlgVGZnsTtvxB3Niad/hhoJx+qtYomuB0dOFixgIux/7CTb8de5bCJqUptFoN/k9DC
         6GorkMDMdBi9rFFmRc3Uggelg+cLU7tyvpsyRhLOSIbI45Yb2e+MxKvDRr5pqTybNZFl
         Pnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJsc2mByCTaVzvS4IrvPa5rvQz9EYF3b31Yl3yAfz8k=;
        b=Wb45s8bghtW9dB1kQ2kR4OJMorAAsDtuGc3iaF2a1atdCapPvncvEklnYm4+qDETC5
         CathmpWNYwnpLPfEHprj0iCVMjONl3iCJGc9WJIdKNxpXxkLc4s0Ht/cInH0EtKf+2Vd
         Gt+mzBPH4ZkPENltB1iUyV0eqbD6mXC5HVCYDlqniXaf5x814ByIml0yfNXzo6PgogHT
         xs0Q+DuKG6rISBcM0iacBJlNsi8yA54obCEypyAEVPHR9mSMjGBlJRb2YMiBztgEyz+6
         niDfCMlhV3QMxzKRFmWsw9l4QPm56BX2egSBnJrXzvsls4GmbwrOS/Bjs/NRwS0wWan6
         4/Dg==
X-Gm-Message-State: AFqh2kpjmrg0Jv4SUhhZHguwGq/FUbuHIkORH6blsJcbhn+fkG7uThSh
        ldNdqH4fFNadbIryCnIXTPOhBwIsbQpJ2A==
X-Google-Smtp-Source: AMrXdXutxUzX1NIjVhVEj8YgJHvJzgCPtvU1B4J0VOqRRNNnmxBx5sDuHlc/E3m35SNFrwc/RSzWHQ==
X-Received: by 2002:aa7:c709:0:b0:499:ef31:3549 with SMTP id i9-20020aa7c709000000b00499ef313549mr17125830edq.6.1673975491400;
        Tue, 17 Jan 2023 09:11:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/19] name-rev: don't xstrdup() an already dup'd string
Date:   Tue, 17 Jan 2023 18:11:11 +0100
Message-Id: <patch-v4-06.19-bd15d991ac7-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

