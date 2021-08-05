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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F4C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EDA6104F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbhHEPIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbhHEPIB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:08:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD0C06179A
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso6573799wms.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAQu9Za/Ms8hrgXJQJo2Nwrx9677XmFs0t2IOAcFuCQ=;
        b=HiSzRHS5VA6Tcr12hcitua4mrmmbrIjMKhME2E1EuVWajVdXEnH80myxgPQ/mPYrJ/
         PwNnQienB3LQ+AXb/ve1cKy3IMaCFj5TTgD7dPwWrSi97FPzu/R+rXNxH93KtTT+FYas
         MRaUQMbCl7fUx7Rt863iXs3/isKHd9a/OmBpPcBz1g8wO/fsezqwM+qBG67Rt4q1Fotj
         rMOa0Gm8QeQEaUOCT+/HNvgCR6FLzajnEte2sHvdEiaqSB9nlhTrv9NhN86jumuKDA3/
         nx7E9/suF+eTJWdfrEvv2WzqovEN/MfcQVZ5jxTCQEk5K0NOTtAqDX2r+TfulcclfB0l
         lgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAQu9Za/Ms8hrgXJQJo2Nwrx9677XmFs0t2IOAcFuCQ=;
        b=Zb5XlYXK2ZiGhFISSIXICDCGB0wJHz0pI0kFxMB2pNaQqY4TJQlgoRoTOYAdKLIF3y
         LXjj6OHiuZiv1s8Yz+lvNZtMiEF74zV7RrwK+njg3zB2+q+/ostXnoJA/9+DNgxWl0Wx
         uVt5FMchslCq5U/hmeISnVpWmNSmevydpxb/fqpBdIu3IYSbzPpM79cEiB/75eklfReO
         js8W522314lD2AWcGyEsWe17HO03uObbBEu1TJ3jj/pKMtz68MaIpFxBx+urcZz7IOr8
         wI+/D8LM93fj2gBaswKhwuqpwPuGNoFWkxMNZ+C4voHF2IEHeg/A7z9OKH0gnrl6yo3k
         W4BA==
X-Gm-Message-State: AOAM533e9Rcse2GKyFnmP5tnw/Y+XYjCuMRlA7V9zBAB/EYJaO/i1Qi5
        dFzxEPCNtu/A9VXsPib/dPV5S0KfPhB7rw==
X-Google-Smtp-Source: ABdhPJzBlFOqZW39ZJgRroflL+z1lRRuWO28zbyTZK6ShaiWy0DKvUulq0fyV5gPDlLVW2F+65BwCA==
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr15876212wmr.137.1628176065160;
        Thu, 05 Aug 2021 08:07:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 11/13] index-pack: add --progress-title option
Date:   Thu,  5 Aug 2021 17:07:27 +0200
Message-Id: <RFC-patch-11.13-7db2684d63-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --progress-title option to index-pack, when data is piped into
index-pack its progress is a proxy for whatever's feeding it
data. This option will allow us to set a more relevant progress bar
title.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-index-pack.txt | 6 ++++++
 builtin/index-pack.c             | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7fa74b9e79..9fd5d8a2d4 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -82,6 +82,12 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
 
+--progress-title::
+	For internal use only.
++
+Set the title of the "Receiving objects" progress bar (it's "Indexing
+objects" under `--stdin`).
+
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865..0841c039ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -122,6 +122,7 @@ static int strict;
 static int do_fsck_object;
 static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static int verbose;
+static const char *progress_title;
 static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
@@ -1157,6 +1158,7 @@ static void parse_pack_objects(unsigned char *hash)
 
 	if (verbose)
 		progress = start_progress(
+				progress_title ? progress_title :
 				from_stdin ? _("Receiving objects") : _("Indexing objects"),
 				nr_objects);
 	for (i = 0; i < nr_objects; i++) {
@@ -1806,6 +1808,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				input_len = sizeof(*hdr);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
+			} else if (!strcmp(arg, "--progress-title")) {
+				if (progress_title || (i+1) >= argc)
+					usage(index_pack_usage);
+				progress_title = argv[++i];
 			} else if (!strcmp(arg, "--show-resolving-progress")) {
 				show_resolving_progress = 1;
 			} else if (!strcmp(arg, "--report-end-of-input")) {
-- 
2.33.0.rc0.646.g585563e77f

