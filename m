Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024C5EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 05:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGUF7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 01:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUF7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 01:59:33 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA33E65
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:59:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63c70dc7ed2so11579576d6.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689919170; x=1690523970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w19+3SQ7kEQZUGz+/5vgbvxnwE/TVicJfTxLTpT7RA=;
        b=c2cb2S9iLl6Tvh5IQ6BWtHuX3hd5YKpOq3I8CN72vhNvXq30T/4biG/Db0EHYLd0G2
         94GW43TUZ/8n5/ZpYfCxIK2GKz/vi8EvRoP8l99JkRfymWkuQAjCSkm+6De/25YshC5x
         RUodphbecEkRDkbRdUIK03pvn2aS+KOAx/aj7XcyfTpftbHCxoYmU3ijImRXD/Cfbevx
         5QOS3qVskt87CPu7F4zayF2piB1JcydKf35v4Nubw2i2OHfO2RBaOyHReAkoLOwaSCFx
         AX4k/1o7y6ZIxZGe3Nzk9KZxxF+aFCjKOZsItRTQK9CyrDeQitlLryDg3r1X8TZl16w2
         7w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919170; x=1690523970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0w19+3SQ7kEQZUGz+/5vgbvxnwE/TVicJfTxLTpT7RA=;
        b=F1VOfhWkpQJQ4s3X2SfCL0Xc4CvejtiuajpeOSbSXkY/wWxgHeXnBldOHCJChO0Ejc
         Y1IoaX7k7qTSQIFUl3JCB7ss/UGLWU5yUfjq+EDBpJFBPPsrE6ULTO8hyXJkz/kB76kJ
         oG9drdIal66liRbdCYbHiFLAZFX5Yw3n0V5AYXO4BY0xspWSaPlHvlHWmL+x16+2hKWn
         glW+JzcLTscizvuKb+8Arin4vZgE08TgGojun8gSdmfwWdyknZqziqNW4ZJmJOf1zlZZ
         65dDwJa0m0hw7dLrOjF+FlZepMnxibm3OiTFg3HpPdM04NjTDbS4j2GjGzoiQvpFgLz3
         U93Q==
X-Gm-Message-State: ABy/qLY6V1ThR75O0A67gptx15nZkC4gMqD3tWcYHbvoDvx0jvI7Z5v1
        sRsCWY9N3yBjmtAwcCV3AGRgQNFBVws=
X-Google-Smtp-Source: APBJJlHY86Jitrr6EOgonDiSgwP8izZu+NSDpwk3QeVWLxd3ae47WPUfhaQHK155wZ32WIl0Jsg1xA==
X-Received: by 2002:a05:620a:258e:b0:765:a77c:7219 with SMTP id x14-20020a05620a258e00b00765a77c7219mr1021835qko.0.1689919170400;
        Thu, 20 Jul 2023 22:59:30 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090aab1700b002636e5c224asm1777941pjq.56.2023.07.20.22.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:59:29 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 0/1] sequencer: finish parsing the todo list despite an invalid first line
Date:   Thu, 20 Jul 2023 23:58:16 -0600
Message-ID: <20230721055841.28146-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721053906.14315-1-alexhenrie24@gmail.com>
References: <20230721053906.14315-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2:
- Include accidentally omitted file redirect so that the output of
  --edit-todo is actually tested

Alex Henrie (1):
  sequencer: finish parsing the todo list despite an invalid first line

 sequencer.c                   |  2 +-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

Range-diff against v2:
1:  8005d81440 ! 1:  b1af2df3f5 sequencer: finish parsing the todo list despite an invalid first line
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'static check of bad command'
     +		grep "cannot .fixup. without a previous commit" actual &&
     +		grep "You can fix this with .git rebase --edit-todo.." actual &&
     +		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
    -+		test_must_fail git rebase --edit-todo &&
    ++		test_must_fail git rebase --edit-todo 2>actual &&
     +		grep "cannot .fixup. without a previous commit" actual &&
     +		grep "You can fix this with .git rebase --edit-todo.." actual &&
     +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
-- 
2.41.0

