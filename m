Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4659C20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdAWWwi (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:52:38 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34538 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdAWWwh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:52:37 -0500
Received: by mail-wj0-f193.google.com with SMTP id ip10so2868622wjb.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N+/Q1aqkedYn4B9pjG8Zddz2VBsnERKlysukyLaRqdk=;
        b=JWKDPEyESLTjDf2nJvk3aHVHeBcSUe6Vi9UP7nLKT0tk4dI4Ss7VxtavuDgMs0yNA4
         KJj1AnOeizUMABOsT5c1IJpddX5GqEpl0ZY+TYz57cmq9XStZiehqBowxH0EMv1MdNl3
         /OlDVnuqiAU7rcTLCKobZlYA7gnX7471qtuwq9zXrE5nbgYq8uQq3Ojwq8x8QA2TjQBE
         Jqlpnl3GSSbbhkFP/42qDCrcYABEpM5FwCs13X1drUDSrHrrYxWYYOn0o1GwxDYus36C
         Xwekcp/VHB3j7pynP7Z8XH0cSLQogPoxoG7BIqqpPnnm3FL7KBBw6Gc5qSgE7yauSfBR
         l9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N+/Q1aqkedYn4B9pjG8Zddz2VBsnERKlysukyLaRqdk=;
        b=mTqQLNdz7/6vuOYCT/G8/8Fgs9JxB9d13W7JYzMQEobMNOBSjJTNIij+zr8hnClKyt
         vaqSjx5qn2cI2ELLvn2f3OWLLAuMf+lsjAtCWQsDwIgCcjMMpQ/SuNHyBZpgtSisAt+6
         24FdNR2bQc5WdMa8d8AoNwtzUY+8hvUcdlTBFAKsdTkUlYAqmdsxD6JWm0ToYIGUwMzK
         XzG4rTvTvv0J7+E0Cy1gyaFe5wgoOiBXUpbgiuykTQQHGOj6Ixzp2h09ka/E276nCw8U
         TpI2tLsgHIkjIbz1EzWbQ5K+3YmNKhqB9V+X7EeCl5c8twpFMiwzXySfFmZImX5WF4g0
         Bqkg==
X-Gm-Message-State: AIkVDXIgIrKBWgNv1Eg2b+02tMLy9WdOjR26cCDYk1jYrr1yV7wwad0SQGVGHpmPMCj1kA==
X-Received: by 10.223.156.9 with SMTP id f9mr25389792wrc.157.1485211956076;
        Mon, 23 Jan 2017 14:52:36 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id h3sm16925363wrb.31.2017.01.23.14.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jan 2017 14:52:34 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/5] sequencer: allow skipping commits
Date:   Mon, 23 Jan 2017 23:52:16 +0100
Message-Id: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.616.gd72966cf44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces a few options to the sequencer,
to allow skipping unwanted/unnecessary commits.

The first patch is just cleanup. The second fixes a potential issue
about sequencing options not being correctly remembered across
interruptions.

The next two introduce cherry-pick options to skip empty (or only
redundant) commits. The two options are introduced separately because
of the complexity associated with the possible combinations that can be
had.

The last commit allows --skip as a reset + --continue, to quickly skip
the current commit during a failed cherry-pick or revert (for example
because a better version of the commit was already merged).

Giuseppe Bilotta (5):
  sequencer: sort options load/save by struct position
  sequencer: save/load all options
  cherry-pick: option to skip empty commits
  cherry-pick: allow skipping only redundant commits
  sequencer: allow to --skip current commit

 Documentation/git-cherry-pick.txt |  10 +++
 Documentation/sequencer.txt       |  10 ++-
 builtin/revert.c                  |  24 +++++-
 sequencer.c                       | 163 ++++++++++++++++++++++++++++++--------
 sequencer.h                       |   4 +-
 5 files changed, 176 insertions(+), 35 deletions(-)

-- 
2.11.0.616.gd72966cf44.dirty

