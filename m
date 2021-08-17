Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F7C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7A060F22
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbhHQIQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbhHQIQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:16:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD828C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f5so27239313wrm.13
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXe1BggZmspd+qvJSOW50NcSNGFu0oWtf0+8z2b8Eys=;
        b=uN9lfDT0SCHouk4R6D+c5mjpAvr5LwdRT2FqdvbySdq2uWnqhTYTl/oX69etbBAUzk
         gUcoWyC4GnD+bELdUZUTh5wwqff13LgJXAxp9pXQ3mrAP4irUrQMH6wljVzKQQGUYZz0
         C+IH7iveye4RFnPYGFaZuB7BbfcORtFRSXlsPaeNO9La3CbfJ32SjLm3r/ZTyKDC8cic
         7v7bdMSafYYbgmTN95yWNXq3PvRXdKbO4ZzXIkb13v527VxYLXNDv5jra+UIuCBGqo41
         TMAHzWRnaQF53YIXsP9MgU4TeveGh/D9SFic57jolyTxwxNW2YgPUuU29ve0Rr5YgVve
         YpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXe1BggZmspd+qvJSOW50NcSNGFu0oWtf0+8z2b8Eys=;
        b=exkPP50RyQjLCW0iPR8MTPv7+8y92RTmJeLc5XxLGRs8Of9YehlLQn73iVVjwy7bL2
         xEuaW+7KQJ+Mfxc7fYrkJCHoRedRFH7Zb1MnkRbuHOPoLAxXR9TV8tEz8FUk1xCuhkYh
         gGtav4ko+go1vJ4M1tjJUdyqbXVTEpMBT7O+Uu1NKW2HEO3T/hVD7yDefD/iayKWMfiS
         mZC8cLB9fye6HbYI2xfJsIhp3x14BpNXDIcTjmwcrPDEywVTD2xBu5zo3relUJhfN0+Q
         1i5L3dJITz80/qzjDJyD9oOkfNqVNradOlydzZIm+AH6E4UnPEznLlDnGgi1oIE7lFYg
         NDLw==
X-Gm-Message-State: AOAM530BgMHe8ErOIf+LsEfEq32peYNE02cQevF7sp/3zqbU9DA3HI7w
        kQoBmwxqONEbP/SvmjCO9h8lV/rM4Oc=
X-Google-Smtp-Source: ABdhPJwm+WyLhvQ19Cvb4jFY5Fga888BkBFOl+ZbIgu1eJEV5OQYF0zduaewJdTmCGlYA+YwzUQt0g==
X-Received: by 2002:adf:f943:: with SMTP id q3mr2513137wrr.118.1629188152448;
        Tue, 17 Aug 2021 01:15:52 -0700 (PDT)
Received: from localhost.localdomain ([178.237.233.111])
        by smtp.gmail.com with ESMTPSA id l21sm1256238wmh.31.2021.08.17.01.15.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:15:52 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 0/6]Finish converting git bisect to C part 4
Date:   Tue, 17 Aug 2021 10:14:52 +0200
Message-Id: <20210817081458.53136-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a fourth part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This fourth part is formed by reimplementations of some `git bisect` 
subcommands, addition of tests and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v4.1.

I would like to thank Junio Hamano, Andrzej Hunt and Christian Couder 
for reviewing this patch series.


General changes
---------------
* Rebase on master branch: 5d213e46bb (Git 2.33-rc2, 2021-08-11) 
to include latest updates in bisect-helper.c file.
* Add three tests requested by reviewers in v3 patch series in 
t6030-bisect-porcelain.sh file.

Specific changes
----------------


[5/6] bisect--helper: reimplement `bisect_run` shell function in C
* Content of the BISECT_RUN file is shown to the user.
* Use strvec_push() instead of xstrdup().
* Fix a bug on previous patch series regarding to 
BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10) return code.

---


Miriam Rubio (3):
  t6030-bisect-porcelain: add tests to control bisect run exit cases
  t6030-bisect-porcelain: add test for bisect visualize
  bisect--helper: retire `--bisect-next-check` subcommand

Pranit Bauva (2):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: reimplement `bisect_visualize()`shell function in C

Tanushree Tumane (1):
  bisect--helper: reimplement `bisect_run` shell function in C

 builtin/bisect--helper.c    | 130 +++++++++++++++++++++++++++++++++---
 git-bisect.sh               |  87 +-----------------------
 run-command.c               |   2 +-
 run-command.h               |  12 ++++
 t/t6030-bisect-porcelain.sh |  21 ++++++
 5 files changed, 158 insertions(+), 94 deletions(-)

-- 
2.29.2

