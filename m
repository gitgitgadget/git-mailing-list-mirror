Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D37C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiAVV4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiAVV4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9149C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s18so6478327wrv.7
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=L31uFY5SpIUYHx4tsrkHDgGcnsONnpvZf1x5kL7Pan4=;
        b=nnLqA0VK4uAyaOgD6eY5S9I6kwnkxK9+2Dtpc52in4I1qCblJSR6+xp/vfn8G6Enbi
         Le+NphDefvurFCmF5VIFj52Bj3V7zWqObko7GgbzI6Gr1unf2YDQ5qhYlpoc5mPRNrna
         1+pNLTJZD/+Or9H/qyzp8Al3Gob2YA83TiZ/Ebq8aY+druUwkioF+XtFNx+lGd74kaUF
         AkE4XCsEU1mt96DpwFqHSMKtUKGk+09PkpjHdmc5Si1v5RTC+BhDlshGoii3j5QIXPOu
         EkFDuKRKGmzM3lVDRsarFeKSwvY+pRYhSddUs7lxWKMLo5cRS2zKMqufR3ENMWMTt+Wu
         YMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L31uFY5SpIUYHx4tsrkHDgGcnsONnpvZf1x5kL7Pan4=;
        b=LYaJ4m0ovE9zTnovoZEmC0Qwd6RFDzwY9MC6MXMSmU+COmtr5Mc885GNTwpEOaybdk
         Rrv2RT1MvyTkY8QUPRnnaU6DecOFoOk5joWvOmZpK2LLVCkfn5OAG3n8dCUSj00IR2cU
         QLourx09UEH6LwUprDbGaeySl2evywADuHfiLhxAh8NMm9X6kZGKnlS0wc7t9pzs5+1I
         n36dXWFVeqArXAMHnszjUuAaaU5jYJQ1bi84viM4xbg1fFdvfg1RusDU7xkrcZd1pmQD
         AOzMwK2e1HHJTbIM6A7+NU8GseZHNXDq5JifR8EE+AQvua/CpctjT6Xhsky/MarB9duW
         LQDA==
X-Gm-Message-State: AOAM531MFseoNHC6C7C0Sq5ibeke2jMYooQIaVRZKXJrAEZBQ/BloWOm
        EppnO6Ii7XkoPTHn2Wps2Osiornc59Y=
X-Google-Smtp-Source: ABdhPJw/L2+d6Xr9HETkqO1LGhWqS1+cc8v5oocRiX+MmEsd+l0ojP2DMpl/z0hb4SpnRtKL63/K6g==
X-Received: by 2002:a5d:5582:: with SMTP id i2mr8879722wrv.442.1642888564469;
        Sat, 22 Jan 2022 13:56:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24sm8659319wme.17.2022.01.22.13.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:03 -0800 (PST)
Message-Id: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:50 +0000
Subject: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note1: Depends on en/remerge-diff (but no need to pick it up; it's still
RFC).

(Note2: This is a continuation of my series at [0], but I can't change the
base repository for a pull request in GitHub so I had to open a new PR and
that makes it look like a new series. [0]
https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com/)

== Basic Summary ==

This series introduces a new mode to git merge-tree allowing it to perform
real merges (three-way text content merges, recursive ancestor
consolidation, rename detection, proper directory/file conflict handling,
etc.) and write the result as a toplevel tree. It doesn't touch the working
tree or index, and doesn't create any commits or update any refs.

== Updates Log ==

Updates since v2 (thanks to Christian, Dscho, Ramsay, and René for
suggestions and comments on v2):

 * Significant changes to output format:
   * Flags no longer take a filename for additional output; they write to
     stdout instead.
   * More information included by default when there are conflicts (no need
     to request it with additional flags, instead flags can be used to
     suppress it).
   * Provide (mode, oid, stage, file) tuples -- i.e. ls-files -u style of
     information -- when there are conflicts. Add a flag to only list
     conflicted files if that's preferred.
 * Much more thorough manual for git-merge-tree.txt
 * Renamed option from --real to --write-tree
 * Accept an optional --trivial-merge option to get old style merge-tree
   behavior
 * Allow both --write-tree and --trivial-merge to be omitted since we can
   deduce which from number of arguments
 * Document exit code when the merge cannot be run (so we can distinguish
   other error cases from conflicts)
 * testcase cleanups: test_tick, early skip of test when using recursive
   backend, variable renames, etc.
 * various minor code cleanups
 * Add a new --allow-unrelated-histories option (with same meaning as the
   one used in git merge)
 * Rebased on top of en/remerge-diff to avoid a small conflict

Updates since v1 (thanks to Johannes Altmanninger and Fabian for suggestions
on v1):

 * Fixed a bad patch splitting, and a style issue pointed out by Johannes
   Altimanninger
 * Fixed misleading commit messages in new test cases
 * Fixed my comments about how commit-tree could be used to correctly use
   two -p flags

== Other notes ==

Stuff intentionally NOT included, but which others seemed to feel strongly
about; they'd need to convince me more on these:

 * Any form of diff output[1]
 * A way to omit printing the generated tree hash[2][3] In regards to these,
   also see also some of the new info in Documentation/git-merge-tree.txt,
   namely the expanded paragraph on "the second form is deprecated" in the
   description as regards diff output usability and performance, and also
   the final paragraph of the new "Mistakes to avoid" section in regards to
   tree hash.

[1]
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet/
(section starting with "Providing a tree") [2]
https://lore.kernel.org/git/CABPp-BHvXrP0sTTmuTYfACoJTCcm9+wk_f441nj4TstrmQdqMQ@mail.gmail.com/
(sections starting with "avoid printing" and "Where did I suggest") [3]
https://lore.kernel.org/git/CABPp-BGdbh=HM7jA+_RTwSWVcMr_qvEY7RoNXooeBT2NB4Ubzw@mail.gmail.com/
(section starting with "Providing a tree object")

Elijah Newren (12):
  merge-tree: rename merge_trees() to trivial_merge_trees()
  merge-tree: move logic for existing merge into new function
  merge-tree: add option parsing and initial shell for real merge
    function
  merge-tree: implement real merges
  merge-ort: split out a separate display_update_messages() function
  merge-ort: allow update messages to be written to different file
    stream
  merge-tree: support including merge messages in output
  merge-ort: provide a merge_get_conflicted_files() helper function
  merge-tree: provide a list of which files have conflicts
  merge-tree: provide easy access to `ls-files -u` style info
  merge-tree: add a --allow-unrelated-histories flag
  git-merge-tree.txt: add a section on potentional usage mistakes

 Documentation/git-merge-tree.txt | 182 +++++++++++++++++++++++++++++--
 builtin/merge-tree.c             | 178 ++++++++++++++++++++++++++++--
 git.c                            |   2 +-
 merge-ort.c                      | 109 ++++++++++++------
 merge-ort.h                      |  30 +++++
 t/t4301-merge-tree-real.sh       | 163 +++++++++++++++++++++++++++
 6 files changed, 603 insertions(+), 61 deletions(-)
 create mode 100755 t/t4301-merge-tree-real.sh


base-commit: ea5df61cf358d3c831189e2f04863abc2157e3e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1122%2Fnewren%2Fin-core-merge-tree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1122/newren/in-core-merge-tree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1122
-- 
gitgitgadget
