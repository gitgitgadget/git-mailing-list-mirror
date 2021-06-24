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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F88C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D92B6120D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhFXTm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhFXTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:42:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567DEC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m18so7939261wrv.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgXZHjxwWzOeQ38JdWFsUjRj3RFirll6S7Nn90VHO1U=;
        b=LTvrl5ssKQwDvdXTQ12rBtr5oXHkHAf6sVU0ef2Gwak2WlbXOYNMTLSwFFJLOgTq/5
         2V4swpEqJHwJZVtrstYwDBznWPM6BUO1D4gZRT1Pa9WG+KwefZSrDGYSGX7Nx5u9um6K
         kZ/YGbuy0UlN52JS9N0SL+whjG9BR8k0IoWxObSjX45t8uOL4axdLvrgfdq1r+Tytx5D
         6JziB15Rervd0xc6c51GbP/h5e1CzeU8VmhcqpFba1lnbdjCVgrxd+kB8X3k2s+Qy7q1
         JdZgQ9jpCaH2hitd2KJa0oQd4kBXL62SBGk8CDDkmzdf1MC+kZytk2ulXlBfIPx77c5H
         WMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgXZHjxwWzOeQ38JdWFsUjRj3RFirll6S7Nn90VHO1U=;
        b=IYEdfOm5YHt7BDPW7qQSl+Qk5oGjQuZyg6BSnA86kktVvlWW6Cp4Rb+lR2RVvZzgHh
         ibz/+K6bHbB2vuXO5X/4++WSZii0kaJ9NTUJdKWWSv0dS6g7t9VqVGh2ZxomlLJJPSj1
         uy8NzEZBWFzyW/SA86dZnqL6US+ZEkmoVGiITuiLr7D6nKP5dx680u4dWv/d+kXlXkTH
         9536O1o4rnA92s7LtTpBVB5fPl2/V22hjf5W17nIlWF6DJ+wOZTBrBiSJYiwHfO0Kno4
         oYzZlPhI7K/7gtmgUnyPKYpVml4f1/jxOkALW/sIzKnt/BwUlHMUkoO52e4KYFgT94JP
         yZzw==
X-Gm-Message-State: AOAM530eSWdJ0w4b+YukCGGVzomNejTLJ6zmcMqADddV3jY0IOvsCgby
        rvImsi9Ut440cyHnZse31kmkqytL/3HHmQ==
X-Google-Smtp-Source: ABdhPJwPOpBTiFzBnaYTBpg/odZmAxujO0Af7ZLtv32BA0oKayN49JahQyoO4UABBwHpP02tl0CyGw==
X-Received: by 2002:a5d:6945:: with SMTP id r5mr6522570wrw.249.1624563630299;
        Thu, 24 Jun 2021 12:40:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm9286057wmi.31.2021.06.24.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:40:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] bundle doc: generaliz & elaborate
Date:   Thu, 24 Jun 2021 21:40:25 +0200
Message-Id: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.610.gd639e370050
In-Reply-To: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
References: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as 1 patch in
https://lore.kernel.org/git/patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com/
but is now 3.

In rewriting the DESCRIPTION section per Junio's feedback I went on to
elaborate on the thin v.s. not thin bundles and in 3/3 rewrote some
prose to make heavier use of show and tell.

Per a certain recent CodingGuidelines discussion about patterns in our
documentation I've long thought that the sort of change I'm doing in
3/3 is something we could do more of. I.e. replacing somewhat complex
and dense prose with short paragraphs broken up by simple command
examples (and output), whenever possible.

Ævar Arnfjörð Bjarmason (3):
  bundle doc: rewrite the "DESCRIPTION" section
  bundle doc: split out thin v.s. not discussion from <rev-arg>
  bundle doc: elaborate on rev<->ref restriction

 Documentation/git-bundle.txt | 111 +++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 24 deletions(-)

Range-diff against v2:
1:  bc6a6d89224 ! 1:  2824133f423 bundle doc: rewrite the "DESCRIPTION" section
    @@ Commit message
     
         Rewrite the "DESCRIPTION" section for "git bundle" to start by talking
         about what bundles are in general terms, rather than diving directly
    -    into one example of what they might be used for. This changes
    -    documentation that's been substantially the same ever since the
    -    command was added in 2e0afafebd8 (Add git-bundle: move objects and
    -    references by archive, 2007-02-22).
    +    into one example of what they might be used for.
    +
    +    This changes documentation that's been substantially the same ever
    +    since the command was added in 2e0afafebd8 (Add git-bundle: move
    +    objects and references by archive, 2007-02-22).
    +
    +    I've split up the DESCRIPTION into that section and a "BUNDLE FORMAT"
    +    section, it briefly discusses the format, but then links to the
    +    technical/bundle-format.txt documentation.
    +
    +    The "the user must specify a basis" part of this is discussed below in
    +    "SPECIFYING REFERENCES", so I'm removing that part and letting the
    +    brief mention of "thin" suffice.
    +
    +    To the extent that we should say more on the topic that documentation
    +    will be improved by subsequent commits.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-bundle.txt ##
    -@@ Documentation/git-bundle.txt: git-bundle(1)
    - 
    - NAME
    - ----
    --git-bundle - Move objects and refs by archive
    -+git-bundle - Create, unpack and manipulate bundles
    - 
    - 
    - SYNOPSIS
     @@ Documentation/git-bundle.txt: SYNOPSIS
      DESCRIPTION
      -----------
    @@ Documentation/git-bundle.txt: SYNOPSIS
     -machine be replicated on another machine, but the two machines cannot
     -be directly connected, and therefore the interactive Git protocols (git,
     -ssh, http) cannot be used.
    -+Create, unpack and manipulate "bundles" (.bundle) files. Bundles are
    -+.pack files (see linkgit:git-pack-objects[1]) with a header indicating
    -+what references are contained within the bundle. The header is in the
    -+format emitted by linkgit:git-show-ref[1].
    - 
    +-
     -The 'git bundle' command packages objects and references in an archive
     -at the originating machine, which can then be imported into another
     -repository using 'git fetch', 'git pull', or 'git clone',
     -after moving the archive by some means (e.g., by sneakernet).
    +-
    +-As no
    +-direct connection between the repositories exists, the user must specify a
    +-basis for the bundle that is held by the destination repository: the
    +-bundle assumes that all objects in the basis are already in the
    +-destination repository.
    ++Create, unpack, and manipulate "bundle" files. Bundles are used for
    ++the "offline" transfer of Git objects without an active "server"
    ++sitting on the other side of the network connection.
    ++
    ++They can be used to create both incremental and full backups of a
    ++repository, and to relay the state of the references in one repository
    ++to another.
    ++
    ++Other git commands that understand protocols such as `ssh://` and
    ++`https://` can also operate on bundle files. It is possible
    ++linkgit:git-clone[1] a new repository from a bundle, to use
    ++linkgit:git-fetch[1] to fetch from one, and to list the references
    ++contained within it with linkgit:git-ls-remote[1].
    ++
    ++See the "EXAMPLES" section below for examples of how to use bundles.
    ++
    ++BUNDLE FORMAT
    ++-------------
    ++
    ++Bundles are `.pack` files (see linkgit:git-pack-objects[1]) with a
    ++header indicating what references are contained within the bundle. The
    ++header is (mostly) in the format emitted by linkgit:git-show-ref[1].
    ++
     +Like the the packed archive format itself bundles can either be
     +self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
     +
    -+Bundles are useful for numerous purposes. They were originally
    -+designed to facilitate the transfer of repository data between
    -+repositories which could not be directly connect to each other, and
    -+therefore the interactive Git protocols (git, ssh, http) could not be
    -+used.
    -+
    -+In that scenario a bundle is produced on the originating machine. It
    -+is then transferred to the other machine (e.g. by sneakernet), and
    -+unpacked on the other end. The unpacking can happen either with
    -+linkgit:git-clone[1] (which knows how to clone from bundle files), or
    -+by "git bundle unbundle".
    - 
    - As no
    - direct connection between the repositories exists, the user must specify a
    -@@ Documentation/git-bundle.txt: basis for the bundle that is held by the destination repository: the
    - bundle assumes that all objects in the basis are already in the
    - destination repository.
    ++See link:technical/bundle-format.html[the `bundle-format`
    ++documentation] for more details.
      
    -+Similarly, bundles are commonly used to produce incremental backups of
    -+git repositories. See the "EXAMPLES" section below.
    -+
      OPTIONS
      -------
    - 
-:  ----------- > 2:  63f871a0c72 bundle doc: split out thin v.s. not discussion from <rev-arg>
-:  ----------- > 3:  14e4a724fb2 bundle doc: elaborate on rev<->ref restriction
-- 
2.32.0.610.gd639e370050

