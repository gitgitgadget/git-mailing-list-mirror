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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44335C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5760232
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFXTm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhFXTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:42:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E63C061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so7939310wrv.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dw25b5B9jjtJqmsCvd0LpMJ1lo7EMy8Nlohi8a73jk=;
        b=fKjfQQ9ljMzguouNx3oaTUyulkP68GXwkm+6soJ/votBA9Byojx/bSN1qQ5ILjbXOZ
         msDLP8uZkyw9k4epSv0KknIKVmGNV+R07bc5fXzNzEvpOuChQYA7Ha0siEC1ffIhhD7D
         3aOYj3z80qs01Qx4S3z1cl04z4SyNN+fvDgagqKhAY1wWakgX0cLfVwbtnfOEQ5ffVsg
         aNIlwSOxcHl8Ay24BIJCTmSHZlUc5P6Ul29NDly42rUYvRKya2kDnmIhDmbySJQ8Wt3B
         895Vp6v5XV6Np5ZT/QECZfHzw35rP0BjpBe0phN0FFbyVi4Ayz7WW3MXLdudEu3W8d9D
         agDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dw25b5B9jjtJqmsCvd0LpMJ1lo7EMy8Nlohi8a73jk=;
        b=F4frreqoNzm53thaxc+M9QgpUT30e2Vc+a0Gc9v5rUBM9jDrPMLiShU/sOpxhE7Itq
         sC/h2VqLcW7RhejIMm8kLxRIomghyS/l8lSed+eGy9UVXTyDGvlXSqiPcpEjEBN1LP0J
         Itg/g3pLgKvSGFJHoSAqRQL3V+XL2xm6gFGDpNtC5CGOuTyAEQpj8/X+w4smbHMV4BXG
         e24eQFUXt/wyCHd/Gsv0et6r4BJLEN3TUUwcILSslzcngaIPzwziuPH2fzoLwNJX6/yp
         0aUn2qSdEUlSJp7dUSGJQ2xjT8v7REZelPHrhziOwbsuGysCKFXPyI0+G1IYzBUgT562
         wjpQ==
X-Gm-Message-State: AOAM530j5tYYwblnwVhsRnLO4b75TancVvoRcFQ60Qgak5xMPRZL4unb
        GInvveiwkCA8hwcLI3+fG+EqOO9FLQQIHw==
X-Google-Smtp-Source: ABdhPJwOPwZZrmo64ZFFIF19lfCblAV/R3PL4qRfN/g9qcju0QgvYfkg6g7UlG+Nc1UacAL9IX139Q==
X-Received: by 2002:adf:f68a:: with SMTP id v10mr6442672wrp.366.1624563631126;
        Thu, 24 Jun 2021 12:40:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm9286057wmi.31.2021.06.24.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:40:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] bundle doc: rewrite the "DESCRIPTION" section
Date:   Thu, 24 Jun 2021 21:40:26 +0200
Message-Id: <patch-1.3-2824133f423-20210624T193730Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.610.gd639e370050
In-Reply-To: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
References: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com> <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
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
"SPECIFYING REFERENCES", so I'm removing that part and letting the
brief mention of "thin" suffice.

To the extent that we should say more on the topic that documentation
will be improved by subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 43 +++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b6..1b02f8b7468 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -18,21 +18,34 @@ SYNOPSIS
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
+Other git commands that understand protocols such as `ssh://` and
+`https://` can also operate on bundle files. It is possible
+linkgit:git-clone[1] a new repository from a bundle, to use
+linkgit:git-fetch[1] to fetch from one, and to list the references
+contained within it with linkgit:git-ls-remote[1].
+
+See the "EXAMPLES" section below for examples of how to use bundles.
+
+BUNDLE FORMAT
+-------------
+
+Bundles are `.pack` files (see linkgit:git-pack-objects[1]) with a
+header indicating what references are contained within the bundle. The
+header is (mostly) in the format emitted by linkgit:git-show-ref[1].
+
+Like the the packed archive format itself bundles can either be
+self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
+
+See link:technical/bundle-format.html[the `bundle-format`
+documentation] for more details.
 
 OPTIONS
 -------
-- 
2.32.0.610.gd639e370050

