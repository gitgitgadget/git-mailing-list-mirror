Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC6C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9318D6101C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhDSNa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242806AbhDSN34 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 09:29:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC931C061346
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 06:27:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s7so33959268wru.6
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=y8x+BulslIfGI1w71aH2+8e0BF+2QDD/5Ra5U9rHOvo=;
        b=b7uodjpJ/Qy57Ha1csY6NrfXqMvDFLPJE4Wl7nz+JeFiPL5ljl6Pm9SBp1JmkY6Bc8
         FQ6U+n9FbkWK9iX11xDJsvvbwx2ERWd6hl8MyJ/8JQIRk2MxGF6XT6onGawrDRNf6ym7
         3zCgb3mqqC4nGoUWASsdGeFOAB5UHiOyWxJ4A4w8bcOjqAtl5XxlrFO6LgS9nFNSWeFc
         +RFXkcdYdg/hhBgo8POPW154SyxnqIkR3opaHIt2St6C5ohHmG0QKeedgqVUzGe//9lN
         Wp89uregwWKXWHN8LaFDBQ2JEB4dZGS4aGGVMmyhvdFG1WvTphVHEpDN4VKXo/9vezMr
         r0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y8x+BulslIfGI1w71aH2+8e0BF+2QDD/5Ra5U9rHOvo=;
        b=SpmDymEcPg/7WtC9z0mEOAL0yALvm4+FNEBF2jEtStnhR9NBBepb368Y2UJcZXCcQT
         njIfowZCVXlNIO4GlV1jy4KbQhyzZpdtgA5uvCAfjZVbptgCIWNebIkskoePPqumF/3H
         mUbHxMF82S/dYKXxNe3Lyc8UkOhe8T8sBhOTyuPoGgwQtR8JGj/EstSrUo/gk/GnJqMD
         QNCsM06DsVyWxxlc2N9RGqF4fIFdKaPJQRTBnT4FYHxO5ljt/MDr64FphCyn/pzXGSsO
         zkgpuKpDsSMDJohnQlRSsu93ru9QL2wUsETqzK8CkoTryj6mVzrwY48pckiZcUx70mjf
         YRwA==
X-Gm-Message-State: AOAM533h32udbzf/0YjrZ34i+I61q3dhdsAQ6iCWE8pYS5F/bqkjQJXK
        lXt7O3iojkXN+Z7r2uxfN+DZMn/PW5I=
X-Google-Smtp-Source: ABdhPJwfhWYujusMrV3A0sD8+FZKp48c88jXmR/v7YH49RqPCz7Zs8V7UG/X3JETbxdrPuf6XYhA8A==
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr14820378wry.24.1618838857523;
        Mon, 19 Apr 2021 06:27:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm17440736wmq.4.2021.04.19.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 06:27:37 -0700 (PDT)
Message-Id: <pull.996.git.git.1618838856399.gitgitgadget@gmail.com>
From:   "Andrey Bienkowski via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 13:27:35 +0000
Subject: [PATCH] doc: clarify the filename encoding in git diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrey Bienkowski <hexagonrecursion@gmail.com>,
        Andrey Bienkowski <hexagonrecursion@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrey Bienkowski <hexagonrecursion@gmail.com>

AFAICT parsing the output of `git diff --name-only master...feature`
is the intended way of programmatically getting the list of files modified
by a feature branch. It is impossible to parse text unless you know what
encoding it is in. The output encoding of diff --name-only and
diff --name-status was not documented.

I asked on the mailing list and got this:
https://public-inbox.org/git/YGx2EMHnwXWbp4ET@coredump.intra.peff.net/
> There's some discussion in Documentation/i18n.txt, which is included in
various manpages (e.g., https://git-scm.com/docs/git-log#_discussion)
but it doesn't seem to be mentioned in git-diff.
>
The short answer is: mostly utf8, but historically on platforms that
don't care (like Linux) you could get away with other encodings.
>
-Peff

My takeaway was to always parse it as utf8 regardless of platform or
environment.

Signed-off-by: Andrey Bienkowski <hexagonrecursion@gmail.com>
---
    doc: clarify the filename encoding in git diff --name-only and
    --name-status
    
    AFAICT parsing the output of git diff --name-only master...feature is
    the intended way of programmatically getting the list of files modified
    by a feature branch. It is impossible to parse text unless you know what
    encoding it is in. The output encoding of diff --name-only and diff
    --name-status was not documented.
    
    I asked on the mailing list and got this:
    https://public-inbox.org/git/YGx2EMHnwXWbp4ET@coredump.intra.peff.net/
    
    > There's some discussion in Documentation/i18n.txt, which is included
    > in various manpages (e.g.,
    > https://git-scm.com/docs/git-log#_discussion) but it doesn't seem to
    > be mentioned in git-diff.
    >
    > The short answer is: mostly utf8, but historically on platforms that
    > don't care (like Linux) you could get away with other encodings.
    >
    > -Peff
    
    My takeaway was to always parse it as utf8 regardless of platform or
    environment.
    
    Changes since v1:
    
     * Replace "always" with "often"
     * Add a link to https://git-scm.com/docs/git-log

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-996%2Fhexagonrecursion%2Futf8-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-996/hexagonrecursion/utf8-v1
Pull-Request: https://github.com/git/git/pull/996

 Documentation/diff-options.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aa2b5c11f20b..4ce36ef535ba 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -293,11 +293,14 @@ explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
 --name-only::
-	Show only names of changed files.
+	Show only names of changed files. The file names are usually encoded in UTF-8.
+	For more information see the discussion about encoding in the linkgit:git-log[1]
+	manual page.
 
 --name-status::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
+	Just like `--name-only` the file names are usually encoded in UTF-8.
 
 --submodule[=<format>]::
 	Specify how differences in submodules are shown.  When specifying

base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
-- 
gitgitgadget
