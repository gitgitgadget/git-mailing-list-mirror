Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D9F1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbeAGSPG (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:06 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35862 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754273AbeAGSPF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:05 -0500
Received: by mail-qt0-f196.google.com with SMTP id a16so11271149qtj.3
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=McqLk9/I/k+Qoc7Aq+Ar8GL2BphU5d3k2Vxo0U42xD4=;
        b=XgqlDaEdKhHmOKUmHRNAsyCjug/RAuViKhV9+ccXYVM/b9kUesqpDFGSAAY9GEzaS6
         03QG8dn0b6jRvhSOZ3cjfkGSxdd6AjO7vftiOawC5fVbtYsDd6QdnX2CCpQrrd/P3eXI
         lfLDPUC6uWqUU6+AUMoQUfJd8KARSidjW4Jn6ITksnF8dZFJejudlaLLDzPasIDmdmb4
         iHBhVhl3nrs+2HL+b5to9L1mhu7Q7PnB9I0ojlE6tmdp/a2avZvHpW+lYKmY2/5+TmfS
         CU07LQz8bRwTyiyY20dZ+6ONK8JJBCFifEtoifwd7LD3qjuTdyk1D/+FSKd4tVYao1Ih
         I6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=McqLk9/I/k+Qoc7Aq+Ar8GL2BphU5d3k2Vxo0U42xD4=;
        b=O7F8l6XxbDc1Vim/wiPFLOufJ2BIO3L7i4xAfWTnBUDV7eChRgxNLri6rONWrUFiw9
         6u2DW7uHPbuZ8Vd2VA+CZ1kRmhAlfMYoA6zNHJi8jQtTUmi53TN9qreuiksAbIMZR+ij
         FMpw22vw0aoS1YlQP5RWWrr/z3HGZuC8kiJ/tVMOvSSLgj81WE+LpVfwy7z7stvdvf08
         Nmgk4IA8pkzuh8OB03mSfUVRHuOUctI+NkQIXHOXE2+PWUF0WUSmqzUYiZkxm0plKewq
         vxQMkv+oQZcDtKTawl1r4AdVe0eA/uDmpjSP+y7ItovnAGj7ba1yoaoZDs/5CpGCWE/1
         B9lg==
X-Gm-Message-State: AKwxyteTZl1rCHOY7QhDW8P6NPNRQu7kXqvX5CrwaknpA/Q8+pF9aCab
        Iqa7OOVRFLLNGN56HIJjY4IZgifuhtU=
X-Google-Smtp-Source: ACJfBovWTEYdzTcIF0OmyUoF72jsKAu67HsK+Cmi9LTslPPwwd8LyLrrczVgKpPf94Al6L2t59L4Ng==
X-Received: by 10.237.61.181 with SMTP id i50mr13292489qtf.89.1515348904027;
        Sun, 07 Jan 2018 10:15:04 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:02 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 00/18] Multi-pack index (MIDX)
Date:   Sun,  7 Jan 2018 13:14:41 -0500
Message-Id: <20180107181459.222909-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC includes a new way to index the objects in multiple packs
using one file, called the multi-pack index (MIDX).

The commits are split into parts as follows:

[01] - A full design document.

[02] - The full file format for MIDX files.

[03] - Creation of core.midx config setting.

[04-12] - Creation of "midx" builtin that writes, reads, and deletes
          MIDX files.

[13-18] - Consume MIDX files for abbreviations and object loads.

The main goals of this RFC are:

* Determine interest in this feature.

* Find other use cases for the MIDX feature.

* Design a proper command-line interface for constructing and checking
  MIDX files. The current "midx" builtin is probably inadequate.

* Determine what additional changes are needed before the feature can
  be merged. Specifically, I'm interested in the interactions with
  repack and fsck. The current patch also does not update the MIDX on
  a fetch (which adds a packfile) but would be valuable. Whenever
  possible, I tried to leave out features that could be added in a
  later patch.

* Consider splitting this patch into multiple patches, such as:

    i. The MIDX design document.
   ii. The command-line interface for building and reading MIDX files.
  iii. Integrations with abbreviations and object lookups.

Please do not send any style nits to this patch, as I expect the code to
change dramatically before we consider merging.

I created three copies of the Linux repo with 1, 24, and 127 packfiles
each using 'git repack -adfF --max-pack-size=[64m|16m]'. These copies
gave significant performance improvements on the following comand:

    git log --oneline --raw --parents

Num Packs | Before MIDX | After MIDX |  Rel % | 1 pack %
----------+-------------+------------+--------+----------
        1 |     35.64 s |    35.28 s |  -1.0% |   -1.0%
       24 |     90.81 s |    40.06 s | -55.9% |  +12.4%
      127 |    257.97 s |    42.25 s | -83.6% |  +18.6%

The last column is the relative difference between the MIDX-enabled repo
and the single-pack repo. The goal of the MIDX feature is to present the
ODB as if it was fully repacked, so there is still room for improvement.

Changing the command to

    git log --oneline --raw --parents --abbrev=40

has no observable difference (sub 1% change in all cases). This is likely
due to the repack I used putting commits and trees in a small number of
packfiles so the MRU cache workes very well. On more naturally-created
lists of packfiles, there can be up to 20% improvement on this command.

We are using a version of this patch with an upcoming release of GVFS.
This feature is particularly important in that space since GVFS performs
a "prefetch" step that downloads a pack of commits and trees on a daily
basis. These packfiles are placed in an alternate that is shared by all
enlistments. Some users have 150+ packfiles and the MRU misses and
abbreviation computations are significant. Now, GVFS manages the MIDX file
after adding new prefetch packfiles using the following command:

    git midx --write --update-head --delete-expired --pack-dir=<alt>

As that release deploys we will gather more specific numbers on the
performance improvements and report them in this thread.

Derrick Stolee (18):
  docs: Multi-Pack Index (MIDX) Design Notes
  midx: specify midx file format
  midx: create core.midx config setting
  midx: write multi-pack indexes for an object list
  midx: create midx builtin with --write mode
  midx: add t5318-midx.sh test script
  midx: teach midx --write to update midx-head
  midx: teach git-midx to read midx file details
  midx: find details of nth object in midx
  midx: use existing midx when writing
  midx: teach git-midx to clear midx files
  midx: teach git-midx to delete expired files
  t5318-midx.h: confirm git actions are stable
  midx: load midx files when loading packs
  midx: use midx for approximate object count
  midx: nth_midxed_object_oid() and bsearch_midx()
  sha1_name: use midx for abbreviations
  packfile: use midx for object loads

 .gitignore                                   |   1 +
 Documentation/config.txt                     |   3 +
 Documentation/git-midx.txt                   | 106 ++++
 Documentation/technical/multi-pack-index.txt | 149 +++++
 Documentation/technical/pack-format.txt      |  85 +++
 Makefile                                     |   2 +
 builtin.h                                    |   1 +
 builtin/midx.c                               | 352 +++++++++++
 cache.h                                      |   1 +
 command-list.txt                             |   1 +
 config.c                                     |   5 +
 environment.c                                |   2 +
 git.c                                        |   1 +
 midx.c                                       | 850 +++++++++++++++++++++++++++
 midx.h                                       | 136 +++++
 packfile.c                                   |  79 ++-
 packfile.h                                   |   2 +
 sha1_name.c                                  |  70 ++-
 t/t5318-midx.sh                              | 189 ++++++
 19 files changed, 2020 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/git-midx.txt
 create mode 100644 Documentation/technical/multi-pack-index.txt
 create mode 100644 builtin/midx.c
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100755 t/t5318-midx.sh

-- 
2.15.0

