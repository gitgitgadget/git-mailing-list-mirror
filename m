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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2E1C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF3B610C7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGOj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhFGOjY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:39:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388FC061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 07:37:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b11so20678306edy.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kGWh1xfkNM+veXMf82WkH9BxTov41auI7RL80EokQfQ=;
        b=o9/PIHIbInDmOQ+xdkOSsSq+is+yLsWUqD0o7UAUmBRCqU8V/vVzcNSbmNCNxHKgbX
         lYs/lin5YOIgNuZvzhSp/TbO90nFD4UfnCpi9ZtPHGd6/oOiCxp4lUtCPbS84pQumT5N
         p+DyqCkZDXllVD6hoBAvMgF71HxSLhXmB28T84j9cnc9kkoxBrTFeBpevsEgMGF1aEkd
         83vCeajkrbDZ6owcrFZDc2GWsgYv6JTUTCgJA9X5GSsQlFBMI9VOs+tMAzqpvCXoXWxk
         2kZzXhc6N/NdXaDwEsFa7czv1ztybxRVlrPuXyIepLx4B/C82/Sk64qUqemTyIERDilW
         63aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kGWh1xfkNM+veXMf82WkH9BxTov41auI7RL80EokQfQ=;
        b=LLbjJ6ywj7aIJriCIbfMyreJn4YsGyTLppkuP3t406Z9S07n8OtQ5ezN/cdMKPD+Cs
         FxGrUezgmY8OwrQt6WdYNoE9wPJcY9m3UkSAeCfJR/jHAc0ZqzgEy1OB3HLXMKpFM/EL
         aLwZTDNIEw3odWenTO/IUREBlXNqdwTP94DncdWDgL1FTqjnYU5uEUI7XIGcmCd5J3oN
         E+8iEWp5sMXGlb4oEhS1nTh8zDgmfsCAQc5+ma5aKX1f5beY7fBx2dRHdfgaGj0Lt11C
         QoEyytCgeTVGRbY+SvS05cXmqm2e2ZmqODFGbAT2tlWxCKvAvU+rJTuB/pF0tdRSFoAW
         Bl7Q==
X-Gm-Message-State: AOAM530wdlgqbHd/g0NpV1mlHyajkfU/VPMt+NyB+uF/uQDrDo2Ramra
        o6RYFko7AlynF3vNxXyrOwKzub6kNVustw==
X-Google-Smtp-Source: ABdhPJw9c78hgBdGJJ5S4//h1SFMoFk2emfbm73gs3RUPbPI5LT7U8i6ODZ2uNdq7iLxVPjmMe6GYQ==
X-Received: by 2002:aa7:cc19:: with SMTP id q25mr19890259edt.56.1623076651513;
        Mon, 07 Jun 2021 07:37:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e25sm6564615eja.15.2021.06.07.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:37:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] bundle doc: rewrite the "DESCRIPTION" section
Date:   Mon,  7 Jun 2021 16:37:26 +0200
Message-Id: <patch-1.1-4e736877d1-20210607T143643Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite the "DESCRIPTION" section for "git bundle" to start by talking
about what bundles are in general terms, rather than diving directly
into one example of what they might be used for. This changes
documentation that's been substantially the same ever since the
command was added in 2e0afafebd8 (Add git-bundle: move objects and
references by archive, 2007-02-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b..1d7c6bdbb2 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -3,7 +3,7 @@ git-bundle(1)
 
 NAME
 ----
-git-bundle - Move objects and refs by archive
+git-bundle - Create, unpack and manipulate "bundles"
 
 
 SYNOPSIS
@@ -18,15 +18,25 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Some workflows require that one or more branches of development on one
-machine be replicated on another machine, but the two machines cannot
-be directly connected, and therefore the interactive Git protocols (git,
-ssh, http) cannot be used.
+Create, unpack and manipulate "bundles" (.bundle) files. Bundles are
+.pack files (see linkgit:git-pack-objects[1]) with a header indicating
+what references are contained within the bundle. The header is in the
+format emitted by linkgit:git-show-ref[1].
 
-The 'git bundle' command packages objects and references in an archive
-at the originating machine, which can then be imported into another
-repository using 'git fetch', 'git pull', or 'git clone',
-after moving the archive by some means (e.g., by sneakernet).
+Like the the packed archive format itself bundles can either be
+self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
+
+Bundles are useful for numerous purposes. They were originally
+designed to facilitate the transfer of repository data between
+repositories which could not be directly connect to each other, and
+therefore the interactive Git protocols (git, ssh, http) could not be
+used.
+
+In that scenario a bundle is produced on the originating machine. It
+is then transferred to the other machine (e.g. by sneakernet), and
+unpacked on the other end. The unpacking can happen either with
+linkgit:git-clone[1] (which knows how to clone from bundle files), or
+by "git bundle unbundle".
 
 As no
 direct connection between the repositories exists, the user must specify a
@@ -34,6 +44,9 @@ basis for the bundle that is held by the destination repository: the
 bundle assumes that all objects in the basis are already in the
 destination repository.
 
+Similarly, bundles are commonly used to produce incremental backups of
+git repositories. See the "EXAMPLES" section below.
+
 OPTIONS
 -------
 
-- 
2.32.0.rc3.434.gd8aed1f08a7

