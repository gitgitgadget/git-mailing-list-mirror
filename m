Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1CC433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 01:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKLBog (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 20:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKLBoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 20:44:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B1145A04
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 17:44:33 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g12so8449477wrs.10
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 17:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pji+j8taOlZlLFJXnBj7jaVfMOFM8Kg+zIbYjLbwQ7I=;
        b=A+VxEAgaVAu1mhfnEV4aSXqfWDHBP4d2Q2P1EnYy5jTx5g9OIJ43pjZn//4iPEzP6t
         qqMAFXAWyzbTgHs7knNmChmucDGCT8OS2SRV7atoXGkebSnRgF80DCLV7SXbPDoq6+Mv
         7jIRKAKF02/5p3qx5IhYTs+B4xycRdzHB3sRq5sUl1madAP6DIxn8beeOoVMQuqpnvFU
         /QBHkfDPFmLlXaMPpO3U55trH5+yyUfDUQUQ7SEm+jTMhut211Uw+Ip2BZtKyZ8fpFOd
         55WkUvThYXU1k/4DeBxn/MuGDiUeCCLWkDVElnAokC+PnK8vI1D7z/nQ6irIWagx/Ns/
         pnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pji+j8taOlZlLFJXnBj7jaVfMOFM8Kg+zIbYjLbwQ7I=;
        b=XB9n5XJYF4lhZkSbaGqQHIR06xrkmjQMWeGxBcdLBPY09OXArgKFCdk2jRYtbjoe7f
         Msgio3kaBaapAGPEmxdw2ZLbixTfqF7MhysJGWFA03gewoFZG+iOKH5uaBg/w51tpacY
         orOKAPctvl+M5rSrepZ8q7L7SuBOAljWRz70YnnOKRREkDfpw81XFA81R/sqCnk5pmcG
         4wNGRbOqfye6O/zutyrxalv+PM0BGEVPeO3n8Eoz3hQmPg4ZZauGLzKB+4haBS9vPTbv
         VWLLSh+5JuWmrRsiVT7eLl+IqWSKThwnHeS5PFAIx94gUyzpl6uC6P4ozACr3iubY4MF
         HN9Q==
X-Gm-Message-State: ANoB5pnp7DV3DmLdvPJ9oo1Vq7lV+tHYJUhY0yS8tQMlUnfBJWVPfosh
        lRG2e+f96i2c9ecdq8nP/h1pCUlub6I=
X-Google-Smtp-Source: AA0mqf7vElZOpeTKdMqFTclSG7+zZeYSIjeprkHpaseZ9uW6qGTecc/uXgIIF0E+sBcUZzTS3tBxMQ==
X-Received: by 2002:adf:fac7:0:b0:236:7988:b282 with SMTP id a7-20020adffac7000000b002367988b282mr2584238wrs.341.1668217471758;
        Fri, 11 Nov 2022 17:44:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020adfee49000000b00228cd9f6349sm3099285wro.106.2022.11.11.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 17:44:31 -0800 (PST)
Message-Id: <pull.1379.git.git.1668217470500.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Nov 2022 01:44:30 +0000
Subject: [PATCH] Docs: describe how a credential-generating helper works
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Previously the docs only described storage helpers.

A concrete example: Git Credential Manager can generate credentials
for GitHub and GitLab via OAuth.
https://github.com/GitCredentialManager/git-credential-manager

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Docs: describe how a credential-generating helper works
    
    Previously the docs only described storage helpers.
    
    A concrete example: Git Credential Manager can generate credentials for
    GitHub and GitLab via OAuth.
    https://github.com/GitCredentialManager/git-credential-manager
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1379%2Fhickford%2Fcredential-generator-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1379/hickford/credential-generator-v1
Pull-Request: https://github.com/git/git/pull/1379

 Documentation/gitcredentials.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 80517b4eb2c..72888402e73 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -61,7 +61,9 @@ for a password. It is generally configured by adding this to your config:
 
 Credential helpers, on the other hand, are external programs from which Git can
 request both usernames and passwords; they typically interface with secure
-storage provided by the OS or other programs.
+storage provided by the OS or other programs. Alternatively, a
+credential-generating helper might generate credentials for certain servers via
+some API.
 
 To use a helper, you must first select one to use. Git currently
 includes the following helpers:
@@ -286,8 +288,8 @@ For a `store` or `erase` operation, the helper's output is ignored.
 If a helper fails to perform the requested operation or needs to notify
 the user of a potential issue, it may write to stderr.
 
-If it does not support the requested operation (e.g., a read-only store),
-it should silently ignore the request.
+If it does not support the requested operation (e.g., a read-only store
+or generator), it should silently ignore the request.
 
 If a helper receives any other operation, it should silently ignore the
 request. This leaves room for future operations to be added (older

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
