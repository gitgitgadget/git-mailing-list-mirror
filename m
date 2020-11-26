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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EBC71156
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0E2145D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps57vlNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391814AbgKZWXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391803AbgKZWXU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A5C0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i2so3690979wrs.4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckUBzPn/JbVodRpFcdto2RyPsNA+Bz1CsFO0XUdMCzw=;
        b=Ps57vlNvnKppH7Gl5ZwjytAk5ZqKTO82xXSa/6yuSSDvN7lz/HpRG80VUGmvfmCjsk
         5A0sA5Fqv3Fya7G7PBP4F6E11rqp7ifY4C9cp4ZP9a2sem5pM+3Mr8PeiNnkqgsDxAwy
         VUeQRUADiV9GPZfr0YM1lMLo6WgT9VGvDYtPkySu8oUxmxOM/Ks8z2jOznrmHXPUMKp6
         o9ta0cOfP8UgKEKCf4uPhx4ZexUS3jkrP2qC4kerKpzOIIzQSAUiOK52PqklFXGoWSiY
         06xTnxtorHhwpfpSqF0Am+p2YJYMoOTeYO6LJqGciGfSvDpEzuUbWKVvsTgH6jUtMDrt
         yE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckUBzPn/JbVodRpFcdto2RyPsNA+Bz1CsFO0XUdMCzw=;
        b=qfps3mia8NNvVQg7Z885C7NK56IyK2x55z3eagyXAIf0VW8htd1hqPl7oNIDopARLe
         mfzYJtRvKck3fHwuvPAgpmY1c4+4ckcUkPhfYFqf2itHNxinZBa+aiyrdBFxnlYWalKb
         sWXdQ1bpVdfbYdGvhkgOr075OIz1AqmKiDjuCldR8UiXij72UG1dOS2Sbz1RS1ru1SUU
         tBT4a6hvyxDbea+iOcK87awdJ8K5VOP7cFGc5HNEcCEmaeHw87DNuzWXBbZAjbDiQ9C6
         jrqk15APoxR4GhNfwlnIDK6NoIafvRlvlRISK0sP81AWTSIOqX+s3E3G5VQWN/XGpX9l
         mLVQ==
X-Gm-Message-State: AOAM5309olEOW3+HDdf9wlxZSG4bRNmjAxp6QrVtOtJ+1f0FzuI+oVWc
        GGVmONt1ZouCc1CgOqcQR2B1+zxwXN4IkA==
X-Google-Smtp-Source: ABdhPJzHs622EbmfFvL+oeHM6qoeuEAp1KWEXWt6htLWYWZPN0LCaVIUll5KOlHua+mZIVPf/Hi+bw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr6452198wrn.208.1606429399067;
        Thu, 26 Nov 2020 14:23:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] mktag doc: update to explain why to use this
Date:   Thu, 26 Nov 2020 23:22:57 +0100
Message-Id: <20201126222257.5629-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
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

Let's make it clear that it's to do with slightly different fsck
validation logic, and cross-link the "mktag" and "hash-object"
documentation to aid discover-ability.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt |  4 ++++
 Documentation/git-mktag.txt       | 29 +++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

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
index a158428eb9..3ba15072df 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -3,7 +3,7 @@ git-mktag(1)
 
 NAME
 ----
-git-mktag - Creates a tag object
+git-mktag - Creates a tag object with extra validation
 
 
 SYNOPSIS
@@ -13,10 +13,20 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads a tag contents on standard input and creates a tag object
-that can also be used to sign other objects.
 
-The output is the new tag's <object> identifier.
+Reads a tag contents on standard input and creates a tag object. The
+output is the new tag's <object> identifier.
+
+This command accepts a subset of what linkgit:git-hash-object[1] would
+accept with `-t tag --stdin`. I.e. both of these work:
+
+    git mktag <my-tag
+    git hash-object -t tag --stdin <my-tag
+
+The difference between the two is that mktag does the equivalent of a
+linkgit:git-fsck(1) check on its input, and furthermore disallows some
+thing linkgit:git-hash-object[1] would pass, e.g. extra headers in the
+object before the message.
 
 Tag Format
 ----------
@@ -34,6 +44,17 @@ exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
 
+HISTORY
+-------
+
+In versions of Git before v2.30.0 the "mktag" command's validation
+logic was subtly different than that of linkgit:git-fsck[1]. It is now
+a strict superset of linkgit:git-fsck[1]'s validation logic.
+
+SEE ALSO
+--------
+linkgit:git-hash-object[1],
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.29.2.222.g5d2a92d10f8

