Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B2C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhL1PgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhL1PgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D44C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so39145745wrg.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S+wtlMvwd7Vsck2OOkF8wvFdUHYb5iMCmAKbpBE49DI=;
        b=c+LSV6WUp4ev7FHigPFTOnv/y95rSN7vLltvuPNhZauUVz0aPC7ShpeNX9ovIvXz8v
         LwEcPR9K3in8iqjx0nrcejWqKoW13aJZFWLdO68XbrmVP+eqBMeeO/9GKjiN/JP4uQHL
         vOC0WTOpJECqvkBaGsxkV8qccHcHxCoMoeq39hJ1GrL/GZY27vEuPxP2OSmVt1npLqHP
         Ktl1N8v4dSS7V20UsuIVWBeqRKoFI2Bzg2f+/WBJXeQ716WfPRwcH+QFy7aJHCzz2SEh
         vN+AjkwXEzKHscpOHZwwoxBG5nm7lByyL3aagA/8339taV6aFBLgqznasBmKIfMbwlT1
         fMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S+wtlMvwd7Vsck2OOkF8wvFdUHYb5iMCmAKbpBE49DI=;
        b=tJ8gq+LFFJ+3gAOFJt0ljifbsK4ZSDSWtzEJr1Z/YZ9qRlhPJJzg/7mnUAuKYx6EQo
         82iKSYimazNZbmkfwkypvm7S3INhxOXtAja6Iyyyt6X9ZSf4gsjCIRe4F7q3uohnVNnZ
         XMWXysa2MmO5A1LyuSkRpIIp+idOi6ZnWgMRxYJ+oBxm891RGwCVlpM8FWq5rbHQEKy6
         WezZOHhgWwX0VQT04GSuhSqWXixmycg1qumgOZKoJrVg9mfuEByc2QA6O5fmhAuA83B3
         uZ9Gc9jLlxOQ1qtQZSuwpdvNif4BmruVcwGIM2bLZnJEApNsOT7JyBA0FrP0YqYfzNBh
         xGtQ==
X-Gm-Message-State: AOAM532QBfZ1LtbHELGMCBNbzYm2t/gey0grFkFfyDf7nl3gHKm0/Vk3
        w3920W3kDB8YR/3Tu6Dx/gdD9i6M5uRIJ5l4
X-Google-Smtp-Source: ABdhPJwqaZXw2YDfIHvd62aKrDP5s/SIbos+W3gbOH3lCgli5xJCBCwuFso6C/UIG7scisZPwKwJ4g==
X-Received: by 2002:a05:6000:18a5:: with SMTP id b5mr17089396wri.267.1640705779568;
        Tue, 28 Dec 2021 07:36:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] help: test and fix small "help -g" regression
Date:   Tue, 28 Dec 2021 16:35:05 +0100
Message-Id: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a trivial regression in 17b3e515050 (Merge branch
'nd/command-list' into nd/complete-config-vars, 2018-05-29) where we'd
overly whitespace pad "git help -g", since the codepath moved to a
function that assumed it needed to "\n\n"-pad multiple items being
emitted, so we'd print an extra leading newline when printing one
item (as opposed to "git help -a").

In doing so I wanted to add regression tests, and to do that we first
need to make the format stable ("git help -a" will change depending on
whatever git-* you have in $PATH).

These are things I noticed when re-rolling my no-yet-picked-up series
to move Documentation/technical/* to manpages[1]. An unsubmitted
re-roll of this series depends on this one. I'll hold off on a
re-submission of it until this series has graduated.

1. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (7):
  help doc: add missing "]" to "[-a|--all]"
  help.c: use puts() instead of printf{,_ln}() for consistency
  help tests: test "git" and "git help [-a|-g] spacing
  help.c: split up list_all_cmds_help() function
  help: error if [-a|-g|-c] and [-i|-m|-w] are combined
  help: add --no-[external-commands|aliases] for use with --all
  help: don't print "\n" before single-section output

 Documentation/git-help.txt | 12 ++++-
 builtin/help.c             | 34 ++++++++++++--
 help.c                     | 37 ++++++++++++----
 help.h                     |  2 +-
 t/t0012-help.sh            | 91 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 161 insertions(+), 15 deletions(-)

-- 
2.34.1.1257.g2af47340c7b

