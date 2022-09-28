Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93366C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiI1IkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiI1Ijl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA30113F09
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h7so6226139wru.10
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tosyrrb83lJV15u62cQrYf+ELhCA98hJlUsUjfzbf6Y=;
        b=hn489AoHYDGxtB9pC14jwNiA2D/uazHdm3QDBh05BctMDpqCSZ0Wo70mN0J610o9yq
         cRoJmO5vQpl4xIebUGpUzU8TV0NyDrEN3KeV+mDFYn96LqMpI4F/sg/5kt7VUnosHaFu
         4HgjffVIphD3nY8/Iv1qGKH2DOhysF0z97/Y0cRvdXKKQ0in3IwEShydubZeIHkjNW7m
         cFCfC74Pr5jWYJZXa2RDv9zlFFueUBZn8GkUiqblFMBryr10OOL47nfkaeTZajCj5mCA
         yhh31hxgRqFRtjPcCeDV7iPfwDI71+jS/+di8C6gXXzFaHUIqWdPU3hpB7DEn2tc5M/4
         rcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tosyrrb83lJV15u62cQrYf+ELhCA98hJlUsUjfzbf6Y=;
        b=xp4IMmmfhlMVKgwi/Gx39ILTgfkhyfGh8U1LBEoU/0pGbr2gXAd/jpO+BZDYdrhzZi
         N+ffruf0lzJ+ZQyuw09cIRF+CD2zfVupyATX4cOyJM52qfsF1Cwdl8Uqj6M46iMuTqMc
         o8z4aFKbnEIRz8neUHk9foWiD/XoSCpjKRJvbMc+viBHfZX4THBwePEL5CNnJC0uWFDa
         +QBaJoJOdL8otlgYAZE42yTmmOqdfhF9fVrcLgcpU+ocYvqlgBapcOf+raFWtTtj6Dn5
         zx+FVoADX9UpGkXKRzy68p3eta4BY+nFncD7Y5/AmKL80U9lpYku+HurhML6I30HlBq5
         XeaQ==
X-Gm-Message-State: ACrzQf1Euv2N8VjptoT12GT4xswegR/Vm05nHU0K0VPx3tswQM6CsZGu
        EGBNIjuuAKAX0dMMzjkGbqG+g8tcyEANSw==
X-Google-Smtp-Source: AMsMyM4hChYkQACzpXmbcsUNkCNfZfCBGP9TdIkpkVHVyorwMNdBvaYqe2fTOUE6MtlLyzcy54CPGA==
X-Received: by 2002:a5d:64c2:0:b0:228:cb3e:1ce with SMTP id f2-20020a5d64c2000000b00228cb3e01cemr19682492wri.392.1664354377920;
        Wed, 28 Sep 2022 01:39:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:37 -0700 (PDT)
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
Subject: [PATCH v2 02/35] builtin/bundle.c: use \t, not fix indentation 2-SP indentation
Date:   Wed, 28 Sep 2022 10:38:57 +0200
Message-Id: <patch-v2-02.35-63145b58504-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix indentation issues introduced with 73c3253d75e (bundle: framework
for options before bundle file, 2019-11-10), and carried forward in
some subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index e80efce3a42..5c78894afd5 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,31 +12,31 @@
  */
 
 static const char * const builtin_bundle_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  N_("git bundle verify [<options>] <file>"),
-  N_("git bundle list-heads <file> [<refname>...]"),
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	N_("git bundle verify [<options>] <file>"),
+	N_("git bundle list-heads <file> [<refname>...]"),
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-  N_("git bundle verify [<options>] <file>"),
-  NULL
+	N_("git bundle verify [<options>] <file>"),
+	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-  N_("git bundle list-heads <file> [<refname>...]"),
-  NULL
+	N_("git bundle list-heads <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static int parse_options_cmd_bundle(int argc,
-- 
2.38.0.rc1.925.gb61c5ccd7da

