Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92784C433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FE62073E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfVCKDd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgHERyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgHERtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:49:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD483C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:49:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so24889523pgq.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AqctvIVBAJrQVFUfuYAWZcPb+Z3k8ZfyiHWkSAt2hs=;
        b=DfVCKDd4uan6hElUjz0271zdd4cnAntMao7F0M2AEherwxzR5lUhtWcPSRzay2VbM0
         DhcvABnCjF0Udoido+yz55eF11rIfpfoOO4BQ4t5u4xxgd5HMTJ6N/iUV0oBR3ABaHeQ
         jWC6qa3v9YOMrVWTeWNe8fm++odX5TcsvxXrIv006/3ZZce6GgOJLd1+3eHm4w9N9cIG
         2jRcC0o65JGiI+pQ6SBsfmdmqGql+knote/QBdTXJjaGWug2RE3D7jH5S2ld1bV8Yj/1
         +A+BmORWhY7Vvlny5Y8pYHe+4zNcMRb5EHyFELw/J1icHAHqGmyEnYiM8RLs1OvgHcHJ
         A2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AqctvIVBAJrQVFUfuYAWZcPb+Z3k8ZfyiHWkSAt2hs=;
        b=NXQLxj/mgXET/JxKNCgi+LhzU9HtmUxxL3u2N1G1mMNrYCunSyzt0kEiWQ0dFHiarZ
         Sb5/3G/PDEqRuJMrqp/oCv7iVqNH0c7g6VTFamVZn7O4TCB+eQwNhWP0dvqOgGfLZlSo
         Ss7U34t9CgTrz0qmgxenrA9ZAbmOP7o3tmK/OECX9AZzsoWTgK5YF51nyMZKVn9YboSs
         kbwifFS3EBUajV6UM63TXfQ9OpysebxrTdNUjuuiTRhDC1g4/6riHg7WtYxYMQOAVido
         NOHzBbBSCX3S864/D9MainWb64O/6GLP8ud9k/+EZe4syWyuQo8lgkcd5ocYGS4c91R4
         QkHw==
X-Gm-Message-State: AOAM532zIiYaLNZ3QBLPY5lcgHtkJ1RnIB+T6FwLgbktVFv1kvBumO7t
        1y8YhkPF9DEwpWxLxI0C4xe/N2fRnd8=
X-Google-Smtp-Source: ABdhPJwHaMnrpxGA09UQ6NxhrYlesnsSByE6kPC38vFBD2fQWWR/2Gr1Vt8i+Am046Q8ro88CiBOyQ==
X-Received: by 2002:a65:68c3:: with SMTP id k3mr4035900pgt.14.1596649785523;
        Wed, 05 Aug 2020 10:49:45 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.185])
        by smtp.gmail.com with ESMTPSA id z77sm4765150pfc.199.2020.08.05.10.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:49:44 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][RESEND][PATCH 0/4] t7401: modernize, cleanup and warn
Date:   Wed,  5 Aug 2020 23:19:17 +0530
Message-Id: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
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

