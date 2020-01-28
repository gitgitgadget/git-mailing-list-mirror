Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF70EC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2825207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knc7GxOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgA1OlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:11 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52192 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgA1OlG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:06 -0500
Received: by mail-wm1-f50.google.com with SMTP id t23so2810098wmi.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ushP40t+c+M0lMsID0Pu1bbzzcO5aspSvxPQEVOnbNI=;
        b=Knc7GxOWkEhibrozQgmS/bGAB7WBubo3aT4IBfEjQiqJwhBbMgQ721MeH4FQTaDSvc
         qrS7L7+N8L3SRH91Vv1UQzANqOzZMEtDYLppikI+y2Wu77KxWDQSMeekBqLDuMrwoOr2
         D+siYVMKZXU+D67lT29b5P6M1QOlEhyZiZT7w4nhx06nThCisC99DX97wtcHae3dswl3
         aS5YVF/QYBv7AkPW5JIktQA/nWUJ+uHzK3U6xoRUgXLxd5O6V/8/aQSHZ6EY59nXq+Mj
         xeVttImZzIMceq7LEqfS4irdmGvOhxdDAV46bGzli1fi/4mbwbxvT2Pwy9daLgGCKQEy
         OClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ushP40t+c+M0lMsID0Pu1bbzzcO5aspSvxPQEVOnbNI=;
        b=KN1s3GEkgZ+UhceaMa85dBEdoUoyEls1feP+mlUrMoJNnCSBoVb5yktpORWiIAxIiW
         G/6B5e91jYsMSgB4auK0J8Po64g7Cu64UiEaJe6RMo719FfjCKbroUwuoDla715QDmzK
         Gnt19/I7N4i8Jy/wi1oWqyxHQaPfUafDyBlOZA60TrIMxFiwPEtFO2LaYb6h3XaZqmAx
         SA7kznUH9HTS/ntY4l1wKWaczhhCgrPub35U3W6xF1VNrNRTtW97Sl/CyPy4DLr6X9fV
         ZjZ03B8RkCjNNhrocBqCTg0o2tdTxToSBfcouemGVdIoub/oN1poL/qDGXrVuK6/kUbg
         WCjA==
X-Gm-Message-State: APjAAAUkTWDqaVYLRvFe3JA5qGMIT3CSfBAxwcQ/C3IOfDje63bD6Ng6
        lTsyWaMNnW48Qmd+kXfK6fadQahr
X-Google-Smtp-Source: APXvYqweDsqgzPobzdIRkESQXt1qsDL/yJKZgspQqXSTkYmeULsbOZB4lCKjXNYjxXYP+HedgpCEYw==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr5604133wmb.33.1580222464322;
        Tue, 28 Jan 2020 06:41:04 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:03 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy][PATCH v2 00/11] Finish converting git bisect to C part 1
Date:   Tue, 28 Jan 2020 15:40:15 +0100
Message-Id: <20200128144026.53128-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a first part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by the interns Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by Miriam Rubio.

This first part are formed of preparatory/clean-up patches and all 
`bisect.c` libification work. 

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part1

It has to be noted that in this version 2 nothing has been done about a 
reviewer suggestion of using enums for error codes, because there was no
consensus about using them by the reviewers.

--- Changes since v1 Finish converting git bisect to C part 1 patch series ---

General changes
---------------

* Previous patch series version has been split in smaller groups 
in order to facilitate revision and integration.
* Rebase on master branch: c7a6207591 (Sync with maint, 2020-01-27).
* Improve commit messages.

Specific changes
----------------

[6/11] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` 
and its dependents
    
* Remove redundant sentences in commit message.
* Use `if (res < 0)` instead of `if (res)`.

[8/11] bisect: libify `check_merge_bases` and its dependents

* Remove redundant sentence in commit message.

--

[9/11] bisect: libify `check_good_are_ancestors_of_bad` and its 
dependents

* Remove redundant sentences in commit message.
* Return in `if (!current_bad_oid)` condition.

--

[10/11] bisect: libify `handle_bad_merge_base` and its dependents

* Remove redundant sentence in commit message.

--

[11/11] bisect: libify `bisect_next_all`

* Remove redundant sentence in commit message.
* Add return codes explanations in `bisect.h`.

--

Miriam Rubio (2):
  bisect--helper: convert `vocab_*` char pointers to char arrays
  bisect: use the standard 'if (!var)' way to check for 0

Pranit Bauva (7):
  run-command: make `exists_in_PATH()` non-static
  bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
    its dependents
  bisect: libify `bisect_checkout`
  bisect: libify `check_merge_bases` and its dependents
  bisect: libify `check_good_are_ancestors_of_bad` and its dependents
  bisect: libify `handle_bad_merge_base` and its dependents
  bisect: libify `bisect_next_all`

Tanushree Tumane (2):
  bisect--helper: change `retval` to `res`
  bisect--helper: introduce new `decide_next()` function

 bisect.c                 | 136 +++++++++++++++++++++++++++------------
 bisect.h                 |  23 +++++++
 builtin/bisect--helper.c | 118 +++++++++++++++++----------------
 run-command.c            |   2 +-
 run-command.h            |  11 ++++
 5 files changed, 193 insertions(+), 97 deletions(-)

-- 
2.21.1 (Apple Git-122.3)

