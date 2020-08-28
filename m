Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886CC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03675208C9
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1rasNTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgH1MrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgH1MrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7F2C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o21so798751wmc.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEBbLJAUMr1PJRB5eqZ+Zdu4HbEM7yxZqL+yLIS//9I=;
        b=Q1rasNTZ2xHTjxV0m1PGa621j3Q90lNtyHsXRTGk8tY46HNuPTCvKN3NTQhx+RsxjE
         6Qr3vuGjAS1Noly3BGqh+QfkzIle0naXZzC7sXT7m4tb2Rew+M8dtPjq+PVrqMZlVqur
         /1It4XKS/c17+AiFkREk/Y92Cps0yYhBkgRBQ+qFWxyccBd1C6lX+s3X02h2lQOvu+j4
         pjSd0MU5hGqVCJSQkTH3PPArkWKHeVLCQB1JVAhLIllc8DG1pTVv9jfruzFQE7xcaXSA
         c2yb/w4SIQ0vwuT9RF22nD73+uw4UrPaE433BXy8VN4W2agr9tkluDcXI/EkpwgszBHP
         RhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEBbLJAUMr1PJRB5eqZ+Zdu4HbEM7yxZqL+yLIS//9I=;
        b=MnSiJ9Evv89LaB7EYq4xBcH6B3Zi8XQsniSA0ymA+NH60TuGO2uCNiEja6x7NAUw7V
         DlnwVUlwOIryDQmpluvBckaPvw68vKmoFB2gGbzX1yuZr6BsUciMv38oLyq6aHpjM3dR
         iK/wAfodrfxumuY4Oc2Io2L2DyLt9a651XLEADaro3lVTZ5EhR0o/6cT3ZSc7VWmQIb9
         SCdbLqGG4xvXlbht/c/sSgFVx8i76bJ4jnDvj8aKLp+tyx5cLP4sygtVx5RdMRmASQlx
         W66oHBlnWZ9tusraH4xvg2dX8Y1/vjsT8A+qz6n30MNyswdyYsdC35pH2GTunQ0fbZxv
         kgYw==
X-Gm-Message-State: AOAM530T57DpenZU5Llj5fGTXERSL1VL7aMwzNwmXqEc1U308Vp4yNTr
        nC9LhJvt9l9m4sAySpGUMGgziWiV3RM=
X-Google-Smtp-Source: ABdhPJy+yT1eWVeBR31doZygxh5HjSB+x1RAWdKGp4v1Vkbeym7T/EauQjEF83AC7udMLMp0yVcrmQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr1436718wmi.101.1598618829940;
        Fri, 28 Aug 2020 05:47:09 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:09 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 00/13] Finish converting git bisect to C part 2
Date:   Fri, 28 Aug 2020 14:46:04 +0200
Message-Id: <20200828124617.60618-1-mirucam@gmail.com>
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
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v6ps.

I would like to thank the reviewers for their help.

General changes
---------------

* Rebase on master branch: e9b77c84a0 (Tenth batch, 2020-08-24)

Specific changes
----------------

[1/13] bisect--helper: BUG() in cmd_*() on invalid subcommand

* Amend commit message.
* Remove casting to int.

---

[2/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return

* Amend commit message.

---

[3/13] bisect--helper: introduce new `write_in_file()` function

* Use saved_errno variable.

---

[5/13] bisect--helper: reimplement `bisect_autostart` shell function in C

* Fix bug using empty_strvec instead of NULL in a `bisect_start()` call.

---


[6/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
 functions in C
 
* Change `file_exists(git_path_bisect_head())` to a refs API call.
 
---

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
 builtin/bisect--helper.c | 445 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            | 145 +------------
 3 files changed, 380 insertions(+), 218 deletions(-)

-- 
2.25.0

