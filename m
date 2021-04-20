Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32126C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020A561363
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 11:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhDTLZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhDTLZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 07:25:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE32C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 04:24:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so10126235wmh.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2fEEv0uE52g6ZiXPUm17jKZNaSiPs7Jd/bjt3+6rm8=;
        b=EpJfv28UA+IwssTGZ9Fyu3rol4LhrWM+uuHn9pjOS8XnMdu481xjALAqWVcQSh+0l7
         7bzboygs3dsCI094pw9Pfoil4P2M7Hl+vrgcWtKxXGIm4tSBApPw8rmvuw8bpHeBczSj
         pk6eSSkt+PuKfdIeVOLWYjeFbz5An5rHe/CNSQkl22EPc4wf3k3gB7aPg7jEwY+dn3Wk
         sRyksMG9/0WUTimKxbk6IzDdtPB5az443oj1l7nw1g/IkpmwMSH5RPPKYASrn47R7s6l
         8AZK1+iD2UgQ+0CgCPVOAeB98NeOCFHsOBMHeRjsKkIGjuav73CkmKUN1+2N1M+5CiY3
         uRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2fEEv0uE52g6ZiXPUm17jKZNaSiPs7Jd/bjt3+6rm8=;
        b=te6dbynWCoU04kpy91qcWS/WgY2Ke7Xm/4z+bPOzxoCzwG78SvAaF0T7ocBGRAPpdA
         5qdyyI1jDC8XJxmSSQuPjrMh6zxPP6zEDDjDUKwIaUbQOZ0buGl/wHSCgfDpbiF0Kz5Z
         wCkZ6KuxQta/j7fNtwWtCNhYUvcyEXGnIP8h0NFPxed2gf6jSXp4v3ohJgpD+PnofQfm
         zcIXTQLoJP74ovFVWKhGN45BZP/vFN2IFXCBFPVvR/cGOtAG7NZCTPgjioRgSAIja4C5
         /Pw4a/P9dxXTqIPJ/XdvB8TfKUsGhcl3kK2NvHcZ740loaCz3U+31LPgIod5DM8wCgUW
         yYZA==
X-Gm-Message-State: AOAM530ytXfXzPQT1ng0TN+X1sUflgn8OJEc7UVenioXEhnfQCQnU9Qz
        oCmo9I+AiaXVCn0SdNMVtf87/HfQRGU=
X-Google-Smtp-Source: ABdhPJz1pdGcwS8DnPZdH8SdLDz9/GSpz4ISTjSTQ9U8x0cjqIbyiXOhQdAulb4Iq8FhZ5TWOCxd7Q==
X-Received: by 2002:a7b:c415:: with SMTP id k21mr3946887wmi.146.1618917879179;
        Tue, 20 Apr 2021 04:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm26272027wro.4.2021.04.20.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:24:38 -0700 (PDT)
Message-Id: <pull.996.v2.git.git.1618917877881.gitgitgadget@gmail.com>
In-Reply-To: <pull.996.git.git.1618838856399.gitgitgadget@gmail.com>
References: <pull.996.git.git.1618838856399.gitgitgadget@gmail.com>
From:   "Andrey Bienkowski via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 11:24:37 +0000
Subject: [PATCH v2] doc: clarify the filename encoding in git diff
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
is the intended way of programmatically getting the list of files
modified
by a feature branch. It is impossible to parse text unless you know what
encoding it is in. The output encoding of diff --name-only and
diff --name-status was not documented.

I asked on the mailing list and got this:
https://public-inbox.org/git/YGx2EMHnwXWbp4ET@coredump.intra.peff.net/
> There's some discussion in Documentation/i18n.txt, which is included
in
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
    
     * Replace "always" with "usually"
     * Add a link to https://git-scm.com/docs/git-log
     * Replace "usually" with "often"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-996%2Fhexagonrecursion%2Futf8-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-996/hexagonrecursion/utf8-v2
Pull-Request: https://github.com/git/git/pull/996

Range-diff vs v1:

 1:  4f1987e5e09c ! 1:  6daa652b7b15 doc: clarify the filename encoding in git diff
     @@ Commit message
          doc: clarify the filename encoding in git diff
      
          AFAICT parsing the output of `git diff --name-only master...feature`
     -    is the intended way of programmatically getting the list of files modified
     +    is the intended way of programmatically getting the list of files
     +    modified
          by a feature branch. It is impossible to parse text unless you know what
          encoding it is in. The output encoding of diff --name-only and
          diff --name-status was not documented.
      
          I asked on the mailing list and got this:
          https://public-inbox.org/git/YGx2EMHnwXWbp4ET@coredump.intra.peff.net/
     -    > There's some discussion in Documentation/i18n.txt, which is included in
     +    > There's some discussion in Documentation/i18n.txt, which is included
     +    in
          various manpages (e.g., https://git-scm.com/docs/git-log#_discussion)
          but it doesn't seem to be mentioned in git-diff.
          >
     @@ Documentation/diff-options.txt: explained for the configuration variable `core.q
       
       --name-only::
      -	Show only names of changed files.
     -+	Show only names of changed files. The file names are usually encoded in UTF-8.
     ++	Show only names of changed files. The file names are often encoded in UTF-8.
      +	For more information see the discussion about encoding in the linkgit:git-log[1]
      +	manual page.
       
       --name-status::
       	Show only names and status of changed files. See the description
       	of the `--diff-filter` option on what the status letters mean.
     -+	Just like `--name-only` the file names are usually encoded in UTF-8.
     ++	Just like `--name-only` the file names are often encoded in UTF-8.
       
       --submodule[=<format>]::
       	Specify how differences in submodules are shown.  When specifying


 Documentation/diff-options.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aa2b5c11f20b..69de49f977b6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -293,11 +293,14 @@ explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
 --name-only::
-	Show only names of changed files.
+	Show only names of changed files. The file names are often encoded in UTF-8.
+	For more information see the discussion about encoding in the linkgit:git-log[1]
+	manual page.
 
 --name-status::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
+	Just like `--name-only` the file names are often encoded in UTF-8.
 
 --submodule[=<format>]::
 	Specify how differences in submodules are shown.  When specifying

base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
-- 
gitgitgadget
