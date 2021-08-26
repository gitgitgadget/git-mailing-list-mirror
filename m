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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C9C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D8A60E0B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbhHZOGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbhHZOGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:06:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08152C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:06:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so5293889wrn.5
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwXtiWsoBT3/ETQ8XHJLKtZU/HCggU775XJY5RyTI3c=;
        b=fr5eXCIcDpbBA1Ng8hzxQoBd6edVNR8S10tTqL3/lGCZf02x1JZvo/OvBDBvsZHLOe
         zNiiK1MBCmx/2rvs1+BQcjF2X2CoKXVqrYb3GUr+/TeICTZWLuVkuelom0AOeiOK0Gsb
         Qr7cQSSxB2cPNK3hdmfdtZd4U+Ea4HUIfG5wFxIE6ay/6Kc/f0qxrEZCoo2p14tF8qAg
         oTwVPjvdnmudGgEjiqyJSGbL1oRDyPTxfd1VINLuGSS8Kx2BvQjR+9b+mBSIMB420Vjs
         CmaVHaWsv1+plliQRhLkb8avwU0xewJtFJbR7dsvMAfGvspUdXsKjNOMV8vgZeZXCPXK
         eRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwXtiWsoBT3/ETQ8XHJLKtZU/HCggU775XJY5RyTI3c=;
        b=mac3LtTMvhldlH0HjiVoEk+d7HJOdrDUqexEIn+7dF8JViZCMt9X/4mcx/RPU9vc+x
         NpfiZmA+BAhbP7bTk5adPIY0O3ISspNUkQkZBOVONCSvvA8Iy3lOe62g/5bHrt3keSEZ
         pwzEvNX0mxC1izJjW4jVoUJCu2cDt1zrNBcYL8H+/AP00c14/4HguWchaAJzRnuB37Aa
         QVEx+U8OrcwnJwldd9eyTzjaiOPSxxXlxCQ+gYOaLkEKSrPvv769rDNezS6rFx5txiDZ
         nZVOZ2lwaeNwsLzoqgvFKuM51PVwjmy83SBYQP4VkvM5X/1CPOGca9cCzq/zCRaeki/J
         tJiw==
X-Gm-Message-State: AOAM5335ipPYieZSdFvDqjZQrB65U6hl3vZMY1z1jEhR5x7bY62HHId/
        fDhOcRBl7gdmTsao3SgDoO1ISFHqRWC4uQ==
X-Google-Smtp-Source: ABdhPJytEOeMI3SWt27LOduc26SMeQD43HuA2wVOftReOt8tT/WJGxCjlO1cSu+Trng95Lb21FmUXQ==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr4185765wrn.365.1629986758423;
        Thu, 26 Aug 2021 07:05:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm2471987wms.33.2021.08.26.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:05:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] index-pack: add --progress-title option
Date:   Thu, 26 Aug 2021 16:05:50 +0200
Message-Id: <patch-v3-4.5-e44d825e5df-20210826T140414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --progress-title option to index-pack, when data is piped into
index-pack its progress is a proxy for whatever's feeding it data.

This option will allow us to set a more relevant progress bar title in
"git bundle unbundle", and is also used in my "bundle-uri" RFC
patches[1] by a new caller in fetch-pack.c.

The code change in cmd_index_pack() won't handle
"--progress-title=xyz", only "--progress-title xyz", and the "(i+1)"
style (as opposed to "i + 1") is a bit odd.

Not using the "--long-option=value" style is inconsistent with
existing long options handled by cmd_index_pack(), but makes the code
that needs to call it better (two strvec_push(), instead of needing a
strvec_pushf()).

Since the option is internal-only the inconsistency shouldn't
matter. I'm copying the pattern to handle it as-is from the handling
of the existing "-o" option in the same function, see 9cf6d3357aa (Add
git-index-pack utility, 2005-10-12) for its addition.

Eventually we'd like to migrate all of this this to parse_options(),
which would make these differences in behavior go away.

1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-index-pack.txt | 6 ++++++
 builtin/index-pack.c             | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7fa74b9e798..1f1e3592251 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -82,6 +82,12 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
 
+--progress-title::
+	For internal use only.
++
+Set the title of the progress bar. The title is "Receiving objects" by
+default and "Indexing objects" when `--stdin` is specified.
+
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865c..0841c039ae2 100644
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
2.33.0.733.ga72a4f1c2e1

