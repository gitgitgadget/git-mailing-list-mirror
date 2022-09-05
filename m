Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B27ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiIEI2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiIEI1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4133A4AC
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e13so10305492wrm.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BXqnYtgizAfDXiyQQ9dXqmQKDuWUuWWqm5+MR6MY/9w=;
        b=P0qjcX4itWoXR4MaGDjcmyxkte760yPB5XWwPjmgobsJ4O2lk4o22063eE7UaR+pLK
         qOS263zfEx+2chog0KypICprF19eHx0adJFOgifMyLWFbS3GqJM0QFYIgdJVJPldOfuA
         sajaFJKs783td/7AE6+SvOnQZZNEnILysgj7fjaAt231+nI1dr0ZnlQJEd9uHTh0X3vy
         o2PtAFkU2bTnvNa9fEZr6KtT4AOCZOlTt8tbHFKIKN7oNexPypVZ5B0NVaaaQuqtLlI0
         HMtlu6r2wMPDgptoKYNsZ1q5c2FoRjm67zimbGnFbKdQtIWG+6deb5EC9ON8aCOzSVxA
         e4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BXqnYtgizAfDXiyQQ9dXqmQKDuWUuWWqm5+MR6MY/9w=;
        b=M1F8KOGzsrAAlSi4+zo1bb40IzsRaQR8LexjaMMCd26XdpuutI1u/H+wzZUWUvbMrr
         Ybyyw6I1TNb4XzvwR9moRxj0i1otvoboj59EVHKrK7yFEcY2eERzfm+RZflPNolvDOC2
         At3SNnbpxRzI81whIkgh6mqo/bSKf1DCPf55ASY83MV6/e6SemJSc8EB1IJg1wx9jl0z
         HVn2gKRKSScatazXp32RCtVZHEbXj037Za2SLbDq0VbSnRGBcg5b5d09VgI9dN47pP0X
         d8tjzzO5qTeerbRYUPWPeWTmaN18byV78o/VuRqA0rUcvPcTT62jZZt9Iz8sV3ubfQ/y
         I7Mw==
X-Gm-Message-State: ACgBeo3keMlP3WOLIslemGeEY/cWQslUKKs4eMhP42lFpbsk6ZSNcJFB
        0KsUb5zw/duLp9W57iidu2BjqSaEWURmHw==
X-Google-Smtp-Source: AA6agR7sRYgoMn+Hgo4HSlz9KGBlOE9lUFs37k8PA04LZktMrpRRCBU8GWSW+8q+huAzETeHqCxIVw==
X-Received: by 2002:adf:ffc3:0:b0:228:65be:6fff with SMTP id x3-20020adfffc3000000b0022865be6fffmr3050169wrs.387.1662366434310;
        Mon, 05 Sep 2022 01:27:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:13 -0700 (PDT)
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
Subject: [PATCH 23/34] doc txt & -h consistency: make "bundle" consistent
Date:   Mon,  5 Sep 2022 10:26:34 +0200
Message-Id: <patch-23.34-dee17f861b2-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the -h output to match that of the *.txt output, the differences
were fairly small. In the case of "[<options>]" we only have a few of
them, so let's exhaustively list them as in the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1b08700bf9e..544c78a5f3a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,13 +12,14 @@
  */
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
-	N_("git bundle create [<options>] <file> <git-rev-list args>")
+	N_("git bundle create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]\n" \
+	   "                  [--version=<version>] <file> <git-rev-list-args>")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
-	N_("git bundle verify [<options>] <file>")
+	N_("git bundle verify [-q | --quiet] <file>")
 #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
 	N_("git bundle list-heads <file> [<refname>...]")
 #define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
-	N_("git bundle unbundle <file> [<refname>...]")
+	N_("git bundle unbundle [--progress] <file> [<refname>...]")
 
 static char const * const builtin_bundle_usage[] = {
 	BUILTIN_BUNDLE_CREATE_USAGE,
-- 
2.37.3.1425.g73df845bcb2

