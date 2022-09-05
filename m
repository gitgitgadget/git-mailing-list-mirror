Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA7C6FA86
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiIEI1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbiIEI1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126821758F
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f15so5524751wrw.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MhLTPdpNHoqrzq9+KnLmuvjF7tk0PvfIfbeJVhYEqAg=;
        b=A6XPK9Hm44KLwLwMBUEaHvZ0nqVsqpJos1NzsLvakhSMYuUDYgcrUE2f6mdBaTIZfQ
         qryDG/BYLA7nBSDn7g0HMLpyHGysqpXBLpxxgUHTlyMP5UO+tMTqVl+fpF7dHZWnp7r2
         om++xAt2s3fqVAdpXkRY6RtU1JnLY6epp4OH8Skoi/3eQ6X/GmNXy5XmJIyHchuXE2kt
         hcnD9cWCXhMEaNx69n06SWCZQKS+ymzgyMp9XtKBoUv2wbOJyZJasvDdgJHg86RaSqle
         U57ulMb3eXBJDRsvE/gMyTxm4SCNDrTG8NrBgjw6YD4Z0kNzDOnimn54jNLSwvu2Dj5f
         yRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MhLTPdpNHoqrzq9+KnLmuvjF7tk0PvfIfbeJVhYEqAg=;
        b=Xniev2/ulj3+e0NnwdxiJ4WM0AClMNm7S/kiHWuCt2tlbz3ugJUecrfQOBTALKCmx8
         0Y+DX262wrq6L/987iYYGod2lzk/rZjw8J/if1SVR4RX+Jr7k01ulpmQEDNGg+KZ5tVX
         ZM08THjGrYUDJ84skMzdWtpGsSEHJBkmX9eu67E/XqiJnNgMdU/SIEdGhbUdHGiUvBKk
         qQe3jlttzn71v+rBN6W4ow+YXi6S0xJ1EAaK1azbMPuc57tkbJL/m33BGRZ/Nar+0Yyu
         sxjqnTu8DW44y77haidhjGbX+akxaAYIMLY8yvPqygXEF4NvpiVN120IybS8HIMT7RZF
         Ab4A==
X-Gm-Message-State: ACgBeo1g9S2zE9kjARVj9z3p4S0QafuDjsxfyDlL6qkBu8+/qTkyFPtN
        RJvXkZq80xI8K6XsuDMQj/NUfpjF0/jGiw==
X-Google-Smtp-Source: AA6agR4OXddEdo99Pgyzt/0A2ahOf8sDKrZtkrIX+Qea36IanMwcjNeE66POWqjIxKIgOUQfydMCvg==
X-Received: by 2002:a05:6000:170a:b0:226:def1:9410 with SMTP id n10-20020a056000170a00b00226def19410mr17605184wrc.142.1662366426047;
        Mon, 05 Sep 2022 01:27:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:05 -0700 (PDT)
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
Subject: [PATCH 15/34] doc txt & -h consistency: use "<options>", not "<options>..."
Date:   Mon,  5 Sep 2022 10:26:26 +0200
Message-Id: <patch-15.34-33d47a8a827-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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

In the case of "mv" let's add the missing "[]" to indicate that these
are optional.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mv.txt     | 2 +-
 Documentation/git-status.txt | 2 +-
 builtin/pack-objects.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index 39e28cfcafc..f3ffeb4cd0f 100644
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
 
-- 
2.37.3.1425.g73df845bcb2

