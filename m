Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF52C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJDNZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJDNYX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C8520A7
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so21315215wrp.11
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5e7xmhKSSgoAZccKa8db+ctFhlOMHRmpx7zbzu6EtM=;
        b=WYCyk3i9dEvdJpU79eBWQhd89baWoNkhFS6esWckEzMIn7LiGfeFwa4JgXcVe5Z1wo
         HiRAhj+wdPfVfBcA6V8eXZIh9EtWvwlsuMgsxPWogo6abg5HDJBwHKI14cTQjN3054XA
         9OWp20JoI/MxmykpP+1gjGHefL+Od4pgOm1B3M5ujl/JvVWDVBOHFMqnI9t1yc4KtUCv
         91XiypiRNpDGsOj9DKi/4a7NRWs8e/ntQEOQuvnANdcdRMYlk9502k0fZEont6c0jY1D
         3mvH4WWYO5o+JIAzXVYohb5STfM08SbGR4atCfE7L3ONeYdTyTAScEuFe7y8x0B+DmOe
         kvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5e7xmhKSSgoAZccKa8db+ctFhlOMHRmpx7zbzu6EtM=;
        b=nkjfJWxv4PerZhduijcpBHG5OEDQR6pWJU3cVBcK99KY8qsymkS9q5WcKQ0EuxyslA
         NO21OpvtQxvcQalWnTmLYzf6yVKCSjeYU7NyTUekJrcobwKT48g2x+vPbL1orBnqFsuC
         5Ujj9nm+mZogSfVib+D3fhVqT52NCXh/JECbgJ+6E7H8x/TagaE/eaT+ChbvZPLWOhZh
         5Xqvm1q7d5GQT7bwYwAnjH1iTOY526FjmOsgRWit9Ax7D3ZBDieOmy14ALrxlwa+B4Ju
         HBkel5VbkeY9l0iJU4IfBSv1+rTL/rUqrTqBAW1OiWzLcO3iyK/4CjH6g8czDLtH6NEl
         PyUg==
X-Gm-Message-State: ACrzQf38DeSDkgwBJGYFn2QAJRMn1wmVeI/khjgBVIEyNhIHn0fbYzoB
        2czmcybOsukMy0t8/+i9kcjb8ySVrdVUAA==
X-Google-Smtp-Source: AMsMyM6cuYX+3FTExzOeXPOuHr89NLCIpW/Q2ym+opdoJjMt/iFsShCfxRtDl+QUpdDs7A56hpWmFg==
X-Received: by 2002:a05:6000:1541:b0:22a:3b77:6ef4 with SMTP id 1-20020a056000154100b0022a3b776ef4mr16148205wry.303.1664889848963;
        Tue, 04 Oct 2022 06:24:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:08 -0700 (PDT)
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
Subject: [PATCH v4 14/34] doc txt & -h consistency: use "<options>", not "<options>..."
Date:   Tue,  4 Oct 2022 15:23:28 +0200
Message-Id: <patch-v4-14.34-e5cb5c91b82-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's arguably more correct to say "[<option>...]" than either of these
forms, but the vast majority of our documentation uses the
"[<options>]" form to indicate an arbitrary number of options, let's
do the same in these cases, which were the odd ones out.

In the case of "mv" and "sparse-checkout" let's add the missing "[]"
to indicate that these are optional.

In the case of "t/helper/test-proc-receive.c" there is no *.txt
version, making it the only hunk in this commit that's not a "doc txt
& -h consistency" change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mv.txt     | 2 +-
 Documentation/git-status.txt | 2 +-
 builtin/pack-objects.c       | 4 ++--
 builtin/sparse-checkout.c    | 2 +-
 t/helper/test-proc-receive.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 79449bf98fe..972a055fbd8 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -9,7 +9,7 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' <options>... <args>...
+'git mv' [<options>] <args>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..5e438a7fdc1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -9,7 +9,7 @@ git-status - Show the working tree status
 SYNOPSIS
 --------
 [verse]
-'git status' [<options>...] [--] [<pathspec>...]
+'git status' [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..573d0b20b76 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -180,8 +180,8 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
 	NULL
 };
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index aac0f708e42..58a22503f04 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -20,7 +20,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
 	NULL
 };
 
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index cc08506cf0b..a4b305f4947 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -6,7 +6,7 @@
 #include "test-tool.h"
 
 static const char *proc_receive_usage[] = {
-	"test-tool proc-receive [<options>...]",
+	"test-tool proc-receive [<options>]",
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

