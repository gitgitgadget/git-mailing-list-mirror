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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91DC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7740A60F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhGZXoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhGZXoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:44:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057DC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r2so13122319wrl.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrIRMMYvK316XeOix5nCKunawZSOcfNahbVQJILldVY=;
        b=DkmVQzaX+iL7/DWf/9kpqLorbpJdFFhCGCbwvb4t6bY5zzTypF7FK5tIB9njqorbQL
         lhgke3XTdr/eKWILA/yDwqnVMM6mT7rX8MvqTqBSb/p9W9znDunskEra/YB90f+73eNX
         hcdeinsGhf3lXQN8diuVLq/jBQgCulAZSSkrnNnKI7BUwtRa+5+OpYoSZHkswetJf1L3
         l3FGmK84lhm+N6rSCTohY8ktAkXEDxkYr8RXfSeK/EyqFoV1RiftdxA5c2OHNc0nmSw/
         o6pkkpVwYBB1yLotRmgYk8Y8gj7WqJF/MW/OpKvwzBZEcnVw/GFrQKqy4IXk1ARkIB+A
         UlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrIRMMYvK316XeOix5nCKunawZSOcfNahbVQJILldVY=;
        b=n4fI/DNFsDaGdRUKsa+XZBEVKCp0o3yS6fiUF2cDU2BwCgjpIxze2/tcV1Msz1GV+h
         w5tGJrKtVUFYUJylpQ3KujDe51eaV/mJ/zbPw3iwUY3H/Z3XpAM4DSR4RUJPMEY1vT2Y
         01hygoKek1GDfn68j4gXt/8dO6chgoQ+fXsmCjIqkQrQaVdFJ+13Utxi+oMRVnAzFQ8B
         KMiaBmWK/USmzHp3U3PV62eK0V2L3KfFztWTnidCZ3g9hfptau1gM/Li3ObI1jxwvs+7
         xHke6EUkT/4X/MBqOTsJ25ooxUb/vq5bvnCpfDyh/4KbiiFGRG+4S1XCT0bgqJgDm74p
         9H9Q==
X-Gm-Message-State: AOAM5323awVz3v/T7jGywHPDkg2wGwnirik8eZVf09z9AfE0yOeBGD7M
        fFLLov6sL8zWEFyJAilnGD1VwbZruwTIUg==
X-Google-Smtp-Source: ABdhPJznFGboRqkSieAGB+kD/gTwXpmXA1KdHCJo3DYSU70qwspKuzBuK8gK3ik6RnLTNy5F/kqkdA==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr21048111wrq.278.1627345467211;
        Mon, 26 Jul 2021 17:24:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm1115872wmq.0.2021.07.26.17.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:24:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 1/3] bundle doc: rewrite the "DESCRIPTION" section
Date:   Tue, 27 Jul 2021 02:24:19 +0200
Message-Id: <patch-1.3-b8f8a20e78-20210727T002001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com> <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
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
index 53804cad4b..339c5b4727 100644
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
2.32.0.988.g1a6a4b2c5f

