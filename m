Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA995C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJDNYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJDNX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:23:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC16CE33
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:23:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o5so8887937wms.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNsiYuRQSP+tfKsK0fGGzhUJVjHNLbZA9YRouJmlX0c=;
        b=FGWlHPnwcuqdoQs8krH9DlECCXWn2aW3WnNXy6eCitYXYZGKKTXVSYd8qsmoQ+MNuM
         Cx0ma7y7lNc/b+35pZK53vVEDd04qHO258wl0CJy4SG2Vgni9RvE+HMnlfttckKOVuel
         EFM6iUOmhtjoUHEO3cng7e4uzfFTtEdeiKy/idZJmAZu/fy4dckl9xsBvOSTxsfE3dUb
         Bah2w4n/KuMjS7Z50+kh4YTq4OsiETVLYzFbtsk0tWsrA3ctKQ/irplAY2t4PuMWjCLN
         gm1WuX20kquuOJ4yFqB233Ef3QN9zCwt/rqqFONWbV24k0R2exYt1uCREh7jiFz/n5KE
         jg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNsiYuRQSP+tfKsK0fGGzhUJVjHNLbZA9YRouJmlX0c=;
        b=lnBFkHPN9k6A7ph3u3vXW0UTXvLXT0GTqTYE57LpthUZFdra4DY0I5edH27dFJN7qn
         jCAU8UgCnQ2uOcve1ZZXTHlIyZ6+oPhhSAk69FKh0wu0E1GXoYGyb8/mF+mUtV5L6/EQ
         XiIV+2aLF1fzNfZcMUE5dZy+mLs0RC8eKsy2yIP5+A4IrsG7N8luidlVv4/RAWf99h5G
         mECw5IUIRV69tSopb3uwjdjaVQ3cA7HdjHPUJck0RbjMDfCcFc1UPcHtMBv1B+axlAQl
         4BhUaQlTKyYqGs/M8DzAyzuEQahnZq2Wv+YxaaQXiz3Z5C52UQ6cARjdRuRzQiYuYPtH
         WVjA==
X-Gm-Message-State: ACrzQf0yRmzNj5rMcbVNaHQ2oHsVaU4MZbbncVqNIkR6RjOBzdq3RYfh
        J/QwWQqWYqyUbdZJxk9ENfplBzeBNIXEKQ==
X-Google-Smtp-Source: AMsMyM7I1/y3BnVJsXuBnZykt2iZJZxq7CN/Lxqd2F1Hgqxaio1g3aYun8S1MgMmcb+36JL3KoRfrQ==
X-Received: by 2002:a7b:c40e:0:b0:3b3:3faa:10c2 with SMTP id k14-20020a7bc40e000000b003b33faa10c2mr10473762wmi.32.1664889834891;
        Tue, 04 Oct 2022 06:23:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/34] builtin/bundle.c: indent with tabs
Date:   Tue,  4 Oct 2022 15:23:17 +0200
Message-Id: <patch-v4-03.34-b7c98a40393-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

