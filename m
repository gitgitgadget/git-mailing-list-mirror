Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C952C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1902561D07
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhF3JTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 05:19:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC8C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i94so2722532wri.4
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkZwxN3Y75g/GihOvV7P2WCawdJCnAlcFeYP1RPMiqs=;
        b=QhhCCgl6/jtwR1wOaqHVR7tAUrLCw6qPNMfF0/zMcttKfEOy6s9KLW12nwpvqapOtt
         helzcgOoRp4fUBxZxztTVb6eIIB3EfaZEpjwivyo4oysYskrVs4rKGc5EepzsaJ+LJk5
         ejM0GSagG38mH8Jeap0LnsJfytVHywXdlYG3sXkkiiuHDdLtrNPESpZxWZrOhlP+z3gz
         MM2lqFc1d7ThmJpx3pum53nVt2LJQARJ+ouL1bm3oL0EPBtL+YJKrU1YMZ59/GVnPt2r
         bWIe3QPCbPxF/zbiRWcuxGcu83J28XiQ+V0PHVrUwfmxS5UAClDEhQZpRAXfgWICp7Pn
         N/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkZwxN3Y75g/GihOvV7P2WCawdJCnAlcFeYP1RPMiqs=;
        b=qt+3N2NB3ttRgoWaPkBSRBk8if9xSn8lYgNQdWGOtMFTVQjL0oRVVVTQJJ8a7ZfUD5
         vqx0tPW+beiCeuljT+X9e/kuUiyKDFXB2rPvxe6ewyOuQFTJTz2kln07V9s1xOCIc+7x
         yF0FcKmFZQMuRo8I6uBcIxGFEl6uB5rpT7ZMHdgheuRio17GskkQlpS2Ca0gJWOrmOEC
         1KH2Emo9ZyF/KQyVkkKJGi31pqEEYd+l83Kc6C0haSPNymWq6qco1OpL5XH0LcvazXfs
         wTnfJycQ5MXjrH4jZ1ytn4zj2oSni80cX//1f9jXz0tSYMLpq5RB4C3xAQ2UZ+MqE4wA
         Y2pg==
X-Gm-Message-State: AOAM53099Ur0Qe1G9qTuQqQGWzPOduCuwsvEmBVutT371erSAt4Zy3Tg
        l0vTeHkXEWp+CKJ6nPsGRJL0aenSmiS/bQ==
X-Google-Smtp-Source: ABdhPJySookfxzRcoAYKWbuQcOiIbqOimTpikzWDIcJsoBe2h6wfdsp4Oh8mOlNjIUFpoOMdsr2/cg==
X-Received: by 2002:adf:fc82:: with SMTP id g2mr37695196wrr.323.1625044590658;
        Wed, 30 Jun 2021 02:16:30 -0700 (PDT)
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
Subject: [PATCH v4 0/3] bundle doc: generalize & elaborate
Date:   Wed, 30 Jun 2021 11:16:25 +0200
Message-Id: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v3:
http://lore.kernel.org/git/cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com

Junio had comments to the effect that we should mention that we can't
push into bundles, and that I was confusing "thin" v.s. "open"
packs. Both ahve been cleared up in this version. I added a new "THIN
BUNDLES" section after the "OPEN AND CLOSED BUNDLES" section.

Ævar Arnfjörð Bjarmason (3):
  bundle doc: rewrite the "DESCRIPTION" section
  bundle doc: split out open v.s. closed discussion from <rev-arg>
  bundle doc: elaborate on rev<->ref restriction

 Documentation/git-bundle.txt | 130 +++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 27 deletions(-)

Range-diff against v3:
1:  2824133f423 ! 1:  e32e7b3322d bundle doc: rewrite the "DESCRIPTION" section
    @@ Documentation/git-bundle.txt: SYNOPSIS
     +repository, and to relay the state of the references in one repository
     +to another.
     +
    -+Other git commands that understand protocols such as `ssh://` and
    -+`https://` can also operate on bundle files. It is possible
    -+linkgit:git-clone[1] a new repository from a bundle, to use
    ++Git commands that fetch or otherwise "read" via protocols such as
    ++`ssh://` and `https://` can also operate on bundle files. It is
    ++possible linkgit:git-clone[1] a new repository from a bundle, to use
     +linkgit:git-fetch[1] to fetch from one, and to list the references
    -+contained within it with linkgit:git-ls-remote[1].
    ++contained within it with linkgit:git-ls-remote[1]. There's no
    ++corresponding "write" support, i.e.a 'git push' into a bundle is not
    ++supported.
     +
     +See the "EXAMPLES" section below for examples of how to use bundles.
     +
2:  63f871a0c72 ! 2:  fe61f20f19f bundle doc: split out thin v.s. not discussion from <rev-arg>
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    bundle doc: split out thin v.s. not discussion from <rev-arg>
    +    bundle doc: split out open v.s. closed discussion from <rev-arg>
     
    -    Split out the discussion of why you should or should not create "thin
    +    Split out the discussion of why you should or should not create "open
         bundles" into a new section, away from the discussion of our handling
         of the rev-args syntax.
     
    @@ Documentation/git-bundle.txt: contained in the union of the given bases.  Each b
      `master~10..master`, `--since=10.days.ago master`).
      
     -It is very important that the basis used be held by the destination.
    -+OPEN (THIN) AND CLOSED BUNDLES
    -+------------------------------
    +-It is okay to err on the side of caution, causing the bundle file
    +-to contain objects already in the destination, as these are ignored
    +-when unpacking at the destination.
    ++OPEN AND CLOSED BUNDLES
    ++-----------------------
     +
     +When creating bundles it is possible to create bundle tips that are
     +either closed or open under reachability, i.e. those that contain all
    @@ Documentation/git-bundle.txt: contained in the union of the given bases.  Each b
     +range such as "master~2..master" will not (unless the full history is
     +contained within that range).
     +
    -+Another name for "open" bundles might be "thin bundles", as in the
    -+`--thin` option to linkgit:git-pack-objects[1]. Under the hood that's
    -+what `git bundle create` uses to write bundles. When thin bundles
    -+it is very important that the basis used be held by the destination.
    - It is okay to err on the side of caution, causing the bundle file
    - to contain objects already in the destination, as these are ignored
    - when unpacking at the destination.
    ++When creating "open" bundles it is very important that the basis used
    ++be held by the destination.  It is okay to err on the side of caution,
    ++causing the bundle file to contain objects already in the destination,
    ++as these are ignored when unpacking at the destination.
    + 
    + `git clone` can use any bundle created without negative refspecs
    + (e.g., `new`, but not `old..new`).
     @@ Documentation/git-bundle.txt: If you want to provide the same set of refs that a clone directly
      from the source repository would get, use `--branches --tags` for
      the `<git-rev-list-args>`.
      
    -+See the the `--thin` option to linkgit:git-pack-objects[1] noted
    -+above, and the discussion of "thin pack" in
    ++THIN BUNDLES
    ++------------
    ++
    ++Bundles that are "open" (see above) are created "thin" by using the
    ++`--thin` option to linkgit:git-pack-objects[1]. Whether a bundle (or
    ++packfile) is "thin" is a subset of whether it's "open". What "thin"
    ++means is that such a packfile can store an object in a deltified form
    ++against a base object that is not in the same packfile.
    ++
    ++To put it another way, when creating "open" bundles we assume that the
    ++objects leading up to the starting range(s) already exist in the
    ++recipient repository, which allows us to save space. When we run 'git
    ++bundle unbundle' we invoke linkgit:git-index-pack[1] with the
    ++`--fix-thin` option.
    ++
    ++See the discussion of "thin pack" in
     +link:technical/pack-format.html[the pack format documentation] for
     +further details.
     +
3:  14e4a724fb2 ! 3:  9a1c33cb853 bundle doc: elaborate on rev<->ref restriction
    @@ Documentation/git-bundle.txt: unbundle <file>::
     +fatal: Refusing to create empty bundle.
     +----------------
      
    - OPEN (THIN) AND CLOSED BUNDLES
    - ------------------------------
    + OPEN AND CLOSED BUNDLES
    + -----------------------
-- 
2.32.0.613.g8e17abc2eb

