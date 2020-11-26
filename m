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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CC8C71155
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B222168B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJFmRYSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgKZB3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbgKZB3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDEC061A52
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 1so555044wme.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OBgRT2gDI16UFkLXk4ZLPAx9PhNcbUhQlyw98Y5NIA=;
        b=VJFmRYStEc9b7eS0J0CKdq6AYEuMs0WGnkJxFu8ZAKEUQZ2X4W0pN6mmMd9E9OFCo7
         7Q9AFYcqAbQkSpJn65T6Mxave4546+oyJQdlmRfznG+6OmrSEaFHOivtqk6fkwtxVpyg
         fc8/iFBdUKx4MWfnAk0rMcTq6yO6lKlKXmOJlmZe1bIaUj+0O+IzwpM8mILQ6KuGvJpE
         wwUEcDmLGOO0x9fwWt8UNIMljWXI64Zg/LX0Fx/0n0EcnCAycg7qbEBX10ZtvJihk/8x
         ptD2tokCbjaqPwf3Pg75ha/ofHSw4mWoZbZ2E92lApcPG2jcLt+MUJ/lw3br6bdOuevQ
         3Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OBgRT2gDI16UFkLXk4ZLPAx9PhNcbUhQlyw98Y5NIA=;
        b=j2Csr1uMfZoKOpszfXM4+xF4fAifb8+OfiMRdYa230Cs66WF0WYb5pKGRSwhdpy5wl
         8FPceVHcO1A1ZhzihTFmm4KuNB9JpIpz4MqRxeXZcnfYGZUicsXlMafl3ZRpFroGVs7N
         PxkrFshtM+2uG7zGIbC/7PUiLvlbh3ZCs7SrQYJwYbb816FCsTikCnnkmgmLWrNZIrqR
         AnaAZAT/hgGKST6xBeMFA5gumcb9jx/UPoh9LOqY5dorG75THeY//tOpLwhiyuPa2lqm
         vWHjJTx6vfrbuRFDvxkDtpaVjH+RZ7c28KsqzArLOSx+RSqJNTbqha3H1WLrJGGHXmOp
         luyg==
X-Gm-Message-State: AOAM532kUTVuB0DGXi6wzSxJQPvej6crX28+amFMDbc3PQaH9XncUKgm
        FzLjFUapEUj099YHcLTW+qCl7qAQz1J2jw==
X-Google-Smtp-Source: ABdhPJyowF6FhqeFy1O3pAQsytfcYgb2zgQsSJchb/MriWAZymYVn58TikYC/hj/wz0xG0Npxv/XoA==
X-Received: by 2002:a05:600c:58e:: with SMTP id o14mr463429wmd.47.1606354151028;
        Wed, 25 Nov 2020 17:29:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 10/12] mktag doc: update to explain why to use this
Date:   Thu, 26 Nov 2020 02:28:52 +0100
Message-Id: <20201126012854.399-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
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
index fa6a756123..11ce8e4bb4 100644
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

