Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2AAC433E4
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D4C206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3DHX2bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgGQKyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgGQKyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC02C061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so16372106wmi.4
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGzfAULOohPKJL0QjQG0tZCdflViLp4M/0UvzM1ft0s=;
        b=u3DHX2bTxVpaMOBdJRm2s9vrtNtQN64J7r2COSsZJsgmhLNUmcKj7zAfXdXA7j+lCr
         QXVEXA/Mu2+co/4flem5L34GeblPmxyOhJw2BXnJOtHkI004O4X8w9gx8KN0b/hQSdwK
         N4ItwN+/AO83NZF+gLqzAzklYOaRLAlvFr/sfxi36EX0Ts6mVhvVHQAEs4IAUZuqI16K
         EFyD3OK9mkiyX9oYIgSqQfnX+AIvNw9u2P2/7SgJUMA2G0O8ixkqGDv8q94xBvwz91jH
         qEdqZV/vprY7Ob/LqDFV6I9b72S3M2RSd3QidEGtsn8LH7GCHp7aTVLOE3Ukl2l45NNB
         +PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGzfAULOohPKJL0QjQG0tZCdflViLp4M/0UvzM1ft0s=;
        b=P9utFD+GnO1iMCisx0v+a3zegWG7vDDbYacrUxr7P/xo/eUieuwKiJPl1tt6+MFYgL
         0ycC/qIduoGaJfV4116Dv4VY5TA30ubXEwnv8tuFq00AWhAZfPKZG7ReHCItdmOh8ALC
         XGK5YWkcBBrLnrE+jWjyCbHVvl8l1qPWqr8U6BEYtSxPUmDgEfZeNSA0wnc5ctKqgZt5
         27iXd+eFfBNOlfG/Uiy/1EUtQ4ZF7u4nAq6lJodIX+rA5+26FWlBDB1FIOXKdRPxVKBM
         JFLsssjN3qROnK1gnPl1ZZaFvG9N45IkH/dxl5N6DD4oECqTI3nOJXDL8NrG3AoU5F1l
         FOmw==
X-Gm-Message-State: AOAM530bRIiKvqteUZbqxOrlBM4oYyh/eF+kU+TbAfCrGcJJPBddsLl+
        bl+5jdDuD8ciTU9YQ3y4m3Eczzyf
X-Google-Smtp-Source: ABdhPJwofoCkzm0lUOiizL8G00dE7EgW0TaBKfaVqRIgS2tNdTsD8AL+mko+a9D9UZw9e31HHZoN3w==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr8527826wme.50.1594983273413;
        Fri, 17 Jul 2020 03:54:33 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:32 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 00/13] Finish converting git bisect to C part 2
Date:   Fri, 17 Jul 2020 12:53:53 +0200
Message-Id: <20200717105406.82226-1-mirucam@gmail.com>
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
https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v5.

I would like to thank Chris Torek and Junio Hamano for reviewing
and Christian Couder for his help.


Specific changes
----------------

[3/12] bisect--helper: introduce new `write_in_file()` function

* Fix typo in commit message.
* Change BUG() message.
* Control 'mode' parameter in write mode only.
* Return vprintf error when result is < 0;
* Simplify return in write_terms().

--

[6/12] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
functions in C

*  Add 'mode' parameter control in append mode.

--

[10/12] bisect--helper: reimplement `bisect_state` & `bisect_head` shell
functions in C

* Remove mark_for_removal() function.

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
 builtin/bisect--helper.c | 443 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            | 145 +------------
 3 files changed, 378 insertions(+), 218 deletions(-)

-- 
2.25.0

