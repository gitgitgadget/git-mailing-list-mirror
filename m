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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09DC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2006060720
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFGQ6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGQ6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:58:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7015C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 09:56:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c9so9739329wrt.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KWvs870+fKBd3M4qRSKB26VnC4XWPF+klGY3Js/64g=;
        b=LFMwmofkDQ4lX35BQBXWow1/g2K8W5idGEzSbSDKuJ/QTopSRPDwQI1dBsOfw+5WzV
         UZORTia+DE43W8cw85PNDHxWcGqvLp6VtrHbB6UoetMQp6XRUTroyQG/KhDnOzT+FWuH
         e08tZa7hofEjWfB7Ws31VNrV5+Mo9gmSTSyObDkWJIyltmwCB6wg3JqOJYsFmfh5YwFe
         fITuT47U3ov32283qTl+A4Wpevkfr1iGxbbf6DsS2lh8xIUl1TbadHgBux8sHWOwklAz
         J8qQ0+/gaq2Eb7/2RNrvP+QS4J1uQaHieOC96l+IO1XCO2AbKuRxU+MeM5qy8zneiyCK
         zY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KWvs870+fKBd3M4qRSKB26VnC4XWPF+klGY3Js/64g=;
        b=E/OgEUOFuNWDitxOISt6OdMBUypwqDDCidQYuSv06IVUrF1d3BB8ULvpTi6eztkefm
         IKrJ6MLC9Pp3ZarlaA2hUs7ILymVhtFMDEhz54Q+iTLKZ8zaCc4kYJcb+oeUkj6M/a/C
         mb+HTCkOkJ5FCDLC6Zdfwm6pFSmncQ1Q4pxYhZK3JbFbVjD4o4WjiY/QLOjzVy507tLc
         IrEXStRMBlW6A/ebQ1/d3YqGoBtrJXXwwCjiUbyS4eNBaa0gzz/WKNoEoAGTwOnPcR+0
         G588hrA8rIpOR03SDmjsQR1mraRp3UccU8+spvnRSkyYQNvH6l++nKlIsHY03VQjJN4N
         HDyw==
X-Gm-Message-State: AOAM533O/5ZvEKhl485Wi827kf11x00LswZyxLzl3hrN6mw7/o+/jc95
        hVwHLPktk+9/xo1kkRKPXqLCd0IMD8kbpg==
X-Google-Smtp-Source: ABdhPJx9W2wfOrpsAEhRw4B1EsfYdaMWwd+g5DozWTNOquPe4fr1GSvGUbKC43fCd5oEWqDuVyoNgQ==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr18256475wrr.71.1623085002169;
        Mon, 07 Jun 2021 09:56:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11sm4066056wmq.4.2021.06.07.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:56:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] bundle doc: rewrite the "DESCRIPTION" section
Date:   Mon,  7 Jun 2021 18:56:39 +0200
Message-Id: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <patch-1.1-4e736877d1-20210607T143643Z-avarab@gmail.com>
References: <patch-1.1-4e736877d1-20210607T143643Z-avarab@gmail.com>
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

I didn't think I needed to type "make" to check a doc-only change, but
as it turns out v1 of this doesn't compile git because the script to
generate command-list.h doesn't know how to escape the quotes in the
C-string it generates.

This is probably better in either case, sorry about the noise.

Range-diff against v1:
1:  4e736877d1 ! 1:  bc6a6d8922 bundle doc: rewrite the "DESCRIPTION" section
    @@ Documentation/git-bundle.txt: git-bundle(1)
      NAME
      ----
     -git-bundle - Move objects and refs by archive
    -+git-bundle - Create, unpack and manipulate "bundles"
    ++git-bundle - Create, unpack and manipulate bundles
      
      
      SYNOPSIS

 Documentation/git-bundle.txt | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b..cdc4e0b51b 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -3,7 +3,7 @@ git-bundle(1)
 
 NAME
 ----
-git-bundle - Move objects and refs by archive
+git-bundle - Create, unpack and manipulate bundles
 
 
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

