Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14BC433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6706F2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpJr+jI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgGZO0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZO0K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 10:26:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85646C0619D2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a23so7701617pfk.13
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AqctvIVBAJrQVFUfuYAWZcPb+Z3k8ZfyiHWkSAt2hs=;
        b=fpJr+jI41xvXdmdPcPrPPSn3Uhy2/yE3shz6dLhyYsnqmcY31JBBuBYtXSkYHbbz7c
         TXaY+t/2hXh63o+7K1yn0TcK1OdQQejLTvdqembq8Fxwy4VilaNn04cQO9pOZN6Uht/n
         uZya2lLYT5tFUzL9uyXai9MQMzEA6k3DlvaS93wAMOH3WBxygO3lVeScEh4FZMNqqA94
         8YEnnLU87SNPaf7UdmAsdAONtLZtXm4vRKqRJXyAaPZGgxp1aPqYU2COwbsm7iaBw1EW
         XWLQEmuEmFCSykJrJRtsbZT1JIOLyln9P4mKNwMiviE0qfVrvp9+70Ed0xreS3x+5GP6
         woLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AqctvIVBAJrQVFUfuYAWZcPb+Z3k8ZfyiHWkSAt2hs=;
        b=tj1x8dadAbcaFzQgs7Tttw8OJ1HNri8jNciM3XLZfCh92FyywRDoG5Tt/L53+qCYAU
         6yC5I56GJHWR4eqqvqJWboJx3rb5TZt8RTU9VM3mZ3c05iRqlBn4qXrQNeCD9DR3qe0M
         Pzz+KlYyGdJ6b1lrNyi618qR6NMjveY+spyzJG1AL30EUJr7D0BDWNQg9YfHeLZVQ3mf
         +FxOf/lDa0jlIdebtNG0r9o3uY+yFnBr/Jc4sJy5NF1tc43RKxJJnIoFD8RM8GAjEJbV
         qlFbez8WupqVTCg0cbcZG51Isz1OWTgBK1wst/wEX40MBm7yMXmrpMbwegAbpePHdkZl
         HPYw==
X-Gm-Message-State: AOAM531LSPWMtcmQnQVxqBQUBqm12tzhwWEGA608esPebYAS8J3YkeDq
        O0t2wHOG6wRWkWsRb5KAF6Lk/Q85qEE=
X-Google-Smtp-Source: ABdhPJyhKhyofN8X+0EmUWt5TebQmNuAGru2BzI0nXZm/an90T4ZVCpGbqk/Rq6Wg/BvPNbj9DlIYA==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr1595384pfl.237.1595773569420;
        Sun, 26 Jul 2020 07:26:09 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.48])
        by smtp.gmail.com with ESMTPSA id p11sm11278908pjb.3.2020.07.26.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:26:08 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH 0/4] t7401: modernize, cleanup and warn
Date:   Sun, 26 Jul 2020 19:55:49 +0530
Message-Id: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

The current phase of my GSoC project involves porting
'git submodule summary' from shell to C. While doing so, I, along with
my mentors Christian and Kaartic noticed some discrepancies in the test
script when trying to add a couple of tests to it. Though the test works
perfectly for my C port of 'summary', there were some unexpected behaviours
when trying to some tests to it. This patch series addresses these
issues in the test script by modernizing it, cleaning it up and warning
about some other issues.

Chiefly about patch 4/4 (t7401: add a WARNING and a NEEDSWORK),
when trying to write a test for verifying the summary output of
deinitialized submodule, doing a 'git submodule deinit <path>' did not
bear any fruit since the submodule never really got deinitialized. 
The deinit documentation states that:

	Unregister the given submodules, i.e. remove the whole
	submodule.$name section from .git/config together with
	their work tree.

Something which was not actually happening in the test. It appeared
that the reason for the deinit issue is that the test script uses
'git add' to add submodules instead of the command 'git submodule add'.

This behaviour also prompted the need to design a new test script to
have a testing of some niche cases such as those stated before, but
this is something that will be covered in the patch series responsible
for porting the 'summary' subcommand to C.

Comments and reviews are appreciated.

Thanks,
Shourya Shukla

Shourya Shukla (4):
  t7401: modernize style
  t7401: change test_i18ncmp syntax for clarity
  t7401: ensure uniformity in the '--for-status' test
  t7401: add a WARNING and a NEEDSWORK

 t/t7401-submodule-summary.sh | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.27.0

