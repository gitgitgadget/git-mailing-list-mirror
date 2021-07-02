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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A00C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7250613FE
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhGBL3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGBL3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:29:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88814C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:26:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v5so12056834wrt.3
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13fuZAnyJ24ncmT1qplBHOXQM0x2VvHhrbPrukYBeAc=;
        b=NEyKDip9UPsEZUJIBvWRWtsQbaLxBwzE5wQ69Gza1ozTsWkcBgZoghFviAsvF+yW9N
         rUTJM8Sx871386DEjNVxq4iM2+p7PpJN15/FMDW85jUmEPYvghGSmFFvVnmA9cQoveYl
         JRH/WTAkesv1v6w9qW0stI4uCetuLuEy/pUnE6smWZ9wOS5TA/F1pYmFKDqEcFZRWIsU
         tjWXV1E0Jz39sjdCpmDIiSGU8Ny5ZDFbcSN3JQhcTARMAWlfzxgFWw/f0hgB24v5F1Na
         4FZCJyg3XyUMXeXmE8UX9O/o9pejNykaLJ80wHaPUg300DSBpnSwzR4PSrM4OFHeormC
         mVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13fuZAnyJ24ncmT1qplBHOXQM0x2VvHhrbPrukYBeAc=;
        b=l0zCSGSDwugteX68oTN9UBdCy5RqTgwb8CHJl15NqS8WmXet8HVsvOdOnkujnkTZG/
         3WUsA5WZLl6IcLfBqnnW2caIRG4HFfv+iZlm4jAnastD9CWAveypV/ivAamjMDPkSe5K
         8IHx4Qc3pLzy0sPp31sXckIf9gwZUWXXw7RBt5UjsTxGVBQz1gx0UvLAvY40cx+DfWuR
         AENHd/I7zg3FPovhla8D7IkTd6U/ZZE+NHWi1OttkL6SilfHNkDbkyjL/JlTUnc9kLn1
         F4cTZH4TsUdjAB+n2TEddqFL2q7f4hOWvzmcq7ruKFUHdfuToGtS2YBT53L4jVKKS95S
         KT6g==
X-Gm-Message-State: AOAM533pf4xFrITB1MDeMC01uLkwzE5V+3iZhqUvirlEyJo0FfleU1QX
        YW8f4Aj2Vr6Y4Yh6udl6KlAgkaKmvRQ9eA==
X-Google-Smtp-Source: ABdhPJxXYpzKju1SgBLFRH1GgL1XDM3LhH2MeEtbcxqmTPVf6+ceTx12C+BthJtZXQGV4A2ChYG5IA==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr5252414wrv.75.1625225217560;
        Fri, 02 Jul 2021 04:26:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m18sm2763887wmq.45.2021.07.02.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:26:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/3] bundle doc: generalize & elaborate
Date:   Fri,  2 Jul 2021 13:26:52 +0200
Message-Id: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v5 of improvements to the "git bundle" documentation. See
http://lore.kernel.org/git/cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com
for v4.

This hopefully addresses Junio's concern in
https://lore.kernel.org/git/xmqqk0mbt5rj.fsf@gitster.g/

I didn't remove the discussion of "thin packs" entirely, but now the
whole section about "open" v.s. "closed" doesn't use that wording at
all, we now talk only about whether a bundle includes prerequisite
commits, and use the same language as git-rev-list does when referring
to "exclusions'.

The mention of "think pack" is left in the "BUNDLE FORMAT"
section. It's made clear that it doesn't matter to the end result, but
that it's noted as a reference to other docs. We then go on to link to
the bundle & pack technical format docs for the overly curious.

Ævar Arnfjörð Bjarmason (3):
  bundle doc: rewrite the "DESCRIPTION" section
  bundle doc: elaborate on object prerequisites
  bundle doc: elaborate on rev<->ref restriction

 Documentation/git-bundle.txt | 130 ++++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 26 deletions(-)

Range-diff against v4:
1:  d10060a237e ! 1:  3b447500da9 bundle doc: rewrite the "DESCRIPTION" section
    @@ Commit message
         technical/bundle-format.txt documentation.
     
         The "the user must specify a basis" part of this is discussed below in
    -    "SPECIFYING REFERENCES", so I'm removing that part and letting the
    -    brief mention of "thin" suffice.
    +    "SPECIFYING REFERENCES", and will be further elaborated on in a
    +    subsequent commit. So I'm removing that part and letting the mention
    +    of "revision exclusions" suffice.
     
    -    To the extent that we should say more on the topic that documentation
    -    will be improved by subsequent commits.
    +    There was a discussion about whether to say anything at all about
    +    "thin packs" here[1]. I think it's good to mention it for the curious
    +    reader willing to read the technical docs, but let's explicitly say
    +    that there's no "thick pack", and that the difference shouldn't
    +    matter.
    +
    +    1. http://lore.kernel.org/git/xmqqk0mbt5rj.fsf@gitster.g
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/git-bundle.txt: SYNOPSIS
     +header is (mostly) in the format emitted by linkgit:git-show-ref[1].
     +
     +Like the the packed archive format itself bundles can either be
    -+self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
    ++self-contained, or be created using exclusions.
    ++
    ++Bundles created using revision exclusions are "thin packs" created
    ++using the `--thin` option to linkgit:git-pack-objects[1], and
    ++unbundled using the `--fix-thin` option to linkgit:git-index-pack[1].
    ++
    ++There is no option to create a "thick pack" when using revision
    ++exclusions, users should not be concerned about the difference. By
    ++using "thin packs" bundles created using exclusions are smaller in
    ++size. That they're "thin" under the hood is merely noted here as a
    ++curiosity, and as a reference to other documentation
     +
     +See link:technical/bundle-format.html[the `bundle-format`
    -+documentation] for more details.
    ++documentation] for more details and the discussion of "thin pack" in
    ++link:technical/pack-format.html[the pack format documentation] for
    ++further details.
      
      OPTIONS
      -------
2:  6a312fbdb01 ! 2:  444b06740bc bundle doc: split out open v.s. closed discussion from <rev-arg>
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    bundle doc: split out open v.s. closed discussion from <rev-arg>
    +    bundle doc: elaborate on object prerequisites
     
    -    Split out the discussion of why you should or should not create "open
    -    bundles" into a new section, away from the discussion of our handling
    -    of the rev-args syntax.
    +    Split out the discussion bout "object prerequisites" into its own
    +    section, and add some more examples of the common cases.
     
         See 2e0afafebd (Add git-bundle: move objects and references by
         archive, 2007-02-22) for the introduction of the documentation being
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-bundle.txt ##
    -@@ Documentation/git-bundle.txt: header indicating what references are contained within the bundle. The
    - header is (mostly) in the format emitted by linkgit:git-show-ref[1].
    +@@ Documentation/git-bundle.txt: header is (mostly) in the format emitted by linkgit:git-show-ref[1].
      
      Like the the packed archive format itself bundles can either be
    --self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
    -+self-contained or thin, see the "OPEN (THIN) AND CLOSED BUNDLES"
    -+section below.
    + self-contained, or be created using exclusions.
    ++See the "OBJECT PREREQUISITES" section below.
      
    - See link:technical/bundle-format.html[the `bundle-format`
    - documentation] for more details.
    + Bundles created using revision exclusions are "thin packs" created
    + using the `--thin` option to linkgit:git-pack-objects[1], and
     @@ Documentation/git-bundle.txt: contained in the union of the given bases.  Each basis can be
      specified explicitly (e.g. `^master~10`), or implicitly (e.g.
      `master~10..master`, `--since=10.days.ago master`).
      
     -It is very important that the basis used be held by the destination.
    --It is okay to err on the side of caution, causing the bundle file
    --to contain objects already in the destination, as these are ignored
    --when unpacking at the destination.
    -+OPEN AND CLOSED BUNDLES
    -+-----------------------
    ++OBJECT PREREQUISITES
    ++--------------------
     +
    -+When creating bundles it is possible to create bundle tips that are
    -+either closed or open under reachability, i.e. those that contain all
    -+the history needed to get to a given point (closed), and those that do
    -+not (open). A revision such as "master" will produce a closed tip, a
    -+range such as "master~2..master" will not (unless the full history is
    -+contained within that range).
    ++When creating bundles it is possible to create a fully self-contained
    ++bundle with all the prerequisite objects, as well as providing
    ++negative revisions to exclude prerequisite objects.
     +
    -+When creating "open" bundles it is very important that the basis used
    -+be held by the destination.  It is okay to err on the side of caution,
    -+causing the bundle file to contain objects already in the destination,
    -+as these are ignored when unpacking at the destination.
    ++A revision such as `new` will produce a tip with all the prerequisite
    ++objects needed for the `new` reference.
    ++
    ++A revision range such as `old..new` will produce a bundle tip that'll
    ++require any objects existing before `new` to already be present in the
    ++repository performing the 'git bundle unbundle' operation.
    ++
    ++A self-contained bundle without any prerequisites can be extracted
    ++into anywhere, even into an empty repository, or be cloned from
    ++(i.e., `new`, but not `old..new`).
    ++
    + It is okay to err on the side of caution, causing the bundle file
    + to contain objects already in the destination, as these are ignored
    + when unpacking at the destination.
      
    - `git clone` can use any bundle created without negative refspecs
    - (e.g., `new`, but not `old..new`).
    -@@ Documentation/git-bundle.txt: If you want to provide the same set of refs that a clone directly
    +-`git clone` can use any bundle created without negative refspecs
    +-(e.g., `new`, but not `old..new`).
    + If you want to match `git clone --mirror`, which would include your
    + refs such as `refs/remotes/*`, use `--all`.
    + If you want to provide the same set of refs that a clone directly
      from the source repository would get, use `--branches --tags` for
      the `<git-rev-list-args>`.
      
    -+THIN BUNDLES
    -+------------
    -+
    -+Bundles that are "open" (see above) are created "thin" by using the
    -+`--thin` option to linkgit:git-pack-objects[1]. Whether a bundle (or
    -+packfile) is "thin" is a subset of whether it's "open". What "thin"
    -+means is that such a packfile can store an object in a deltified form
    -+against a base object that is not in the same packfile.
    -+
    -+To put it another way, when creating "open" bundles we assume that the
    -+objects leading up to the starting range(s) already exist in the
    -+recipient repository, which allows us to save space. When we run 'git
    -+bundle unbundle' we invoke linkgit:git-index-pack[1] with the
    -+`--fix-thin` option.
    -+
    -+See the discussion of "thin pack" in
    -+link:technical/pack-format.html[the pack format documentation] for
    -+further details.
    ++The 'git bundle verify' command can be used to check whether your
    ++recipient repository has the required prerequisite commits for a
    ++bundle.
     +
      EXAMPLES
      --------
3:  47b8dacb4aa ! 3:  6d8f2f27088 bundle doc: elaborate on rev<->ref restriction
    @@ Documentation/git-bundle.txt: unbundle <file>::
     +fatal: Refusing to create empty bundle.
     +----------------
      
    - OPEN AND CLOSED BUNDLES
    - -----------------------
    + OBJECT PREREQUISITES
    + --------------------
-- 
2.32.0.632.g49a94b9226d

