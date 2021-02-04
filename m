Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A8C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C17064F10
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbhBDTG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbhBDTGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:06:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3AC0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:05:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id j2so2802863pgl.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erHVNnSmemVvRVjNvdOdj/PfE3ik1TunPqZCONfVu2g=;
        b=BRqSTve2HK6BVK1X1pz6kTvageKn/7DfrrxuHAtketAMxrkrEimFe0v8oNYQxXGO1G
         xMcYzfrvf3ZnW4hASOYVZH2isGDSN7pgVftlmRvtvb3RK8WeUlJvJqRS5pU9TQ6ODZfA
         NKvjTi52aBvUh9Sls/B1AORFEuW/2IV++yd/fcUwL/wx4C3qz0/l/AQyOSEjnAlopvEF
         JK5TCkdDz3Lo6K4Ytnp+PRbzHqsPG8skPy0Lt+t6g03iDph6QLVXhPKIHNOW7Tr/T1j2
         ipk4of6HbYZGT1UpjjITceCXvtGQmJIvMS0M2Ro2sBQP2xTGkWyvdPYAGFxf6qUZJ626
         rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erHVNnSmemVvRVjNvdOdj/PfE3ik1TunPqZCONfVu2g=;
        b=OFz6a92kUzdwKFTRRyDcte8ONOJMkPTv36cLs4Dl+QLQJnGS6ZkGujkGMEyanZ3dBN
         ph9XzGVlbP1shE/LgFb6LplKw4K2M64JvDhaJu7jIEjz8YwrZiw/QCq5O3ALFNS595mk
         zdWWPj403a4v1Sv6/0UXdvsQCRf7u+oY+ScYWdpOteqKWWIJS27iI0Akih12T8kiC411
         NOyS9YbS4R0ql/QKOhkCNbPp+V6p5F3vVd9p9FQ5+1h+70R6BecGmG/sjsncv+3QryFs
         BFGHvlzmlsCI03220KDigskfxI6HTgmfPmw1oi/Wjgbh9gBClS/0BdyUXS2cLTIi0zSK
         QP4A==
X-Gm-Message-State: AOAM533aUuUzzeYTVmBTKLZqKd0NBU2GsZYvys/EBxUodrp5g1dZxIsH
        v8pmvAookKL81h3zHkisuShkSF2QcXJieg==
X-Google-Smtp-Source: ABdhPJzQsajRENBmCZgfTYJD1mEZFhgPwhDyJ8uYY1Haw9W5LAMJ6qqJWT1DVnvNAgOOvtxnzHYkbw==
X-Received: by 2002:aa7:86cb:0:b029:1bc:775:343f with SMTP id h11-20020aa786cb0000b02901bc0775343fmr877803pfo.54.1612465530081;
        Thu, 04 Feb 2021 11:05:30 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:05:29 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
Date:   Fri,  5 Feb 2021 00:34:59 +0530
Message-Id: <20210204190507.26487-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds fixup [-C|-c] options to interactive rebase. In
addition to amending the contents of the commit as the `fixup` command
does now, `fixup -C` replaces the commit message of the original commit
which we are fixing up with the message of the fixup commit.
And to edit the fixup commit message before committing, `fixup -c`
command is used instead of `fixup -C`. This convention is similar to
the existing `merge` command in the interactive rebase, that also supports
`-c` and `-C` options with similar meanings.

Also, `fixup -C` is intended to support amend! commit upon --autosquash
and it's working will be added in another patch series with the implementation
of amend! commit.

Changes from v4 :
(Thanks to Eric Sunshine, Christian Couder and Phillip Wood for suggestions
 and reviews)

The major change in this version is to remove the working of `fixup -C`
with amend! commit and will include in the another patch series, in order
to avoid the confusion. So there are following changes :
* removed the patch (rebase -i : teach --autosquash to work with amend!)
* updated the test script (t3437-*.sh), changed the test setup and removed
  two tests.

  Earlier every test includes the commit message having subject starting
  with amend! So, now it includes a setup of different branch for testing
  fixup with options and also updated all the tests.
  Removed the test - "skip fixup -C removes amend! from message" and also
  "sequence of fixup, fixup -C & squash --signoff works" as I think it would
  be better to test this also in the branch with amend! commit with different
  author. (Will add these tests with amend! commit implementation)

* changed the flag type from enum todo_item_flags to unsigned
* Removed amend! conditions from sequencer.c and
* Replaced fixup_-* with fixup-* in lib-rebase.sh
* fixup a small nit in Documentation

Charvi Mendiratta (5):
  sequencer: pass todo_item to do_pick_commit()
  sequencer: use const variable for commit message comments
  rebase -i: add fixup [-C | -c] command
  t3437: test script for fixup [-C|-c] options in interactive rebase
  doc/git-rebase: add documentation for fixup [-C|-c] options

Phillip Wood (3):
  rebase -i: only write fixup-message when it's needed
  sequencer: factor out code to append squash message
  rebase -i: comment out squash!/fixup! subjects from squash message

 Documentation/git-rebase.txt      |  13 +-
 rebase-interactive.c              |   4 +-
 sequencer.c                       | 270 ++++++++++++++++++++++++++----
 t/lib-rebase.sh                   |   8 +-
 t/t3415-rebase-autosquash.sh      |  30 ++--
 t/t3437-rebase-fixup-options.sh   | 133 +++++++++++++++
 t/t3437/expected-combined-message |  19 +++
 t/t3900-i18n-commit.sh            |   4 -
 8 files changed, 425 insertions(+), 56 deletions(-)
 create mode 100755 t/t3437-rebase-fixup-options.sh
 create mode 100644 t/t3437/expected-combined-message

--
2.29.0.rc1

