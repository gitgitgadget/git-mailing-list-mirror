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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A967C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7000760F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhGZXoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhGZXoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:44:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B4C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z4so1196686wrv.11
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haLapC99sdbAcgvrE3yDJOaK47RBUZc29cWOis6HITE=;
        b=noQj6q0GNyJwTgRshtmUXdfISCHLZzA33l+aIwJlPtrMUEKMpHzOwAE4QWSWHs+Iup
         XGoawCB9W+2+MShzV5cdLHovKG0dVlQmv6OPmgltLjRHqT7cQ62ektTx9+PleHXhP7Ov
         2vO4+8biChYu8dPd7oDUEXxBOGwLLBllPCqC4ZMzukGf2LLV5wpDMnlnQ55O1HFN8A4z
         zlC39he7c9a6uSRBPFK60+Py5Du/6BqIKd8sv+5iMBbA43O+rvImunV/2NjmXqMN3XZA
         J4L3Cjb4v9T0UN3pcrmplar9FINJQ2RoTe1M8KnbM34HdVuwYPE0iA0FmvOVH9JthfV5
         bWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haLapC99sdbAcgvrE3yDJOaK47RBUZc29cWOis6HITE=;
        b=IEpbxeL7A0j7M5CzLitLfsYeIJjkxXC3NvJbm6clMaZB9hglvInVzuCRHaFAB1LrhJ
         dF0c5dpc9DN06B2RMR6esW6fK/KWG5XdoXpxXplVpacYk1zoaksJtbkVUbYCPbrXlfKp
         lw4L4ScWTyGp3JosG0GyNAAN7ilotOZetjUsfW/0x0EMBJE2tEreJNKcNge9BgLFBB2w
         wlI4J2sViQjQM6ZX7ptQSo1mCtlWFXwm5Kxd3HYwcccAe5bb4L6zzcAA8jB4DWvhfWtR
         1jorBopLJTdjyOi5dLKFre3MIva24sDAmHE4u/NK1mk31z+rLd5jhA6X7/b248C7CJqQ
         YqEg==
X-Gm-Message-State: AOAM5319tlnsq+OUMaZ6B1pOFgi9zTOLDHf+YmZBYveVrfwzXCmB66Sj
        a9dcmqIaMUdwMgI8RIlv+BSRZN9b3+RW0w==
X-Google-Smtp-Source: ABdhPJwbKdGQitQHE53BRBtmhfqIjOLsZHWz0XdDenLPDeiKIRoHwWWgNgsAWYaLEwT7rQEF4fOk4A==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr21483838wrt.126.1627345466342;
        Mon, 26 Jul 2021 17:24:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm1115872wmq.0.2021.07.26.17.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:24:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/3] bundle doc: generalize & elaborate
Date:   Tue, 27 Jul 2021 02:24:18 +0200
Message-Id: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v7 hopefully addresses the outstanding comments on v6.

The mention of "show-ref" is gone (more confusing than not), and this
includes Junio's queued squash.

I left the further clarification of "basis" and "header references"
mentioned in [1] be. I think the former refers to the "basis can be
specified" wording in 3/3, which isn't new, but in that regard mostly
moves existing documentation around.

This documentation can definitely be improved further, but given that
this is in v7 and we're changing smaller and smaller things I'd like
to not add anything new to it for now, and hopefully get it merged
down & then build on top of it for any further changes.

1. https://lore.kernel.org/git/697ca0f3-a897-a20b-48e4-bf439697afb5@iee.email/

Ævar Arnfjörð Bjarmason (3):
  bundle doc: rewrite the "DESCRIPTION" section
  bundle doc: elaborate on object prerequisites
  bundle doc: elaborate on rev<->ref restriction

 Documentation/git-bundle.txt | 140 ++++++++++++++++++++++++++++-------
 1 file changed, 114 insertions(+), 26 deletions(-)

Range-diff against v6:
1:  3b447500da ! 1:  b8f8a20e78 bundle doc: rewrite the "DESCRIPTION" section
    @@ Documentation/git-bundle.txt: SYNOPSIS
     +-------------
     +
     +Bundles are `.pack` files (see linkgit:git-pack-objects[1]) with a
    -+header indicating what references are contained within the bundle. The
    -+header is (mostly) in the format emitted by linkgit:git-show-ref[1].
    ++header indicating what references are contained within the bundle.
     +
     +Like the the packed archive format itself bundles can either be
     +self-contained, or be created using exclusions.
2:  444b06740b ! 2:  5f344bd24a bundle doc: elaborate on object prerequisites
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-bundle.txt ##
    -@@ Documentation/git-bundle.txt: header is (mostly) in the format emitted by linkgit:git-show-ref[1].
    +@@ Documentation/git-bundle.txt: header indicating what references are contained within the bundle.
      
      Like the the packed archive format itself bundles can either be
      self-contained, or be created using exclusions.
    @@ Documentation/git-bundle.txt: contained in the union of the given bases.  Each b
     +OBJECT PREREQUISITES
     +--------------------
     +
    -+When creating bundles it is possible to create a fully self-contained
    -+bundle with all the prerequisite objects, as well as providing
    -+negative revisions to exclude prerequisite objects.
    ++When creating bundles it is possible to create a self-contained bundle
    ++that can be unbundled in a repository with no common history, as well
    ++as providing negative revisions to exclude objects needed in the
    ++earlier parts of the history.
     +
    -+A revision such as `new` will produce a tip with all the prerequisite
    -+objects needed for the `new` reference.
    ++Feeding a revision such as `new` to `git bundle create` will create a
    ++bundle file that contains all the objects reachable from the revision
    ++`new`. That bundle can be unbundled in any repository to obtain a full
    ++history that leads to the revision `new`:
     +
    -+A revision range such as `old..new` will produce a bundle tip that'll
    -+require any objects existing before `new` to already be present in the
    -+repository performing the 'git bundle unbundle' operation.
    ++----------------
    ++$ git bundle create full.bundle new
    ++----------------
    ++
    ++A revision range such as `old..new` will produce a bundle file that
    ++will require the revision `old` (and any objects reachable from it)
    ++to exist for the bundle to be "unbundle"-able:
    ++
    ++----------------
    ++$ git bundle create full.bundle old..new
    ++----------------
     +
     +A self-contained bundle without any prerequisites can be extracted
     +into anywhere, even into an empty repository, or be cloned from
3:  6d8f2f2708 = 3:  88e7ad1cf4 bundle doc: elaborate on rev<->ref restriction
-- 
2.32.0.988.g1a6a4b2c5f

