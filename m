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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B26C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB386610A3
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhIKTLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbhIKTLm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22953C06175F
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so2789747wrq.4
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=509hFfgLXq5rsuWWiRmsRiQFHNvqLlTn3QulSzySEGQ=;
        b=ghAubXGHaxz7kc20LHIz0Xa5JC4W3KG9fIzH4/5ijkHx837u7lBPQ9wuDCuwkBX6YB
         tFwdWcvilSIGp9tvEdOVnv3OaDUCZCoIfDxskURs2dW5EXg6HGqXSEkl7SlMZyQyaS85
         6+6rStZviq0ZeTV+pONuP+4eshpMEhtu6tcrPromkDCb33gCoY8Gs4jOnhvfnsG7UXNl
         sIZowcbJlGIdnH8UpPiL416fR6XNXIGeLCerpTWwmveP7dOjKv+u8fqxjBgi0Dp++jKb
         5rGBzOL4NJm+nkNxelEQs0Ydb6dv65F7i79aGc6sahHPzH9nzsGA7bphI8oKysoVoMXX
         +wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=509hFfgLXq5rsuWWiRmsRiQFHNvqLlTn3QulSzySEGQ=;
        b=D16yD7fVSUxaRkgNBWxhnaw8WUgPFRmFXHgYMsUsu1gqbmSpyTKMRMaeix5w7nt8nu
         nJ28sTHfub/L9CO3pbIfxVkbkiGGGDzgaQEdswsQm1s0+E0TUwj0606xuLn8aRiLhwLw
         ls0z4sD6yfBG1XYuKXCGYJ2xmjGh9lawzZ5l42/5kmJQq2nJZTPuOolgKwTJnMSUNVL/
         hrNSHDgktOFuFbVntg1xIX9Z9LzfgixsLRM1HTSp8Yf6x8VedztjkINqIc5a51RFfmoj
         UPuHLLjK+6MbrX2EjZNqOiFeGkbso4O9oveM0Xyxm2EcOkEkU+fdJuD/1njaQI5M9c4s
         a9xg==
X-Gm-Message-State: AOAM5325R8OIa1ECT3zwqRmFb/Xz8atrVXDgetFjyKNRoeGADXmDVTke
        XPu+VI5OqyLDn8iwjKbCdpYRAJBzDot2/w==
X-Google-Smtp-Source: ABdhPJziXv4H4ZuZUb0zMLbBF4keJaDTMvTy3XvSYwISIgVCw15TrKzqnBbPvgDnzRJumeSOu9MgMQ==
X-Received: by 2002:adf:80eb:: with SMTP id 98mr4242212wrl.348.1631387427405;
        Sat, 11 Sep 2021 12:10:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] blame: replace usage end blurb with better option spec
Date:   Sat, 11 Sep 2021 21:09:01 +0200
Message-Id: <patch-v3-2.6-036eb0efb5b-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "git blame -h" output to be consistent with "git bundle
-h"'s, i.e. before this we'd emit:

    $ git blame -h
    usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>

        <rev-opts> are documented in git-rev-list(1)
    [...]

Now instead of that we'll emit:

    $ git blame -h
    usage: git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>
    [...]

This makes it consistent with the usage spec used for "git bundle":

    $ git bundle -h
    usage: git bundle create [<options>] <file> <git-rev-list args>
    [...]

The use of this in "blame" dated back to 5817da01434 (git-blame:
migrate to incremental parse-option [1/2], 2008-07-08), and the use in
"bundle" to 2e0afafebd8 (Add git-bundle: move objects and
references by archive, 2007-02-22).

Once we get rid of this special case we can also use usage_msg_opt()
to emit the error message we'd get on an invalid "-L <range>"
argument, which means we can get rid of the old-style "blame_usage"
variable entirely. This makes the output friendlier, before we'd emit say:

    $ git blame -L1,2,3,4 Makefile
    usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>
    $

Now we'll instead emit:

    $ git blame -L1,2,3,4 Makefile
    fatal: Invalid -L <range> parameter

    usage: git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>
    [...]
    $

The "[...]" there elides the "git blame" option summary.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..e469829bc76 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -29,12 +29,8 @@
 #include "refs.h"
 #include "tag.h"
 
-static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
-
 static const char *blame_opt_usage[] = {
-	blame_usage,
-	"",
-	N_("<rev-opts> are documented in git-rev-list(1)"),
+	N_("git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>"),
 	NULL
 };
 
@@ -1107,7 +1103,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path,
 				    the_repository->index))
-			usage(blame_usage);
+			usage_msg_opt(_("Invalid -L <range> parameter"),
+				      blame_opt_usage, options);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-- 
2.33.0.995.ga5ea46173a2

