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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D4C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E2660FE6
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhHWLD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbhHWLDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:03:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F1C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so625092wms.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5bVDpDDM4jitAadEpzucYMSoHo4ZJQjv6h4Jf7JGKw=;
        b=tCesf42Z0Z4oT8ddiyg5JCAqrnSESE80CONWIMYSAxfTGfuWLLMgGTsiYrFDk359DC
         PpWZekwfZMNFARkaZT16R7nkql4x9iAWXF1uAfUtwpc46EORZ0WlmDgH4pRKf6M3F80C
         IlK/03wI8W87MGvfk72aJ+gkv9IfUY5+RcbBTJgQdUZLnlpiljgGbESPF7GcV40soup2
         EWnFfx3eXv6yx3WlYvAHfMmHYkB0WJ+e68R2HDgErKcFLEi/LHe22z4nm5V+JbHTbS0Z
         jBvt7Z4aFC37AsPEKKrP74qRKFHIU950qQZEiGQgR21JsbpoUxmE8861s6eiIa7va8co
         OhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5bVDpDDM4jitAadEpzucYMSoHo4ZJQjv6h4Jf7JGKw=;
        b=iLC8YNO4+iLfiZDnHMq1BJwo/O9MJzT3N4f5DkFgz7dTpQIIzSjjPO63EXk7xqilTQ
         gBZML7EgQ82VYZa6SmoT3fIXmThmAKoWn7V8f9u1ED1f8AotgVbuF5WBvSg4mK9VDpdM
         BIQX6rVTi6GjnzaglxrljzBWqRfD10yshvgCyGAMNba6pPRGVhsDWVTbXzCHI3DzjrgM
         H0PMT7SZhF20wvCYXsT0owGxJdFCdPN6ItEuTC4r++oW1ntBVE2HhuF3rTG8hnurwBoz
         7E6u97ebI2jt+93AoE9C9/kjiSQECtNjjqQQYlGv1lpc8u/U25uC8M7JClSdR+cmjkJX
         vA7Q==
X-Gm-Message-State: AOAM531/uiGopGpNLlCKS0uCzFuqDBGldNlnsw2nuR4W3suNNWnfOBC3
        Cehuj8Rk1e0XeyiL1MNKkXHqKgjvQ3y8fucr
X-Google-Smtp-Source: ABdhPJxz1vdCaVTwSW1ukqmkH+A4OdLAnBY0S57P2N4Ag2DcEl0HSMhSx//yS3vJKTVNZvrhySPL7w==
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr15553243wmq.120.1629716587579;
        Mon, 23 Aug 2021 04:03:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19sm13255493wmi.4.2021.08.23.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:03:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] index-pack: add --progress-title option
Date:   Mon, 23 Aug 2021 13:02:58 +0200
Message-Id: <patch-v2-3.4-67197064a8b-20210823T110136Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --progress-title option to index-pack, when data is piped into
index-pack its progress is a proxy for whatever's feeding it
data.

This option will allow us to set a more relevant progress bar title in
"git bundle unbundle", and is also used in my "bundle-uri" RFC
patches[1] by a new caller in fetch-pack.c.

1. https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-index-pack.txt | 6 ++++++
 builtin/index-pack.c             | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7fa74b9e798..9fd5d8a2d45 100644
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
2.33.0.662.g438caf9576d

