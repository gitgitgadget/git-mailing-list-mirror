Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52365C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjEPR4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjEPR4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:56:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE28688
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:56:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba81f71dfefso1566377276.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684259791; x=1686851791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTRtnKgGh6HGZKklYtS0NP2tpPf1hNdsytBKswMf5BY=;
        b=J0f+J4BT5W4o6kwdfJpIGxlJPbjN7lEA5wL5a2qCHcrb49KXSUmyZah1KhuhmHFyJB
         CdOyW7nTcxbgBpblI28/MTk4CVrI+keTRpZVUHKrieZJRfRja8djurLRImEidrtmWLRs
         wJe+0H3JbgOIH/Onm6R8XIgxKTmx3OxSesoTxEi8+Ss3Cbfa0prfOXdBIiLSSp+0Pox2
         XEd5GZhdDdO6pMze9HY0BqaIDaMYYzPln67ztzBFKYi5y0rPJv5L4n7rYI/rpS9zmJlo
         dll0XcUsDv7JHjoyGynGAzTTt3jfO2/oXa8xr/GB00425YsRtogW2EqGxgCgY7nuEpZv
         Ramw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684259791; x=1686851791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTRtnKgGh6HGZKklYtS0NP2tpPf1hNdsytBKswMf5BY=;
        b=bzoYYa7YgvpvLe384U3ISuoBFph5T4guv+vCErLijmvN9kDabrSwP9NBCtaj8rQrwH
         Zw+aZc917USm7Nyw4hrYEu8Vwo07ECAfjCB1mw4qcfNqyX2cH0hxfaDOtJIlniYwkOcB
         18tblmJYW7YB9K82aVyAgQrJAXkYNoVwy1Znkq8E9W49eV8cJWyM6CGVYvtQTmXfN2qz
         fEUMHxVA5Wt9DFymqIcndR95Cp5Iijd3yyVFdjioYGdCOt0yFLaNh3EKGh5LEd2DDwZX
         mkZwPI9zZ7XZcxkjCFMQAen27LUqs5ftXgvO83FL6ydw49fp9ZjBlSH1gIYSkq+vBu1g
         PctA==
X-Gm-Message-State: AC+VfDylV/PW5gP7nojhVk064R4IYbz7C4LFdVIw4Ei4PRcY2x/nXIje
        MIdibhuxVpfto3g0f0MNV/34GsyDcx+0fLH+OrGc5Q==
X-Google-Smtp-Source: ACHHUZ4AAoUMS/7jb8OF15J8MMUNP/46aQQBGCEX4iqB1Ayr5FY95jSQPbfDrIUtze/WuWpgjBv0dQ==
X-Received: by 2002:a25:fc0a:0:b0:b9d:e253:d25 with SMTP id v10-20020a25fc0a000000b00b9de2530d25mr35026548ybd.11.1684259791610;
        Tue, 16 May 2023 10:56:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13-20020a5b028d000000b00b9db62abff3sm16312ybl.58.2023.05.16.10.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 10:56:31 -0700 (PDT)
Date:   Tue, 16 May 2023 13:56:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`
Message-ID: <db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com>
References: <ZGO4LesPe4A2ftdm@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGO4LesPe4A2ftdm@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building git with `NO_PTHREADS=YesPlease`, we fail to build
run-command.o since we don't have a definition for ALLOC_GROW:

    $ make NO_PTHREADS=1 DEVELOPER=1 run-command.o
    GIT_VERSION = 2.41.0.rc0.1.g787eb3beae.dirty
        CC run-command.o
    run-command.c: In function ‘git_atexit’:
    run-command.c:1103:9: error: implicit declaration of function ‘ALLOC_GROW’ [-Werror=implicit-function-declaration]
     1103 |         ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1, git_atexit_hdlrs.alloc);
          |         ^~~~~~~~~~
    cc1: all warnings being treated as errors
    make: *** [Makefile:2715: run-command.o] Error 1

This bisects to 36bf195890 (alloc.h: move ALLOC_GROW() functions from
cache.h, 2023-02-24), which replaced includes of "cache.h" with
"alloc.h", which is the new home of `ALLOC_GROW()` (and
`ALLOC_GROW_BY()`).

run-command.c compiles fine when `NO_PTHREADS` is undefined, since its
use of `ALLOC_GROW()` is behind a `#ifndef NO_PTHREADS`. (Everything
else compiles fine when NO_PTHREADS is defined, so this is the only spot
that needs fixing).

We could fix this by conditionally including "alloc.h" when
`NO_PTHREADS` is defined.  But we have relatively few examples of
conditional includes throughout the tree[^1].

Instead, include "alloc.h" unconditionally in run-command.c to allow it
to successfully compile even when NO_PTHREADS is defined.

[^1]: With `git grep -E -A1 '#if(n)?def' -- **/*.c | grep '#include' -B1`.

Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 run-command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/run-command.c b/run-command.c
index d4247d5fcc..60c9419866 100644
--- a/run-command.c
+++ b/run-command.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "hook.h"
 #include "compat/nonblock.h"
+#include "alloc.h"
 
 void child_process_init(struct child_process *child)
 {
-- 
2.41.0.rc0.dirty
