Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12ADEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 06:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGUGKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGUGJy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 02:09:54 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC0730F1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 23:09:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bb07d274feso1046366a34.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689919746; x=1690524546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IPAaViNlZR1Rb7RNvhKQxSiWtIQIF7p19CtHidIv3E=;
        b=SYEKh/1EVmA+WQxJ9MIBjmbFFcC5ggadpVZRqh73sX5jyUbMtHBRikSVbnRVfShxAn
         I67lvAQDTmuZXuOFzkYBC9L8n+Buo22VZhjKcbKLv6DOzcVQCKJ3bF9xL+3amAXbnFfb
         g/8KrcAnSeKyeRizheC4uvm8DtnRG6XvBkBxjE3EZC2A/Nd4yp/lu8WyUG8soXzh9ktX
         xbQ5eZDRVzO2pVxpuDCZJNp1hpqib+7LT8YDONUdU/mLs5qcq+0kfYXAQDHNs648weai
         liss16NqVVzw/98x4Ozp8/iAR/818eXQFPmgwbLzRITe3hHMzVShVJ1H33SebMEo/y0X
         WE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919746; x=1690524546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IPAaViNlZR1Rb7RNvhKQxSiWtIQIF7p19CtHidIv3E=;
        b=O57Nef9aI0bg0YIXXS/HsA0lzfgGXNNddUh+ULF6Q0xoJU5tm2+dPkRCy1TjGkUWlj
         qD45zJhPy1ym481VHWmnp59zQ5QecTRGXoBg7RoqIr11ME+ohWSX0U7GAu8M4HPxXZzh
         g9iPRJOewzk4L7MV/T8XxQgSiWrvJmnpwV+Hd2irepeTRsLzZiNv34fsa2h9zvUETz5c
         xE7x1tMVNmensyJgImEaCTFCd1gLOZbahdMhe9nPIFxTJmzTQfXGjKDVYtCn2379P//w
         bOfDO1z6y3KOYsf4x7szpEMOzn42hiZ73K8fByM84Nm4heLupU9l0BAHNoPdI2ehTQsP
         61cg==
X-Gm-Message-State: ABy/qLYtesk48jm1u/IHw6V90DpVHCEhPN88/n8NIzxS31Yrp0pEVOk4
        hpg7ATxLaYJgznNuE/uTSQtuVPuyh3Q=
X-Google-Smtp-Source: APBJJlFSuK7dUCuyyCaYqSQ3U/FQdZAk30kQQ44EKbFmwzaQWwcavxzghb4F2yfBQOs77bk56IGcOg==
X-Received: by 2002:a05:6870:438f:b0:1b3:f370:79c7 with SMTP id r15-20020a056870438f00b001b3f37079c7mr1159310oah.37.1689919746036;
        Thu, 20 Jul 2023 23:09:06 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7928e000000b0067a1f4f4f7dsm2121639pfa.169.2023.07.20.23.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 23:09:05 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 0/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Fri, 21 Jul 2023 00:07:50 -0600
Message-ID: <20230721060848.35641-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721055841.28146-1-alexhenrie24@gmail.com>
References: <20230721055841.28146-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v3:
- Rebase onto HEAD~4 instead of --root (which was the original motivation
  for sending a new patch and I forgot to include that change; I probably
  shouldn't be doing Git development late at night...)

Alex Henrie (1):
  sequencer: finish parsing the todo list despite an invalid first line

 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

Range-diff against v3:
1:  b1af2df3f5 ! 1:  f6fcdcd9a9 sequencer: finish parsing the todo list despite an invalid first line
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'static check of bad command'
     +	rebase_setup_and_clean fixup-first &&
     +	(
     +		set_fake_editor &&
    -+		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
    -+			       git rebase -i --root 2>actual &&
    ++		test_must_fail env FAKE_LINES="fixup 1 2 3 4" \
    ++			       git rebase -i HEAD~4 2>actual &&
     +		grep "cannot .fixup. without a previous commit" actual &&
     +		grep "You can fix this with .git rebase --edit-todo.." actual &&
     +		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
-- 
2.41.0

