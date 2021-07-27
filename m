Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6088C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A8660F93
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhG0ABg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbhG0ABY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE9DC061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g15so13131210wrd.3
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/traU91cDrNFT3hGuPII7AHre5vT/tFNS+On9oA60+A=;
        b=ujotQc+l3Cg/uO6uLjqN+XwKDeIJ3tRA4Vlc3yiDchvSukMtWe3Z4IapB6Q2kBl+zb
         6yT0xvGfSuERggxDVusskYrvGpI1WgERy9KDjRBR8wVH38iVFTBMV0ORy+siDBbBTN1+
         5U301yz+GbOnSVYx2ws5d9mXWNRz8bkmBL1niS7zxRe6Fv5jRAjlSke8bVVnI4so+Pzt
         VADnpoMBxivE1JxNDFyjGTaK8/J/l0l2ptqm+uPfQ+JkPpuFJTPM99X56XdiWEX+jdR+
         Z0ZRCn9aQW+bhfw2UwhD/nwRJloUUKoNGUAcZWHQtq/tNMzL3Klnb9/py7fLVaNHKVco
         XR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/traU91cDrNFT3hGuPII7AHre5vT/tFNS+On9oA60+A=;
        b=X6+/WNBiL4/6wnGMa9uwlAp9QXBZxW54Ugl9/L2jfgw3r8ywC2k74+dKQkp4fJckge
         DpptN26MmTaLqIzAyEdtcF4g+S4LtTA5FVLpcQVQf9kljWRFRtsHAZG+ROqsRYOvKSVw
         xOKPBaEUvQn7U2H1ZsVA/yfOXSRo6dba0wWVYr3zVlDL7u4Rtza+kQIFlkV7nsYkZg5H
         hu5WmzoP4qPFN8Wdm4AG9CWO1TA6V5DX6bXmxSHCNcpnHF3xheXYfSvvmVSfHYaTkKOX
         3mJIeQR4zpzIagIxU6R8vaZRuvdz+9/Fi4NH9b29AIiK33w9l4G8TY2Mh1ltyIuBKxmK
         LUxA==
X-Gm-Message-State: AOAM5310sY3yleT8ndnosG7wXASJ0wHngTVkQ2GlDqciRLJgZmyfOztz
        3ehKuv+KouDIDJ4Ap++2NmwwWRhI1JKZ7g==
X-Google-Smtp-Source: ABdhPJzQPAOtfmHlnPde6AYGiafsZNXfX4WiKj171MAQOqhek+/SNUjDqJbynvrjQ8zk5Wc05+A8bA==
X-Received: by 2002:a05:6000:1b0c:: with SMTP id f12mr21710670wrz.225.1627346510133;
        Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c16sm1254377wru.82.2021.07.26.17.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:41:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] index-pack: add --progress-title option
Date:   Tue, 27 Jul 2021 02:41:41 +0200
Message-Id: <patch-3.4-f32c722f32-20210727T004015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g189fd9ae38
In-Reply-To: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
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
index 3fbc5d7077..0237623943 100644
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
@@ -1159,6 +1160,7 @@ static void parse_pack_objects(unsigned char *hash)
 
 	if (verbose)
 		progress = start_progress(
+				progress_title ? progress_title :
 				from_stdin ? _("Receiving objects") : _("Indexing objects"),
 				nr_objects);
 	for (i = 0; i < nr_objects; i++) {
@@ -1808,6 +1810,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
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
2.32.0.988.g189fd9ae38

