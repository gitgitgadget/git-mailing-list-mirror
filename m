Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E14C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303732073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNJPq/Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLINKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:10:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33535 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINKk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 08:10:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so5169392pls.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CCygJ/rLTlqJM5l+8blrWriw9hd5IbKNkMrkdK8YdXA=;
        b=DNJPq/NiUVDjrSSH9yhVTYhQ+bkgueiPRrJ2o3pJIJRY+ZPPuk88yRsqbGC1bnTGeJ
         ZR1VIxo/LUzColjwyZxHegaEnHsfbmag5+/6mE62eVDSLZY/NEa1qJnGCAHIcumXjZzN
         3zTNpmjBykzpJRU/HdFaG2sM0Xqt7lfrWVGDvDyB471JUVM4sNI16dqY6NDmz1mhc9Ve
         aHqYlfbfi5EI2ysOAcBV+dqp9VR9Xe3Mpy8YRYlqFNUMPewePDE7VlQCfzfVHx1tm0HI
         8W+SxvjD0OmiQQZVIETkwYwLaAcOaznWJhSo5FpAudU9bQj2jyGmGEFtGJFNj6hk02gm
         u91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CCygJ/rLTlqJM5l+8blrWriw9hd5IbKNkMrkdK8YdXA=;
        b=g9VIkkH3S4WYoEAkdLwzGo79FdyKa9MdNUYZbCi5czySk7KcYInFEuC2/ffizmTVXV
         AUVS1r+ZEEk46YRtHZDgWsk9M5G1Fiif+u4wq7ittfudwu3j3irTs5stlir8bZCPl8cj
         n2WVfg8uIKcYK/4AuuVs7mIInqeeFMmSJtVPrmQsM1+ZyAfjQKnH/8cgcBsc8cynUw/2
         P5XxIgbGQfSsyH6kWD117H+y2/Fr8NqjBY+fkJfGQABhMKikMhqXbEyP/z7QEQx/PV4X
         GfgzcDDlUR3DllvGP4j48g5yoEPwr/65tGfaGM1qDkTTj4t/FhPKelWh0KAbXQp0QUtO
         kuVQ==
X-Gm-Message-State: APjAAAVJuj/ePEcNdgRH7TcQIwICZQxILmd4SxurT376ZuKlgmEV+qfD
        geRzspI6y/cK2HbWnd7KWzArk+NF
X-Google-Smtp-Source: APXvYqxygTe95YQ9UX0YXyZkMIwGhPqVWXFaqJ3pujXsG66361BxoOvH4obM+6SKyAqtNUnZZStFbA==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr31995096pjo.80.1575897039235;
        Mon, 09 Dec 2019 05:10:39 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id q11sm26710062pff.111.2019.12.09.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:10:38 -0800 (PST)
Date:   Mon, 9 Dec 2019 05:10:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH 0/5] format-patch: improve handling of `format.notes`
Message-ID: <cover.1575896661.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this email[1], Elijah pointed out that the handling of multiple
`format.notes` configurations could be buggy. If we had
`format.notes = <ref1>`, `format.notes = false` and
`format.notes = <ref2>`, the behaviour is ambiguous. This series uses
the way `--notes=<ref1> --no-notes --notes=<ref2>` is handled as a model
and structures the handling of `format.notes` in a similar manner,
allowing one `format.notes = false` to override previous configs.

Also, in the same email, it was pointed out that git_config() should be
called before repo_init_revisions(). In 13cdf78094 (format-patch: teach
format.notes config option, 2019-05-16), the order was reversed. This
series changes it back such that git_config() is called before
repo_init_revisions().

This series is based on top of 'dl/format-patch-notes-config'.

It has minor textual conflicts with 'pu'. The merge resolution can be found at
https://github.com/Denton-L/git.git on branch
'published/published/pu-format-patch-notes-config'.

[1]: https://lore.kernel.org/git/CABPp-BF44+6gvZVNimKf-k7AWbOjw3OK-cJeFunNR96wvZGkcw@mail.gmail.com/

Denton Liu (5):
  notes: rename to load_display_notes()
  notes: create init_display_notes() helper
  notes: extract logic into set_display_notes()
  format-patch: use --notes behavior for format.notes
  format-patch: move git_config() before repo_init_revisions()

 builtin/log.c           | 26 +++++++++-----------------
 notes.c                 | 30 ++++++++++++++++++++++++++++++
 notes.h                 | 21 ++++++++++++++++++---
 revision.c              | 22 +++++-----------------
 t/t4014-format-patch.sh | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 37 deletions(-)

-- 
2.24.0.627.geba02921db

