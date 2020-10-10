Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F69C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EE120795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe4Vx0uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgJJW4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgJJTxO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720FC05BD16
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a72so1878402wme.5
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b23EmFzFsxwo1S2gWctHs5EJQtfiHMxDw6hxTgsP6JA=;
        b=Xe4Vx0uBjIMZ0W58485jDe+sG0IL0/zEIie7TnqHV6ObRPVDWco3kFNgcEwcy4hdeI
         S+JRUKJ7knA1kdOWS8ewYNaDOxzsW358mdU7gMfGLG+oxD4n+z53Had26rZ2+SXgSxhk
         26SoocK2bQnpApNXDR+2Kq+ww46qphjiHgHuyHVyNUet5fGCD9ZLxcHCoEEEbMDKrbd4
         3k6xO4raRnoJLBqDh6h3ACPFvumaZIljYaJZnqdcSISd99YKTAQy/rnwRnJJ3e6oI9Yk
         ISKN0r0M1rD62LF8iotEu7DcDlYsHsaUK2LN5X+0LQCzBSDySHHsTy+eL25uhLXSi9nj
         YZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b23EmFzFsxwo1S2gWctHs5EJQtfiHMxDw6hxTgsP6JA=;
        b=Fu0ynJ5GVIxlk9WXviLoZjtLvvwFwS7VE6jNqYbipekYbdTq70C153MbTUfQo/l6tv
         V2kced82KAZnk8QXeBz+d6zsnjNaDu2S9wYTPMdLPCiYz6HIzpRNUGvQgRK8GSbNK2hM
         pDVO9jSGJVptBJfEDmlwuuKZ5/mIZO91TdvfhKHU5vaAAZnjtciImOdPwvg+diEesDko
         i8VlBC8i51GGdzzuGyXio3SGn4tOLmJgCCWJAMFSKNXBoHo0uB30YXCQjifyx/IUL+e8
         PDbhH07+ru9EKGNVoxzpw+aM7loSKDt/+qft65uTu1RC+0RIMwKBqYeyVj1v6JDvpWWw
         PYqA==
X-Gm-Message-State: AOAM531T23BBwhKnEwS2nc+xtN7wN4YXY702FlL2oXTxfSsnjN0wqPO7
        uvr59A/aM1ugdFXycNjo+4efCM96KW8=
X-Google-Smtp-Source: ABdhPJzr5hfpKeR+QBOtaIOef29mOiEHPJHdqa+Y3LP+44JtqGqkGu64BpOMs9aiW5visuciXGMWcA==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr2916362wmg.70.1602338932834;
        Sat, 10 Oct 2020 07:08:52 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:08:52 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 0/7]Finish converting git bisect to C part 2 subset 2
Date:   Sat, 10 Oct 2020 16:07:36 +0200
Message-Id: <20201010140743.580-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a second part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This patch series version is composed by the last seven patches of part2
set. 

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v10-subset2.

I would like to thank Johannes Schindelin for reviewing this patch series
and to Christian Couder for his advice and help.


General information
-------------------

* Rebased on d4a392452e (Git 2.29-rc1, 2020-10-08) to build with latest
changes in bisect--helper.c file.

Specific changes
----------------

[1/7]bisect--helper: finish porting `bisect_start()` to C

* Add comment in commit message related with `eval` command.
* Remove code comment that does not apply anymore.

---

[4/7]bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
    
* Add comment in commit message related with `eval` command.
* Change some code to convert shell command more faithfully.
* Add call to bisect_autostart() in bisect_state().
* Amend error message.
    
---


Pranit Bauva (7):
  bisect--helper: finish porting `bisect_start()` to C
  bisect--helper: retire `--bisect-clean-state` subcommand
  bisect--helper: retire `--next-all` subcommand
  bisect--helper: reimplement `bisect_state` & `bisect_head` shell
    functions in C
  bisect--helper: retire `--check-expected-revs` subcommand
  bisect--helper: retire `--write-terms` subcommand
  bisect--helper: retire `--bisect-autostart` subcommand

 builtin/bisect--helper.c | 185 +++++++++++++++++++++++----------------
 git-bisect.sh            |  81 ++---------------
 2 files changed, 115 insertions(+), 151 deletions(-)

-- 
2.25.0

