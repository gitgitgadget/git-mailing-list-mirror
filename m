Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55AC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1954C2256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLWBi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLWBi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:38:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2390C0617A6
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t16so16989657wra.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAug6kmmdOMweMyapaJZKRTxgmVCfR9BD1/XejsxQYQ=;
        b=JFSwfxliMEUjpwuyKl0MWzoNILlwCtDAICdz8dGrd31urLOCo9bj5gyGledoyb0t5Z
         biE5TlhdhWJ6E+kdzVvD5u9mvV3F3aNCWwJ65bdAzhQJZek0uqaVyAkv4CWuDG3psQhW
         1iVYhSMhh++cjHEEiFoSCaTaAdVVTHmo6XP8Rnv1RgeS+ZJnoKS7x0u6UHsoPX7cz/qN
         +5m9z9x+qQDpMIZ4fr3C90QSf+ID5uYLJKFT1jE9SaFg5xN2QKKRcf5/wVt/KeGzSwuL
         bhsRhj7f0/YSMXiEyWWSiRp7F0rxhIvmAtFKRVlamRBczZZKEAGMmsk4klrLAxZ6VUBP
         xI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAug6kmmdOMweMyapaJZKRTxgmVCfR9BD1/XejsxQYQ=;
        b=eF7lHQsE2Xcn3BFbPnvKuEwfc8f/ugq1mVsZsq63cSker2e1njyyj0WLQqsR+TEg6I
         2RjkDuOw+5IesfNaniGP6Nd0L/tLCUOnQSOGBcZDFUNVh3OokHbdooMyhgpfWoy5zgdx
         4olWKCognxOk0+eNtflLNuD+dJN2lljD1WXRb6SFyibee0Mj5zNxkq7oQvlTmEPUvRC3
         81enHo9BuSH9AugcMqGHCoMR4g9e8tRVvBN7JB+OPFgq4EiJPTB9b9J4+g+9EypvQPKu
         9x8yld7a0YtuAbL1szGTkHxF+MmMLfRMNOTfDWQnrIBO20LFi+qvDOs86wSfbVXZSrer
         XyeA==
X-Gm-Message-State: AOAM533Yk1lPosq6tmQM5q6gQEPIW6VjFjqUPh+++1lE0TYjjVEmf4nk
        iQuyKAMc2XOA6eThSS3DDCMhfxh4dcw/1g==
X-Google-Smtp-Source: ABdhPJyIk68znv+Rk4/ASqYMwd7SQrz4awc6qZUOLdxoFsb024/Wv0HcSj25/7NpIoNTNU16F2fPgA==
X-Received: by 2002:a5d:4d45:: with SMTP id a5mr27387401wru.380.1608687465378;
        Tue, 22 Dec 2020 17:37:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/20] mktag doc: update to explain why to use this
Date:   Wed, 23 Dec 2020 02:35:48 +0100
Message-Id: <20201223013606.7972-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mktag documentation to compare itself to the similar
"hash-object -t tag" command. Before this someone reading the
documentation wouldn't have much of an idea what the difference
was.

Let's allude to our own validation logic, and cross-link the "mktag"
and "hash-object" documentation to aid discover-ability. A follow-up
change to migrate "mktag" to use "fsck" validation will make the part
about validation logic clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt |  4 ++++
 Documentation/git-mktag.txt       | 21 +++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bd..c535661ced 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -58,6 +58,10 @@ OPTIONS
 	stress-testing Git itself or reproducing characteristics of corrupt or
 	bogus objects encountered in the wild.
 
+SEE ALSO
+--------
+linkgit:git-mktag[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 1b0667e372..adc63f6d4e 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -3,7 +3,7 @@ git-mktag(1)
 
 NAME
 ----
-git-mktag - Creates a tag object
+git-mktag - Creates a tag object with extra validation
 
 
 SYNOPSIS
@@ -13,10 +13,19 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads a tag contents on standard input and creates a tag object
-that can also be used to sign other objects.
 
-The output is the new tag's <object> identifier.
+Reads a tag contents on standard input and creates a tag object. The
+output is the new tag's <object> identifier.
+
+This command is mostly equivalent to linkgit:git-hash-object[1]
+invoked with `-t tag -w --stdin`. I.e. both of these will create and
+write a tag found in `my-tag`:
+
+    git mktag <my-tag
+    git hash-object -t tag -w --stdin <my-tag
+
+The difference is that mktag will die before writing the tag if the
+tag doesn't pass a sanity check.
 
 Tag Format
 ----------
@@ -34,6 +43,10 @@ exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
 
+SEE ALSO
+--------
+linkgit:git-hash-object[1],
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.29.2.222.g5d2a92d10f8

