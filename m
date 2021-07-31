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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B91C432BE
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31F860F39
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhGaIXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhGaIXT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 04:23:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964FC0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b7so14392217wri.8
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+kj+2kPVc0X1GHPFENrqXCHIa08ZM6iwBGFRPciBMg=;
        b=np4eJCAhMvhzkvPv4DRMNFBGyIgQCn3lOldH0d2d7dwN+HQVmgNoaDaV5tjFcWW4hc
         eQY+i+6kzvk74FK5JkuLxPEma/0Ebcy41y2YmOTkU20JcpzKJBRCSwWM2MZmmcb3EpII
         nGyEhyWky/Eke/AIVvOnFbOxzMoPUBJlm/d0+wh+95HQWUG2GSEaAD2GdDPabnk6gh54
         bVeoFq9seY6b1dKeYI4AxxycVDj9iS8EDm6TadZ9hPBOcXfkTZsYCrxCu40vAFlxx11Z
         kjP/2VMuqA0ml2Kad2xuGLmmKko0M5S4Z58u5OaU0ukyWBmUkhO5IDoMxNfHQm7SYvm2
         KLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+kj+2kPVc0X1GHPFENrqXCHIa08ZM6iwBGFRPciBMg=;
        b=Y531oWB4kSvKNtBpinKObKLj53pVUkL6GiUjNCACOC16j53qTkr0aY/Xf/zXGcJtaS
         LNbjhynAU6pfsGYTz+9WVOjC+xxwfKNuT/JFbP5g/BY29nryvSslONWrmlO8wl3u+RE2
         lgKkp5lykCWwIW5Aa71tKfcR0APTF4WzdHr0BtKPsRQl+TLJ3NH+Yy2bi/ZbsrGu8Cg4
         i/np6CYv4i+EqOAlIeC3Agi11QXr8VpNGv4MXRgqUSeeTIBqJr7372mvZDWjSML6LjFd
         22oTgVmwhR2RVRbl6UBaetIO8rgGPEVG7gwGirq/BUy5BUsanXWniARBpPlVkP7q8fl8
         2udw==
X-Gm-Message-State: AOAM533kNNV/lnag5qRIdXUv8FGGaUdPDEHylgpm2duAqLFP9/KBq/GV
        TVCb9yA8GllrbtOk9R+uRi8vs10zaPoAIQ==
X-Google-Smtp-Source: ABdhPJwkcND11HUQ2HXvIuWuH6r91qTZV4EUiXgpQYy58JfPqgm9BmfvqM4r2FpzqgFy5CDs52EbDg==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr7177738wrs.341.1627719790984;
        Sat, 31 Jul 2021 01:23:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm4877548wrs.81.2021.07.31.01.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:23:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 1/4] bundle doc: rewrite the "DESCRIPTION" section
Date:   Sat, 31 Jul 2021 10:23:04 +0200
Message-Id: <patch-v8-1.4-b8f8a20e789-20210731T082120Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g545f0888808
In-Reply-To: <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com> <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite the "DESCRIPTION" section for "git bundle" to start by talking
about what bundles are in general terms, rather than diving directly
into one example of what they might be used for.

This changes documentation that's been substantially the same ever
since the command was added in 2e0afafebd8 (Add git-bundle: move
objects and references by archive, 2007-02-22).

I've split up the DESCRIPTION into that section and a "BUNDLE FORMAT"
section, it briefly discusses the format, but then links to the
technical/bundle-format.txt documentation.

The "the user must specify a basis" part of this is discussed below in
"SPECIFYING REFERENCES", and will be further elaborated on in a
subsequent commit. So I'm removing that part and letting the mention
of "revision exclusions" suffice.

There was a discussion about whether to say anything at all about
"thin packs" here[1]. I think it's good to mention it for the curious
reader willing to read the technical docs, but let's explicitly say
that there's no "thick pack", and that the difference shouldn't
matter.

1. http://lore.kernel.org/git/xmqqk0mbt5rj.fsf@gitster.g

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 56 ++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b6..339c5b47276 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -18,21 +18,47 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Some workflows require that one or more branches of development on one
-machine be replicated on another machine, but the two machines cannot
-be directly connected, and therefore the interactive Git protocols (git,
-ssh, http) cannot be used.
-
-The 'git bundle' command packages objects and references in an archive
-at the originating machine, which can then be imported into another
-repository using 'git fetch', 'git pull', or 'git clone',
-after moving the archive by some means (e.g., by sneakernet).
-
-As no
-direct connection between the repositories exists, the user must specify a
-basis for the bundle that is held by the destination repository: the
-bundle assumes that all objects in the basis are already in the
-destination repository.
+Create, unpack, and manipulate "bundle" files. Bundles are used for
+the "offline" transfer of Git objects without an active "server"
+sitting on the other side of the network connection.
+
+They can be used to create both incremental and full backups of a
+repository, and to relay the state of the references in one repository
+to another.
+
+Git commands that fetch or otherwise "read" via protocols such as
+`ssh://` and `https://` can also operate on bundle files. It is
+possible linkgit:git-clone[1] a new repository from a bundle, to use
+linkgit:git-fetch[1] to fetch from one, and to list the references
+contained within it with linkgit:git-ls-remote[1]. There's no
+corresponding "write" support, i.e.a 'git push' into a bundle is not
+supported.
+
+See the "EXAMPLES" section below for examples of how to use bundles.
+
+BUNDLE FORMAT
+-------------
+
+Bundles are `.pack` files (see linkgit:git-pack-objects[1]) with a
+header indicating what references are contained within the bundle.
+
+Like the the packed archive format itself bundles can either be
+self-contained, or be created using exclusions.
+
+Bundles created using revision exclusions are "thin packs" created
+using the `--thin` option to linkgit:git-pack-objects[1], and
+unbundled using the `--fix-thin` option to linkgit:git-index-pack[1].
+
+There is no option to create a "thick pack" when using revision
+exclusions, users should not be concerned about the difference. By
+using "thin packs" bundles created using exclusions are smaller in
+size. That they're "thin" under the hood is merely noted here as a
+curiosity, and as a reference to other documentation
+
+See link:technical/bundle-format.html[the `bundle-format`
+documentation] for more details and the discussion of "thin pack" in
+link:technical/pack-format.html[the pack format documentation] for
+further details.
 
 OPTIONS
 -------
-- 
2.32.0.1069.g545f0888808

