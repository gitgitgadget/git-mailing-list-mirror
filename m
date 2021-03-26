Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD7C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13E961A4E
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZKhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCZKg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:36:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D1C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so5197762wrn.0
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0Zr5ss4AOs9+e9Esec7e5AYU93Tfns0F2D3Fg5QCTY=;
        b=iaD4flk+Uo2R617SQ3sjDnDbgpdFsXjG98Wq7lqQjb0mqwEq3p+u3xp8Dy2xZ/MNuM
         XPxrrFGWvjQOPSCl3r85IMVZDVPAf34W8nrty5IJAOt5BJlWVYIr75bHsK6OX0oq0XZS
         pABn1L8joRywhGWnrQbDdB5HibAPLbVwq9kGT3hdn14eKOYZ0MeTk3C7aeypLTT3TX/O
         ogWCgc0K3M2dXMjShVdOU32PAD+mrVQZSPzq3sSXrg2H+Z0rFA3dtnUymtY8u3DUOZ++
         x0oISaFLelXlI3k0j9UBMI/4h+XLntVBj2m0S3u1/CWi6sZJJrv4p4EOoP+szJT+t+QI
         tjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0Zr5ss4AOs9+e9Esec7e5AYU93Tfns0F2D3Fg5QCTY=;
        b=PdSnFPRD69WBYyMZqhFEx5JfiUg99fYBvobRIXcWgpet0nyTE/X0H6RxhAdkdCCG6K
         LOjz3s0HoNKorYxSyxOTkQu0XgeiN9f4yz8IuuTpOZNjxZNzotxEgmwX0+9Iwo5SK+xq
         BT6TY1VnhtObsHiyqQa3P/z+cp3ypngPTcgacYk+MXV9OprGxHmgUP6NYMyhv14z1N4t
         Eb1IfK8p/3veciCYvWAMOdtSBYMnS8UE1zkSDhkAbfX3ITvoG1ir8QUrExwAOA2RzLF8
         l0YxgmBdqo51ezOxYMBs6ib5B3DGbkPRNKFvYXNlXgWFwchbgRmLcxPqZC5La8vnbBv2
         T+AA==
X-Gm-Message-State: AOAM531axdkiHK9FOMb9omHYJkAZOT6k2w/VSDrDtFOLlYsUXy5yX1oX
        nswJrhVPusv+FjFSxOcKCEoJgT8NNTuTAg==
X-Google-Smtp-Source: ABdhPJz3t70YbpUXRQrykpvxEr1JtBGGZ6WzDsZb1X3voHJ0oXQ4WVRBdzC3rjwWVNOw6uV2ZgYyjA==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr13468017wrw.289.1616755014426;
        Fri, 26 Mar 2021 03:36:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1752563wmr.10.2021.03.26.03.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:36:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] small doc make and lint fixes
Date:   Fri, 26 Mar 2021 11:36:45 +0100
Message-Id: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.419.gfc6e4cae13
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small stand-alone series of doc infrastructure fixes. 5/6 fixes an
interesting bug that's been missed since doc-diff was introduced.

Ævar Arnfjörð Bjarmason (5):
  Documentation/Makefile: make $(wildcard howto/*.txt) a var
  Documentation/Makefile: make $(wildcard <doc deps>) a var
  doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
  doc lint: fix bugs in, simplify and improve lint script
  doc lint: lint and fix missing "GIT" end sections

 Documentation/Makefile           |  31 +++++++--
 Documentation/git-credential.txt |   4 ++
 Documentation/git-p4.txt         |   4 ++
 Documentation/gitnamespaces.txt  |   4 ++
 Documentation/lint-gitlink.perl  | 110 +++++++++++++++----------------
 Documentation/lint-man-txt.perl  |  24 +++++++
 6 files changed, 116 insertions(+), 61 deletions(-)
 create mode 100755 Documentation/lint-man-txt.perl

-- 
2.31.0.419.gfc6e4cae13

