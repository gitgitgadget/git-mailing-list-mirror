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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F7C43460
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E616143E
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhEMSTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhEMSTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC5C061756
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h4so39830774lfv.0
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xeerkNJmwffn34M2unVC4v8JjYe68qL1iP9GQYhGHqg=;
        b=WZ4fCxHrVyFwkl7z3/xGb8mkd3RqZwwvtI/Zk1w8E549QaCRDjfFqrPr7phXy7G/lx
         W6a886mWwncmiApQaXfB1e3b1Zl6D8Flzi+GGrj9bIanDbfa2rQPko26liOdjt1Xd6I9
         SyKKyV2ClIK+UGkYOoJPvy3rkwKjYFT9UG7EgqGB16Yp6Db5ON8s/1tnKECEBFchCYKk
         tpbSotl2gMl7k22vLJlW8nTc+wG2FPSWftcUVBKAF6/xxalxZMnp05Po3AINSur+kX7c
         RJeAZkn8UmTSZvM3YuTokmIcxJTE5YmXBVVNypqgBPqKkYtR5PDCZZdWhfHeGHsBJFg6
         +IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeerkNJmwffn34M2unVC4v8JjYe68qL1iP9GQYhGHqg=;
        b=KDETuZ8Ya1PA5B+0w1wKOfKPjpORyblr/816Zc4hs1EHwIJwz2MvYdeMpryFEjMYn3
         Eap1e+bSdyuN0/STDqB1AwhgL9TFbEc1j5zPaWF76zZPh+FeklcryjK0Jq7RTVPEnCnU
         lyv5zUjnwWUtpNdzDJ9zMXiAs8OT/UJ+IP/rlWZIJLW66uzo5bkN/jZ1NkwSYHHjg+DQ
         KLzN5VoDWJGMcOfqQ0liEjfHafJ0CXkFMY1wC7OlKV+cguBG8jWjkmkoAmxDeICX6vx4
         RIAp9b8QuOv08lPf8UaOXFvBIepteWP8KS+JulMj9wgXCphaz/xfVxmp/+brNQVxgvQf
         AH7g==
X-Gm-Message-State: AOAM533Skm6/5tyTiSv4CXbklh1C2yQv3ZLHc8iDAY1fc25VGBxvpRRI
        SGBad9/y/wX9D3DKWx9jVVfSO+kDFwU=
X-Google-Smtp-Source: ABdhPJwo/3gOM0nFQgJsVPWjNFDgg7hItqV1SydmYSqCkeSivUKoUsqxDjXduj6qQgOEjoIU7CCelA==
X-Received: by 2002:a05:6512:11f0:: with SMTP id p16mr15176764lfs.520.1620929890304;
        Thu, 13 May 2021 11:18:10 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.18.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:09 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
Date:   Thu, 13 May 2021 20:17:42 +0200
Message-Id: <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor renders 'git cat-file' with the single quotes. It's somehow
tricked by the single quote in "srcref\'s" earler in the paragraph. If
we drop the backslash, we'll regress with AsciiDoc. Let's just rewrite
things a bit to avoid "srcref's" entirely.

Add backticks for monospacing around these refs and command invocations
while at it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-check-ref-format.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ee6a4144fb..71d53ffb60 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -70,10 +70,10 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . A tilde `~` and caret `^` are used to introduce the postfix
   'nth parent' and 'peel onion' operation.
 
-. A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
-  value and store it in dstref" in fetch and push operations.
+. A colon `:` is used as in `srcref:dstref` to mean "use the value
+  of `srcref` and store it in `dstref`" in fetch and push operations.
   It may also be used to select a specific object such as with
-  'git cat-file': "git cat-file blob v1.3.3:refs.c".
+  'git cat-file': `git cat-file blob v1.3.3:refs.c`.
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
-- 
2.31.1.751.gd2f1c929bd

