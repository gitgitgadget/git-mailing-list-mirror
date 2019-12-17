Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D2C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3417207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5PO06tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLQMBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:44 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:37204 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLQMBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:43 -0500
Received: by mail-pj1-f47.google.com with SMTP id ep17so4487988pjb.4
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0p94IZUG0C0bzS62Y70cNz/smXkhogMJ741qZhgEOE=;
        b=f5PO06tmKr5tNYUsgUMsJcOXhsuGns3Jsts/LaZWp5s5mFMEhYS872RfftE+zILsF7
         3s+MOU6xfs5g5oX1v7ikLN+MgxDlAwiR3GwIawcu8zYoZ7gsfmXKuU5zAovfyUPHtZWF
         IVqZJ2lqBxfG/m2NDAfpSIK6aMiqMk3R+N2J93vtfkyFyli8qegEx+IhIq6kvPkWUDJU
         2rr+0tNQxQsTGukdjpmyMKJ19BYi1OCIdv+WRdIlkS2reoywOE370DQ3oPKWV/zZqUzP
         VQ/CRsV3haCoD1P0t5CAq2Jq4eh5SOGgKzqaVtNrE+0cahzbQ7KB9E0yuReD262urHDy
         AdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0p94IZUG0C0bzS62Y70cNz/smXkhogMJ741qZhgEOE=;
        b=A9G7npQ65dni31/mdqLTK296+7bdHlXnLT2nQL2hz2Dr7e1OSebvsFkHTMjkruBDNP
         jYZWf32ptYNVhmc8ftFuu/sHhJpOHovo5RHoIM7mdhYoK6eWJbZZkkCwcGUihumfAcA5
         SLxp5WG5bQfslf70D7bE7ssRACj8HF2hLjFi84bJPolE+h23oIUTF0Tc6rXwMsp70srS
         MjDAqM70L4bYZ8EA7YBBnl7orkNjacFM+ABIC0EGMKWqMx7zxzZgaKDETCJsQP6LdGF9
         XKHHUlnRfBe1gN5KLtnKE1/JwZ7Y6zTxml9bI2G+1G5xuZx8+c2i6qco4878d4H9GwLS
         y6XQ==
X-Gm-Message-State: APjAAAXxOeIgBJAO+nRKcRKfUroMqOT+juhqjnZvaIdYb8nahX/t5StC
        1/agtPstzztY9l1U2bPGBWZuAtjM
X-Google-Smtp-Source: APXvYqysrVTQgB8tOmHMrBgpK5at8WopIRgf7tpSdzLdTk4ZZxb+JLisihYnl7UuCwm8k/Hn+zhY0w==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr5557462pjn.60.1576584102913;
        Tue, 17 Dec 2019 04:01:42 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:42 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 00/15] t: replace incorrect test_must_fail usage (part 1)
Date:   Tue, 17 Dec 2019 04:01:25 -0800
Message-Id: <cover.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the first part. It focuses on t[01]*.sh and also t/lib-git-p4.

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2

Denton Liu (15):
  test-lib-functions: introduce test_non_git_might_fail()
  t/lib-git-p4: use test_path_is_missing()
  t0000: replace test_must_fail with ! for run_sub_test_lib_test()
  t0003: use named parameters in attr_check()
  t0003: use test_must_be_empty()
  t0003: don't use `test_must_fail attr_check`
  t0020: drop redirections to /dev/null
  t0020: s/test_must_fail has_cr/! has_cr/
  t0020: use ! check_packed_refs_marked
  t1306: convert `test_might_fail rm` to `rm -f`
  t1307: reorder `nongit test_must_fail`
  t1409: let sed open its own files
  t1409: use test_path_is_missing()
  t1501: remove use of `test_might_fail cp`
  t1507: teach full_name() to accept `!` arg

 t/lib-git-p4.sh               |  2 +-
 t/t0000-basic.sh              | 14 +++++-----
 t/t0003-attributes.sh         | 51 ++++++++++++++++++-----------------
 t/t0020-crlf.sh               | 20 +++++++-------
 t/t1306-xdg-files.sh          |  8 +++---
 t/t1307-config-blob.sh        |  2 +-
 t/t1409-avoid-packing-refs.sh | 16 +++++------
 t/t1501-work-tree.sh          |  2 +-
 t/t1507-rev-parse-upstream.sh | 14 +++++++---
 t/test-lib-functions.sh       |  9 +++++++
 10 files changed, 77 insertions(+), 61 deletions(-)

-- 
2.24.0.627.geba02921db

