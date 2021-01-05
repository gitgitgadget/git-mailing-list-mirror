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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F7BC433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AB622D72
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbhAEToO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbhAEToL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6709DC061796
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g185so623333wmf.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V1YEaCkjPz0KNEeXzNPgbWhGO2r4fyI1mxyNllWJhA8=;
        b=aPxFgKc4fjiEoPXV5csHpGeTgivawbc2yomYmAS0kWpuvzlQnSfKhnOswBesLB0cHK
         LkgVrdFCrGB4EZsRBIddrYLP4svY1iafo31PGS3MlV4b0C/qPZe4HwYb+mslmK/ismRN
         4xlfpmPtHC+2hcYciojSmlyDDIj98o6PbDBLy0eInmBuGXWNJmnwWQ/PiLmtUPofMRJI
         DqkAnMtiQH1OfmOlUteFlVkc1sitYk05AQutQw2e5X2gZMAFt7LXar8/FhgVzKH8tIe4
         ua0xwKUO12bsLufK8v1U8EFNfH71ffXYFFY4saiQwwW4Hb5VRv7uFT5nMM6wQmO3KvVg
         6BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V1YEaCkjPz0KNEeXzNPgbWhGO2r4fyI1mxyNllWJhA8=;
        b=dnrwMSRN99MdY5f6q4gWdddv55yT8P+Rl7106TWdnuYdzfsZ8NjahCd+oZWVQ4+tpl
         igiaEt4AFiv2ltPR0a8i17/kL+jwubQNfoSNvdDU/wZ9RfiB808yOD+g6o3UvTVJ5o/R
         GUP6JGfirOvv0M+3JSD9/VfTfcw8yvnmvLZyEwf/ocza0Ag9M+I13l+mvvL0LDUBYpTR
         3j4089Eg9o/GqCwwRuc1YFeTt2PwCCz2GIqr3oPw/j6EFRx1c0AK/RkSkhAcXdTjM3B5
         ufh2Be4xorAfDxyohzDs0gw8n25nOpshqF1ftgFvb7lH3pEuwVk8xCzmZO6pNKfFlWpr
         /FqQ==
X-Gm-Message-State: AOAM53138uLyk01xwbHNGA6XyefksGYrhEm6iRA4Sv9/MyysMRYjS4EW
        JlEKL8xcvesj0+exBqO6c86qDE80Uq8KUw==
X-Google-Smtp-Source: ABdhPJytFWrp2ac0KlICs50k30yYbKY6VhOXP5wSGb+AI0PfY4FrxX+9lH9E5VVaroWnGw1WCzGZNg==
X-Received: by 2002:a7b:c773:: with SMTP id x19mr581563wmk.127.1609875809957;
        Tue, 05 Jan 2021 11:43:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/23] mktag doc: update to explain why to use this
Date:   Tue,  5 Jan 2021 20:42:32 +0100
Message-Id: <20210105194252.627-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
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
 Documentation/git-mktag.txt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 1b0667e372a..20af1915e9e 100644
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
-- 
2.29.2.222.g5d2a92d10f8

