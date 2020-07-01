Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55241C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F986206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbIyDhcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgGANfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgGANfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156CC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z13so23868304wrw.5
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/pduDXXAyHdh9gdgOCtUeqQXh+8OMx/RaHB84r9/0M=;
        b=NbIyDhcxGx+X2UMUsnQIJ37F9rtrLrdCBQWG7Nf5TFPtofycQnkur+UfsVqPVERjSB
         MrerXMdXy6RDldWBX61WkJgMa8UcsR/AeWZlgKS1fF7JC/Id7Sh6wQe3RyfXHYdF9SR1
         9NBFduc4dU0LGbpprlznDlexuiqvcy32qqei/zivi7tPCJYU31H4EmX2CQiQc+I+Vh+4
         662osZOOQ1U6uEm6Pzeqew8B+pHJ/Onn3UqK+KQzivjewQvoMEcgVJMHrxgFU7+RREj3
         e2ZZ8vr32HPXfz816iVZzBxM/Laz1rSCl/T8NVfmBdkBFvVb87+s1urblJNZFnPiS2jB
         96gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/pduDXXAyHdh9gdgOCtUeqQXh+8OMx/RaHB84r9/0M=;
        b=GUrbUmZXqvi5jfF2Y3b/dcYywN47INjmaer3TF34yNxNBlcI04qoeY9xm+lJU3QD1J
         xrII4DgDz4RWq/HSH9BtE2s14U6ZIiR1ptoaDlPnV1zjTZdhkUlQsYqvE8AFhLHmLore
         2aBpCZ7Wo1Ij8R7RYSwR8h1HULidASxgx0WIWlAIPhaayiGsZtpfmKan4WRplmVqVhHy
         x3YmFiISIIz2VYrPySDEUgmi+3jMF6TL13Ef4ro+0X93lICVCGC9PVyHOzpv6fHC4Gft
         NrmFeDXMy8tcQjre4LCQNJAV8NA31BRnFBxjFra2cQzU8Tj4PfZB/CD2k3C/QxtsmDXA
         WaBw==
X-Gm-Message-State: AOAM530HF5nG3LSXVKvpSTXYD+okVdw8Xcj08XFDl1lLjLvmFlp9sulD
        TsICmFLixC68mEQuRDojSbLTe/OwSxQ=
X-Google-Smtp-Source: ABdhPJzECipl/qxQN3gqrazkcn5SUxRrEJLiSSK1UCRNVaBDr/0qJTusvKScJGwZhqX9UO5TzVeqLA==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr26521172wrw.111.1593610529958;
        Wed, 01 Jul 2020 06:35:29 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:29 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 00/13] Finish converting git bisect to C part 2
Date:   Wed,  1 Jul 2020 15:34:51 +0200
Message-Id: <20200701133504.18360-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v4.

I would like to thank Johannes Schindelin for reviewing this patch series
and Christian Couder for his help.

General changes
---------------

* Rebase on master branch: f402ea6816 (The fifth batch, 2020-06-25)
* Improve commit messages.

Specific changes
----------------

[3/12] bisect--helper: introduce new `write_in_file()` function

* Add a wrapper for "w" mode.
* Adapt calls to new wrapper.

--

[4/12] bisect--helper: reimplement `bisect_autostart` shell function in C

* Add file_is_not_empty() function and call.
* Change fprintf to fprintf_ln.
* !isatty(STDIN_FILENO) returns 0 instead of 1.
* Change bisect_autostart() return implementation.
* Move bisect_autostart() previous header declaration to patch [6/12].
* Change some error and user messages.

--
[5/12] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'

* New patch splitted from [6/12] patch.

--

[6/12] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
functions in C

* Add struct add_bisect_ref_data.
* Add wrapper append_to_file() and adapt calls.
* Remove register_good_ref() and prepare_rev_argv() functions.
* Add add_bisect_ref() function.
* Reimplementation of prepare_revs() function.
* Include process_skipped_commits() code in bisect_skipped_commits().
* Use lookup_commit_reference_by_name() instead of lookup_commit_reference().

--

[7/12] bisect--helper: finish porting `bisect_start()` to C

* Amend code comments.
* Add is_bisect_success() function and call.
* git-bisect.sh: merge with master changes.

--

[10/12] bisect--helper: reimplement `bisect_state` & `bisect_head` shell
functions in C

* Remove bisect_head() function.
* Add mark_for_removal() function.
* Reimplement bisect_state().

--
Miriam Rubio (4):
  bisect--helper: BUG() in cmd_*() on invalid subcommand
  bisect--helper: use '-res' in 'cmd_bisect__helper' return
  bisect--helper: introduce new `write_in_file()` function
  bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'

Pranit Bauva (9):
  bisect--helper: reimplement `bisect_autostart` shell function in C
  bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
    functions in C
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 bisect.c                 |   8 +
 builtin/bisect--helper.c | 452 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            | 145 +------------
 3 files changed, 387 insertions(+), 218 deletions(-)

-- 
2.25.0

