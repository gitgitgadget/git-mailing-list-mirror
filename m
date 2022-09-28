Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA3C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiI1IkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiI1Ijm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6771A3BE
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso718372wmk.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JvL7xdFYloeXr1xWrqgq+LeuChoJvSoMuTTMWo+XfBw=;
        b=meEwc31E3HFwKEv9TiwVfyVcDH7hN6CksdZ4gTlr7UKGd7P9DauRmElShGJIv0IQX2
         audSy0Y/yBniotWV1rvOKEJD+TVV3FeySh11TGuh6G2fRMNdpQzd280w7uLvkLSel8zY
         ZGTJrokz/aVJaX0s85H6FUoT08IZ4mbVAhn2Q2ZOMFEcJpZUo+2UcbxSCuyYva5kIaKh
         4ozOVhxcRbMsnSjZFr3pcJDdvOoejOEZbDNpcE4ge0z02IGY4MbJQR8L+cQD2FRdcjqs
         F9ZnLmCXPlTK0ilHEaGiT2oeIQTanzzVsRAr3L4qcQn5+rbQosDCN7PTbIj5JeCct5Mn
         6SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JvL7xdFYloeXr1xWrqgq+LeuChoJvSoMuTTMWo+XfBw=;
        b=1Yz0+AL0JizOq4Q7DhOIjpdi9TuU9SHFYPWYMqkpiv/Q+YQldw6nhw3HAE/Zf+k5S8
         8Xej/TyfDYuQUwNL+xp5N4hxyMCdsV6owAtcRmHg62/iPzAx21LTkUwXqYqRZPIKlnA8
         /Om/LP6l11m/t3zZqnvY5PJT6d2ywrlHMgiZqKTh2aV7Tf2LdMeBhN8oyJU4GXktsML0
         mDQTCmX2JeVNdN74df01mZdyeR7sRRHUcMi5uf6szvp2oxlmwWaPjrNhA4f2/RaiiYuP
         kJrXfxJhyXo6pitzw/wgRNPOt/Ch3Iv+oBoeSBE4LE+FQJOtr5uKcOPpC6NRYcmWjAVS
         qxUw==
X-Gm-Message-State: ACrzQf3VesH/aFP3wRptW8CJT3QkDdtFztjUEc/V04ZAFaMkW3lF3Erh
        UWLlbsEf7uFeri/7lKge/BND1olAeMzBSQ==
X-Google-Smtp-Source: AMsMyM48HD68A5c5pVtxvv1gy3zwnz38ullcVAo+KfqL/VVlJtgz1lt4pdeOJJeGUa89JFTwnsZ1BA==
X-Received: by 2002:a05:600c:a49:b0:3a6:673a:2a9b with SMTP id c9-20020a05600c0a4900b003a6673a2a9bmr5733367wmq.3.1664354379017;
        Wed, 28 Sep 2022 01:39:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/35] bundle: define subcommand -h in terms of command -h
Date:   Wed, 28 Sep 2022 10:38:58 +0200
Message-Id: <patch-v2-03.35-6bcfab04cbe-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid repeating the "-h" output for the "git bundle" command, and
instead define the usage of each subcommand with macros, so that the
"-h" output for the command itself can re-use those definitions. See
[1], [2] and [3] for prior art using the same pattern.

1. b25b727494f (builtin/multi-pack-index.c: define common usage with a
   macro, 2021-03-30)
2. 8757b35d443 (commit-graph: define common usage with a macro,
   2021-08-23)
3. 1e91d3faf6c (reflog: move "usage" variables and use macros,
   2022-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5c78894afd5..1b08700bf9e 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -11,31 +11,40 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char * const builtin_bundle_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
-	N_("git bundle verify [<options>] <file>"),
-	N_("git bundle list-heads <file> [<refname>...]"),
-	N_("git bundle unbundle <file> [<refname>...]"),
-	NULL
+#define BUILTIN_BUNDLE_CREATE_USAGE \
+	N_("git bundle create [<options>] <file> <git-rev-list args>")
+#define BUILTIN_BUNDLE_VERIFY_USAGE \
+	N_("git bundle verify [<options>] <file>")
+#define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
+	N_("git bundle list-heads <file> [<refname>...]")
+#define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
+	N_("git bundle unbundle <file> [<refname>...]")
+
+static char const * const builtin_bundle_usage[] = {
+	BUILTIN_BUNDLE_CREATE_USAGE,
+	BUILTIN_BUNDLE_VERIFY_USAGE,
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
+	NULL,
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	BUILTIN_BUNDLE_CREATE_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-	N_("git bundle verify [<options>] <file>"),
+	BUILTIN_BUNDLE_VERIFY_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-	N_("git bundle list-heads <file> [<refname>...]"),
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-	N_("git bundle unbundle <file> [<refname>...]"),
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
 	NULL
 };
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

