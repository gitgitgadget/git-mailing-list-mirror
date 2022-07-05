Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B95C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGEOCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiGEOBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358722C117
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cl1so17659003wrb.4
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4feJHHjy2OuTxa+ur+kNEIfxdn/2JKrVa5uqMpKlgc=;
        b=Ve0/CicmWLhPKIaMet/KRls4TPd8vp9kBj/pjr5s/bAg2CpSV2qO/fDk41KI9a/T8v
         wvs/AWwInQfat1IjqNJaEFXRkvRpcGXnfLd+iCHfPfgovNdbDNaxfNdQahHEZYV9BHng
         alAn5Wxv1mRPvja5DzMHN8bV+NdhWx92IGQkWgdeRxIxegRcz5xox9bKVK+DJq2wJ66U
         PyERd27l1esBXieC8l1rYcGO8aFU2mWrfYBlkGdEHNFQdeiONviaa+77x7LMm/YoCRwU
         Yka7b0cu9OB/Vg0qCplrrfKUSdjxQonjjaViD00K8BRjhB8muPyaJRi4OHNdVnCNjt4p
         R+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4feJHHjy2OuTxa+ur+kNEIfxdn/2JKrVa5uqMpKlgc=;
        b=sVWZfluClW4rGeR5yXPU+e9C0WDk1Ozd+NtoKkR2MsGOHKwWUCjleCNd2zqrgnR3ca
         OzNuqp9dmIEcLURdCmGAT3K23u1Nv1JrtZJUvOB0hl4iwvpMfDoX/fjbHms06m14Xpcg
         qDGOHCQj3PLE4amBHTos38VD9bYPQhQN5PM+5cEa2lV9PeKvxtqz6btiHizl9JtpBqvO
         NtSbChiJm2AvhYM0VivgEJ0ypDGRKqE3mdlYaaKfNzjjYwd9E2Y+JQAQ+mWj8SvuO0dH
         Wq80dtdo7LCxpnhoXvyrF42q8slbIXNHxiDymPuIN31r0i9W2f06YNSWBEgU+vIZmTQL
         rJ4g==
X-Gm-Message-State: AJIora8PhvWuP+fdj4B/i+SGVIoBuO9vN9wESjttUpphd+y2HwwGcujy
        5oaCfPpamCrrNZXxsCvEVWhaYSZHCwVyGQ==
X-Google-Smtp-Source: AGRyM1t5LBiRnEdfyRI10mPgVsJ2kpPM1D9bWusm3arXbCQs8Cv1sNNGkd3lhuuAasgckdyMcEFcQA==
X-Received: by 2002:adf:ed83:0:b0:21d:6c97:b4 with SMTP id c3-20020adfed83000000b0021d6c9700b4mr8375260wro.205.1657028833422;
        Tue, 05 Jul 2022 06:47:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] cocci: generalize "unused" rule to cover more than "strbuf"
Date:   Tue,  5 Jul 2022 15:47:00 +0200
Message-Id: <patch-v4-6.6-dafd59d5ded-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generalize the newly added "unused.cocci" rule to find more than just
"struct strbuf", let's have it find the same unused patterns for
"struct string_list", as well as other code that uses
similar-looking *_{release,clear,free}() and {release,clear,free}_*()
functions.

We're intentionally loose in accepting e.g. a "strbuf_init(&sb)"
followed by a "string_list_clear(&sb, 0)".  It's assumed that the
compiler will catch any such invalid code, i.e. that our
constructors/destructors don't take a "void *".

See [1] for example of code that would be covered by the
"get_worktrees()" part of this rule. We'd still need work that the
series is based on (we were passing "worktrees" to a function), but
could now do the change in [1] automatically.

1. https://lore.kernel.org/git/Yq6eJFUPPTv%2Fzc0o@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/repack.c                    |  2 --
 contrib/coccinelle/tests/unused.c   | 27 +++++++++++++++++++++++++++
 contrib/coccinelle/tests/unused.res | 15 +++++++++++++++
 contrib/coccinelle/unused.cocci     | 19 +++++++++++++++----
 4 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4a7ae4cf489..482b66f57d6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -727,7 +727,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
@@ -1117,7 +1116,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	string_list_clear(&names, 0);
-	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
diff --git a/contrib/coccinelle/tests/unused.c b/contrib/coccinelle/tests/unused.c
index 495ae58ccf1..8294d734ba4 100644
--- a/contrib/coccinelle/tests/unused.c
+++ b/contrib/coccinelle/tests/unused.c
@@ -53,3 +53,30 @@ void test_strbuf(void)
 		return;
 	strbuf_release(&sb8);
 }
+
+void test_other(void)
+{
+	struct string_list l = STRING_LIST_INIT_DUP;
+	struct strbuf sb = STRBUF_INIT;
+
+	string_list_clear(&l, 0);
+	string_list_clear(&sb, 0);
+}
+
+void test_worktrees(void)
+{
+	struct worktree **w1 = get_worktrees();
+	struct worktree **w2 = get_worktrees();
+	struct worktree **w3;
+	struct worktree **w4;
+
+	w3 = get_worktrees();
+	w4 = get_worktrees();
+
+	use_it(w4);
+
+	free_worktrees(w1);
+	free_worktrees(w2);
+	free_worktrees(w3);
+	free_worktrees(w4);
+}
diff --git a/contrib/coccinelle/tests/unused.res b/contrib/coccinelle/tests/unused.res
index b3b71053ed6..6d3e745683c 100644
--- a/contrib/coccinelle/tests/unused.res
+++ b/contrib/coccinelle/tests/unused.res
@@ -28,3 +28,18 @@ void test_strbuf(void)
 	if (when_strict())
 		return;
 }
+
+void test_other(void)
+{
+}
+
+void test_worktrees(void)
+{
+	struct worktree **w4;
+
+	w4 = get_worktrees();
+
+	use_it(w4);
+
+	free_worktrees(w4);
+}
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
index 56530498d17..d84046f82ea 100644
--- a/contrib/coccinelle/unused.cocci
+++ b/contrib/coccinelle/unused.cocci
@@ -4,10 +4,13 @@
 @@
 type T;
 identifier I;
-constant INIT_MACRO =~ "^STRBUF_INIT$";
+// STRBUF_INIT, but also e.g. STRING_LIST_INIT_DUP (so no anchoring)
+constant INIT_MACRO =~ "_INIT";
 identifier MALLOC1 =~ "^x?[mc]alloc$";
-identifier INIT_CALL1 =~ "^strbuf_init$";
-identifier REL1 =~ "^strbuf_(release|reset)$";
+identifier INIT_ASSIGN1 =~ "^get_worktrees$";
+identifier INIT_CALL1 =~ "^[a-z_]*_init$";
+identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
+identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
 @@
 
 (
@@ -18,15 +21,23 @@ identifier REL1 =~ "^strbuf_(release|reset)$";
 - T I = INIT_MACRO;
 |
 - T I = MALLOC1(...);
+|
+- T I = INIT_ASSIGN1(...);
 )
 
 <... when != \( I \| &I \)
 (
 - \( INIT_CALL1 \)( \( I \| &I \), ...);
 |
+- I = \( INIT_ASSIGN1 \)(...);
+|
 - I = MALLOC1(...);
 )
 ...>
 
-- \( REL1 \)( \( &I \| I \) );
+(
+- \( REL1 \| REL2 \)( \( I \| &I \), ...);
+|
+- \( REL1 \| REL2 \)( \( &I \| I \) );
+)
   ... when != \( I \| &I \)
-- 
2.37.0.913.g50625c3f077

