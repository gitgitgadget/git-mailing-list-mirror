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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7137C11F69
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72BE613F7
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhGBL3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhGBL3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:29:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D81C061764
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:26:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m18so12074633wrv.2
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggvapYuLHD1KBfGLJtYEaUR+mZsg0TYQpQAIl5LPCvw=;
        b=dLbqtwbe0LadmHIvvRel238+UJ4npIALs6NcpX1S4hdZduY6nffVS6iG6sHWeqUHAZ
         crWheNZcaeGaT/f+E9xjjXJvGzmkuBbfyRqTlGtlPqG5Jqp2HYCJIgpM432cFyAbV3dq
         waA57YzWDrIZbyIHRN8AgjHa4qGSbHTnOp8fRoKR09OJrRFeGOwnWPZ4uExilyQd+t06
         hvlH0Z8GkmAoNKBffQw3yYHsz/ssQfJfEigxGPjUu8xvzUe0yL55OpLkpmiGIpKMzxld
         C/4KbujBlavz8bQkTb4xRSEPgTxrnplKHHT5kFe3EzzEQ1Y5zTmuLnUnokms0xjWK+RR
         nNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggvapYuLHD1KBfGLJtYEaUR+mZsg0TYQpQAIl5LPCvw=;
        b=kuNop8hvBPqnpXbF9wOIeaQwm52+nPQPcmn8m7b5G/eYzgQJxX9n2PwQMf1JktMoMN
         IqkBeR6Zd17mGmIUtBbtN9ngW0cCP6XlHfoASD3M61MkhgrSaU+0oa9LA1J4Kg6J4sJy
         yVkW5uHW+oke0oIgvZ7tmUnMH+bKrK+xhaT0UKLN5BFF0710JpeJGrzome3tW0pA0Uyv
         HVME4wKfjFawUBnsWB2ufZRoDkQeJ7a4W7k/D50b/cI48WvCtGZQouwemb2VOZHI7Y9n
         Z326lS/Bwonl5X4TeCOKigFOq8Mu6u6+y4engpXISwefLfgs3s3j+BKn8MHo2e8YbbGj
         eLBg==
X-Gm-Message-State: AOAM531RjcaI6b0CCsZ7s2DbuNTuOxEHtkfzW7heQBZ9Q1OHA/6LW/lH
        ZGaaP1Wdhvt4WEFz7FC2qpnfgZ9qKrCS5A==
X-Google-Smtp-Source: ABdhPJx8fF+S0NY99SUevngK7uf/WUavy76YvI52k3NKu42gEBidY/FRCwMZKD81qadR9wKiDULaWA==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr5377323wrs.345.1625225218100;
        Fri, 02 Jul 2021 04:26:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m18sm2763887wmq.45.2021.07.02.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:26:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/3] bundle doc: rewrite the "DESCRIPTION" section
Date:   Fri,  2 Jul 2021 13:26:53 +0200
Message-Id: <patch-1.3-3b447500da9-20210702T112254Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com> <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
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
 Documentation/git-bundle.txt | 57 ++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b6..9c743aed49f 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -18,21 +18,48 @@ SYNOPSIS
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
2.32.0.632.g49a94b9226d

