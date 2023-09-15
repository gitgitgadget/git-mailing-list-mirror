Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF71CD37A9
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjIOU0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbjIOU0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 16:26:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A4AC
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 13:26:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-792975085b2so84409339f.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694809571; x=1695414371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n9WDCByPxr3hWmjEQvk6F3JYpCKZNV7w+m69NFweiA=;
        b=dPLPQUd6o5CubJ2hcwzijRhGvfr8riUDgqCewPOywywiZrgvnT3x58Q4EgqbBXJZXb
         ZLg7L0J1QLgwunnBWQKJtkHROEekdJOBrm9vWXTQK9PFmHMZUA3pbf0sb8sdV3SohCuS
         ZnK4m3OM+RZP6QAszI1bAn9zPWqXysX1HtCpLDBUBYCZ7M/9fIleMlXl6T+Z55nscyvd
         FgiejFHzvUDYZuJjiFFH4AENIwtc6wjIAMElfEw8lQa0/Y7Em8pu5cKRzwipMHv5zIuL
         85g+kTbq21sTMyHhAM6CBdArnt1vp0d3+PXWob4nOVP0H0zvB6PpZY39MIlk4fJvt0kw
         qZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694809571; x=1695414371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6n9WDCByPxr3hWmjEQvk6F3JYpCKZNV7w+m69NFweiA=;
        b=N6P8d/kr5doeM3SHIZg54v7LNMN2Tls0EPDF2PAXSbjYcBcra8yjmakckGB8F2O6Dt
         ylv6jyEI1Ol90ugwbw2UB8fYkZv+JLI71Rjj5xgdrrOU/TleLS7j4mu9Ye5YRjbGLaLk
         65TM74hgGrOCpf+MI6YprfZzo+vHP14IyLYdBb3HZd42ddyBVribd8hOAH/P/ev31dI8
         95RnlzdxuK1oZN74yxdAJRZq28N1BaVwkgoQv2f+n1qIGkhezllanbGSZg9U8MJK7YqR
         NtYV0xDPuSG3Inqg6KpCE/GPWC/XhfPRi42uwyOMl6plt74lEF0YNx4NBez2Q9s6c+sa
         Cy2g==
X-Gm-Message-State: AOJu0Yz+FvKahcN3J16KYjQAb+IoXdV4YnhkknXHkwdX1ePb7D1ndPMY
        jqpj3/FPqDLJned27KR/kwpWllsVidk=
X-Google-Smtp-Source: AGHT+IEv/6Fe81O9C7dtRsuD1rhXOWZVKN1/F+Va+bg2aJkT7cUnNCJ95KSFI6DNUTUx1ztDr5s9Lg==
X-Received: by 2002:a05:6e02:128c:b0:34c:dbeb:a2a2 with SMTP id y12-20020a056e02128c00b0034cdbeba2a2mr3350615ilq.21.1694809571183;
        Fri, 15 Sep 2023 13:26:11 -0700 (PDT)
Received: from uranus2.cardinalpeak.com (laf-cen-179.cardinalpeak.com. [208.46.74.179])
        by smtp.gmail.com with ESMTPSA id b9-20020a056e020c8900b0034e1092bccfsm1350143ile.80.2023.09.15.13.26.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:26:10 -0700 (PDT)
From:   Evan Gates <evan.gates@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-config: fix misworded --type=path explanation
Date:   Fri, 15 Sep 2023 14:24:59 -0600
Message-ID: <20230915202610.21206-1-evan.gates@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `--type=<type>` was added as a prefered alias for `--<type>`
the explanation for the path type was reworded.  Whereas the previous
explanation said "expand a leading `~`" this was changed to "adding a
leading `~`".  Change "adding" to "expanding" to correctly explain the
canonicalization.

Fixes: fb0dc3bac1 (builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`)
Signed-off-by: Evan Gates <evan.gates@gmail.com>
---

Turns out --type=path is exactly what I had been looking for, but
it took some experimentation as I found the documentation confusing.
In hindsight it's obvious, but I hope this simple fix helps someone else
figure it out faster in the future.

 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7a2bcb2f6c..b1caac887a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -201,7 +201,7 @@ Valid `<type>`'s include:
   1073741824 upon input.
 - 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
   above.
-- 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
+- 'path': canonicalize by expanding a leading `~` to the value of `$HOME` and
   `~user` to the home directory for the specified user. This specifier has no
   effect when setting the value (but you can use `git config section.variable
   ~/` from the command line to let your shell do the expansion.)
-- 
2.42.0

