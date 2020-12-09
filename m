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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C4C1B0D8
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437AB23A02
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgLIUDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgLIUDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:03:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED8C061282
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:02:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m5so3085339wrx.9
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVk5sEKV5o4yCpPZ9+sZdlq59QLbdXgEld6bx+c/E7Q=;
        b=m26ZApixRGBhsoS1dQM1YPHc37EujofFsKF4YWEBwdm4aG3wZfJnWxX6W8GxeUBEG5
         T86/YaOkRnSbgXGtSqqE6EL7KqyUAcCOkl8aJ0iZu0IftixBxwPCOj5IQPRUIYyg7fHw
         Ww8nr4VZVpL8iR/TM9qCqp6kmDDtwTcLZxWQUq4xj2QS/NAtscVIFYYzX951zWPKcova
         4bBEOgCs0MN4h//MV1qYCL+qjIlcbvbZ/S5AGYrwSTsNPTRnNbkorOOD/Csaz5YdRgwJ
         aZFCotQGM/cqCPKUg3rTBNoz3H6riQW/rt9eyBuxhQPEXk2PA2I4ibggbGiP41vlDFt9
         3L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVk5sEKV5o4yCpPZ9+sZdlq59QLbdXgEld6bx+c/E7Q=;
        b=kOaCYM7QXPrS7x0lDYsGFEqbStF3+Y50Y9E6T7IyrHT3ivZiC0C9Wh2gbf053ohzm/
         6niR25Co+UH1+8/fKR497HuH3ICCQ4Q9fvrUhTJo/g7kfALn9gKOtQWWikZc8tDhbs6T
         re5ljDXAnnQh/tXt6k5aOBXiIJC/kJr9hVrs3jLO/0Hpf2uy5wduIw+RzKW2mcBAzkEo
         T1VA5g/IxQHRpPXgRoWVr03c/oD9h8kTT6MJ+zaBs4zFJ5Q+m00MXrXG3SVbJIiBJXch
         T8MNY49R/UaiERVtannzrlwFIYoZFZTEmCONA3XfYM/8U6P+eBj6iGz0gFFqEv6enAeT
         UizA==
X-Gm-Message-State: AOAM531hLFEkR7fuUxf3qEce2tZhkrvABANYZOBAEHGStetVMEoZImKM
        a/CrlcWzMKlUbzEGI2C1hfVWfr3O7l2bTg==
X-Google-Smtp-Source: ABdhPJxxYH0M7AtrgmEPsGZdemELetErEMVfXNU/wQyC2SykTfRzqr9PeoAuXhp9hxPJCNeR55s5OQ==
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr4419671wrp.147.1607544127475;
        Wed, 09 Dec 2020 12:02:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:02:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/10] mktag doc: update to explain why to use this
Date:   Wed,  9 Dec 2020 21:01:38 +0100
Message-Id: <20201209200140.29425-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
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
 Documentation/git-mktag.txt       | 27 +++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bdb..c535661ced8 100644
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
index a158428eb9f..b164ab563bd 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -3,7 +3,7 @@ git-mktag(1)
 
 NAME
 ----
-git-mktag - Creates a tag object
+git-mktag - Creates a tag object with extra validation
 
 
 SYNOPSIS
@@ -13,10 +13,25 @@ SYNOPSIS
 
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
+tag doesn't pass a linkgit:git-fsck[1] check.
+
+The "fsck" check done mktag is is stricter than what
+linkgit:git-fsck[1] would run by default in that all `fsck.<msg-id>`
+messages are promoted from warnings to errors (so e.g. a missing
+"tagger" line is an error). Extra headers in the object are also an
+error under mktag, but ignored by linkgit:git-fsck[1].
 
 Tag Format
 ----------
@@ -34,6 +49,10 @@ exists, is separated by a blank line from the header.  The
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

