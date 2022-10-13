Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC22FC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJMPjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJMPjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195142733
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a3so3541377wrt.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl1On+b50GpNZ/TGOwLJm0n/+sJcl5ZvmJGb2ZwBBG8=;
        b=dlfGqsobacua7hwtmzc/61+W/O055uy9wJ57LWspuTys+wNTNZrSKaifX106qGWHRL
         79213w4BGu71kXZCT2gD/QL3E356EUKxqmp/DwSNvAZ6CVDsi8lq7N20j9lxO5sFVmav
         KHPeWOEO88XJmOjOnmTknQl4wsVujYW7zUeb6EVJse3jW7VjV4zt2I0pQBt1KaSIm/6g
         EfAGWIze3DlNr1ZnceixGgroPv+DMCY3FCeLFDFepjWe3T/Ud6A/aol3WpoQBxGJcSRu
         kbtwObfMiLo3G/MOFRKyRLNV/N/9eg4fP7h9zQ2FEIM1OaMWin79dFcBGglEwpcRcFT0
         /6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl1On+b50GpNZ/TGOwLJm0n/+sJcl5ZvmJGb2ZwBBG8=;
        b=Hg8pFOQX1405lCXAsJHl3FBCiObEZqt0emweV+cEyV1zQ1gf3hi+YjTcodDz7EmVw/
         pFaaDyASbYQAtjds6VI9cDAy8zytXErDPeznBaXrFFk4eODbCbuJaT49HF9AMMTTPfzl
         sNdFv866Kh0uAxTchjiHzLG8pMbIRhtCpaIkJYuR4AURiou0wffE/t5Wo08w9MWKZ50P
         0gA+h5rmqRxd3YF476LOaU6uArsAP8a0yvX9a8c2Lg86ApGDggu7ifKd/ntmhIn91lk7
         9NxkI61yeK+iMnZcMxKypnFfunRZkukzQrmZLX6kqm9R+WUYk7W9oM1Jt6F91Gfg38aj
         HiYA==
X-Gm-Message-State: ACrzQf2UgTroqsD30EoIE2wm4DsohKaTLKLBa+PYDbs/4ZGE1yQQUBV6
        E3jJX4JbHKl+D9E2rIb3/Dl1yjZCpaSh1g==
X-Google-Smtp-Source: AMsMyM7390Jjn8QYCNLKSwB40Jvp9B+WT2+8kDqUDTTy1zLavdkKzuAFaHbp9n5AcstfrYSySt/EQw==
X-Received: by 2002:a05:6000:1f88:b0:22e:3c57:943b with SMTP id bw8-20020a0560001f8800b0022e3c57943bmr399682wrb.65.1665675576818;
        Thu, 13 Oct 2022 08:39:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:36 -0700 (PDT)
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
Subject: [PATCH v5 03/34] builtin/bundle.c: indent with tabs
Date:   Thu, 13 Oct 2022 17:38:57 +0200
Message-Id: <patch-v5-03.34-dadae0d364f-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

