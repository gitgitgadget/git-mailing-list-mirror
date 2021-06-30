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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481DAC11F69
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FA961D07
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhF3JTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhF3JTC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 05:19:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D1C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so2722569wri.4
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZH0UFIZHzSv2PrzGs6l/0bruWY+6C9eT5tMUsuTMIU=;
        b=RYqWuSN/ZFsZTA7rnzVvKH0cHEJbBo7kfYm3+VdLlqNczIEsZh6uZnFrqigeg640P/
         mjK/GiauVzMDPP2WD3HyKtMSDbTc2adi9hpfT3+KpBVKlZJ05k2EAfgU3CGmj036qMtY
         cgM4YU9Xo53Yf0hiJ68me+4oR2mrlhj/DXULToiIcGV0P/MrMG4l7mWUslTPskL4hBW/
         bfbHy4rUAnXR3aBOsWTRnSnL7NystmiStyN0ci0jxfilTUehQqmYjpn19jkTn7I7OAdq
         GisFf+Gr6oXwYYDYGwWZceqZHiCSfZhJzyA3N9PiMsG2mo6eARzddz5ZjCHy2RGBJLQJ
         9W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZH0UFIZHzSv2PrzGs6l/0bruWY+6C9eT5tMUsuTMIU=;
        b=PJBrWLHuxScq2iqqfymOdl1plOaZWCb7/NhAjeRoah3ARxb4XVcyJn2YaNsVFbmDoL
         BuP1hYNJULZoji+41koFcadxxlqeoakxEm1ZHIWmwvRD3sGR1XlOyqlkpX1H7icv/3/L
         xqnmDmkH263SWVif3BsqwmYxBllADiD7eUunQ9FbiIEwjRNHEucTYMHuILwTPpYYecZJ
         QaA+1R4iE+qN9q8TdFUhr+JeyNTmukEU6d3qjHazMhinT51iK7UXJyip4CaWdJRGZRhV
         msloVBcsgw0pZ9M5Lj1thnmbP3oop5PYiD5UF0+T2cXb4jExd70cd/DWOI8S2pryH2XJ
         9bZw==
X-Gm-Message-State: AOAM532N73BJsiW55twB1z6rc5AUeHQ51xfqvGZ+/7OWSV9bAg2ry2r3
        w0qGVl60JZl5szuxZd30o05JZbQzuaH0hA==
X-Google-Smtp-Source: ABdhPJzWGtJHIbJttMy465p/TkRFPu9utE2XOUWaHjrdB7s9alfaCoHS5lN6JoATwWm4TZNEPl7sjg==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr5269525wrn.70.1625044591497;
        Wed, 30 Jun 2021 02:16:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2sm20372711wro.16.2021.06.30.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:16:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/3] bundle doc: rewrite the "DESCRIPTION" section
Date:   Wed, 30 Jun 2021 11:16:26 +0200
Message-Id: <patch-1.3-e32e7b3322d-20210630T091548Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com> <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
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
 Documentation/git-bundle.txt | 45 ++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b6..e19c2b83c91 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -18,21 +18,36 @@ SYNOPSIS
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
2.32.0.613.g8e17abc2eb

