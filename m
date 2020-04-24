Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5683C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D30F20728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4RI2Yx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDXWfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWfw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:35:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1FC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:35:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so13119646wrw.7
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lWMN2hT5ewhxVGqssT9xXyYHlaQ94Q2hjy4bWA0u6Qw=;
        b=f4RI2Yx+Kzdot44udA45+9Ja4uOImiDj3RUm706D4ULDaupXu0R3gP8Yhd/cl9VOeF
         39S+sh6JSpuQcRwO04lUKZyhxQXlqr3OqORAjL0olerxb8/J0AUKR7VB1qq4REeNMkwB
         9Zb0EIU3dkQ0NtGNbqQUrrmq8uEgmkaQAMYfNCOk2tw4g7MHXUjYzutgCDx9Vqjw0ISH
         BJvCLvwgt38rX5c1Aj1ovXWU2/kEfqMr0aOIW08v63RYrbGkzVa63V9ZcfVBYkhl1kGK
         Tbzy8Xtneh286qzOiQoX6j3vfbvGripMxUXTqzhvcY4EpdwHoRTNgabcqtTFPrTuVOaz
         wvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lWMN2hT5ewhxVGqssT9xXyYHlaQ94Q2hjy4bWA0u6Qw=;
        b=VR2cojQl/XE08fd0MZkRy2eXAVlF8Z4mdvm0iCrlf25uJzbjRGizeqhhL9h7BDGBXQ
         F5Cu+m5MTENbEEamw0/l2XeuC589gBv0BryxMiMaxVmgjE0miZlO7VKCxVPrByKZJotI
         wi4m9Qh7L10wKq12IPL60xlZkNiPQb38ETbFSu3KlbcDdHE7mUghDhASPBXfoSraihiP
         jJdXfDq1s9tzZEdk1X6YX0D+xOCYvydvA8yVdZyBv8mclrqnX3jeOELeCB5qT7CT062q
         wzUJxLi3bp/YSlrdhuDzLnd3xt4M/x1an2GPVvBW6yWVhxKNtqAMCpz/PuT5vltz9V7d
         8h8Q==
X-Gm-Message-State: AGi0Pub2yno2OuR4D5w7l5bX1DfgxV6Ewz2md3U7NmlrkQ9zzX7AcXlx
        aUc0OHF934Aqx206hP7j4dg125sA
X-Google-Smtp-Source: APiQypJLFJoXnTkvQhoohU1N/buPxeKuOlxnQludLf4btSvih4UZyGlTxgAmBzYHyz+47Nh8PDlhCw==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr13513595wrr.299.1587767750570;
        Fri, 24 Apr 2020 15:35:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm4473593wmi.32.2020.04.24.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:35:50 -0700 (PDT)
Message-Id: <pull.620.git.1587767749.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 22:35:47 +0000
Subject: [PATCH 0/2]  credential: handle partial URLs in config settings again (master)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a companion patch to https://github.com/gitgitgadget/git/pull/615,
but targets maint instead of maint-2.17: There is not really a good way to
get those patches into maint by merging because the final patch looks quite
a bit different by necessity (after 46fd7b390034 (credential: allow wildcard
patterns when matching config, 2020-02-20) the urlmatch machinery is
supposed to handle credential.<url>.* config parsing).

IMHO the easiest strategy would be to apply these patches on top of maint,
then merge the other patches on top of maint-2.17 with -s ours.

Note: typically I do not send GitGitGadget PRs before the builds finished,
just in case that I did something really stupid that breaks plenty of tests.
However, in this case, I figure that y'all want to see them patches early,
and I can't wait for the build to finish because I need to get some rest,
like, right now.

Johannes Schindelin (2):
  credential: optionally allow partial URLs in
    credential_from_url_gently()
  credential: handle `credential.<partial-URL>.<key>` again

 credential.c           | 69 ++++++++++++++++++++++++++++++++++++++----
 t/t0300-credentials.sh | 38 +++++++++++++++++++++++
 urlmatch.c             | 10 ++++--
 urlmatch.h             |  5 +++
 4 files changed, 113 insertions(+), 9 deletions(-)


base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-620%2Fdscho%2Fcredential-config-partial-url-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-620/dscho/credential-config-partial-url-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/620
-- 
gitgitgadget
